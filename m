Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB4487A9F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jan 2022 17:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbiAGQnu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 7 Jan 2022 11:43:50 -0500
Received: from aposti.net ([89.234.176.197]:40182 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240038AbiAGQnu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Jan 2022 11:43:50 -0500
Date:   Fri, 07 Jan 2022 16:43:37 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/6] PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS
 macros
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Message-Id: <PGMC5R.ZEUF4DPAECD7@crapouillou.net>
In-Reply-To: <CAPDyKFpUUPzqonNBrFq68h8QOVxardvf2q7AuEQVeUJ-S2726A@mail.gmail.com>
References: <20220105182939.106885-1-paul@crapouillou.net>
        <20220105182939.106885-4-paul@crapouillou.net>
        <CAPDyKFpUUPzqonNBrFq68h8QOVxardvf2q7AuEQVeUJ-S2726A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le ven., janv. 7 2022 at 17:33:04 +0100, Ulf Hansson 
<ulf.hansson@linaro.org> a �crit :
> On Wed, 5 Jan 2022 at 19:30, Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> 
>>  These macros are defined conditionally, according to CONFIG_PM:
>>  - if CONFIG_PM is enabled, these macros resolve to
>>    DEFINE_SIMPLE_DEV_PM_OPS(), and the dev_pm_ops symbol will be
>>    exported.
>> 
>>  - if CONFIG_PM is disabled, these macros will result in a dummy 
>> static
>>    dev_pm_ops to be created with the __maybe_unused flag. The 
>> dev_pm_ops
>>    will then be discarded by the compiler, along with the provided
>>    callback functions if they are not used anywhere else.
>> 
>>  In the second case, the symbol is not exported, which should be
>>  perfectly fine - users of the symbol should all use the pm_ptr() or
>>  pm_sleep_ptr() macro, so the dev_pm_ops marked as "extern" in the
>>  client's code will never be accessed.
> 
> How common is it to export the dev_pm_ops? Do we really need a macro 
> for this?

$ rgrep EXPORT_SYMBOL drivers/ |grep pm_ops |wc -l
44

That should be enough to justify a macro.

Cheers,
-Paul

> 
> The similar comment/question applies for patch5.
> 
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Kind regards
> Uffe
> 
>>  ---
>> 
>>  Notes:
>>      v2: Remove useless empty line
>> 
>>   include/linux/pm.h | 32 +++++++++++++++++++++++++++++---
>>   1 file changed, 29 insertions(+), 3 deletions(-)
>> 
>>  diff --git a/include/linux/pm.h b/include/linux/pm.h
>>  index 389e600df233..b82f40e701ab 100644
>>  --- a/include/linux/pm.h
>>  +++ b/include/linux/pm.h
>>  @@ -8,6 +8,7 @@
>>   #ifndef _LINUX_PM_H
>>   #define _LINUX_PM_H
>> 
>>  +#include <linux/export.h>
>>   #include <linux/list.h>
>>   #include <linux/workqueue.h>
>>   #include <linux/spinlock.h>
>>  @@ -357,14 +358,39 @@ struct dev_pm_ops {
>>   #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
>>   #endif
>> 
>>  +#define _DEFINE_DEV_PM_OPS(name, \
>>  +                          suspend_fn, resume_fn, \
>>  +                          runtime_suspend_fn, runtime_resume_fn, 
>> idle_fn) \
>>  +const struct dev_pm_ops name = { \
>>  +       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>  +       RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, 
>> idle_fn) \
>>  +}
>>  +
>>   /*
>>    * Use this if you want to use the same suspend and resume 
>> callbacks for suspend
>>    * to RAM and hibernation.
>>    */
>>   #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  -const struct dev_pm_ops name = { \
>>  -       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>  -}
>>  +       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, 
>> NULL)
>>  +
>>  +#ifdef CONFIG_PM
>>  +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, 
>> runtime_suspend_fn, \
>>  +                          runtime_resume_fn, idle_fn, sec) \
>>  +       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, 
>> runtime_suspend_fn, \
>>  +                          runtime_resume_fn, idle_fn); \
>>  +       _EXPORT_SYMBOL(name, sec)
>>  +#else
>>  +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, 
>> runtime_suspend_fn, \
>>  +                          runtime_resume_fn, idle_fn, sec) \
>>  +static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, 
>> suspend_fn, \
>>  +                                        resume_fn, 
>> runtime_suspend_fn, \
>>  +                                        runtime_resume_fn, idle_fn)
>>  +#endif
>>  +
>>  +#define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  +       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, 
>> NULL, "")
>>  +#define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  +       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, 
>> NULL, "_gpl")
>> 
>>   /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>>   #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  --
>>  2.34.1
>> 


