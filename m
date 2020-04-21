Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9071B246C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 12:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgDUKzv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 06:55:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbgDUKzv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Apr 2020 06:55:51 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EF84BD6786AB5C32E036;
        Tue, 21 Apr 2020 11:55:48 +0100 (IST)
Received: from localhost (10.47.92.218) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 21 Apr
 2020 11:55:48 +0100
Date:   Tue, 21 Apr 2020 11:55:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Berghe, Darius" <Darius.Berghe@analog.com>
CC:     "Pop, Cristian" <Cristian.Pop@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [RFC] IIO way of representing device operation range ?
Message-ID: <20200421115535.00002016@Huawei.com>
In-Reply-To: <5fcdceb2360500e029ab3174437def939c0134b2.camel@analog.com>
References: <9d9fd2c70f793a9637f581e7ed0574012a3006f9.camel@analog.com>
        <20200417101949.00003770@Huawei.com>
        <5fcdceb2360500e029ab3174437def939c0134b2.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.218]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 10:26:53 +0000
"Berghe, Darius" <Darius.Berghe@analog.com> wrote:

> On Fri, 2020-04-17 at 10:19 +0100, Jonathan Cameron wrote:
> > This is really a question to address in a userspace library, not
> > a the level of the kernel interfaces.  Whilst it may look lovely and
> > elegant to do it down in the kernel, having two interfaces to the
> > same
> > basic controls is often a recipe for long term disaster.  It's fine
> > for userspace to iterate through all the options of each control and
> > build up a set of range pairs complete with how to get to them.  We
> > could
> > simplify this by putting precedence into the ABI description. Right
> > now
> > I'm fairly sure we don't say anything on that.  
> 
> Hi Jonathan, and thanks for the comments,

Hi Darius,

One thing to note is that the interface for runtime range changing
discussion has been going for 10 years and I've held firm against
it so far on basis of complexity of ABI and it never having been
a 'real' requirement as opposed to support all the knobs on a device.
Note below does mention that you can 'read' range using existing
defined ABI and there are some consumers who need that info to
do scaling of touchscreen units for example.

> 
> I assume your refer to scale and offset as the basic controls. In this
> case, having a new range member in iio_chan_info_enum that controls
> both scale and offset at the same time would mean that the write_raw
> would not need to implement direct setting of scale and offset. It
> could probably even be ensured at compile time that write_raw for scale
> and offset are not implemented when the range is implemented. 
> 
> Thus, write_raw would implement only the range (setting both offset and
> scale in the background), and read_raw would implement offset and scale
> to be able to read them and do the transform to physical units of the
> raw value.

The issue here is that would require 'all' userspace to be modified to support
this new interface.  To avoid that the 'legacy' offset + scale write method
needs to be supported.  Also note that we have always defined the ABI to
include the possibility for one change to affect the options available on other
attributes.

As mentioned earlier, changing the range is actually an extremely unusual
activity in real systems (with the exception of light sensors where this
is typically done automatically and not exposed to userspace at all -
userspace would have no idea what to do with it anyway), so I'll
take a lot of convincing to make our ABI more complex just to
make that slightly more intuitive to support.

> 
> > 
> > Now, the additional problem you have here is that may you have to
> > transition
> > through non existent states which makes for a slightly odd userspace
> > interface.
> > If you enable the channel when not in a valid state then that enable
> > will
> > have to fail.  
> 
> Exactly, and I would like if possible to avoid that because it implies
> code in kernel to handle those situations, and code in userspace to
> handle it too.

Kernel regularly has to handle this sort of configuration restriction,
so such is life.

For userspace it's not unusual to have to 'walk' a set of one configuration
parameters to find out what is possible for another one.
> 
> I thought of a range as a solution but please come with other
> suggestions if you think this is not fit, maybe see the chip
> requirements below first to get a better idea.

Userspace library support for exploring the available settings and
presenting that to a user who actually wants to tweak this.

It's a nested for loop. Maybe 5-10 lines of code assuming a few utility
functions.

Note that you can provide read only range of values the channel can
take in any setting using the existing out_voltage_available attribute
and a range output from the read_avail callback.

disable channel (shouldn't be considering changing these after enable anyway)

for_each_value(scale_avail)
   set_scale
   for_each_value(offset_avail)
	set_offset
	read_avail and record 4 values (min, max, scale, offset).

reset to some default state.

Each of the avail attrs needs to take into account the current setting
of whatever takes precedence.

Only thing needed to do this for all devices would be define precedence
for scale and offset when one effects the other.  When it doesn't then
the walk will still work but result will be rather less interesting ;)

We'd need to add the precedence ordering to the ABI docs and check no
existing driver breaks it (or cross our fingers no one notices).
 
> 
> > 
> > One reason we have never gone there for DACs in particular is that
> > its
> > not unheard of for changing the range to result in burnt tracks. 
> > Hence
> > this is normally considered a board configuration question and pushed
> > to devicetree or similar.  Devicetree should at least provide a list
> > of
> > 'safe' limits.
> > 
> > What is the requirement driving this flexibility?  
> 
> Please check AD5770R datasheet, page 29, you may see where this
> requirement comes from. But this is definitely not the only chip
> requiring this, it is just a good fitting example.
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD5770R.pdf

That's not a use case. That is a chip supporting the functionality.
I can see for 'dev kits' you might want to do this - for a real device
this is not something that is changed live.  If we have to make it slightly
hard for dev kits which tend to ship with example code anyway, such is
life.

For real shipping product it almost always belongs in system configuration such
as device tree.  Also note that there would be an absolute requirement
for controls in devicetree governing what settings are safe for a given
device. Without those we should not enable the DAC at all.
For existing multirange DACs we only provide configuration via DT.

Jonathan


> 
> Thanks and best regards,
> Darius Berghe


