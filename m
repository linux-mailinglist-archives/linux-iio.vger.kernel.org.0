Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44D141041
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2020 18:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAQRxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jan 2020 12:53:11 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbgAQRxL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jan 2020 12:53:11 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8C6A6AEF7A93634FEC18;
        Fri, 17 Jan 2020 17:53:09 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 Jan 2020 17:53:08 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 17 Jan
 2020 17:53:08 +0000
Date:   Fri, 17 Jan 2020 17:53:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Linux Input <linux-input@vger.kernel.org>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        "Jonathan Bakker" <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v4] iio: light: Add a driver for Sharp GP2AP002x00F
Message-ID: <20200117175307.00000c8c@Huawei.com>
In-Reply-To: <CACRpkdbDEhCu8LVBT_xjuar1UgCPALJg0V12varZjG-eGqj=2Q@mail.gmail.com>
References: <20200112111341.21388-1-linus.walleij@linaro.org>
        <20200112111341.21388-2-linus.walleij@linaro.org>
        <20200112165404.GA72221@gerhold.net>
        <CACRpkdbDEhCu8LVBT_xjuar1UgCPALJg0V12varZjG-eGqj=2Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 22:02:00 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Jan 12, 2020 at 5:54 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > It seems to work fine on samsung,golden with gp2ap002s00f.
> > There are interrupts being sent when something moves in front of the
> > sensor and iio-event-monitor looks good too:
> >
> > Tested-by: Stephan Gerhold <stephan@gerhold.net>  
> 
> Thanks! I think I'm up at v7 or something on this driver
> and now it looks good.
> 
> > Out of curiosity: I'm not so familiar with the IIO subsystem,
> > is it intended that the sensor is active the whole time?
> > Wouldn't it be better to activate it only when something is reading
> > /dev/iio:device2?  
> 
> IMO the best way to power manage an IIO sensor is like I do in
> drivers/iio/gyro/mpu3050-core.c
> 
> Of course I think it is excellent code since I wrote it. Beware
> of hubris in the driver.
> 
> The idea is to take the runtime pm handle on the device
> whenever in use (reading values from the hardware or
> using the trigger), and then use autosuspend to completely
> shut it down (including regulators) when not in use. If the power-up
> time for the sensor is long, then the autosuspend timeout
> should be proportionally longer, like a magnitude or two above.
> 
> With the proximity events I have this problem that I don't know
> in the driver if someone had opened the file to read events
> or not, only the core knows, I think. I just emit my events
> and be happy.
> 
> Jonathan: is there a way for the driver to know if someone
> is listening on the event interface?

Hmm. Normally we'd do it on someone actually enabling the events on
the basis I'd expect userspace to open the file then enable the events.

Nothing stops us doing it on file open I guess, but not sure what the
real world benefit would be.

> 
> > There is one problem I noticed, although I'm not sure if it is a problem
> > in this driver. Reading one of the files in the sysfs results in:
> >
> > $ cat /sys/bus/iio/devices/iio\:device2/events/in_proximity_thresh_either_en
> > Segmentation fault  
> 
> That looks like an ordinary bug, but that seems to be for the
> core? Hm...
Ah.. Seems I missed that you have the driver set event spec for enable, but
didn't actually provide the callback function.   + we clearly don't sanity
check that one.  Hence IIO core could do with hardening but driver is
buggy as well.

+static const struct iio_event_spec gp2ap002_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};

Means you must supply read_event_config in iio_info.
It's a bit odd if you don't also supply write event config for that
matter though that wasn't the bug here. It would cause a similar
bug if you wrote the sysfs file though :)

Kind of also explains why my logic about enabling the event
doesn't apply currently.

Good find from Stephan on both fronts.

Jonathan

> 
> Yours,
> Linus Walleij


