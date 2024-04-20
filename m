Return-Path: <linux-iio+bounces-4402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7F8ABC23
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0032B1C20B8B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215B282FE;
	Sat, 20 Apr 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6i0RJDm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250B20DCC;
	Sat, 20 Apr 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713625494; cv=none; b=sIkP+hysKbt+1blGdhyCmdJ6pu83r2uOpKkC8KaT5worjZVVl4MKorKgGjG3wSZsiMgSm/V/eQ+E0aJnDM4H3gJ7stj9dpfmhuvviP/etsswQEj4LZq/iT/5o6eE4hDuxQ4YWpyXv8NC7ghojtab7gzb/HQTmm+qCekKorJiqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713625494; c=relaxed/simple;
	bh=Rx/qFNdT/pKTdFjyaMUaeply7T/pY94Bh6MdE8Xwmik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUF1sdpQALSpuf2J/fIR31BosJLaHb2gHlI94s+IOaUdnRqQtPDkgxpLA345oddmekIjl3zWpvWCNwGqCIq+Jkgz8ImQjreRQWKAfTwz/7iNpWghM1FeA5cu/exj+TuGshCi28/1E7RNm443idQPRI19D7U0XIkAcodAjmFGH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6i0RJDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B27C072AA;
	Sat, 20 Apr 2024 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713625494;
	bh=Rx/qFNdT/pKTdFjyaMUaeply7T/pY94Bh6MdE8Xwmik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B6i0RJDm8qHRt1jnVq/sPhdEtg2THTPAAgnYVZ0M1q/uMx0oPlRYAxvc3vGdOFAiR
	 bmeImDu0OwkcKYXpoJs3zLKpN6udI2A9QWWefqEaZj/yMTMIGEnOH6EuwE7Z9m2aKK
	 MvvlIttNFWW0wR+zY2r0BALZOabgOmp5gAPZFgKHNfRN6SipnZaPWCEhW3L4PYsxu1
	 Mow+i45O9bdwuFjBjWhBefW74cTgHJPI0pLeJzQCANeupl/+p8je1ELF34doFvSDhY
	 l8iO32bscymMqSuXDR9rsKCnwPgd640mXD92l0lwHLkxU/WnevMC79MNwV1gzB3AEc
	 Mi/5wTV8BB5xQ==
Date: Sat, 20 Apr 2024 16:04:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 4/8] iio: adc: axi-adc: make sure AXI clock is enabled
Message-ID: <20240420160442.05be6dc5@jic23-huawei>
In-Reply-To: <20240419-ad9467-new-features-v1-4-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-4-3e7628ff6d5e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 17:36:47 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> We can only access the IP core registers if the bus clock is enabled. As
> such we need to get and enable it and not rely on anyone else to do it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Likewise - smells like a fix, but no fixes tag?

> ---
>  drivers/iio/adc/adi-axi-adc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index a543b91124b07..e3b2158829416 100644
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


