Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73048591B34
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiHMPCb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 11:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiHMPCb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 11:02:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44366F5A6
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 08:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF36FB8010F
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 15:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F79C433C1;
        Sat, 13 Aug 2022 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660402946;
        bh=+LVqaEZSRgdNdywwt1pQnu+d6uT+QdIklmik0ipz52g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nAU+MrNspYbVw/mlmf3+OY74VKgJroi9txSbiQHWtQkaQ9C69Vbss0LoA6QH09IPw
         QsEZh+oN7C2Mrk+pnU/Vr8Jgl0JlfAL0x4gYNuKsQnWMxQoqBpRipTUcI1OjO5kSQe
         svN8no3dK/56453L9Nw498GRKT+6ICAkLyry7/yEyH8waG2FxlGO7TyVJbgfWsVc7+
         3UlQy4d8y42rWueYT5//AwDLZOcRGjTwRFJYU4Qh4Pqp0d7C9Tx1VjXUQLduymWqHd
         QQ+R1xRJXirAF4MiUqT/f3KXjrpwE9/F03N2VVhFUBXl/r6kdFp2XVjLyKeDLTNya6
         YCXZOA1Cbl/lw==
Date:   Sat, 13 Aug 2022 16:12:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Iio <linux-iio@vger.kernel.org>
Subject: Re: Controlling device power management from terminal
Message-ID: <20220813161255.542bf93b@jic23-huawei>
In-Reply-To: <CAKv63uvaQZO+RNDN-Mcn2uUzuSs8PFhGT=ex6HXCSp-aM03JLw@mail.gmail.com>
References: <CAKv63uvFgLD8d5a4cc12OQZezHG2kfLuY=7X1obmZp4XYP7ANw@mail.gmail.com>
        <CAHp75VcrFQXW10vkLSB5Yh2D24zPzKR9FtfDU8bsSqDwD7=zjg@mail.gmail.com>
        <CAKv63uv12XWEEVAhUBuK9Botj4mCtKWwRL-YzxywOipTAHgQFg@mail.gmail.com>
        <CAHp75Vd7_Vz+kTEUzO+Pz3Bj5b7AYo=NMukL5dbX9HLXHE4K0Q@mail.gmail.com>
        <CAKv63uuaVNoo7hG8bampmx1r5WH7=BdNVL-4HAgzPou9d58HDg@mail.gmail.com>
        <20220806182823.08d15b35@jic23-huawei>
        <CAKv63uvaQZO+RNDN-Mcn2uUzuSs8PFhGT=ex6HXCSp-aM03JLw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Aug 2022 23:44:50 +0200
Crt Mori <cmo@melexis.com> wrote:

> On Sat, 6 Aug 2022 at 19:18, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 2 Aug 2022 17:32:22 +0200
> > Crt Mori <cmo@melexis.com> wrote:
> >  
> > > Hi Andy,
> > > Thanks for the explanation and help - now the PM runtime suspend and
> > > resume are triggered. It was indeed the combination of bad
> > > initialization and that I did not have "enter wakeup" on the read
> > > data.
> > >
> > > Currently, I view pm_runtime mode as a power saving mode (device
> > > should be in low power) and normal running as running mode. However,
> > > the sensor is able to report data in both modes - just reading is a
> > > bit different. I also do not have a problem with autosuspend after
> > > some time, but I do wonder how would user change the power mode from
> > > pm_runtime to normal mode (reading, in this case, should not change
> > > the mode). What is the recommended ABI for that?  
> >
> > This comes up from time to time.  Normally it's very hard for a user
> > to know the right answer to power mode questions because they rarely
> > know enough of the impacts, so we try to use things that do have obvious
> > meaning.
> >
> > * If we are doing buffered capture, can assume the user wants good perf
> >   so switch to a high power mode.  If doing sysfs reads they probably
> >   care less about perf.  We could apply a heuristic along the lines of
> >   they read it twice in the last second, keep it in high power mode.
> >  
> I do not think the buffered mode is kinda something that would be
> applicable here since refresh rate is not really that fast. (64 Hz).
> Or you think I should implement this simply for continuous mode?

Possibly not. Assuming the non continuous mode is reasonably low latency
I would probably just not implement it.  Maybe it doesn't make any real
sense for this device on Linux.  If latency is quite high you might
make this the 'non autosuspended' case.

> 
> > * Often power modes are reflected in sampling rate.  So just wire it up
> >   to that (with possible side effects on other parameters).
> >   I took a quick look at the mlx90632 data sheet and it seems the modes
> >   we have are.
> >
> > Sleep step mode:  Goes to sleep between individual measurement sets. So
> > each one has higher latency after request.  Various subtle complexities
> > around control int his mode, but it's the latency at start and finish
> > which differs from other modes  
> This is the new part of the driver I want to add. We call it Burst
> measurement mode, and it allows sensor to be in sleep step mode, while
> performing triggered measurements. This is the mode I would go after
> autosuspend.

Sounds reasonable to me.

