Return-Path: <linux-iio+bounces-11861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3209BA25C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 21:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAEA283B8D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B721AAE33;
	Sat,  2 Nov 2024 20:03:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F413BAF1
	for <linux-iio@vger.kernel.org>; Sat,  2 Nov 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577801; cv=none; b=LqZPsxZS7bdchi80Cuha0no7jSH8dBcVSzDBRLZ1rsdOfiUCj6NC4mjYFRdidpyWgyurO4oi68VMrVY8FZ3PdEztmAizp1vRzOaVuOl630emwof2+XtMcVKCqoiz8LYvlOZ0maemifwPzCtiKMrtaDAfOICP7Sixe21tlhu4AC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577801; c=relaxed/simple;
	bh=DtP5FSIkG2PIybT2p8GApK3yMLeLjIu4VMFq5eFVZPw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4nsIsz3dxa9z7QRVY0KPPLQsL1SkJwobhjOpsRO1EUZLyQEQRoeuyFc4l8LLrmvVjmjd6FDxd5eyBadfAVRP9yFieF5cdgEWVjGP3MYHA5p/KF6iH07skMBrABW7KunFYgrUd4IBV+2qGzVTfD5tUog25DKUZx1BEvq09w77qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 516c248d-9955-11ef-968f-005056bdf889;
	Sat, 02 Nov 2024 22:01:59 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Nov 2024 22:01:58 +0200
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de,
	marius.cristea@microchip.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <ZyaFNsuWOOK1HHg0@surfacebook.localdomain>
References: <20241031065205.50154-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031065205.50154-1-victor.duicu@microchip.com>

Thu, Oct 31, 2024 at 08:52:05AM +0200, victor.duicu@microchip.com kirjoitti:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.

More comments below.

...

> +#define PAC1921_ACPI_GET_UOHMS_VALS             0

uOHM ?

#define PAC1921_ACPI_GET_uOHM_VALS             0

...

> +/* The maximum accepted value of shunt_resistor in UOHMS <= INT_MAX */
> +#define PAC1921_MAX_SHUNT_VALUE_OHMS		2147

Instead of the comment do it like this:

#define PAC1921_MAX_SHUNT_VALUE_OHM		(INT_MAX / MICRO)

Need to include limits.h and units.h.

...

> +static inline bool pac1921_shunt_is_invalid(u32 shunt_val)

is_invalid is confusing name, make it rather is_valid

> +{
> +	return shunt_val == 0 || shunt_val > INT_MAX;
> +}

...

> +	/* This check is to ensure val * MICRO won't overflow */
> +	if (val < 0 || val > PAC1921_MAX_SHUNT_VALUE_OHMS)
> +		return -EINVAL;
> +
>  	rshunt_uohm = val * MICRO + val_fract;
> -	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
> +	if (pac1921_shunt_is_invalid(rshunt_uohm))
>  		return -EINVAL;

With the above check how this can't be a dead code?

...

> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez)

Use status instead of rez for the variable name. This is kinda standard to keep
the return of ACPI APIs.

> +		return dev_err_probe(dev, -EINVAL,
> +				     "Could not read shunt from ACPI table\n");

...

> +	label = devm_kstrdup(dev, rez->package.elements->string.pointer, GFP_KERNEL);
> +	if (!label)
> +		return dev_err_probe(dev, -EINVAL, "Label is NULL\n");

We do not print an error for -ENOMEM, which should be here as the error code
(Jonathan already pointed out on this).

So, just

		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



