Return-Path: <linux-iio+bounces-24183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA280B5A37A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 22:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D60322940
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E628314E;
	Tue, 16 Sep 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sX2NAplt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717C2582;
	Tue, 16 Sep 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056016; cv=none; b=klpF2QzhnB/yHufgrzqCenJUdrD6c2XrdRF0ytbStdzK2JRkKJhN/cyxhbukqHCVbnUGYMpcqC7KAT3zwCpytbUeTdi9EyUudt4lpLhMtqkKpVDBOMdpqf0KFc4YKuTbtEwxKEfWvmWERmyuFyItqlqnlh401m+gLoYmUc6Kj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056016; c=relaxed/simple;
	bh=uUubJs8bOxMTHPR4DTibp6eIte4WdH2/29ZxdZWiurs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5g5aT+nmLdBD4mxQkm8vQ8dHT4EQPR+n5zMh9EG7gtPkCySp8G/+QmfIvxgNYRZXXsz/Zq3Xzk1GZu9WD9Sf3KUkZXB/pp3O6MIx4PzzP0Ahy66g0y4dzROf0u3mJt/hWIsoB0AtavF5aNd0fIu6ETtJBiOpgUBlC/EgJGZh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sX2NAplt; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id ycg4uDQfgNEP1ycg4uY8zG; Tue, 16 Sep 2025 22:53:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1758056010;
	bh=YVBH0cCDdgQq/NKC5gRUU1oByt7SDjC9SrS7xiiT7sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sX2NApltPb+/vm0YlP0wwVw/p5NegydxULjeyp6f6GxxMy+Q2NSLPaBn906XYuL6G
	 eWuf/V/K4wQqato9fNzIP+pJMlFU0An7TiXA8qrMH0rjTfvMw+yMPpgVmX1MHGfToO
	 cKC3NR3V7H+xmAhBOsM5BhdT5ZobblIJNnXW6MMrcLdd5TlKp8sn9xoREUSFBus/6q
	 LdefoON8v+beAGIzo8ygmzj+GQj88GbVknPifUD9hQzhU2mbdIhKhHZPm5sdbkBI6a
	 PEm6eKdzuvT1ZKqcqME0CRmkf9J85EY5pb1ReslQIuyg/DhKbGucMZ9GOrWAEjH8kg
	 1QZv3FLGZS8ZQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 16 Sep 2025 22:53:30 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <f4e52440-fa96-486b-9c50-828fdbbe27eb@wanadoo.fr>
Date: Tue, 16 Sep 2025 22:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250916202605.2152129-1-daniel.lezcano@linaro.org>
 <20250916202605.2152129-3-daniel.lezcano@linaro.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250916202605.2152129-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/09/2025 à 22:26, Daniel Lezcano a écrit :
> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> 
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
> 
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
> 
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers, while the author refers to
> the initial BSP driver file creator.
> 
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.
> 
> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi,

> +static void nxp_sar_adc_dma_remove(void *data)
> +{
> +	struct nxp_sar_adc *info = data;
> +
> +	dma_free_coherent(info->dma_chan->device->dev, NXP_SAR_ADC_DMA_BUFF_SZ,
> +			  info->dma_buf.buf, info->rx_dma_buf);
> +}
> +
> +static int nxp_sar_adc_dma_probe(struct device *dev, struct nxp_sar_adc *info)
> +{
> +	struct device *dev_dma;
> +	u8 *rx_buf;
> +
> +	info->dma_chan = devm_dma_request_chan(dev, "rx");
> +	if (IS_ERR(info->dma_chan))
> +		return PTR_ERR(info->dma_chan);
> +
> +	dev_dma = info->dma_chan->device->dev;
> +	rx_buf = dma_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
> +				    &info->rx_dma_buf, GFP_KERNEL);

maybe dmam_alloc_coherent() for the managed version?
This would save some LoC.

> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	info->dma_buf.buf = rx_buf;
> +
> +	return devm_add_action_or_reset(dev, nxp_sar_adc_dma_remove, info);
> +}


