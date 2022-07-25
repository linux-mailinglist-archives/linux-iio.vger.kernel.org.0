Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B350E5806E9
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jul 2022 23:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiGYVpl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jul 2022 17:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGYVpl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2022 17:45:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569FFB1CB
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2022 14:45:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x91so15651331ede.1
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2022 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRreLrBrAPCGQtNT0TZPoAtN/YhPomZRv5YcZJZHleA=;
        b=VoU5Rr0ZDWMRHErHReBxi9nHMyN6dtvmiiU4ftC8Z2qZDdozn70hs+Lp26AMZpbhMr
         mkrJYUziK3atjoUvn1AS6kBGkkRDWLRSDdOYmQAL2qSd14DjVH7AD3c9G2iRGKyOj1v5
         RRfRIxTjN7fWxbaS3P3tO/WJ5dnGdg+euG6OAAsIC4oQEgDqjeXGlA6KzuUNKFR/eAuw
         qPnYo6Rb/UMtNqT+P6SvTQ71CC72BfO7Ai9k7ITpU0ZWb7aIkSxpDbdNV5OVg2e5Jurc
         ncm9Oe98PpoL7fEGcAewhiUEyucVvwfXLIm1eMWNzvpyjh9C6Wvn2rx2gX3vZaHn7Jw0
         ANig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRreLrBrAPCGQtNT0TZPoAtN/YhPomZRv5YcZJZHleA=;
        b=Wz1u6zwksq4rlqy5FOxHVRV9Aoy0Kgel7HPt3CVagoUHeLuL2BhTZ44EdL1N2zY3sr
         QVygwnKgLdhN1xe1FxVdL7qGW3dQm5Dq/FZqHAefniLKH3GyS1hDV8065KxOMeH7VYnb
         byuER0AXaDPE0kt7SpZ8jQOoJPVu4feaznTT09koF8Z1NO5wbi3jy9GneKbGmoPuHlfF
         ost/kS2btcwsyjg/CtWTqiXy7TBRRRGjRzrfCyEo8so139PSbS39gVCoAXVZqSFu+Wd7
         Cj65S+V1wxnErw0iWmwW4Sz5BhLC/1lehvSSL3AVqrP/69aStlbeZzg4dvLYTV3VGd2f
         GXqQ==
X-Gm-Message-State: AJIora8VVuQ126GhYjjq5iFU4dSE31Ij9NEWVhzggS1sMJxUxzZnysSa
        59cPQqzWJkjd0gydeNxG6tIu1C6FNxhCHjrgNEhlM6nm7ho=
X-Google-Smtp-Source: AGRyM1uvwLvmqfkgXKDLrrEeoJ+e0FFLbdHJaAZ/7sB7ND/rlYLZoPk+Dg4cDiF2Bp0L+DheGBogvVyvbk9sMQ7xuIU=
X-Received: by 2002:a05:6402:d05:b0:435:b2a6:94eb with SMTP id
 eb5-20020a0564020d0500b00435b2a694ebmr15028463edb.87.1658785538685; Mon, 25
 Jul 2022 14:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv63uvFgLD8d5a4cc12OQZezHG2kfLuY=7X1obmZp4XYP7ANw@mail.gmail.com>
 <CAHp75VcrFQXW10vkLSB5Yh2D24zPzKR9FtfDU8bsSqDwD7=zjg@mail.gmail.com> <CAKv63uv12XWEEVAhUBuK9Botj4mCtKWwRL-YzxywOipTAHgQFg@mail.gmail.com>
In-Reply-To: <CAKv63uv12XWEEVAhUBuK9Botj4mCtKWwRL-YzxywOipTAHgQFg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:45:02 +0200
Message-ID: <CAHp75Vd7_Vz+kTEUzO+Pz3Bj5b7AYo=NMukL5dbX9HLXHE4K0Q@mail.gmail.com>
Subject: Re: Controlling device power management from terminal
To:     Crt Mori <cmo@melexis.com>
Cc:     Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 25, 2022 at 11:36 PM Crt Mori <cmo@melexis.com> wrote:
> On Mon, 25 Jul 2022 at 23:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jul 25, 2022 at 10:48 AM Crt Mori <cmo@melexis.com> wrote:
> > >
> > > Hi,
> > > I am implementing the power saving modes for mlx90632 device driver
> > > and while I have implemented routines for SET_RUNTIME_PM_OPS
> > > (runtime_pm_suspend and runtime_pm_resume) I am not able to find out
> > > how to trigger them from the terminal.
> > >
> > > It could be that my driver code for power management implementation is
> > > incomplete and I need to initialize something more.
> > >
> > > Maybe it is helpful, but the power submodule of the device contains below files:
> > >
> > > $ ls -al /sys/bus/iio/devices/iio\:device0/power
> > > total 0
> > > drwxrwxr-x 2 root gpio    0 Apr  6 14:17 .
> > > drwxrwxr-x 3 root gpio    0 Apr  6 14:17 ..
> > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 async
> > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 autosuspend_delay_ms
> > > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:18 control
> > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_kids
> > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_time
> > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_enabled
> > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_status
> > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_suspended_time
> > > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_usage
> > >
> > > And control is already set to "auto" which according to documentation
> > > should allow the PM.
> >
> > 'auto' should enable it. So, whenever the driver thinks it's a time to
> > power off/on the device it will call the methods.
> >
> > You may hack a bit to enable autosuspend (which often is not a good
> > idea for IIO sensors) and see it done automatically after some time.
>
> So the idea is to wait?

Yes.

> How would I enable autosuspend - by lowering
> the autosusped_delay_ms?

Yep, if you wish. The driver should enable it though.

> How does the driver decide that it is time to
> power off/on?

I'm not a driver author, it seems you , who should answer this
question (as you are about to add PM there, am I right?).

> Do I need something else enabled to have this done automatically?
> Autosuspend is 5000 in my case which would mean 5 seconds, so I am
> quite sure I waited that long and I did not see printk's from the
> driver.

Something prevents it from doing (reference counting) or simply some
initialization / enablement is forgotten. For different buses
different PM runtime rules are applied (for example, IIRC, PCI core
does it for you, while platform bus is on what driver wants basis).

-- 
With Best Regards,
Andy Shevchenko
