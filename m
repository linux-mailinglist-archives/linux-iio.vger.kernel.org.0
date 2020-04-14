Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE11A7A1C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgDNLwI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 07:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbgDNLwG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 07:52:06 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.102.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC477206D5;
        Tue, 14 Apr 2020 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586865126;
        bh=Fdj1YVdp//ceZ9oMqGAN8F8tYVPLTWDDFpuFS8d9ZK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvLl7gxIK83JbrlKz158gl7mOTjXgiogxIFkzAfjjz+oIY5zBWsHqzrNFmgAqOLbA
         P/zzA3lQB9Qd8GhjnQIg/w6omdvO2ltpJYdcrpsC36+XJuHHDFS9eJQhe7h7x2Ost3
         nxZiqNMd+376EhOyEglUhGg3Hizw1Q0W+Df/EDvc=
Date:   Tue, 14 Apr 2020 17:21:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: Add OF match table for CCS811 VOC
 sensor
Message-ID: <20200414115153.GC21559@Mani-XPS-13-9360>
References: <20200412183658.6755-1-mani@kernel.org>
 <20200412183658.6755-4-mani@kernel.org>
 <20200413175054.626283dc@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413175054.626283dc@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 05:50:54PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Apr 2020 00:06:58 +0530
> mani@kernel.org wrote:
> 
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > Add devicetree OF match table support for CCS811 VOC sensor.
> > 
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Hi,
> 
> A few small things to clean up inline
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/chemical/ccs811.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> > index 6cd92c49c348..313931208f61 100644
> > --- a/drivers/iio/chemical/ccs811.c
> > +++ b/drivers/iio/chemical/ccs811.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> 
> You are including this just to get things in mod_devicetable.h
> so include that directly instead.
> 

I added this include for of_match_ptr. Since it is not needed anymore, I'll drop
this.

> >  
> >  #define CCS811_STATUS		0x00
> >  #define CCS811_MEAS_MODE	0x01
> > @@ -538,9 +539,16 @@ static const struct i2c_device_id ccs811_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ccs811_id);
> >  
> > +static const struct of_device_id ccs811_dt_ids[] = {
> > +	{ .compatible = "ams,ccs811" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ccs811_dt_ids);
> > +
> >  static struct i2c_driver ccs811_driver = {
> >  	.driver = {
> >  		.name = "ccs811",
> > +		.of_match_table = of_match_ptr(ccs811_dt_ids),
> No need for the of_match_ptr macro.  It has several issues.
> 
> 1) Blocks PRP001 ACPI magic device types being used to instantiate
> this using the device tree binding but under ACPI.
> 2) Will give warnings about ccs811_dt_ids being unused on no
>    device tree builds.
> 

Okay, will use ccs811_dt_ids directly.

Thanks,
Mani

> >  	},
> >  	.probe = ccs811_probe,
> >  	.remove = ccs811_remove,
> 
