Return-Path: <linux-iio+bounces-19849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CB6AC2C91
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB6D3B99CC
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DAE1C5486;
	Sat, 24 May 2025 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUcz2oJL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FB4C7C;
	Sat, 24 May 2025 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748044827; cv=none; b=oIw1smAJjPqc5wVTE2UdltkaqS8QvRf2wjkLNZfcOdY1F8KPeiSIiU7/M+Ndq2dSyDRdYf6KMJXNPGw2PbMej19eXmWIGiRZVeWXRhVggogPDn2MqtYVnSAn+vOsDZw+4eUm1KblzeRppiUmMX/8pzygHi2OUWX6xofNwtonjTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748044827; c=relaxed/simple;
	bh=TNxK7mTWRgfqHFOlA9knAWb8UG7aQsjnNGtP0nwujr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjhPic57ucu1gUS74iCZYUxZ5Jbmgrw99NekuoD7SNCSH5ULCK5h0xXBJ4PPbkMZ/LhLc9bzudUNH7elzh/VyCiLFb1/TK+NN9Sa2EQW5vVHxRTw5J31jbky6wsK8IaJPOqsi1S9jYHbCUj79d3HBZb2EQHp1cVmfcEBYEW+NBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUcz2oJL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fa9c907cacso719386d6.1;
        Fri, 23 May 2025 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748044824; x=1748649624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9g0bCtwZKg4p785vc5FWBzUYXiC+e3vu3lEqFvrGvvQ=;
        b=FUcz2oJLRLwh7TG27ciHJRTX7uNuPhlqlv8MibCAN1+uZxHRUC1TryF/cGnYNn7p9x
         ulQeDt4ZZso6P/E/tJNOk5xGqNVCyg6gRzQvlyjJ/UfioZIQqU1/YKChbPnbRXHbvPZq
         PWmfc04O70+kD7LqiZkOst3q7vW9772P/L+eTtuReFIlUuWbXBzdFWTMo72rGsa23XSs
         kxOtG2LJ8CtH+YkYN0XmBmu0ltuKj8lottvIeQ//vBG7QzKKj/tx5j/QEuPnxnA2L6T4
         any5OnXi3bcBSFkbcAmz7zesd0KBjSwov2OmrhnGGyjRtLOnGBthg3JT0fYDQt7TpH93
         EHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748044824; x=1748649624;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9g0bCtwZKg4p785vc5FWBzUYXiC+e3vu3lEqFvrGvvQ=;
        b=LsLEBoA/8LsAopHhrIB1gF3GarNLFWDO4P6FHDE5SK2eNwtaethQQmsE+qY5u6chjY
         x/KaoOCFeFAg7cNUE+MLXhI7pL3mxOeSRzAu3R19CtLDzG9/zAdYGzepSi/42BguVQus
         iAflXaF6W5at+JKEkJYNYbM7YbNSe8lFrtvuNuL+saZ5bb+eax18Df8jc8C+GKnhq5bD
         a1xpprFfMr3U+4Eou05aHtrowu7PBMR9IkD4IVZdCYYt6SYJ6q+QkARYV5Ps5CzCH/Jw
         lXDIVqi5ttNyddQIVV/uCYezM8zBVDXP6aFhmIwf7RLL+OJI7xbawIKqLg/jjnL2zgfU
         V0vg==
X-Forwarded-Encrypted: i=1; AJvYcCUSUMFr+aaTzpE7Uj4HaRf9qA0C4AZmj60pbv+uhD9c/gkCdF48WrIysdR2SNDcXTm9U796bnN0KCQZdnXU@vger.kernel.org, AJvYcCXDx3S4p8B2kRZS7nhmkio1/m4k2mkGgd7U4fskbtsPTUoZkWyUwCl3lRwMHbs40ssdpS/rNhG7xam8@vger.kernel.org, AJvYcCXNs/MI2KimsFhxb0nl8yrRHw47ANzW+rlWqbxM29x0++qA961Ez/tOKTcilWD3cnc1An4zcNdDKed2@vger.kernel.org, AJvYcCXeqye8InnnhmmhZzHgB2ISRDJKAubP70nuc+DgCVd/5Ye8Y5wWDgthvBc0iAkOJv1UHjeK1ryeCa5d3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyutb6Ry4YTDnxjovBfiameVSa2g5hrEIVN3U3N/D69mZigMcnH
	eLe3k+7uCC+39f3z4CFxFe5EbG9OywRq1Rj1tUZRwUzXHpVgKU0re6VO
X-Gm-Gg: ASbGncs7U3A4hRX5HQhCusQvVWHmoEqKVPR6F3prvA0ouHpDOF/DMSGNWHozHQvBQWB
	WJcMNjK6Vfa4xaxyLgqFsChONqScYjFXId2DIjjo4BVFGhEXVo3rFl+Zt2W/RXunOjWTz2w8bZh
	UCRXat9ODRiv8mkHmgJ/2dkvKv82ZFXb53oyYUZF/5gkzdywZldWS/409C4U3SHij4T/Tcl6jI7
	+lsb6WgNdScdwpupIbGng32dVR8atJyv/ZcNUPqgAzl5l3FYAcELp40Rc4la2Uvygr8ySb6jGLZ
	DU3CHP/9ajr4qartTePLVJ8zAGh4XvKzQzGbzQsNnVBl7J8/39Ht16tGr9e7DxjWWCLT0WVk8Tc
	VErS7h3g=
