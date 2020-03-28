Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7111966C1
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgC1Og4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgC1Og4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:36:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C5420716;
        Sat, 28 Mar 2020 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585406214;
        bh=AWdBYh99FDHxI0k2K+e0lUAvGRN3tYo0uPU7p+6s9S4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aCE5lAg7ZAbFB2QqZWTO9Ytqpq8Ek03zf1FWXpzOU9ExxA4j43AiZfyVgmo72rCfg
         ZeUvMskWeunoUn8xCBTM3TFDQbHnWmPfupuFiJcb0rQrgSJSo5zPsBJIfQF+hNmQ9O
         oeukZzXIDGLvt3/BRLGaaSIptKHaZ5+x+xiXJVrQ=
Date:   Sat, 28 Mar 2020 14:36:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     saravanan sekar <sravanhome@gmail.com>, robh+dt@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200328143649.2a428bee@archlinux>
In-Reply-To: <20200327102221.GA3383@dell>
References: <20200322224626.13160-1-sravanhome@gmail.com>
        <20200322224626.13160-3-sravanhome@gmail.com>
        <20200327075541.GF603801@dell>
        <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com>
        <20200327102221.GA3383@dell>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020 10:22:21 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> Saravanan, Jonathan,
> 
> On Fri, 27 Mar 2020, saravanan sekar wrote:
> > On 27/03/20 8:55 am, Lee Jones wrote:  
> > > On Sun, 22 Mar 2020, Saravanan Sekar wrote:
> > >   
> > > > mp2629 is a highly-integrated switching-mode battery charge management
> > > > device for single-cell Li-ion or Li-polymer battery.
> > > > 
> > > > Add MFD core enables chip access for ADC driver for battery readings,
> > > > and a power supply battery-charger driver
> > > > 
> > > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > > ---
> > > >   drivers/mfd/Kconfig        |   9 +++
> > > >   drivers/mfd/Makefile       |   2 +
> > > >   drivers/mfd/mp2629.c       | 116 +++++++++++++++++++++++++++++++++++++
> > > >   include/linux/mfd/mp2629.h |  22 +++++++
> > > >   4 files changed, 149 insertions(+)
> > > >   create mode 100644 drivers/mfd/mp2629.c
> > > >   create mode 100644 include/linux/mfd/mp2629.h  
> 
> [...]
> 
> > > > +static int mp2629_probe(struct i2c_client *client)
> > > > +{
> > > > +	struct mp2629_info *info;  
> > > Call this ddata instead of info.  
> > Not sure the reason, I will do.  
> 
> Because this is device data.  Info is too loose of a definition.
> 
> > > > +	struct resource	*resources;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> > > > +	if (!info)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	info->dev = &client->dev;
> > > > +	i2c_set_clientdata(client, info);
> > > > +
> > > > +	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
> > > > +	if (IS_ERR(info->regmap)) {
> > > > +		dev_err(info->dev, "Failed to allocate regmap!\n");
> > > > +		return PTR_ERR(info->regmap);
> > > > +	}
> > > > +
> > > > +	for (i = 0; i < MP2629_MFD_MAX; i++) {
> > > > +		mp2629mfd[i].platform_data = &info->regmap;
> > > > +		mp2629mfd[i].pdata_size = sizeof(info->regmap);  
> > > You don't need to store this in platform data as well.
> > > 
> > > You already have it in device data (ddata [currently 'info']).  
> > 
> > "The IIO parts seems fine (minor comments inline) but I'm not keep on
> > directly accessing the internals of the mfd device info structure.
> > To my mind that should be opaque to the child drivers so as to provide
> > clear structure to any such accesses.
> > 
> > This mess in layering with the children directly using the parents
> > regmap is a little concerning. It means that the 3 drivers
> > really aren't very well separated and can't really be reviewed
> > independently (not a good thing)."
> > 
> > This is the review comments form Jonathan on V2, not to access parent data
> > structure directly.
> > Am I misunderstood his review comments? please suggest the better option to
> > follow as like in V2
> > or V2 + some improvements or V4 + improvements?  
> 
> I will take this up with Jonathan separately if necessary.
> 
> For your FYI (and Jonathan if he's Cc'ed), it's very common for a
> child of an MFD to acquire resources from their parent.  That is the
> point of a lot of MFDs, to obtain and register shared resources and
> pass them onto their offspring.  There are 10's of examples of this.
> 
> Things like Regmaps aren't platform data, they are device/driver data,
> which is usually passed though platform_set_drvdata().
> 

Fair enough.  It seemed a bit messy to have full visibility of the
parent driver structures just to access one element.

What I was actually meaning to suggest was a couple of wrapper functions,
not passing the regmap separately, but I guess that doesn't really make
any difference.  

So a read / write wrapper that just takes an abstract ddata pointer.

Fair enough if you think that's an unnecessary bit of abstraction.

Jonathan

> [...]
> 
> > > > + */
> > > > +
> > > > +#ifndef __MP2629_H__
> > > > +#define __MP2629_H__
> > > > +
> > > > +#include <linux/types.h>
> > > > +
> > > > +struct device;
> > > > +struct regmap;  
> > > Why not just add the includes?  
> > Some more shared enum added in ADC driver  
> 
> Sorry?
> 
> > > > +struct mp2629_info {
> > > > +	struct device *dev;
> > > > +	struct regmap *regmap;
> > > > +};
> > > > +
> > > > +#endif  
> 

