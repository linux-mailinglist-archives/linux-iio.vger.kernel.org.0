Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA531AD9A8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgDQJUE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 05:20:04 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729987AbgDQJUD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Apr 2020 05:20:03 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9544ADD39F7A194D0130;
        Fri, 17 Apr 2020 10:20:02 +0100 (IST)
Received: from localhost (10.47.87.249) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 17 Apr
 2020 10:20:02 +0100
Date:   Fri, 17 Apr 2020 10:19:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Berghe, Darius" <Darius.Berghe@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Pop, Cristian" <Cristian.Pop@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [RFC] IIO way of representing device operation range ?
Message-ID: <20200417101949.00003770@Huawei.com>
In-Reply-To: <9d9fd2c70f793a9637f581e7ed0574012a3006f9.camel@analog.com>
References: <9d9fd2c70f793a9637f581e7ed0574012a3006f9.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.249]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 07:49:38 +0000
"Berghe, Darius" <Darius.Berghe@analog.com> wrote:

> Hi Jonathan,
> 
> Some devices (think DAC or ADC) have selectable contiguous operation
> ranges per channel, Rmin...Rmax, where Rmin and Rmax are the range
> minimum and maximum values expressed in physical units as in datasheet
> (mA, mV, etc).
> 
> Example DAC:
>         current0 0...50mA 0...100mA 
>         current1 0...200mA -60...200mA 0...100mA -60...100mA
> 
> physical [mV, mA, etc] = (raw + offset) * scale
> 
> One way of approaching this that I could find is let the user select
> offset and scale from a list of available offsets and scales. But due
> to the formula above, offset has higher priority in the computation and
> needs to be selected first. Once the user selects the offset, the list
> of scales may be recomputed by the driver. At this point the user may
> query available scales and select one.
> 
> Usage example, user wants to select -60...200mA:
> # cd /sys/bus/iio/devices/iio:device0 
> # cat out_current1_offset
> 0.0
> # cat out_current1_scale_available
> 0.003051757 0.001525878# cat out_current1_offset_available
> 0.0 -15123.0 -24576.0
> # echo -123456.0 > out_current1_offset
> # cat out_current1_scale_available
> 0,003967364
> # echo 0,003967364 > out_current1_scale
> 
> 
> All this is rather complicated for the user, being a two step
> procedure. Also, the user cannot pick a range in physical units as
> specified in the datasheet, but in a fractional (dimensionless) scale
> or a raw ADC/DAC register (dimensionless) offset.

> 
> Is there a direct way to select a contiguous operation range in
> physical units (as in datasheet) with the current state of the IIO ? I
> would like the user to only care about specifying Rmin and Rmax.

This is really a question to address in a userspace library, not
a the level of the kernel interfaces.  Whilst it may look lovely and
elegant to do it down in the kernel, having two interfaces to the same
basic controls is often a recipe for long term disaster.  It's fine
for userspace to iterate through all the options of each control and
build up a set of range pairs complete with how to get to them.  We could
simplify this by putting precedence into the ABI description. Right now
I'm fairly sure we don't say anything on that.

Now, the additional problem you have here is that may you have to transition
through non existent states which makes for a slightly odd userspace interface.
If you enable the channel when not in a valid state then that enable will
have to fail.

One reason we have never gone there for DACs in particular is that its
not unheard of for changing the range to result in burnt tracks.  Hence
this is normally considered a board configuration question and pushed
to devicetree or similar.  Devicetree should at least provide a list of
'safe' limits.

What is the requirement driving this flexibility?

Thanks,

Jonathan

> 
> Thanks,
> Darius Berghe


