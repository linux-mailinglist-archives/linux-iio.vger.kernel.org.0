Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6062C66690C
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jan 2023 03:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjALCsU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Jan 2023 21:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjALCsT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2023 21:48:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025511468
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2023 18:48:18 -0800 (PST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 963E43F75B
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 02:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1673491694;
        bh=zYT9PUo9w/dJFrmMQtkzrIxsqhQvFM3k5XqH0wxHBms=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=XHYxeMo6/5dOCU149cTNVghPxRx+YIQGZ93GdHc7Dh9afy7NhPbfUHPGsaHQERt0Y
         NNBXRs96fBNm6dxnSUIyfspC1aLxbs3mufuPu/PhlyZ1kbUrCw/xsHM/YfF+4s+zrh
         q8j38SPV4RSXjTPIyzMFuTdyHJb1+OS+cVl1CSi7pmzmkba7vOg86K3X11gBa3V6po
         rPQv1qzXBOuxkd373ArlWDL27llwyng0Sf+xzg/bIZ/6seiICYXc7TH45kGfwqqqel
         lX6SdeXIwlHXG8/dPal9Za2MBExAhFxNW4aKx8mTCFcqxywr6xqiOp5SDMF8gVQEFv
         054T1cSA6GeJA==
Received: by mail-pj1-f70.google.com with SMTP id s22-20020a17090aad9600b002271d094c82so6198864pjq.7
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2023 18:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYT9PUo9w/dJFrmMQtkzrIxsqhQvFM3k5XqH0wxHBms=;
        b=e2mljX7DIKfMvqchT60oMHBNcmsQxwoCnDbvJPhEHyHLVz3XXY4WMCbDf8LjkdiU1n
         hx0Zki3JyNluASKcZBNSjx9C2I88jUdVwLqLHkO2PDbJX8xlCt9MyHVLDkXmZWO2zeJ8
         Ikyh+H9FxMv+uU7+bO2SD5F/afZEZ7hS2VOo252NhUilb3Ic8jm8aiD3oZTzoUhyD6Gv
         D7HIn6m5bSOCBmj2oR26EL4A+moLNMxZb1dS1ATHU5mbrXx4SEo2CWVnbo5NbK0ySJ0j
         tODJ2/Zt6dPNbeZgTCROEYgMxPX5Mn6xTjIVyr21czhjfrzq+7I05wSSVNLqE7bK0EYh
         2NbA==
X-Gm-Message-State: AFqh2kps1snreSZLhhOrm0DaqAt+y3mPk/bzb5aRPmtDVbytIjZtuUVn
        4mLxuZgNWi09w0LlRejtjsV+JJwsFMGzRrc5aIoHwmE3hMP8LeM7tmCkSc4RAbBfdiPxpMtNMX4
        3FKQdhu4lF/gKoCuXGWk6uU0qZtKHcwwF8U5PSpHv9Z4Mt8mMyLtODA==
X-Received: by 2002:a17:902:db07:b0:192:ab97:633c with SMTP id m7-20020a170902db0700b00192ab97633cmr2237376plx.69.1673491693163;
        Wed, 11 Jan 2023 18:48:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtKjjdpIgp8p3cj1V5pJdJsAOoiLEvx8pfI4gi22HkYWBlJooK6hnMr322dKWvk5zGUKMXK7Scf93J8UPxe0Dc=
X-Received: by 2002:a17:902:db07:b0:192:ab97:633c with SMTP id
 m7-20020a170902db0700b00192ab97633cmr2237374plx.69.1673491692790; Wed, 11 Jan
 2023 18:48:12 -0800 (PST)
MIME-Version: 1.0
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com>
 <20230103112629.000063e8@Huawei.com> <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com>
 <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com>
 <8sH16OwIJbnTXpjBaNVGn7Qpv1HmPww_fiXBQ2EfhLkhjWnf90kGxXKfHhyZX9Eu2JqsozqOFWEk3smuGqYxkSZNxEPHTkTTjBc2n7ksRhw=@protonmail.com>
 <20230108124654.514a5b1b@jic23-huawei>
In-Reply-To: <20230108124654.514a5b1b@jic23-huawei>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 12 Jan 2023 10:48:01 +0800
Message-ID: <CAAd53p5nz0ehBmg05njKRG7cnBQQgJFpT-1oqDtajSY8Zz0NMw@mail.gmail.com>
Subject: Re: CM32181 Bug Report (Linux 6.0+)
To:     Wahaj <wahajaved@protonmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Jonathan.Cameron@huawei.com,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Wahaj,

On Sun, Jan 8, 2023 at 8:33 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 07 Jan 2023 00:37:40 +0000
> Wahaj <wahajaved@protonmail.com> wrote:
>
> > ------- Original Message -------
> > On Friday, January 6th, 2023 at 9:08 AM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> >
> > > Hi Wahaj,
> > >
> > > On Fri, Jan 6, 2023 at 12:26 AM Wahaj wahajaved@protonmail.com wrote:
> > >
> > > > ------- Original Message -------
> > > >
> > > > On Tuesday, January 3rd, 2023 at 2:26 PM, Jonathan Cameron Jonathan.Cameron@Huawei.com wrote:
> > > >
> > > > > On Wed, 28 Dec 2022 14:05:24 +0000
> > > > > Wahaj wahajaved@protonmail.com wrote:
> > > >
> > > > > > Hi Jonathan
> > > > > >
> > > > > > Hope you're doing well. I have been using a laptop that comes with a
> > > > > > CM32181 Light Sensor and after upgrading to the Linux kernel 6.0+, my
> > > > > > laptop cannot seem to suspend because of the PM subsystem error. I
> > > > > > have narrowed the problem down to this module and I believe that the
> > > > > > commit 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20bis the culprit
> > > > > >
> > > > > > The following lines were provided from the journalctl logs:
> > > > > >
> > > > > > > cm32181 i2c-CPLM3218:00: PM: dpm_run_callback():
> > > > > > > acpi_subsys_suspend+0x0/0x60 returns -121 cm32181 i2c-CPLM3218:00:
> > > > > > > PM: failed to suspend async: error -121
> > > > > >
> > > > > > I would love the chance to be able to work on this given any guidance
> > > > > > on where to start
> > > > >
> > > > > Hi Wahaj,
> > > > >
> > > > > Certainly seems likely that you have identified the right commit.
> > > > > As a starting point, resend this email to linux-iio@vger.kernel.org
> > > > > and Kai-Heng Feng kai.heng.feng@canonical.com
> > > > >
> > > > > If you could try reverting the commit to be completely sure it is
> > > > > the cause that would help avoid any doubt.
> > > > > Superficially the only thing that I can see causing this problem is
> > > > > a fail of the i2c bus write.
> > > > >
> > > > > Does the device work prior to suspend? Try cat /sys/bus/iio/iio:device0/*
> > > > > and see if you get any errors (may be device1 etc)
> > > > >
> > > > > If the device wasn't working at all the register writes in probe() should
> > > > > have failed so we shouldn't be trying to suspend it.
> > > > > It's possible your machine has some unusual power dependencies or
> > > > > similar that mean the device is getting powered down before we try to
> > > > > suspend it.
> > > > >
> > > > > Anyhow, better to have this discussion on list as there are many other people
> > > > > who may have more insight than me or be able to replicate and help debug.
> > > > >
> > > > > Jonathan
> > > > >
> > > > > > Best Regards,
> > > > > > Wahaj Javed
> > > >
> > > > Hi Jonathan and Kai-Heng Feng,
> > > >
> > > > I am currently using the 5.15 linux kernel for a while now which works perfectly fine.
> > > >
> > > > From what I gather the suspend functionality does work when using an older Linux version without the PM i2c bus writes.
> > >
> > >
> > > Does your system use S3 or S2idle to perform suspend?
> > >
> > My system uses S3 to perform suspend
> > > > The device does work fine prior to and post attempted suspend with no errors showing in cat /sys/bus/iio/iio:device0/*
> > >
> > >
> > > Does in_illuminance_input value change after system suspend?
> > Yes, the in_illuminance_input value changes after system suspend with or without the suspend and resume functions
> >
> >
> > >
> > > Kai-Heng
> > >
> > > > Let me know if there's anything I should start looking into
> > > >
> > > > Best Regards
> > > > Wahaj Javed
> >
> > How did the kernel used to suspend/resume before using the suspend and resume functions in the light sensor?
> >
> > Was the DEFINE_SIMPLE_DEV_PM_OPS introduced as a part of the Linux 6.0+ PM rework?
>
> Until https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68c1b3dd5c48b2323067f8c1f0649ae2f31ab20b
> which will have hit mainline in 6.0, the driver had no suspend / resume support.
>
> That patch introduced an i2c write to put the chip into a low power mode.
> My best guess for a cause would be that something else is incorrectly being disabled
> before this call and hence breaking the i2c comms.

Can you please try the patch here and see if the device supports
DISABLE command at all:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1988346/comments/52

Kai-Heng

>
> Jonathan
>
> >
> > I would like to take on this bug and try to solve it if that's possible
> >
> >
> > Best Regards
> > Wahaj Javed
>
