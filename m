Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB81661514
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 13:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjAHMda (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 07:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjAHMd2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 07:33:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E95BF5C
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 04:33:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD3B60C12
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 12:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27134C433EF;
        Sun,  8 Jan 2023 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673181205;
        bh=4TthHC5Q+H+F9h8PUhClsn4/Ta9qqKLqzWa7Z+PzfwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p9qeTCFEZqGmUXbh2i7c7Rk6MN6uKAdIMG0b4HMCtVHXtyL2KeJft90EX7rHFumGP
         UMuGdLd0x2JraggqBUaD3hI79g+ktV9PrP/7e9zsTTnMN2JMTpHmPF7wD/oq6CZR7+
         vxq8zX7tRG10TVKVt6YHT5BwIvEy0XcHVOLsgWG42xyu8v2bv3Pc+9vuCw8SiAIb0O
         yCM0VpLGk4gio/gU1+B+hCE4xAGInFzpuQtdR3PjDuVNXeG7cnM05HS+acLw4AZNVF
         W8ydXEUNfOfLtHd8pQIoBQ6Dpaes9uKzKh9Kj4xrhyEEsALQFCcKUll7ub0Fe/E7Ew
         e3G3qv5iqflgQ==
Date:   Sun, 8 Jan 2023 12:46:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wahaj <wahajaved@protonmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org
Subject: Re: CM32181 Bug Report (Linux 6.0+)
Message-ID: <20230108124654.514a5b1b@jic23-huawei>
In-Reply-To: <8sH16OwIJbnTXpjBaNVGn7Qpv1HmPww_fiXBQ2EfhLkhjWnf90kGxXKfHhyZX9Eu2JqsozqOFWEk3smuGqYxkSZNxEPHTkTTjBc2n7ksRhw=@protonmail.com>
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com>
        <20230103112629.000063e8@Huawei.com>
        <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com>
        <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com>
        <8sH16OwIJbnTXpjBaNVGn7Qpv1HmPww_fiXBQ2EfhLkhjWnf90kGxXKfHhyZX9Eu2JqsozqOFWEk3smuGqYxkSZNxEPHTkTTjBc2n7ksRhw=@protonmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 07 Jan 2023 00:37:40 +0000
Wahaj <wahajaved@protonmail.com> wrote:

> ------- Original Message -------
> On Friday, January 6th, 2023 at 9:08 AM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> > Hi Wahaj,
> > 
> > On Fri, Jan 6, 2023 at 12:26 AM Wahaj wahajaved@protonmail.com wrote:
> >   
> > > ------- Original Message -------
> > > 
> > > On Tuesday, January 3rd, 2023 at 2:26 PM, Jonathan Cameron Jonathan.Cameron@Huawei.com wrote:
> > >   
> > > > On Wed, 28 Dec 2022 14:05:24 +0000
> > > > Wahaj wahajaved@protonmail.com wrote:  
> > >   
> > > > > Hi Jonathan
> > > > > 
> > > > > Hope you're doing well. I have been using a laptop that comes with a
> > > > > CM32181 Light Sensor and after upgrading to the Linux kernel 6.0+, my
> > > > > laptop cannot seem to suspend because of the PM subsystem error. I
> > > > > have narrowed the problem down to this module and I believe that the
> > > > > commit 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20bis the culprit
> > > > > 
> > > > > The following lines were provided from the journalctl logs:
> > > > >   
> > > > > > cm32181 i2c-CPLM3218:00: PM: dpm_run_callback():
> > > > > > acpi_subsys_suspend+0x0/0x60 returns -121 cm32181 i2c-CPLM3218:00:
> > > > > > PM: failed to suspend async: error -121  
> > > > > 
> > > > > I would love the chance to be able to work on this given any guidance
> > > > > on where to start  
> > > > 
> > > > Hi Wahaj,
> > > > 
> > > > Certainly seems likely that you have identified the right commit.
> > > > As a starting point, resend this email to linux-iio@vger.kernel.org
> > > > and Kai-Heng Feng kai.heng.feng@canonical.com
> > > > 
> > > > If you could try reverting the commit to be completely sure it is
> > > > the cause that would help avoid any doubt.
> > > > Superficially the only thing that I can see causing this problem is
> > > > a fail of the i2c bus write.
> > > > 
> > > > Does the device work prior to suspend? Try cat /sys/bus/iio/iio:device0/*
> > > > and see if you get any errors (may be device1 etc)
> > > > 
> > > > If the device wasn't working at all the register writes in probe() should
> > > > have failed so we shouldn't be trying to suspend it.
> > > > It's possible your machine has some unusual power dependencies or
> > > > similar that mean the device is getting powered down before we try to
> > > > suspend it.
> > > > 
> > > > Anyhow, better to have this discussion on list as there are many other people
> > > > who may have more insight than me or be able to replicate and help debug.
> > > > 
> > > > Jonathan
> > > >   
> > > > > Best Regards,
> > > > > Wahaj Javed  
> > > 
> > > Hi Jonathan and Kai-Heng Feng,
> > > 
> > > I am currently using the 5.15 linux kernel for a while now which works perfectly fine.
> > > 
> > > From what I gather the suspend functionality does work when using an older Linux version without the PM i2c bus writes.  
> > 
> > 
> > Does your system use S3 or S2idle to perform suspend?
> >   
> My system uses S3 to perform suspend
> > > The device does work fine prior to and post attempted suspend with no errors showing in cat /sys/bus/iio/iio:device0/*  
> > 
> > 
> > Does in_illuminance_input value change after system suspend?  
> Yes, the in_illuminance_input value changes after system suspend with or without the suspend and resume functions
> 
> 
> > 
> > Kai-Heng
> >   
> > > Let me know if there's anything I should start looking into
> > > 
> > > Best Regards
> > > Wahaj Javed  
> 
> How did the kernel used to suspend/resume before using the suspend and resume functions in the light sensor?
> 
> Was the DEFINE_SIMPLE_DEV_PM_OPS introduced as a part of the Linux 6.0+ PM rework?

Until https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68c1b3dd5c48b2323067f8c1f0649ae2f31ab20b
which will have hit mainline in 6.0, the driver had no suspend / resume support.

That patch introduced an i2c write to put the chip into a low power mode.
My best guess for a cause would be that something else is incorrectly being disabled
before this call and hence breaking the i2c comms.

Jonathan

> 
> I would like to take on this bug and try to solve it if that's possible
> 
> 
> Best Regards
> Wahaj Javed

