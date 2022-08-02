Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84D9587EFE
	for <lists+linux-iio@lfdr.de>; Tue,  2 Aug 2022 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiHBPdB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Aug 2022 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHBPdA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Aug 2022 11:33:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F5245
        for <linux-iio@vger.kernel.org>; Tue,  2 Aug 2022 08:32:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r13so16937811oie.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Aug 2022 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSDPxM2By8vi0ZP2NPNQOJTJOQmur6WOk590MvQmElQ=;
        b=JY7PQqVA34lrfStrOcPH7nqIj08Wwxr9DV6Dxz2WDid/GFoEsRJbX0c0A1fCjWPGqT
         VtpiTZe67AzC+zxkNS1u7GhrIsc7yG5JThpTHSlfSAFlCLgrj9XNwozoJQpEE1BuB6iu
         9fpIDGDd0zQRxi/B6HFJnFrtEPn7Bz0iG3eV8I2APHWaRNvAoBbacJIeztzkdlB3JPIA
         lUYKNg0mAEjehpw4prvJ6WvSe5wS33gEaF0P472gD5ILfY/nh3lnjuaAqXeOOEtIcmBs
         QNvimD5lXoHHPU3Cb/Eb8wSX1ibV5h81FL+zYSItSw53R++gJKV8vrMXrIMW3K6XkqkC
         MPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSDPxM2By8vi0ZP2NPNQOJTJOQmur6WOk590MvQmElQ=;
        b=YzBNpIf2EC8RpzrXkYcYWZrsY1jaa4yTsSm3WfP3A/qyJY/M+p48suEy5px+tkCnT1
         dWJVu036XAc3wrtTeZW1LFNFXBQxBcbw3VuOtuPVSbFYWlwooxzwtuO7qAS5QsQ8cpTw
         JqqWrchhw8gQkMWbq5TbCrhR1M6Y+07jVCYryV7Zqd0u3Ins035ufuQXknVnVC1RhaGm
         b0T7OguavPG46SVUhyXSgNJLaRlvsOtKfdrGPtcP0+KS0rnnUOarr8Q3ImRXUjJ1eXoW
         AmcX/RBZFWaKx3Jmm5PyNIoloykwUWV+fwnP5En7PnHbm3ckAPZ8RI8QnJ24I1p1bAx/
         vftg==
X-Gm-Message-State: ACgBeo1h+27JJY3Phdg/3GuOv2VU+TLseIq+ymOp/gaDZa4g+w3i4tIs
        RaF3at1Q0YtfHPIn+8pkLqAmQVq6J+L+08x4wUgci02KylkFgQ==
X-Google-Smtp-Source: AA6agR7cNevxiBbSsfCCVKPtA951j1X6fgs+uBfk5dDr8yAhlx8qa9Pzev3TtmsM4nQv8QPJqy0MURH7bCyXGnnkVug=
X-Received: by 2002:a05:6808:1708:b0:335:1b16:fb09 with SMTP id
 bc8-20020a056808170800b003351b16fb09mr19114oib.7.1659454378466; Tue, 02 Aug
 2022 08:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv63uvFgLD8d5a4cc12OQZezHG2kfLuY=7X1obmZp4XYP7ANw@mail.gmail.com>
 <CAHp75VcrFQXW10vkLSB5Yh2D24zPzKR9FtfDU8bsSqDwD7=zjg@mail.gmail.com>
 <CAKv63uv12XWEEVAhUBuK9Botj4mCtKWwRL-YzxywOipTAHgQFg@mail.gmail.com> <CAHp75Vd7_Vz+kTEUzO+Pz3Bj5b7AYo=NMukL5dbX9HLXHE4K0Q@mail.gmail.com>
In-Reply-To: <CAHp75Vd7_Vz+kTEUzO+Pz3Bj5b7AYo=NMukL5dbX9HLXHE4K0Q@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Tue, 2 Aug 2022 17:32:22 +0200
Message-ID: <CAKv63uuaVNoo7hG8bampmx1r5WH7=BdNVL-4HAgzPou9d58HDg@mail.gmail.com>
Subject: Re: Controlling device power management from terminal
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,
Thanks for the explanation and help - now the PM runtime suspend and
resume are triggered. It was indeed the combination of bad
initialization and that I did not have "enter wakeup" on the read
data.

Currently, I view pm_runtime mode as a power saving mode (device
should be in low power) and normal running as running mode. However,
the sensor is able to report data in both modes - just reading is a
bit different. I also do not have a problem with autosuspend after
some time, but I do wonder how would user change the power mode from
pm_runtime to normal mode (reading, in this case, should not change
the mode). What is the recommended ABI for that?

On Mon, 25 Jul 2022 at 23:45, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jul 25, 2022 at 11:36 PM Crt Mori <cmo@melexis.com> wrote:
> > On Mon, 25 Jul 2022 at 23:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Jul 25, 2022 at 10:48 AM Crt Mori <cmo@melexis.com> wrote:
> > > >
> > > > Hi,
> > > > I am implementing the power saving modes for mlx90632 device driver
> > > > and while I have implemented routines for SET_RUNTIME_PM_OPS
> > > > (runtime_pm_suspend and runtime_pm_resume) I am not able to find out
> > > > how to trigger them from the terminal.
> > > >
> > > > It could be that my driver code for power management implementation is
> > > > incomplete and I need to initialize something more.
> > > >
> > > > Maybe it is helpful, but the power submodule of the device contains below files:
> > > >
> > > > $ ls -al /sys/bus/iio/devices/iio\:device0/power
> > > > total 0
> > > > drwxrwxr-x 2 root gpio    0 Apr  6 14:17 .
> > > > drwxrwxr-x 3 root gpio    0 Apr  6 14:17 ..
> > > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 async
> > > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 autosuspend_delay_ms
> > > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:18 control
> > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_kids
> > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_time
> > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_enabled
> > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_status
> > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_suspended_time
> > > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_usage
> > > >
> > > > And control is already set to "auto" which according to documentation
> > > > should allow the PM.
> > >
> > > 'auto' should enable it. So, whenever the driver thinks it's a time to
> > > power off/on the device it will call the methods.
> > >
> > > You may hack a bit to enable autosuspend (which often is not a good
> > > idea for IIO sensors) and see it done automatically after some time.
> >
> > So the idea is to wait?
>
> Yes.
>
> > How would I enable autosuspend - by lowering
> > the autosusped_delay_ms?
>
> Yep, if you wish. The driver should enable it though.

Is there a way for driver to attach a callback to
power/autosuspend_delay_ms request or to power/control?

>
> > How does the driver decide that it is time to
> > power off/on?
>
> I'm not a driver author, it seems you , who should answer this
> question (as you are about to add PM there, am I right?).
>
> > Do I need something else enabled to have this done automatically?
> > Autosuspend is 5000 in my case which would mean 5 seconds, so I am
> > quite sure I waited that long and I did not see printk's from the
> > driver.
>
> Something prevents it from doing (reference counting) or simply some
> initialization / enablement is forgotten. For different buses
> different PM runtime rules are applied (for example, IIRC, PCI core
> does it for you, while platform bus is on what driver wants basis).
>
> --
> With Best Regards,
> Andy Shevchenko
