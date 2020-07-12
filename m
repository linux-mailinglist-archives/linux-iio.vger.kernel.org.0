Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775CA21C8A1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGLKzF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 06:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbgGLKyt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 06:54:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DE820720;
        Sun, 12 Jul 2020 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594551288;
        bh=h1ne07FHLiz8De2xC5xQiyVpWB1TPgnhI1R16gyd9rE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OgUWsd25psMIylJkYHXEp3NMXaozmh9NvyuXyvuWihkM0coGLJth8O/dQ8f7SLFq4
         xEQJr+sTJpspHqmnv8pEUJuXmQ82oKYQ0dXs7o7+f64+bqnIF3gpBwIAOh3bbJVfPM
         0xUdniTZBmE98I+USuLckPTE86B//PnNIUWRFKNc=
Date:   Sun, 12 Jul 2020 11:54:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eugene Zaikonnikov <ez@norphonic.com>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
Message-ID: <20200712115444.49dc18c6@archlinux>
In-Reply-To: <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com>
References: <86d053d1re.fsf@norphonic.com>
        <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 Jul 2020 18:27:09 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jul 10, 2020 at 2:54 PM Eugene Zaikonnikov <ez@norphonic.com> wrote:
> >
> > Add support for HDC2010/2080 driver and sysfs documentation for its
> > heater element.
> >
> > HDC2010 is an integrated high-accuracy humidity and temperature sensor
> > with very low power consumption. The device includes a resistive heating
> > element. The temperature range is -40C to 125C with 0.2C
> > accuracy. Humidity measurement is 0 to 100% with 2% RH accuracy.  
> 
> Now, some almost context-less comments to the contribution.
> 
> Please, use Datasheet tag(s) here with URL(s) to the datasheet(s).
> Also, be sure you are using https (note S) everywhere.
> 
> Datasheet: https://...
> Datasheet: ...
> 
> > Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>  
> 
> 1. No need to put file name into the file
> 2. Missed at least bits.h inclusion
> 3. Keep comma in HDC2010_GROUP_HUMIDITY
> 4. IIO_CONST_ATTR can be one line, but hey don't we have IIO core to
> take care of it?

For that one, we could indeed use the read_avail callback here
for the out_current_heater_raw_available. I've not yet started insisting
on this because of the huge number of drivers that predate introduction of
that stuff to the core and as a result a lack of good examples.
Eugene, if you are happy to change this one over to that and hence act
as an example it would be great!

> 5. Use traditional pattern
> 
> if (ret)
>   return ret;
> 
> data->drdy_config = tmp;
> 
> return 0;
> 
> 6. Indent better
> 
> if (!i2c_check_functionality(client->adapter,
>     I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
> 
> (or split last line above by operand per line or alike)
> 
> 7. Drop unneeded casting
> tmp = (data->measurement_config & ~HDC2010_MEAS_CONF) | HDC2010_MEAS_TRIG;
> 
> 8. It's one line
> ret = i2c_smbus_write_byte_data(client,
>     HDC2010_REG_MEASUREMENT_CONF, tmp);
> 
> Ditto:
> dev_warn(&client->dev, "Unable to restore default AMM\n");
> 
> In general it doesn't look bad!
> 

Thanks,

Jonathan

