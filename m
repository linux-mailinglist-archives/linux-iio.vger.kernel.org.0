Return-Path: <linux-iio+bounces-2636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B3857F6D
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC3F1F26F3B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0948212E1F8;
	Fri, 16 Feb 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8R8zyiW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460E101C4;
	Fri, 16 Feb 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094086; cv=none; b=O4XwlYdJrUmHONKoNf6rIrA3IUDeJVlT/+mqgpBt2FbotZ3zVJ4lq0GqRrR4EOy9BNUp9MlZxm/wR01/lUL5gVPFp5pmnsZHyUg+0TKgDu8inr7DBZc+TVQ0/2ZhRHN434lcMMnpx8fGhCIikOcvkjfn049YugnvR0E94ag8TvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094086; c=relaxed/simple;
	bh=4VEoWj9njKor5Uuyl7TfRX6Gv5f5mthxT9tJLZ8b7ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hj3Rmus3LZrRZQQ3IiePst5jqzLVdCt5OmTWzR/h5nKd/7nWq4J0V/8Y/RQg/2uN9KXpz329cLtRdXBnBqf5Uf9fnsKSAyCcbHADQZglTieEVrwbHt/EQ7RsImaR5FNjiyQlAkdoLGdtTcrxGTSCkK8J7282FPnobcBs67Qd2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8R8zyiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B83CC433C7;
	Fri, 16 Feb 2024 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708094086;
	bh=4VEoWj9njKor5Uuyl7TfRX6Gv5f5mthxT9tJLZ8b7ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8R8zyiWcs7FIicIBitRurbzqNlugABgI/XaY91qc65/yPzM5vxALx3zlMZ/OU1rK
	 IDb1at6yYCqN+Tpay1kNiskUQkWI238ntJIdI1kNmS+gewj6YNpTqcgxWbGkJrRmSp
	 Ixzxdczm5ld4TqE6UqnQW8ogxMg5wcb7lm2hkVu9ZRXZr6Q56Uk6lTm+6zE5El1bY9
	 KRObd3HZ2YqWKOg6/fTwh3rMb9oQg9we/pzqyx0gNryhBz6sdeb3I5NnCGND8vcebL
	 uV9Nk5D7zdDTnLN5GBBdXeguAdm4zKKy7+CKK1vL3vEct3AfNHw+No5A+eqbEFQJhk
	 waoLeDbLj8HMw==
Date: Fri, 16 Feb 2024 14:34:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com, Rob Herring
 <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v11 3/7] of: property: add device link support for
 io-backends
Message-ID: <20240216143432.745ae6e4@jic23-huawei>
In-Reply-To: <20240210-iio-backend-v11-3-f5242a5fb42a@analog.com>
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
	<20240210-iio-backend-v11-3-f5242a5fb42a@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Feb 2024 21:57:15 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> Add support for creating device links out of more DT properties.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
+CC Stephen Rothwell for linux-next conflict.

I'm going to pick this up against my current tree where the fix
for the line above the DEFINE isn't present. That will cause
a minor merge conflict due to the change in context.

Sorry for the irritation Stephen!

I'm keen to get this into linux next now rather than waiting for
a second pull to Greg late this cycle.  I'll aim to do first pull
with this in next week.

Will be briefly pushing out as testing though so 0-day can have
a look first and then out for linux-next to pick up after I see
those test reports (so this will probably waste a tiny bit
of Stephen's time mid week).

Thanks,

Jonathan


>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index caa3e54aae13..0e91a5f4d0cb 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1245,6 +1245,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
>  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
>  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
>  DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
> +DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
>  DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
>  DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
>  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
> @@ -1335,6 +1336,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_iommu_maps, .optional = true, },
>  	{ .parse_prop = parse_mboxes, },
>  	{ .parse_prop = parse_io_channels, },
> +	{ .parse_prop = parse_io_backends, },
>  	{ .parse_prop = parse_interrupt_parent, },
>  	{ .parse_prop = parse_dmas, .optional = true, },
>  	{ .parse_prop = parse_power_domains, },
> 


