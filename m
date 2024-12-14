Return-Path: <linux-iio+bounces-13451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E509F1E80
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 13:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33DD1889E12
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418E1917EB;
	Sat, 14 Dec 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiUimzaG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72319066D;
	Sat, 14 Dec 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734178595; cv=none; b=cn2khBJuWnk09U/RmotuQwGivpwZruoAE6v1dt2YR5dc+O+8gcbXrxs+tCzuWtzLCcNuIbhGczbUI3N4Cl8TK728oTMIAB9DPnOVdGWYbEhfgRVrH9dH6+TbPXIrH/DtnD5LEknau5Nyt6kBhttsrRz7n8olIcpUbk30Coo79fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734178595; c=relaxed/simple;
	bh=8NbUaoRJSfTiPenvniNAPNrrdotf04coVGY+/+Q7VtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLEK/VrLqMGcd2GaBBW1y1KZrwguzG3AMe0/TSZpzybFRDI0n/a75i1dxiNHGzaPyrDtHakLIGI5mBGgH3tb+zp611y4D3hadt4zWnpIkvGjo/McePA1/w8XtDA/7J4oGTcdOuCOz4awNESuPMwu40AuHMIBzEQbsFmhMYZSq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiUimzaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73A2C4CED1;
	Sat, 14 Dec 2024 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734178595;
	bh=8NbUaoRJSfTiPenvniNAPNrrdotf04coVGY+/+Q7VtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GiUimzaGHnoL4v1WIXjKZ5yo2PfTkJsTMDRWLVp5jWIxBUz5mbkaz1xOOmFcgVUcD
	 /XBl46KN86dNRbFmEXDAAJICYBCulMl8PdgRSJpTXY2Nz1SOBZHedAa/HWQsecGZXa
	 w7v+cS7pn+QtqvujN/Umr7jXZbzQTAgQwmEWB4ER8BPYDdCLJHAxPStkaHQSTh4b95
	 6SWvRZnId417L+727nw0uWFFLSp/sasUG9V0twVe1SrlnIPMUtxQonAoDwRukCGGOX
	 COC8yEhKwZ6J2Fj9zF7zAHj+lsuNZpn9LlP3R0lLVhDd/RH74IWkWu4S8LfyANbkKt
	 TBARNn4u5H1tw==
Date: Sat, 14 Dec 2024 12:16:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 4/7] iio: accel: adxl345: introduce interrupt
 handling
Message-ID: <20241214121626.4701b84a@jic23-huawei>
In-Reply-To: <20241213211909.40896-5-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
	<20241213211909.40896-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 21:19:06 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the possibility to claim an interrupt. Init the state structure
> with an interrupt line obtained from the DT. The adxl345 can use
> two different interrupt lines for event handling. Only one is used.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index b48bc838c..fb3b45d99 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -11,15 +11,22 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/units.h>
> +#include <linux/interrupt.h>

Keep to local style. Headers in alphabetical order (with IIO ones
separate obviously!)

>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
>  #include "adxl345.h"
>  
> +#define ADXL345_INT_NONE		0xff
> +#define ADXL345_INT1			0
> +#define ADXL345_INT2			1
> +
>  struct adxl345_state {
> +	int irq;

Whilst it doesn't really matter. I'm not seeing any logic in having this as first
element and intio as last.  Might as well put them both at the end.

>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> +	u8 intio;
>  };
>  
>  #define ADXL345_CHANNEL(index, axis) {					\
> @@ -213,6 +220,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	st = iio_priv(indio_dev);
>  	st->regmap = regmap;
> +
Check patches for unrelated changes like this and drop them as they are noise.
If you want to tidy this sort of whitespace up, separate patch.

>  	st->info = device_get_match_data(dev);
>  	if (!st->info)
>  		return -ENODEV;
> @@ -263,6 +271,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret < 0)
>  		return ret;
>  
> +	st->intio = ADXL345_INT1;
> +	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +	if (st->irq < 0) {
> +		st->intio = ADXL345_INT2;
> +		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> +		if (st->irq < 0)
> +			st->intio = ADXL345_INT_NONE;

As in the DT binding, maybe we can fall back to an assumption of default.
So if interrupt names missing we assume INT1.

> +	}
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);


