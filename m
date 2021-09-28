Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9153041AD0B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhI1KgA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 28 Sep 2021 06:36:00 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50403 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhI1Kf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 06:35:59 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 72B1C2000F;
        Tue, 28 Sep 2021 10:34:16 +0000 (UTC)
Date:   Tue, 28 Sep 2021 12:34:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 35/47] mfd: ti_am335x_tscadc: Add ADC1/magnetic
 reader support
Message-ID: <20210928123415.332f9d5a@xps13>
In-Reply-To: <YUtTFEv1YFOMeuEb@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
        <20210915155908.476767-36-miquel.raynal@bootlin.com>
        <YUtTFEv1YFOMeuEb@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

> >  static const struct ti_tscadc_data tscdata = {
> >  	.has_tsc = true,
> > +	.has_mag = false,
> >  	.name_tscmag = "TI-am335x-tsc",
> >  	.compat_tscmag = "ti,am3359-tsc",
> >  	.name_adc = "TI-am335x-adc",
> > @@ -341,11 +356,25 @@ static const struct ti_tscadc_data tscdata = {
> >  	.target_clk_rate = TSC_ADC_CLK,
> >  };
> >  
> > +static const struct ti_tscadc_data magdata = {
> > +	.has_tsc = false,
> > +	.has_mag = true,  
> 
> Why 2 bools?
> 
> Better to have a single u8:
> 
>   MODE_TOUCHSCREEN
>   MODE_MAG_STRING
>   MODE_NONE

I was about to add an enum for these but actually it is totally
redundant with the compatible name. Instead, I have added a
helper which checks the compatible string and gives the same
information.

Thanks,
Miquèl
