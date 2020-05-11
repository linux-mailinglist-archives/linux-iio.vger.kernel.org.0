Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE901CE1B9
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgEKRbG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 13:31:06 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729698AbgEKRbG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 May 2020 13:31:06 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 1BBEFD5F880730EEF03C;
        Mon, 11 May 2020 18:31:04 +0100 (IST)
Received: from localhost (10.47.24.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 May
 2020 18:31:03 +0100
Date:   Mon, 11 May 2020 18:30:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Saravanan Sekar <saravanan@linumiz.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: accel: wsen-itds accel documentation
Message-ID: <20200511183038.000031cf@Huawei.com>
In-Reply-To: <9e7b0365-deed-a647-ec36-b4e6ccfa2ae4@linumiz.com>
References: <20200429133943.18298-1-saravanan@linumiz.com>
        <20200429133943.18298-4-saravanan@linumiz.com>
        <20200503130103.16a92131@archlinux>
        <9e7b0365-deed-a647-ec36-b4e6ccfa2ae4@linumiz.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.74]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 May 2020 20:11:55 +0200
Saravanan Sekar <saravanan@linumiz.com> wrote:

> Hi Jonathan,
> 
> On 03/05/20 2:01 pm, Jonathan Cameron wrote:
> > On Wed, 29 Apr 2020 15:39:42 +0200
> > Saravanan Sekar<saravanan@linumiz.com>  wrote:
> >  
> >> Add documentation about device operating mode and output data range
> >> supported according to operating mode
> >>
> >> Signed-off-by: Saravanan Sekar<saravanan@linumiz.com>
> >> ---
> >>   .../ABI/testing/sysfs-bus-iio-wsen-itds       | 23 +++++++++++++++++++
> >>   1 file changed, 23 insertions(+)
> >>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds b/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
> >> new file mode 100644
> >> index 000000000000..5979f2b8aa1a
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
> >> @@ -0,0 +1,23 @@
> >> +What:		/sys/bus/iio/devices/iio\:device0/in_accel_samp_freq_available
> >> +KernelVersion:	5.7
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Reading gives range of sample frequencies available for current operating mode
> >> +		after one data has generated.  
> > This is standard ABI so should be the main docs, not here.
> > It also takes absolute precedence over the power modes (as mentioned below, no
> > standard userspace will be able to use those).  So if the frequency is
> > only available in high perf mode, then we change to high perf mode.
> >  
> >> +
> >> +		Access: Read
> >> +		Valid values: represented in Hz
> >> +		- range [12.5, 1600] for high permormance mode
> >> +		- range [1.6, 200] for normal/low power mode
> >> +
> >> +What:		/sys/bus/iio/devices/iio\:device0/operating_mode
> >> +KernelVersion:	5.7
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Represents the device operating mode. High performance mode gives high output
> >> +		data rate and low noise compared to normal mode. Normal mode consumes less
> >> +		current.  In single shot device enters to lowpower after one data has
> >> +		generated.
> >> +
> >> +		Access: Read, Write
> >> +		Valid values: "lowpower", "normal", "high_perf", "single_shot"  
> > The issue with these sort of 'mode' interface is almost no userspace will ever use them.
> > They are too unpredictable across different types of devices.  
> I don't understand how can we assume or say no one will use this. The 
> device supports multiple features
> and my understanding is driver should support according to device, not 
> reverse.

The aim of a subsystem and an ABI definition for such is to 'unify' and provide standard
ways of doing things.  It is against that 'standard' that userspace code will generally
be written.  So every time we define custom ABI for a device, we have basically written
something that the vast majority of userspace code will never use.  The only exception
is code written for a particular device.

So we have two options for features like this:

1) Map them to existing ABI wherever possible - ensure the code people have written
   already for userspace will do what they would expect.  Here it's a case of providing
   'reasonable' configuration for the full range of sampling frequencies.  That may
   miss some corners that are optimal but we may have to live with that.

2) Define new ABI that is 'generic' so that future user space code can use it.
   The problem with power modes is they are extremely device specific, so this second
   option is one we have never succeeded with.  In theory you could define a set of
   modes, but they would need to fully describing.  As in you would need a record that
   tells userspace every characteristic that is affected by each mode.
   To put it bluntly software doesn't read data sheets.  (nor for that matter to
   most userspace code developers :)

> This is more or
> less device specific and no sure idea about bring all the device in one 
> umbrella.

We have existing userspace code - quite a bit of it.  That code should work for your device.
It doesn't know about your own magic interface, so it won't use it.
That's the point of standardization around one interface, we want it to work.
Note that the only way we make that happen is to review new ABI very carefully
and often block it entirely.

> > Some of these should also not be exposed to userspace anyway as they are about 'how'
> > you are using the driver.  For example, if you aren't doing triggered capture then
> > single_shot is almost always the correct option. Annoyingly I see high performance
> > mode gives lower noise...
> >
> > So no need to expose single_shot to userspace.
> >
> > For the others we are just looking at different power vs speed and accuracy trade offs.
> > Those are better exposed by what they effect.  Here the big control for that is
> > sampling frequency.
> >
> > So if we assume the user is never going to touch this control (if it's even there)
> > then we probably want to assume they want the best possible accuracy for whatever
> > frequency they are running at.  So transition across the modes to provide that.
> >
> > Should we ever support low power mode?  It sounds nice on paper, but in reality
> > userspace won't use so I suspect we should just drop it - certainly in an initial
> > patch submission (as it will hold up acceptance).  Even if we did support
> > it, as mentioned above ABI controls will take precedence so we are looking
> > at a 'hint' not a control of mode.
> >
> > ABI is a pain, and we will put a lot of effort into not expanding it unless
> > there is a good usecase plus no way of mapping to existing ABI.  
> Obviously without any reason or requirement device manufacture won't 
> come-up these kind of feature.

Agreed, there are clear reasons for doing this, but until we understand the
target use case it is very hard to have a discussion about how an ABI will
be expanded.

> I will change the driver as you don't accept at least for initial version.

Great.

Thanks,

Jonathan


> 
> 
> Thanks,
> Saravanan
> 