X-Google-Smtp-Source: AGHT+IH6VVwSEesBgULWBddMghxWcMgx95hbJxuBZHbEXRgYNm4ei9O3lM42bP5G9QWa4OOvSKv9Lw==
X-Received: by 2002:ac8:5710:0:b0:48a:80e5:72bb with SMTP id d75a77b69052e-49f46055e2cmr7140761cf.2.1748044824092;
        Fri, 23 May 2025 17:00:24 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae528ffasm120727491cf.73.2025.05.23.17.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 17:00:23 -0700 (PDT)
Date: Fri, 23 May 2025 21:00:17 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v8 08/11] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <aDEMEWQvu0r9stCh@JSANTO12-L01.ad.analog.com>
Reply-To: 20250518175832.77b8d670@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
 <59f45c9af16fa68f2a479f824129f5a9f2cd0997.1747175187.git.Jonathan.Santos@analog.com>
 <aCcFXolH0FVBSP11@smile.fi.intel.com>
 <20250518175832.77b8d670@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518175832.77b8d670@jic23-huawei>

On 05/18, Jonathan Cameron wrote:
> On Fri, 16 May 2025 12:29:02 +0300
> Andy Shevchenko <andy@kernel.org> wrote:
> 
> > On Thu, May 15, 2025 at 06:13:56PM -0300, Jonathan Santos wrote:
> > > The synchronization method using GPIO requires the generated pulse to be
> > > truly synchronous with the base MCLK signal. When it is not possible to
> > > do that in hardware, the datasheet recommends using synchronization over
> > > SPI, where the generated pulse is already synchronous with MCLK. This
> > > requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
> > > 
> > > Use trigger-sources property to enable device synchronization over SPI
> > > and multi-device synchronization while replacing sync-in-gpios property.  
> Given some discussion in here I'll not (yet) pick up this series.
> 
> It's almost certainly just missed the coming merge window anyway so
> we have time.
> 
> > 
> > ...
> > 
> > > +static int ad7768_trigger_sources_get_sync(struct device *dev,
> > > +					   struct ad7768_state *st)
> > > +{
> > > +	struct fwnode_reference_args args;
> > > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> > > +	 * to synchronize one or more devices:
> > > +	 * 1. Using an external GPIO.
> > > +	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
> > > +	 *    synchronization pulse that drives the SYNC_IN pin.
> > > +	 */
> > > +	if (!fwnode_property_present(fwnode, "trigger-sources")) {  
> > 
> > I'm wondering if you can split the below to a separate function and do something like
> > 
> > 	if (fwnode_property_present(...))
> > 		return setup_trigger_source(...);
> > 
> > 	...
> > 	en_spi_sync = true;
> > 	return 0;
> > 
> > > +		/*
> > > +		 * In the absence of trigger-sources property, enable self
> > > +		 * synchronization over SPI (SYNC_OUT).
> > > +		 */
> > > +		st->en_spi_sync = true;
> > > +		return 0;
> > > +	}
> > > +
> > > +	ret = fwnode_property_get_reference_args(fwnode,
> > > +						 "trigger-sources",
> > > +						 "#trigger-source-cells",
> > > +						 0,
> > > +						 AD7768_TRIGGER_SOURCE_SYNC_IDX,
> > > +						 &args);  
> > 
> > 
> > __free(fwnode_handle) ?
> 
> For args.fwnode?
> 
> That's fiddly to do and needs a different local variable to...
> 
> 
> 
> > 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	fwnode = args.fwnode;
> 
> this one.
> 
> You could wrap it up in a function to make that works cleanly.
> So something similar to fwnode_find_reference() but with the
> rest of the arguments.  Is there appetite for such a wrapper
> in the generic property code?
>

you mean like:

fwnode_find_reference_args(const struct fwnode_handle *fwnode,
			   const char *name, const char *nargs_prop,
			   unsigned int nargs, unsigned int index,
			   struct fwnode_reference_args *args)

I don't know if it helps that much and since we are not handling
arguments right know, I think fwnode_find_reference() would work (or not?).
In that case maybe we add some note or TODO to explain why. 

> 
> > > +	/* First, try getting the GPIO trigger source */
> > > +	if (fwnode_device_is_compatible(fwnode, "gpio-trigger")) {
> > > +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, fwnode,
> > > +							       NULL,
> > > +							       0,
> > > +							       GPIOD_OUT_LOW,
> > > +							       "sync-in");
> > > +		ret = PTR_ERR_OR_ZERO(st->gpio_sync_in);
> > > +		goto out_put_node;
> > > +	}
> > > +
> > > +	/*
> > > +	 * TODO: Support the other cases when we have a trigger subsystem to
> > > +	 * reliably handle other types of devices as trigger sources.
> > > +	 *
> > > +	 * For now, return an error message. For self triggering, omit the
> > > +	 * trigger-sources property.
> > > +	 */
> > > +	ret = dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> > > +
> > > +out_put_node:  
> > 
> > The above will allow to get rid of this label.
> > 
> > > +	fwnode_handle_put(args.fwnode);
> > > +	return ret;
> > > +}  
> > 
> 

