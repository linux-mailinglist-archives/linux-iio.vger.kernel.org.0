Return-Path: <linux-iio+bounces-306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A8C7F66F6
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 20:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8311C2108B
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B864B5DE;
	Thu, 23 Nov 2023 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDfcvTch"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB63210;
	Thu, 23 Nov 2023 19:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C706C433C7;
	Thu, 23 Nov 2023 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700766588;
	bh=H31tYMRMi9KqwFq+p39ksYkA9U91as7rK22EFXyG874=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cDfcvTch5RfNfxfF5D79XFdoatrLc/szYurTXztwWV/Dqw2WfIvQRbT1ly1TJRkr1
	 JdnTlb4EQGY1DiK2wriv9OEDl28V0vdl7Dtcbl3phz7B9SzdMCTD9ePpKgjNPVah4c
	 J7EkAjCek5sBU/ZDkej90SIeovaVGGEpOIBo4NfyAJHgVqVjkdMP/gla45kzs7imCv
	 z5TGPafyWpBEln7Ci39ksTkqTtO1jWWOQFRlmIh9BT7ntLm7JigCIZN/E04Y3wN2eq
	 v3f6L4nGQ2mtNfDRqsaYJtCDCEoKOqE5udKhRbKrXsyvn4yCz8FWKHHacSNJMpo/CN
	 9yf6M2Tk+P45g==
Date: Thu, 23 Nov 2023 19:09:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: mitrutzceclan <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
 brgl@bgdev.pl, linux-gpio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231123190936.51f61b8d@jic23-huawei>
In-Reply-To: <ZV-CHima8bpXcopc@smile.fi.intel.com>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
	<20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
	<ZV-CHima8bpXcopc@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> ...
> 
> > +	return vref / (MICRO/MILLI);  
> 
> Wouldn't MILLI in the denominator just suffice?

Just a quick comment here. Given this is converting from micro to milli units
I'd consider the maths here be acting as documentation of that which would be lost if
/MILLI only used.  Need spaces around the / though


> 
> ...
> 
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		reg = st->channels[chan->address].cfg.odr;
> > +
> > +		*val = st->info->sinc5_data_rates[reg] / MILLI;
> > +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO/MILLI);
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	}  
> 
> > +		ret = fwnode_property_read_string(child, "adi,reference-select", &ref_label);
> > +		if (!ret) {
> > +			for (i = 0; i < ARRAY_SIZE(ad7173_ref_sel_str); i++)
> > +				if (strcmp(ref_label, ad7173_ref_sel_str[i]) == 0) {
> > +					ref_sel = i;
> > +					break;
> > +				}  
> 
> > +			if (i == ARRAY_SIZE(ad7173_ref_sel_str))
> > +				return dev_err_probe(dev, -EINVAL, "Invalid channel reference name %s", ref_label);  
> 
> Too long line.
> 
> > +		} else if (ret != -EINVAL) {
> > +			return dev_err_probe(dev, ret, "Invalid channel reference value");
> > +		}  
> 
> 
> Use standard pattern and it will be easier to see that 'else' is redundant.
> 
> 		if (ret == -EINVAL) // However I don't like this handling of
> 				    // properties, but up to you and maintainer

Personally I'd check for existence of property first and only try reading if it
exists.  Avoid dance with resetting ret to 0.

> 			ret = 0;
> 		if (ret)
> 			return dev_err_probe(...);
> 
> 
> BUT. Isn't it a home grown variant of fwnode_property_match_property_string()?

true enough...  I'd still add an existence check first given this one is optional.

Jonathan

