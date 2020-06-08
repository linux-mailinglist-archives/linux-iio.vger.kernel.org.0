Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976041F1A92
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgFHOJI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFHOJI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 10:09:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231AAC08C5C2;
        Mon,  8 Jun 2020 07:09:08 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jiISS-00083D-MF; Mon, 08 Jun 2020 16:09:00 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 22334100F9F; Mon,  8 Jun 2020 16:09:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Nyekjaer <sean@geanix.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
In-Reply-To: <fbef0ac8-e313-c20c-9300-9dee00588102@geanix.com>
References: <20200603080619.GA544784@lore-desk.lan> <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com> <20200603102841.GC544784@lore-desk.lan> <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com> <20200603105105.GD544784@lore-desk.lan> <a6716a15-abf9-3218-00b8-fb7f257e5649@geanix.com> <20200603121227.GE544784@lore-desk.lan> <55fb09cf-76ab-0c42-7283-0836838f2deb@geanix.com> <20200603125630.GF544784@lore-desk.lan> <2d60c115-a634-c25f-b50b-38f13cac6229@geanix.com> <20200603134033.GG544784@lore-desk.lan> <2d8b2b9b-5e63-1254-04d9-8b9be0d91877@geanix.com> <fbef0ac8-e313-c20c-9300-9dee00588102@geanix.com>
Date:   Mon, 08 Jun 2020 16:09:00 +0200
Message-ID: <87k10habur.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sean,

Sean Nyekjaer <sean@geanix.com> writes:
> I have a question regarding CLOCK_REALTIME and CLOCK_BOOTTIME when 
> resuming from suspend.
>
> We have run into problems with
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c + the first patch from
> Lorenzo Bianconi in this thread.  The accelerometer have an internal
> FIFO that includes a timestamp. When we resume from suspend, the
> driver resets the fifo ts counter and sets an internal reference to
> that time.
>
> But to me it looks like both CLOCK_REALTIME and CLOCK_BOOTIME aren't 
> ready when st_lsm6dsx_resume() is called.

That depends on your system. Timekeeping is resumed way before drivers
are resumed, but the suspend time injection might happen late when there
is no early device to read from. In this case it happens when the RTC is
resumed.

If the IIO driver resumes before the RTC which injects the suspend time,
then the core time is still in the past. And RTC is using the default
resume mechanism, so depending on device/class registration order this
might be the case. Deferring to the PM & RTC wizards.

Thanks,

        tglx


