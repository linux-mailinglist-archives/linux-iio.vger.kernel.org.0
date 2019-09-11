Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB4AF9C1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2019 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfIKKAi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Sep 2019 06:00:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbfIKKAi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Sep 2019 06:00:38 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 401ECA04E75352E041CD;
        Wed, 11 Sep 2019 18:00:34 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 18:00:31 +0800
Date:   Wed, 11 Sep 2019 11:00:23 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Bobby Jones <rjones@gateworks.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: FXOS8700 Accelerometer/Magnetometer Support
Message-ID: <20190911110023.00000016@huawei.com>
In-Reply-To: <CALAE=UBhLi=B09FZhZOO3PAsjVTPDP1kkH=AG4V5UrmC=wXhWg@mail.gmail.com>
References: <CALAE=UBN7ZPGTHB_jgSje0zG3mCvE8auW1FTrbjn=KbJzN_How@mail.gmail.com>
        <20190714161623.0127bbcb@archlinux>
        <CALAE=UBhLi=B09FZhZOO3PAsjVTPDP1kkH=AG4V5UrmC=wXhWg@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Sep 2019 14:36:44 -0700
Bobby Jones <rjones@gateworks.com> wrote:

> Hello Jonathan and iio,
> 
Hi Bobby.

> I've finally been able to circle back to this effort. I've spent some
> time last week referencing the misc driver I linked to originally
> while refactoring the BMI160 imu driver as a starting point (it
> honestly just seemed like the simplest 2-sensor device) and am a
> little stuck with the implementation.
> 
> When defining the iio_chan_spec structs that will be assigned to the
> iio_dev.channels array, everything makes sense when the fxos8700 only
> has 1 sensor enabled. It is my understanding that the
> iio_info.read_raw function will be called with the type/channel and
> the proper regmap calls I've set up will be made. Now my confusion
> begins when considering how to support both devices enabled. According
> to the datasheet this means that "hybrid" mode is enabled, which
> halves the data rate and requires a single burst transaction to read
> all of the output data registers. If any data output register is not
> read, that data will be lost. So when the IIO subsystem calls on a
> single channel for data and the unit is in hybrid mode I don't see how
> I can avoid loss of data.
> 
> I'm assuming there is a different way I should be setting up the
> iio_info and iio_chan_spec structs but I'm not sure how to go about
> it. I believe this may have something to do with the
> iio_info.read_raw_multi function and the
> iio_chan_spec.info_mask_shared* fields. Can anyone provide input? If
> it helps I've posted my wip at
> https://github.com/Bobby-Soliis-Jones/iio_imu_fxos8700.

There are two modes in which an IIO device can be accessed from
userspace.

1. Polling which uses read_raw etc.  That if for slow single channel data.
There are no guarantees that you will get a consistent set etc.  Don't worry
about dropping readings in this mode.  It involves reading text files from
sysfs, it is 'slow' :)

2. A push mode, which uses a character device (called buffered mode in
IIO because it actually reads from the device into a fifo so as to allow
userspace to come along when it's ready and retrieve the data).

That second mode is the way you deal with devices where you want a full
read of a set of channels.  For that, you explicitly enable the channels
that you actually want then the core code will work out from the available
set of scan_masks which one is the smallest superset of these.

In this case I think that will mean, if you have any magnetometer channels
enabled it will read the whole thing.

I note this device also has a hardware fifo.  That usually complicates
things a bit, but there are lots of examples in tree.  When such
a fifo exists, you normally get to chose between triggering reads of
the channels on demand (from say a high resolution timer trigger) or
using the fifo which will be clocked by the device itself.

One thing to note is that it is optional to support read_raw when
operating in buffered mode. Many drivers don't because it can add a lot
of complexity and isn't a common way of using the devices.

Fifo trigger mode looks fun, but that's definitely something to ignore
for an initial driver :)  Also lots of different 'events' that could
be supported (probably not in an initial driver though).

Anyhow, v1 driver might just support the read_raw interface and provide
no guarantees on consistent data.  Up to you if you also want to support
buffered mode in the initial driver or add that in a follow up set.

Thanks,

Jonathan




> 
> Thanks in advance!
> Bobby Jones



