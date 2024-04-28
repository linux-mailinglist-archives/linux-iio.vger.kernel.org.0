Return-Path: <linux-iio+bounces-4598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A578B4D3D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA161F212DB
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC47350E;
	Sun, 28 Apr 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTE8BI/8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1D7317F;
	Sun, 28 Apr 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325502; cv=none; b=bzICi5jH8zePFM2EDb+ZPR7iBo7cmJHP1+ZiEwdS8Fu9rQGV64dp2fPqYbb5QYbCfFoijU7mthiCNmeQ0wDmWbGjJqWZIpCipzkIiVCbc58qfAY7KT6klgqg8xqMFwM7dw84GFES/hmmJdFXF5XuZZQT/bAC7uAj/XPuOpArybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325502; c=relaxed/simple;
	bh=hFZjQo/dh+Ie3EsIHfVDyM8xgyYcKVep0AXZkaRSMS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xewk38/L68xeaj5nnK5CIVLpsDR4wqDYVSgWyyG5yZnlgVQNG8rpA33JpU4/puIZQfNsc+fi+UTEFRl2aXhZwDPVuz0FbsDRTEN+JgTUu8COnt4sXnzVPkSC/tYAE4EkBfLzx3zl4xvNsjaS5qWRS+GW2GpQfr7TLShtgXnfZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTE8BI/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A37C113CC;
	Sun, 28 Apr 2024 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714325501;
	bh=hFZjQo/dh+Ie3EsIHfVDyM8xgyYcKVep0AXZkaRSMS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YTE8BI/8WbD/9OahnkT8iszK7h+2CtYJZieJkxckD3Pdi05GUGjkkX8h0AhRl8tbb
	 NATEgGQ1GZ85nifzLF9j4iNzEqkZd/ATqviX/uf0fBW017JcRsjIXkpXnRn3vxvoVg
	 mmaLbdZh0uVFiPoVkKl0mPQvqUCITf04VWeNvr0QQsnTGVO2+SYZpeyuxoggYSHvZX
	 C/yfBF4WkxwWR0IuE+QTj4mOHkhmcrz6iiR5zsYvbYClYIVhYXIi9wnhLrlLkcMF/N
	 xv3rDy7SlGuaua1PXG90PMuN4uDt4EQJOATde2CX7/LLjPEFV3OkPWlm9jcVoJN87S
	 pdQjPrw0jiqfg==
Date: Sun, 28 Apr 2024 18:31:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 4/7] iio: adc: axi-adc: make sure AXI clock is
 enabled
Message-ID: <20240428183123.622eac07@jic23-huawei>
In-Reply-To: <20240426-ad9467-new-features-v2-4-6361fc3ba1cc@analog.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
	<20240426-ad9467-new-features-v2-4-6361fc3ba1cc@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 17:42:13 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> We can only access the IP core registers if the bus clock is enabled. As
> such we need to get and enable it and not rely on anyone else to do it.
> 
> Note this clock is a very fundamental one that is typically enabled
> pretty early during boot. Independently of that, we should really rely on
> it to be enabled.
> 
> Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Queued up this and the previous one.

If the rest doesn't quite make the merge window I'd like these two fixed
to do so anyway.

Also marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/adi-axi-adc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index a543b91124b0..e3b215882941 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -175,6 +175,7 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	struct adi_axi_adc_state *st;
>  	void __iomem *base;
>  	unsigned int ver;
> +	struct clk *clk;
>  	int ret;
>  
>  	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
> @@ -195,6 +196,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	if (!expected_ver)
>  		return -ENODEV;
>  
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
>  	/*
>  	 * Force disable the core. Up to the frontend to enable us. And we can
>  	 * still read/write registers...
> 


