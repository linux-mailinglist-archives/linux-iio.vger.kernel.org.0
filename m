Return-Path: <linux-iio+bounces-2988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C98624F4
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 13:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168DC284057
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F343C47E;
	Sat, 24 Feb 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGVgb878"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF094250EA;
	Sat, 24 Feb 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777031; cv=none; b=a3p0wNsv0jZqJza81zoxmKVGtm5CvGcJf7Y7LHwJZuySAvUCbDQgNSUBc6QJKEWg04IQqssUPwK+PYt8/PtqbdY2sG/HvOnLaYKPienp8dpTay6bjYu5EHzem6aQDnm1I6+qQ0Wcu7MtEkUzWh0qoJhwXYlaeJyorziNkgkV9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777031; c=relaxed/simple;
	bh=ZWpsYiNfzULQnKaSo35Y3LNGUc+8+X9Y66Kzvcxbu2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMuGkn+CARBTqQBnI7HpZtUfWDSBV43vlR8oSUDnd0hQJjZYBPbEDYNZoqC1pELkBRBQGavIC+cIyqSnUlmZnObWd61LxDPGfFiH5oGiu6kWeFKMIV++GdnsXtCShxf9eXPPD8Fu/zExb3E5bqH2XC1QOmHDoam6s/uEsBdCVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGVgb878; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4DFC433F1;
	Sat, 24 Feb 2024 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708777031;
	bh=ZWpsYiNfzULQnKaSo35Y3LNGUc+8+X9Y66Kzvcxbu2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oGVgb878zFLcRiGmJBNTSDoVgTizDEsBm8RCVDQo0DgyOsC+zID/IZiQiVCGC+Qau
	 fuQDnLfxANuZYecB3ofHuux8YRs04UqEUI39+l/3aAI3XjRuiPOhbStRGyuOQTf1KN
	 YZmqTSf1gGIgUCmLHS2pztJqui1BxhNx1oOHtt1+MlR4ot3czhQ65x7h3ys9lPHrs1
	 elDtKb+QKk9dBRn3qHanpaM988LzuOpCUHht34IlZuUhuL3UpAzfYSIkU6fw7221W2
	 K4Of1Sta9XU5APFikXLq9gQvbyNMmt6WhTEmDn7srTrkll5G1niBzQGkKfzrTBwlBE
	 B2Cz1gm09dhqQ==
Date: Sat, 24 Feb 2024 12:16:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 09/15] iio: adc: stm32: Use
 device_for_each_child_node_scoped()
Message-ID: <20240224121651.260404a5@jic23-huawei>
In-Reply-To: <ZdM_P93vVIrBHkmg@smile.fi.intel.com>
References: <20240217164249.921878-1-jic23@kernel.org>
	<20240217164249.921878-10-jic23@kernel.org>
	<ZdM_P93vVIrBHkmg@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 13:45:03 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Feb 17, 2024 at 04:42:43PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Switching to the _scoped() version removes the need for manual
> > calling of fwnode_handle_put() in the paths where the code
> > exits the loop early. In this case that's all in error paths.
> > 
> > Note this includes a probable fix as in one path an error message was
> > printed with ret == 0.
> > 
> > Took advantage of dev_err_probe() to futher simplify things given no
> > longer a need for the goto err.  
> 
> ...
> 
> >  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;  
> 
> I believe with
> 
> 	struct device *dev = &indio_dev->dev;
> 
> you can make the below neater.

Agreed.  Given the users of indio_dev are all the error messages I'm touching
anyway, this is in scope for this patch I think.

> Also see some side notes.
> 
> > -	struct fwnode_handle *child;
> >  	const char *name;
> >  	int val, scan_index = 0, ret;
> >  	bool differential;
> >  	u32 vin[2];  
> 
> ...
> 
> >  		if (!ret) {  
> 
> Not a fan of this pattern, below we have two different patterns for the cases
> like this :-(

Likewise not a fan.

Tidying this up is unrelated enough though that I won't do it in this
series.

> 
> > +			if (strlen(name) >= STM32_ADC_CH_SZ)
> > +				return dev_err_probe(&indio_dev->dev, -EINVAL,
> > +						     "Label %s exceeds %d characters\n",
> > +						     name, STM32_ADC_CH_SZ);
> > +
> >  			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
> >  			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
> >  			if (ret == -ENOENT)
> >  				continue;
> >  			else if (ret)  
> 
> 
> This 'else' is redundant.
> 
> > +				return ret;
> > +		} else if (ret != -EINVAL)  
>
I shouldn't have dropped the bracket here, so I'll put that back for now.
 
> This also...
> 
> > +			return dev_err_probe(&indio_dev->dev, ret, "Invalid label\n");  
> 
> ...if you first do like
> 
> 		if (ret && ret != -EINVAL)
> 			return dev_err_probe(...);
> 		if (!ret) {
> 
> Another option
> 
> 		if (ret) {
> 			if (ret != -EINVAL)
> 				return dev_err_probe(...);
> 		} else {
> 
> ...
> 
> >  		differential = false;
> >  		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);  
> 
> ARRAY_SIZE()?
> 
> >  		/* diff-channels is optional */  
> 
> ...
> 
> >  		if (!ret) {
> > +			if (vin[0] != val || vin[1] >= adc_info->max_channels)
> > +				return dev_err_probe(&indio_dev->dev, -EINVAL,
> > +						     "Invalid channel in%d-in%d\n",
> > +						     vin[0], vin[1]);
> >  		} else if (ret != -EINVAL) {
> > -			dev_err(&indio_dev->dev, "Invalid diff-channels property %d\n", ret);
> > -			goto err;
> > +			return dev_err_probe(&indio_dev->dev, ret,
> > +					     "Invalid diff-channels property\n");
> >  		} 
> 
> As per above?
> 
Agree with all comments, but as you said side notes. Stuff to cleanup in a series
doing a wider driver clean up.

Thanks,

Jonathan



