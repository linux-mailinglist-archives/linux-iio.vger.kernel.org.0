Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936942B3019
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 20:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgKNTTi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 14:19:38 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59045 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKNTTi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 14:19:38 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E4F291BF205;
        Sat, 14 Nov 2020 19:19:34 +0000 (UTC)
Date:   Sat, 14 Nov 2020 20:19:34 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] iio: adc: at91_adc: merge at91_adc_probe_dt back in
 at91_adc_probe
Message-ID: <20201114191934.GB5272@piout.net>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
 <20201113212650.507680-6-alexandre.belloni@bootlin.com>
 <20201114170804.4b51c84b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114170804.4b51c84b@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/11/2020 17:08:04+0000, Jonathan Cameron wrote:
> > -	ret = at91_adc_probe_dt(idev, pdev);
> > -	if (ret)
> > -		return ret;
> > +	st->caps = (struct at91_adc_caps *)
> > +		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
> 
> of_device_get match_data  - obviously an unrelated change but trivial enough
> I'd just slip it in this patch (unless you have it a later one!)
> 
> That returns a void * so no need for the cast.
> 

I guess I will change the next patch to use of_device_get_match_data as
Andy doesn't like it when the fo_ and device_ APIs are mixed.

> > +	st->registers = &st->caps->registers;
> > +	st->num_channels = st->caps->num_channels;
> > +
> > +	/* Check if touchscreen is supported. */
> > +	if (st->caps->has_ts) {
> > +		ret = at91_adc_probe_dt_ts(node, st, &idev->dev);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	platform_set_drvdata(pdev, idev);
> >  
> > @@ -1091,7 +1072,6 @@ static int at91_adc_probe(struct platform_device *pdev)
> >  	if (IS_ERR(st->reg_base))
> >  		return PTR_ERR(st->reg_base);
> >  
> > -
> Stray change that shouldn't be in this patch ideally but not that important.
> 

I know I sneaked this one in but I didn't want to have that as a separate
patch ;). I'll drop it.

