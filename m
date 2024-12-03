Return-Path: <linux-iio+bounces-13056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA419E2F44
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660F7B2F41E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30D41F76DB;
	Tue,  3 Dec 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIrbT+F4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327C1DF27E;
	Tue,  3 Dec 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263696; cv=none; b=k5BcDOgo+GTBtQhuQpe5qkMKSehmHRPADqGgAJUkOj/FWk90KkFMXo2BN4VpcBtk0Rh6Ek2zlyu9O5XCEzY7WxnUeimymCdQrrRAPNDa64r7mQzuyfWsfyiFKwxtz32Na7bR8CKwxuWDrm54KAViZhmPmjcA7u73A8Q3Q8xnUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263696; c=relaxed/simple;
	bh=9ZguCax4zgSj4gzzoNSEdLNmuYozpUsLrWhfso455gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNw0Aty2RO8ZRmGpfHICAHwkQQmcbqPbgoY59hwboNKi/QJ505soMQ9htNyQ2SFBuUGdCyymTE2+2JPdqAR50UF2hSlkueFQ1N3A27xst01NqsU60zl2iVj30SL0BZs7xThF++xGeuJSegJDU7/x51TFo3KuYsB6PBcafILmFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIrbT+F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F63C4CEDC;
	Tue,  3 Dec 2024 22:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733263695;
	bh=9ZguCax4zgSj4gzzoNSEdLNmuYozpUsLrWhfso455gQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GIrbT+F4dnKTe7dXB2pJ85d2k+69p2NnZJi0dRIGi1z6z9oCIUvh3pxH/9y92RAlZ
	 9kbaHZ4u8KZYtKmDxfTaR3dM02J/1mWTxAZad7vm1vWPDERxaZeBNuVRme9P2+3R3L
	 1XFes72w00sfTANMMQgz64nsdcPggA7pwM+a32Jl3T4ur9rdqDHrB/LFV+vv3VrtsW
	 VmaoEgFwPM6BzNGgerAlVX2Z5ZocUYQI0ZIvLux5Q/URkDCtYvjiGE7PZ/MJ0J8WiS
	 4VzHMRpF9xW+eH9os2I4ErgpeEe8Pma0FetHJmrHuLnlQRJQaIQ2l93dQj0Z6oCxgW
	 PivUEoXFAZ+rA==
Date: Tue, 3 Dec 2024 22:08:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 12/14] iio: adc: rzg2l_adc: Add support for Renesas
 RZ/G3S
Message-ID: <20241203220804.3f3aa177@jic23-huawei>
In-Reply-To: <20241203111314.2420473-13-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
	<20241203111314.2420473-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:13:12 +0200
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
Hi Claudia,

This one and the others I haven't comment on look good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 634073e7241f..dd2ef8203966 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -525,7 +525,16 @@ static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
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


