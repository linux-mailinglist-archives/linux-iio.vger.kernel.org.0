Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41343B7DD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390955AbfFJO5J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 10:57:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43655 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390087AbfFJO5J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jun 2019 10:57:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so8233253ljv.10;
        Mon, 10 Jun 2019 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PYmx133KZQoJKDFhZXpflZLvuaXqiDVJHDj8dnvFK3c=;
        b=fbu4D2EgerCZ8FNWJPtQDISqx63NaDowo7n/mstpGpU/xykkL8yOFxZuacw62v6XQf
         1iJo5/rx8BI29ePuVNjIwPs4EnoJ/3coLMCxG7+TH/JLrRZp/Rx3guDb3eNY9J/mBFx7
         SCVXNggMrj1hRcUw+FVPQphyH8TF3hGv5Gn3lbxPWYZXjmsrau2ZHfSm5wPmKZwwZwca
         IT+YYg1GBYyb9v+BownkloeB6fHIOvAdPkNyeP3SuaOYUqypnK9AI/i9lrTy8Aom51SK
         Ponr29VCpDxtxTYyO3B0XlR92ftOpNO5E9SvhOPuMNuHiFYhf/aY9uZJVi/Ne3WvgJuV
         n9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PYmx133KZQoJKDFhZXpflZLvuaXqiDVJHDj8dnvFK3c=;
        b=rn+eLt9TXSVvTTpjxKrG+qBjy79Isg7x22VGGuIfcA6LL8ja/u8kYi3I1Tt7CSQWCQ
         hlqL3nBV6MvU1lnUO+8J9zt9Optr0Fm18AA9VfuzE4k7IwaX+B6skxkzTq1tH3ypB100
         sk9GYq/NQ8zbVIt2ccwNIc6mnLJbhXUIG0hOf6+eCROnsSPnN1Z4ktABrM0RnE3KlxEi
         ktE5HeELLIBq7UqkhACFxpKvd8iZ3Mq4Jq0yAe5hNPrUrduWSBDmFt7UOmMSrJQPT8V7
         yzdpfLdSyngj32cgsJ9g8ViV6sDn1zSlRD/GD9n+OfvgzQiFqENcjXUZ6f0c9xi2LjUv
         rOSQ==
X-Gm-Message-State: APjAAAUsWIypz2pUsgUuv0ZmYyWVwAvrMOIqxq+JNwYE8oyBgUW0nuvv
        Xmi76MiJM2pXrWp1OJmzVbE=
X-Google-Smtp-Source: APXvYqwkoaAsQc0xLpcBSP3WoJ20Ez1h8UYrPQfhT1yfxDdElhqvqJkB19rRLWhY4W32ccUwgR/3qg==
X-Received: by 2002:a2e:29c4:: with SMTP id p65mr7961612ljp.141.1560178626442;
        Mon, 10 Jun 2019 07:57:06 -0700 (PDT)
Received: from mobilestation ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id q1sm2041202lfc.79.2019.06.10.07.57.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 07:57:05 -0700 (PDT)
Date:   Mon, 10 Jun 2019 17:57:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Jean Delvare <jdelvare@suse.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Add ads1000/ads1100 voltage ADCs driver
Message-ID: <20190610145702.fa7px7zkic4x5zqd@mobilestation>
References: <20190514225810.12591-1-fancer.lancer@gmail.com>
 <20190514225810.12591-3-fancer.lancer@gmail.com>
 <20190530125510.GA26072@roeck-us.net>
 <20190603121117.0000512c@huawei.com>
 <20190605205556.GA397@roeck-us.net>
 <20190607230144.fnkzljhnnqks5oqx@mobilestation>
 <02ff9666-d666-c539-aeb3-9e67fc358b17@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ff9666-d666-c539-aeb3-9e67fc358b17@roeck-us.net>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Guenter