> 
> >
> > Step mode: Stays powered up, but you need to poll to get a measurement.  
> This mode I would skip. There is no bigger added value at least in Linux case.
> 
> >
> > Continuous: Autonomous sampling mode.
> >
> > So fun device. I think you kind of have to implement a heuristic for this.
> > Probably switch between step mode and sleep step mode based on time between
> > last two accesses or similar.  If there haven't been 2 accesses yet
> > stay in sleep step mode.  
> This mode I would have in repeated measurements. However, how do I
> define that? Is there a PM function that would tell me to switch from
> Sleep step mode to this?

I don't think there is anything appropriate for this.  You can probably
implement it in driver, using some of the ideas from PM.

> Because runtime_resume in this case would
> prevent sensor to work in sleep step mode, so like you suggested I
> will check for the time between last two accesses. Does this time need
> to be configurable, or can I hardcode it to some "reasonable" value?

I'd go for hard coded initially.  If it turns out there is a strong
reason to vary it then we can possibly add that later - though at the
cost of having an interface no one would generally know how to use.

Note the autosuspend delays (which are kind of similar) are almost always
hard coded and we haven't seen much demand to change that.

> 
> >
> > Side note. As you presumably have hardware for this part, could you run
> > a rest with UNIVERSAL_DEV_PM_OPS (which is deprecated) switched to
> > DEFINE_RUNTIME_PM_OPS()  The RUNTIME version checks if we are already
> > suspended on entry into a full suspend and only powers down the device
> > if not already powered down.  I plan to spin a patch soon to do this
> > anyway, but it is technically different behaviour so want it tested
> > if at all possible! (feel free to not wait for my patch, or to send
> > your own :)
> >  
> I see you already sent your patch, although what I am preparing (with
> runtime_pm) will probably overwrite it. I will test your patch
> tomorrow as my patches will probably take some time.

Thanks.

Jonathan

> 
> Thanks for the answers.
> Crt
> > Jonathan
> >
> >  
> > >
> > > On Mon, 25 Jul 2022 at 23:45, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > >
> > > > On Mon, Jul 25, 2022 at 11:36 PM Crt Mori <cmo@melexis.com> wrote:  
> > > > > On Mon, 25 Jul 2022 at 23:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > > > On Mon, Jul 25, 2022 at 10:48 AM Crt Mori <cmo@melexis.com> wrote:  
> > > > > > >
> > > > > > > Hi,
> > > > > > > I am implementing the power saving modes for mlx90632 device driver
> > > > > > > and while I have implemented routines for SET_RUNTIME_PM_OPS
> > > > > > > (runtime_pm_suspend and runtime_pm_resume) I am not able to find out
> > > > > > > how to trigger them from the terminal.
> > > > > > >
> > > > > > > It could be that my driver code for power management implementation is
> > > > > > > incomplete and I need to initialize something more.
> > > > > > >
> > > > > > > Maybe it is helpful, but the power submodule of the device contains below files:
> > > > > > >
> > > > > > > $ ls -al /sys/bus/iio/devices/iio\:device0/power
> > > > > > > total 0
> > > > > > > drwxrwxr-x 2 root gpio    0 Apr  6 14:17 .
> > > > > > > drwxrwxr-x 3 root gpio    0 Apr  6 14:17 ..
> > > > > > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 async
> > > > > > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 autosuspend_delay_ms
> > > > > > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:18 control
> > > > > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_kids
> > > > > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_time
> > > > > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_enabled
> > > > > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_status
> > > > > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_suspended_time
> > > > > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_usage
> > > > > > >
> > > > > > > And control is already set to "auto" which according to documentation
> > > > > > > should allow the PM.  
> > > > > >
> > > > > > 'auto' should enable it. So, whenever the driver thinks it's a time to
> > > > > > power off/on the device it will call the methods.
> > > > > >
> > > > > > You may hack a bit to enable autosuspend (which often is not a good
> > > > > > idea for IIO sensors) and see it done automatically after some time.  
> > > > >
> > > > > So the idea is to wait?  
> > > >
> > > > Yes.
> > > >  
> > > > > How would I enable autosuspend - by lowering
> > > > > the autosusped_delay_ms?  
> > > >
> > > > Yep, if you wish. The driver should enable it though.  
> > >
> > > Is there a way for driver to attach a callback to
> > > power/autosuspend_delay_ms request or to power/control?
> > >  
> > > >  
> > > > > How does the driver decide that it is time to
> > > > > power off/on?  
> > > >
> > > > I'm not a driver author, it seems you , who should answer this
> > > > question (as you are about to add PM there, am I right?).
> > > >  
> > > > > Do I need something else enabled to have this done automatically?
> > > > > Autosuspend is 5000 in my case which would mean 5 seconds, so I am
> > > > > quite sure I waited that long and I did not see printk's from the
> > > > > driver.  
> > > >
> > > > Something prevents it from doing (reference counting) or simply some
> > > > initialization / enablement is forgotten. For different buses
> > > > different PM runtime rules are applied (for example, IIRC, PCI core
> > > > does it for you, while platform bus is on what driver wants basis).
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko  
> >  

