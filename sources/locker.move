// A TimeLockedBalance with potentially unsafe methods removed,
// specifically 'change_unlock_per_second' and 'change_unlock_start_ts_sec'.
module fomo::locker {
    use sui::balance::Balance;
    use sui::clock::Clock;
    use fomo::time_locked_balance as tlb;

    public struct Locker<phantom T> has store {
        balance: tlb::TimeLockedBalance<T>,
    }

    public fun create<T>(
        locked_balance: Balance<T>, unlock_start_ts_sec: u64, unlock_per_second: u64
    ): Locker<T> {
        Locker {
            balance: tlb::create(locked_balance, unlock_start_ts_sec, unlock_per_second)
        }
    }

    // View

    public fun unlock_start_ts_sec<T>(self: &Locker<T>): u64 {
        self.balance.unlock_start_ts_sec()
    }

    public fun unlock_per_second<T>(self: &Locker<T>): u64 {
        self.balance.unlock_per_second()
    }

    public fun final_unlock_ts_sec<T>(self: &Locker<T>): u64 {
        self.balance.final_unlock_ts_sec()
    }

    public fun max_withdrawable<T>(self: &Locker<T>, clock: &Clock): u64 {
        self.balance.max_withdrawable(clock)
    }

    public fun remaining_unlock<T>(self: &Locker<T>, clock: &Clock): u64 {
        self.balance.remaining_unlock(clock)
    }

    public fun extraneous_locked_amount<T>(self: &Locker<T>): u64 {
        self.balance.extraneous_locked_amount()
    }

    // Mutate

    public fun withdraw<T>(self: &mut Locker<T>, amount: u64, clock: &Clock): Balance<T> {
        self.balance.withdraw(amount, clock)
    }

    public fun withdraw_all<T>(self: &mut Locker<T>, clock: &Clock): Balance<T> {
        self.balance.withdraw_all(clock)
    }

    public fun top_up<T>(self: &mut Locker<T>, balance: Balance<T>, clock: &Clock) {
        self.balance.top_up(balance, clock)
    }

    public fun skim_extraneous_balance<T>(self: &mut Locker<T>): Balance<T> {
        self.balance.skim_extraneous_balance()
    }

    public fun destroy_empty<T>(self: Locker<T>) {
        let Locker { balance } = self;
        balance.destroy_empty();
    }

}