On Fri, Jun 07, 2019 at 06:02:48PM -0700, Guenter Roeck wrote:
> On 6/7/19 4:01 PM, Serge Semin wrote:
> > Hello folks
> > 
> > On Wed, Jun 05, 2019 at 01:55:56PM -0700, Guenter Roeck wrote:
> > > On Mon, Jun 03, 2019 at 12:11:17PM +0100, Jonathan Cameron wrote:
> > > > On Thu, 30 May 2019 05:55:10 -0700
> > > > Guenter Roeck <linux@roeck-us.net> wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > On Wed, May 15, 2019 at 01:58:09AM +0300, Serge Semin wrote:
> > > > > > These are simple Texas Instruments ADC working over i2c-interface with
> > > > > > just one differential input and with configurable 12-16 bits resolution.
> > > > > > Sample rate is fixed to 128 for ads1000 and can vary from 8 to 128 for
> > > > > > ads1100. Vdd value reference value must be supplied so to properly
> > > > > > translate the sampled code to the real voltage. All of these configs are
> > > > > > implemented in the device drivers for hwmon subsystem. The next dts
> > > > > > properties should be specified to comply the device platform setup:
> > > > > >   - vdd-supply - voltage regulator connected to the Vdd pin of the device
> > > > > >   - ti,gain - programmable gain amplifier
> > > > > >   - ti,datarate - converter data rate
> > > > > >   - ti,voltage-divider - possible resistors-base external divider
> > > > > > See bindings documentation file for details.
> > > > > > 
> > > > > > Even though these devices seem more like ads1015 series, they
> > > > > > in fact pretty much different. First of all ads1000/ads1100 got less
> > > > > > capabilities: just one port, no configurations of digital comparator, no
> > > > > > input multi-channel multiplexer, smaller PGA and data-rate ranges.
> > > > > > In addition they haven't got internal voltage reference, but instead
> > > > > > are created to use Vdd pin voltage. Finally the output code value is
> > > > > > provided in different format. As a result it was much easier for
> > > > > > development and for future support to create a separate driver.
> > > > > 
> > > > > This chicp doesn't have any real hardware monitoring characteristics
> > > > > (no limit registers). It seems to be better suited to be implemented
> > > > > as iio driver. If it is used as hardware monitor, the iio-hwmon bridge
> > > > > should work just fine.
> > > > > 
> > > > > Jonathan, what do you think ?
> > > > Sorry for slow response, was on vacation.
> > > > 
> > > > Agreed, this looks like a standard multipurpose ADC so probably more suited
> > > > to IIO. Whether you bother with a buffered /chardev interface or not given it
> > > > is a fairly slow device is a separate question (can always be added later
> > > > when someone wants it).
> > > > 
> > > > Note the voltage-divider in the DT properties is something that should
> > > > have a generic representation. In IIO we have drivers/iio/afe/iio-rescale.c
> > > > for that, in this case using the voltage divider binding.
> > > > 
> > > > gain and datarate are both characteristics that should be controlled from
> > > > userspace rather than via a binding.
> > > > 
> > > 
> > > In summary: Serge, please re-implement the driver as iio adc driver.
> > > 
> > 
> > Thanks for the comments. I see your point, but since you are asking of a pretty
> > much serious code redevelopment, I want to make sure it is fully justified.
> > 
> > I made my decision of creating the hwmon driver following the next logic.
> > Before I started this driver development, I searched the kernel for either a
> > ready-to-use code or for a similar device driver to add the ads1000 ADC support.
> > I found the ads1015 driver, which is created for TI ADC1015 ADCs. These devices
> > are similar to the ads1000 series, but are more complex. Due to the complexity
> > I decided to create a separate driver for ads1000s, and of course since the similar
> > device driver lived in hwmon, I chose it to be home of my new driver.
> > 
> > But now you are asking me to move it to IIO, while the driver of more complex
> > ads1015 device exists in the hwmon subsystem of the kernel. Moreover the ads1000
> 
> A driver for ADS1015 also exists in drivers/iio/adc/ti-ads1015.c, meaning there
> are already two drivers for that chip. Accepting the driver for ads1000 into
> hwmon would ultimately mean that we would end up with another duplicate driver,
> as soon as someone needs iio support for this chip. From hwmon perspective,
> that driver would have zero additional functionality.
> 
> Users would then have to choose between the hwmon ads1000 driver and the iio
> ads1000 driver plus iio->hwmon bridge. The kernel maintainers would have to
> maintain two drivers instead of one, for no good reason. We would therefore
> at that time remove hwmon driver from the kernel because it doesn't make sense
> to keep two drivers for the same chip if both drivers provide exactly the same
> functionality. This just doesn't make sense.
> 
> On top of that, the ads1000 has zero characteristics of a typical hardware
> monitoring chip. It doesn't have any limit or alarm status registers.
> 
> > device is utilized on our board to monitor system itself (voltage on the input
> > DC-DC). Could you please tell me why the driver should really be in IIO instead
> > of hwmon and how do you select which subsystem one or another driver is supposed
> > to live in?
> > 
> If a chip has typical hardware monitoring characteristics such as slow but accurate
> conversion rates and limit/alarm registers, we are happy to accept it into the
> hardware monitoring subsystem. If the chip has no such characteristics,
> it should be implemented as iio driver.
> 
> Actually, we should remove the ads1015 driver from the hwmon subsystem.
> I'll start a separate thread to discuss that.
> 

Thank you very much for the detailed explanation. I can't believe I missed that
iio-version of ads1015. I'll take a look at that. If it's possible to add
ads1000 support right into the ads1015 drive, I'll do this. Otherwise I'll
port the ads1000 to the IIO subsystem as you suggested.

Regards,
-Sergey

> Thanks,
> Guenter
