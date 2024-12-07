Return-Path: <linux-iio+bounces-13205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB79E819B
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 19:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5278C1883B0E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4EC1509B4;
	Sat,  7 Dec 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRughQ36"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488D7A13A;
	Sat,  7 Dec 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596474; cv=none; b=ZESXadPT2bBppeJXt0Fgq9KmAKMn6iM2K+GcDSKhuEazkscjjcS9zc2dbAN+buRpPHozEdosEfRSPEKvZCdA4hr7hW2drZCCc/AX2h8o2FnAT0Uk4CC4881vFwLF52lXFsrUMPe6VvZQZatLjd0oev8EDIL8O5LqHp+suK3q8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596474; c=relaxed/simple;
	bh=l+6Ko6CQ5FhFJ9D0H70DrCdGgtswUd0TVzG4Virbb1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dn6NjRbro61+NOu09Y9ZYc9LAhnJ093AuZuKHh43c4XxADF9kZY1YttuE9sHr44Y7ZitlBdaawLdeZTYmyCDNRqBqU0yuRnwVbvg4ZDOstp3koefP3uaeWf/3WvLy486/T96YA1Tr2ofeiqgdRPEAqEoPKeTGe9CV8OE3D8bsvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRughQ36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD49C4CECD;
	Sat,  7 Dec 2024 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733596474;
	bh=l+6Ko6CQ5FhFJ9D0H70DrCdGgtswUd0TVzG4Virbb1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aRughQ36HT2p4loQhbrJkiIfTBvFZz91GBRwnCJCmGvtbTqiBOZuBbDWshas8KGBk
	 lSkVPnvf4yVh2utuJ+WwJC7FyZTJa8ktz8VV30Ds+J/o7L3No4wdCsvY1sv1zO65UR
	 CimPYlXWqb49mUxZkTTU7sY2Upp8HRv1wj8SgwTHVcNndPe8HGz1eWzNytHZjmXNt0
	 60GbB8DHrkpXEazqFCcnn2mB3AyR3HCp4uLP/paRZTqGbgY2ebbAIuwsDPvRnkFeQs
	 czdP5raLRs+Ta+3kmGBDfluAsPeoN8SApd5pzi074m4G7ShPCGySY3WyyySsxMQd8b
	 l7pA48A1CFWPA==
Date: Sat, 7 Dec 2024 18:34:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 13/15] iio: adc: rzg2l_adc: Add support for Renesas
 RZ/G3S
Message-ID: <20241207183423.4af1f988@jic23-huawei>
In-Reply-To: <20241206111337.726244-14-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
	<20241206111337.726244-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 13:13:35 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add ADC support for the Renesas RZ/G3S SoC. The key features of this IP
> include:
> - 9 channels, with one dedicated to reading the temperature reported by the
>   Thermal Sensor Unit (TSU)
> - A different default ADCMP value, which is written to the ADM3 register.
> - Different default sampling rates
> - ADM3.ADSMP field is 8 bits wide
> - ADINT.INTEN field is 11 bits wide
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Hi Claudiu

As my comments were all minor stuff, I have applied this.
However they were the sort of minor changes that result in lots of
fuzz and hand editing when applying so please check the result.
Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
> 
> Changes in v2:
> - none
> 
>  drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 2a911269a358..81904e2c4075 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -502,7 +502,16 @@ static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
>  	.adivc = true
>  };
>  
> +static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
> +	.num_channels = 9,
> +	.default_adcmp = 0x1d,
> +	.default_adsmp = { 0x7f, 0xff },
> +	.adsmp_mask = GENMASK(7, 0),
> +	.adint_inten_mask = GENMASK(11, 0),
> +};
> +
>  static const struct of_device_id rzg2l_adc_match[] = {
> +	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
>  	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
>  	{ /* sentinel */ }
>  };


