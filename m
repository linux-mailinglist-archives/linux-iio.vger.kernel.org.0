Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3F19550C
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 11:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgC0KVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 06:21:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52972 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgC0KVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 06:21:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id z18so10845312wmk.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mxz8+ilE2NjB6kYVNyYap8z20EWNc89Zq7z80dHig9g=;
        b=lwFfgP7q0u5LzYu5IHEQz+moTPm67eiVbNP8jvxisTOsI5Ma9EXK0h13/GmZJTgMnl
         +Onr6bFvSPfXY+9YSNs3mbaMYQKyYOx/Nun1R1AIDyUetdtqqChqnXG7/1EIZeZJwG+h
         AoYjZMrLCixc4B2+nEQHEZhYmkVUgGuEFxsGPd1u8CQiLy2L6AQ8e4C5sS5mdW24AHni
         L423xnfJL3YVYLmXGSdDIk0Rk/t8gmiLBSeHvfIrZebXL+l1ni5cFPFsMcSjyofPyV6m
         rZrGDRGPqN0mT60S1tgbFGUZi4IjDSYnD6UJGS6q6bGnrTlVviriUNh9zl3/vfCBifys
         8g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mxz8+ilE2NjB6kYVNyYap8z20EWNc89Zq7z80dHig9g=;
        b=hkVI9OIOsAwWnVop7Im8+5/NZ4AWGwMh0RAd/kmV+OAx8yS658BfvrvmPu0UKa2Jft
         H2ty7xf3HUzu5WQrqQgrfhRZGy1uLpyXn16bwlttRHR3OF1ATFyLtd8+oeqn3nSKrlZ6
         ZrIuFaan67WXVBPUsC7m88Ih4BCe/3KFKEu7PzDl1Dhh3yotiK0LYvmjGz5d1t7wYzOJ
         YV6pigdJTNZc/i8L2HzlVCDhFPkJ0tny21/NUTzPAt1H6d1tTisKAOcqHeJTPUnM0bwW
         dtz5EWP+K2OfrR2oivTDJuQa9xcyQgaL9gPpEVKs/nKsWL12yzZpKsgbQjtXsuadVGql
         GztQ==
X-Gm-Message-State: ANhLgQ0Cf3Q5BMClkiJJxqbZNT4b9+Q+K4YyPpBylgyWFG8HflagIKtE
        AKDxSa9A4xJmznipEn3164T5eg==
X-Google-Smtp-Source: ADFU+vv/J6W+8sMVirHWEM1E3vhMlYyC18B4Hdl1cCEW5yYGJgHZTGUu0teFlFTlPWijkILtA2tP2g==
X-Received: by 2002:a1c:b4c6:: with SMTP id d189mr4433247wmf.132.1585304491231;
        Fri, 27 Mar 2020 03:21:31 -0700 (PDT)
Received: from dell ([95.149.164.95])
        by smtp.gmail.com with ESMTPSA id n9sm7646671wru.50.2020.03.27.03.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 03:21:30 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:22:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200327102221.GA3383@dell>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-3-sravanhome@gmail.com>
 <20200327075541.GF603801@dell>
 <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Saravanan, Jonathan,

On Fri, 27 Mar 2020, saravanan sekar wrote:
> On 27/03/20 8:55 am, Lee Jones wrote:
> > On Sun, 22 Mar 2020, Saravanan Sekar wrote:
> > 
> > > mp2629 is a highly-integrated switching-mode battery charge management
> > > device for single-cell Li-ion or Li-polymer battery.
> > > 
> > > Add MFD core enables chip access for ADC driver for battery readings,
> > > and a power supply battery-charger driver
> > > 
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > ---
> > >   drivers/mfd/Kconfig        |   9 +++
> > >   drivers/mfd/Makefile       |   2 +
> > >   drivers/mfd/mp2629.c       | 116 +++++++++++++++++++++++++++++++++++++
> > >   include/linux/mfd/mp2629.h |  22 +++++++
> > >   4 files changed, 149 insertions(+)
> > >   create mode 100644 drivers/mfd/mp2629.c
> > >   create mode 100644 include/linux/mfd/mp2629.h

[...]

> > > +static int mp2629_probe(struct i2c_client *client)
> > > +{
> > > +	struct mp2629_info *info;
> > Call this ddata instead of info.
> Not sure the reason, I will do.

Because this is device data.  Info is too loose of a definition.

> > > +	struct resource	*resources;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> > > +	if (!info)
> > > +		return -ENOMEM;
> > > +
> > > +	info->dev = &client->dev;
> > > +	i2c_set_clientdata(client, info);
> > > +
> > > +	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
> > > +	if (IS_ERR(info->regmap)) {
> > > +		dev_err(info->dev, "Failed to allocate regmap!\n");
> > > +		return PTR_ERR(info->regmap);
> > > +	}
> > > +
> > > +	for (i = 0; i < MP2629_MFD_MAX; i++) {
> > > +		mp2629mfd[i].platform_data = &info->regmap;
> > > +		mp2629mfd[i].pdata_size = sizeof(info->regmap);
> > You don't need to store this in platform data as well.
> > 
> > You already have it in device data (ddata [currently 'info']).
> 
> "The IIO parts seems fine (minor comments inline) but I'm not keep on
> directly accessing the internals of the mfd device info structure.
> To my mind that should be opaque to the child drivers so as to provide
> clear structure to any such accesses.
> 
> This mess in layering with the children directly using the parents
> regmap is a little concerning. It means that the 3 drivers
> really aren't very well separated and can't really be reviewed
> independently (not a good thing)."
> 
> This is the review comments form Jonathan on V2, not to access parent data
> structure directly.
> Am I misunderstood his review comments? please suggest the better option to
> follow as like in V2
> or V2 + some improvements or V4 + improvements?

I will take this up with Jonathan separately if necessary.

For your FYI (and Jonathan if he's Cc'ed), it's very common for a
child of an MFD to acquire resources from their parent.  That is the
point of a lot of MFDs, to obtain and register shared resources and
pass them onto their offspring.  There are 10's of examples of this.

Things like Regmaps aren't platform data, they are device/driver data,
which is usually passed though platform_set_drvdata().

[...]

> > > + */
> > > +
> > > +#ifndef __MP2629_H__
> > > +#define __MP2629_H__
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +struct device;
> > > +struct regmap;
> > Why not just add the includes?
> Some more shared enum added in ADC driver

Sorry?

> > > +struct mp2629_info {
> > > +	struct device *dev;
> > > +	struct regmap *regmap;
> > > +};
> > > +
> > > +#endif

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
