Return-Path: <linux-iio+bounces-11853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6D29BA22E
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 20:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B222822BA
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 19:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7D1A4E9E;
	Sat,  2 Nov 2024 19:48:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508315E5B5
	for <linux-iio@vger.kernel.org>; Sat,  2 Nov 2024 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730576896; cv=none; b=cglFP7V8jVrlxDpKpk9XZUKQaYzYjAyp//fx1eeX8ui3+W8kCN78j7PkvcuK7udY0u4rYSrDJBitFuNPiW1dQZVYMY5wqo37L5+FTMy2SGbSP8Qx0q4V6uQgpyo0olMmtC339RmC7XUDNQI7DlCK1s6iB5riDC4etOXI1J1O+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730576896; c=relaxed/simple;
	bh=L4xMV/8gYoMZk3Q3diI5SpjBN7teilAKah//V0XO1UI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfrkmDAtvP4hqDZf+2J0acoy57cjm3JGwK3wkEzpVX0BNzOH7T5/8uUGB5RdKQ9HN4/zkPQQ4121nUA0ckRSe0iwOYXgrHp4azDGTTijMPDX2BrnJNz41dKPPXkdAFwkCxswWanhH8FtMiwmjd8XOGhgOo3jfuIoHhPKwnvXw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6061fdeb-9953-11ef-8871-005056bdd08f;
	Sat, 02 Nov 2024 21:48:05 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Nov 2024 21:48:04 +0200
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de,
	marius.cristea@microchip.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <ZyaB9G1baF10FzZD@surfacebook.localdomain>
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

This ID might be okay, but can we please have:
1) the list of the models (or a model) of the device on the market that has this;
2) ACPI DSDT excerpt of the respective Device object?

(I mean a laptop, tablet, phone or other device that has this sensor described
in the ACPI)

...

> +/*
> + * documentation related to the ACPI device definition

Documentation

> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */

...

> +	if (ACPI_HANDLE(dev))

Hmm... Want this be really needed? You can try to call DSM. and if it fails try
DT (or actually other way around as we usually do).

> +		ret = pac1921_match_acpi_device(indio_dev);
> +	else
> +		ret = pac1921_parse_of_fw(indio_dev);

...

> +static const struct acpi_device_id pac1921_acpi_match[] = {
> +	{ "MCHP1921" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);

Missing blank line here.

...

>  	.driver	 = {
>  		.name = "pac1921",
>  		.pm = pm_sleep_ptr(&pac1921_pm_ops),
>  		.of_match_table = pac1921_of_match,
> +		.acpi_match_table = pac1921_acpi_match


Missing trailing comma here.

>  	},

-- 
With Best Regards,
Andy Shevchenko



