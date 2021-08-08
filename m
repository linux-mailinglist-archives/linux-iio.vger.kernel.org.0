Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3923E3B56
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhHHQUb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 8 Aug 2021 12:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhHHQUa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 12:20:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4322760F38;
        Sun,  8 Aug 2021 16:20:07 +0000 (UTC)
Date:   Sun, 8 Aug 2021 17:22:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: potentiometer: Add driver support for AD5110
Message-ID: <20210808172257.59b13400@jic23-huawei>
In-Reply-To: <66d670d6-0374-88ae-c4c1-efd60b54bbd2@gmail.com>
References: <20210807050900.10075-1-dmugil2000@gmail.com>
        <20210807050900.10075-3-dmugil2000@gmail.com>
        <53306463-668e-e291-4539-caca2352ea05@metafoo.de>
        <9b58fb0c-245d-795f-2124-6cc2020bc8c5@gmail.com>
        <66d670d6-0374-88ae-c4c1-efd60b54bbd2@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 7 Aug 2021 23:04:18 +0530
Mugilraj Dhavachelvan <dmugil2000@gmail.com> wrote:

> Sorry some formatting issues happened in my previous mail.
> 
> On 07/08/21 10:56 pm, Mugilraj Dhavachelvan wrote:
> > 
> > 
> > On 07/08/21 5:41 pm, Lars-Peter Clausen wrote:  
> >> On 8/7/21 7:08 AM, Mugilraj Dhavachelvan wrote:  
> >>> The AD5110/AD5112/AD5114 provide a nonvolatile solution
> >>> for 128-/64-/32-position adjustment applications, offering
> >>> guaranteed low resistor tolerance errors of ±8% and up to
> >>> ±6 mA current density.
> >>>
> >>> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
> >>> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>  
> >>
> >> Thanks for the patch. This looks really good> 
> >>  
>

...

> >>> +
> >>> +static IIO_DEVICE_ATTR(wiper_pos_eeprom, 0644,
> >>> +               ad5110_eeprom_read,
> >>> +               ad5110_eeprom_write, 0);  
> >> This is new custom ABI and needs to be documented  

We have existing similar ABI in dac/mcp4725 which is simply
called store_eeprom

It's in the main docs
Documentation/ABI/testing/sysfs-bus-iio as storing
device configuration.  I'm guessing this device doesn't have
other configuration so that description will work?


> 
> > I'm not aware of this, fixed in v2.  
> >>> +static int ad5110_write_raw(struct iio_dev *indio_dev,
> >>> +                struct iio_chan_spec const *chan,
> >>> +                int val, int val2, long mask)
> >>> +{
> >>> +    struct ad5110_data *data = iio_priv(indio_dev);
> >>> +    int ret;
> >>> +
> >>> +    switch (mask) {
> >>> +    case IIO_CHAN_INFO_RAW:
> >>> +        if (val >= data->cfg->max_pos || val < 0)  
> >> val == data->cfg->max_pos is a valid setting. Writing max_pos puts it in top-scale mode which gives maximum resistance.  
> > Fixed in v2.  
> >>> +            return -EINVAL;
> >>> +
> >>> +        return ad5110_write(data, AD5110_RDAC_WR, val << data->cfg->shift);
> >>> +    case IIO_CHAN_INFO_ENABLE:
> >>> +        if (val < 0 || val > 1)
> >>> +            return -EINVAL;
> >>> +        if (data->enable == val)
> >>> +            return 0;
> >>> +        ret = ad5110_write(data, AD5110_SHUTDOWN, val);  
> >> Doesn't val have to be inverted to get the right behavior  
> 
> > I just replicated the datasheet operation. 
> > You mean,
> >  1 - shutdown off
> >  0 - shutdown on
> > If yes, then the user won't get confused with the datasheet and the behavior of the driver?
> > Or Is it work like this? But yeah even I like this change it's more convenient.  

ABI has to be consistent and writing an enable attribute with 1 has to mean enabling it whatever
approach the datasheet takes to describe things.  Most users don't read
datasheets so interface needs to be intuitive.

> >>> +        if (ret)
> >>> +            return ret;
> >>> +        data->enable = val;
> >>> +        return 0;
> >>> +    default:
> >>> +        return -EINVAL;
> >>> +    }
> >>> +}  
> >> [...]  
> > Thanks for feedback!!
> >   

