Return-Path: <linux-iio+bounces-23992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6CB53CF2
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 22:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E127CA05A07
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F21257444;
	Thu, 11 Sep 2025 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cnfeupin"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92F2F5B
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621455; cv=none; b=fcWmuJJ5QyLKh0+el4hzJJUOkfXNooaORx0+bd6qgl3U56wFsgC195N/0aB1aw7ckB5Y8N0vrDg9RbwWrTFT1cCTQsc0zj2mEN7wMWeRk/UmKF86sM12j5fmsG57SQ9sB74fIiuxKbk9cWYb7IWkZvdjC8SO2tFu70QnmdxnCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621455; c=relaxed/simple;
	bh=qYBVM3fe4BGHMXxVL6g9/6MFTFWbPMqYggM/QPmNt/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkbRuuJZvWc1k55SRKoTfhFq4XpbwSvNLKhS/bfAlKgpf1MRYAtuBdFk3HKxEi7qh+e++TWnXGPFU5+PfK8wBdwkmnj4Zs+s961GqQAY1vcpN4cOsY6N/fGFzCClgCyvAlp7r144rZKxyf8SrirTi7PPTFOb55rp3GULWGjSP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cnfeupin; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-746d72028e0so960527a34.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757621451; x=1758226251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVR1xB3u1lrq++KAtUqQDXjBQx9C8pkwXfrhVmqDDLo=;
        b=cnfeupin/N4ERbVEo/C2jkbJPdMa23fvhhKEcYm0Z3I5qdrgB8ONymJA3+oVY/haZU
         HhGieYAgLncie5PQbhwQFO3tu7iLXoeLuFABeK1APkqp5e+K0t+R7w8X+P2KRuZ/w+Ww
         hSvK/DnVaRB7KwkHxWlyKxKHwHfz0QniPLLBgggmQOmwVGSOKNjfZLwmgM/sfBbwb8VA
         bCRjm5WZiSyugPdjGmsTkoQubuiBUna1T0/sI9AgAGVzA5d2IQ8t5lycMFjTR5pYIxwD
         h1hRJwxmnfZajAytrUk+sbwOng2G9GsgVIcYH2/wGUN1oLJCZWG9xZFe4NeyRnVF/ci/
         47tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757621451; x=1758226251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVR1xB3u1lrq++KAtUqQDXjBQx9C8pkwXfrhVmqDDLo=;
        b=HXkIAWatn2tLCC19BAM4c2HeIxPjDVqq2Yn0MISiopTzqmfxjwaN8qUNNn3uG7eS/f
         q+pf7dPOOXmx0ZYSkJV6B6jjF4SHArsJ/93wjp/XY4N95IwqmrglIV1X3ybIK0vP0Xff
         uT9FUArqv+pdlmRZoFcqER0XsJrY8PzJDfkK5iHBZWY84YEr/MLmfNRBeE0vecW+oQu2
         YWqGGvek1W9ftC5bKbinunQJj9XFDURjgSCAyPseD441Gw07c1eP3lJCJnBKe+83hTw7
         uBn1TaMZoKQ6li9JIGhys75FlFJi/PL5JRiXR+Icvdg0XD1iYnDlsWmsHVdF/kCfdntm
         ip3w==
X-Gm-Message-State: AOJu0YxnVsvCXmtFUMFSQVmPmDaqIfMYfqc0Crxf4yK9c5Gj2LMySdRB
	cZg0AlFp7YqMe/YiJgyrS/W5uncqR0kKYfapPw1mlkW52FYxhCa3IRCodtR8cK7ZBlE=
X-Gm-Gg: ASbGncvSJqeEEMk95iz/tabNGZTDOKp0rZljGKW72Ap7T6DXa349v+Z5Gy52noJep2c
	YPHG7Nuw5BK/YhQKrSVFRn0FHiqgGslTNuywTBZiqj7V9yWr+V/72iEZx1e71iIg81kTIAVA8Fp
	/rGhI/jKgA3obnjoiTEuQjJy68eELSyX7Q1d3NSEkqExwCmmibsS7Pg08jfy0q31QAe38n1DxKp
	W1ZsNOgVlFo/MvHkHyzqgWm/6zyvHbMQVGH6Cg/Ka6MxwQUwBtc63I87M0og2/HHJOUD4XcBVSG
	dI8f2APK4xre4KPeDjU8HTqsqI+nRiRcSRl2X8mxxPMu7w8NYJYFsxHkqcKDnNfCYBGX3PR9ZVU
	XiQBZ/VrQdH/iZAbxbVMNGSujK4YA8K9THJNdV3JSK6JJNpqKU53Y8VEeH/ff11PfQI+YLimrmj
	U=
X-Google-Smtp-Source: AGHT+IEPeaLAXI4MuSkVTX84m53HoFbAgfzK58U6F293kMnmLeY68gXTEEXyi0LKbeSqZTIF0Vrtyw==
X-Received: by 2002:a05:6830:6618:b0:73c:e29c:3fdc with SMTP id 46e09a7af769-75354cfe5e6mr373180a34.18.1757621450629;
        Thu, 11 Sep 2025 13:10:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-75249961b08sm555259a34.16.2025.09.11.13.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 13:10:50 -0700 (PDT)
Message-ID: <d53b22d1-35d6-4fb8-ae56-3ba4953b64af@baylibre.com>
Date: Thu, 11 Sep 2025 15:10:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
 <20250910155759.75380-3-daniel.lezcano@linaro.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910155759.75380-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 10:57 AM, Daniel Lezcano wrote:
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
>  drivers/iio/adc/Kconfig       |   13 +
>  drivers/iio/adc/Makefile      |    1 +
>  drivers/iio/adc/nxp-sar-adc.c | 1026 +++++++++++++++++++++++++++++++++
>  3 files changed, 1040 insertions(+)
>  create mode 100644 drivers/iio/adc/nxp-sar-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6de2abad0197..4c2473a1fa20 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1168,6 +1168,19 @@ config NPCM_ADC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called npcm_adc.
>  
> +config NXP_SAR_ADC
> +	tristate "NXP S32G SAR-ADC driver"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select IIO_SYSFS_TRIGGER
> +	help
> +	  Say yes here to build support for S32G platforms
> +	  analog-to-digital converter.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called nxp_sar_adc.
> +
>  config PAC1921
>  	tristate "Microchip Technology PAC1921 driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1c6ca5fd4b6d..d1d939753bcc 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -119,6 +119,7 @@ obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
>  obj-$(CONFIG_ROHM_BD79124) += rohm-bd79124.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>  obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
> +obj-$(CONFIG_NXP_SAR_ADC) += nxp-sar-adc.o

We try to keep these in alphabetical order.

>  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>  obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
>  obj-$(CONFIG_SOPHGO_CV1800B_ADC) += sophgo-cv1800b-adc.o
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> new file mode 100644
> index 000000000000..421ce42ad9ec
> --- /dev/null
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -0,0 +1,1026 @@
> +// SPDX-License-Identifier: GPL-2.0

Prefer explicit GPL-2.0-only or GPL-2.0-or-later

...

> +static void nxp_sar_adc_dma_cb(void *data)
> +{
> +	struct nxp_sar_adc *info = iio_priv((struct iio_dev *)data);
> +	struct iio_dev *indio_dev = data;
> +	struct dma_tx_state state;
> +	struct circ_buf *dma_buf;
> +	struct device *dev_dma;
> +	u32 *dma_samples;
> +	s64 timestamp;
> +	int idx, ret;
> +
> +	guard(spinlock_irqsave)(&info->lock);
> +
> +	dma_buf = &info->dma_buf;
> +	dma_samples = (u32 *)dma_buf->buf;
> +	dev_dma = info->dma_chan->device->dev;
> +
> +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> +
> +	dma_sync_single_for_cpu(dev_dma, info->rx_dma_buf,
> +				NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +	/* Current head position */
> +	dma_buf->head = (NXP_SAR_ADC_DMA_BUFF_SZ - state.residue) /
> +			NXP_SAR_ADC_DMA_SAMPLE_SZ;
> +
> +	/* If everything transferred, avoid an off by one error. */
> +	if (!state.residue)
> +		dma_buf->head--;
> +
> +	/* Something went wrong and nothing transferred. */
> +	if (state.residue == NXP_SAR_ADC_DMA_BUFF_SZ)
> +		goto out;
> +
> +	/* Make sure that head is multiple of info->channels_used */
> +	dma_buf->head -= dma_buf->head % info->channels_used;
> +
> +	/* dma_buf->tail != dma_buf->head condition will become false
> +	 * because dma_buf->tail will be incremented with 1.
> +	 */
> +	while (dma_buf->tail != dma_buf->head) {
> +		idx = dma_buf->tail % info->channels_used;
> +		info->buffer[idx] = dma_samples[dma_buf->tail];
> +		dma_buf->tail = (dma_buf->tail + 1) % NXP_SAR_ADC_DMA_SAMPLE_CNT;
> +		if (idx != info->channels_used - 1)
> +			continue;
> +
> +		/* iio_push_to_buffers_with_timestamp should not be called
> +		 * with dma_samples as parameter. The samples will be smashed
> +		 * if timestamp is enabled.
> +		 */
> +		timestamp = iio_get_time_ns(indio_dev);
> +		ret = iio_push_to_buffers_with_timestamp(indio_dev,
> +							 info->buffer,
> +							 timestamp);

Is it OK to call this with spinlock held? It looks like it can call
devm_krealloc() which may sleep.

> +		if (ret < 0 && ret != -EBUSY)
> +			dev_err_ratelimited(&indio_dev->dev,
> +					    "failed to push iio buffer: %d",
> +					    ret);
> +	}
> +
> +	dma_buf->tail = dma_buf->head;
> +out:
> +	dma_sync_single_for_device(dev_dma, info->rx_dma_buf,
> +				   NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +}
> +

...

> +static int nxp_sar_adc_probe(struct platform_device *pdev)
> +{
> +	const struct nxp_sar_adc_data *data;
> +	struct nxp_sar_adc *info;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	struct device *dev = &pdev->dev;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct nxp_sar_adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	data = device_get_match_data(dev);
> +
> +	info->vref_mV = data->vref_mV;
> +
> +	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> +	if (IS_ERR(info->regs))
> +		return dev_err_probe(dev, PTR_ERR(info->regs),
> +				     "failed to get and remap resource");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
> +			       dev_name(dev), indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
> +
> +	info->regs_phys = mem->start;
> +	spin_lock_init(&info->lock);
> +
> +	info->clk = devm_clk_get_enabled(dev, "adc");

clock-names was dropped from bindings, so name should be NULL.

> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk),
> +				     "failed to get the clock\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&info->completion);
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &nxp_sar_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels = nxp_sar_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(nxp_sar_adc_iio_channels);
> +
> +	nxp_sar_adc_set_default_values(info);
> +
> +	ret = nxp_sar_adc_calibration(info);
> +	if (ret) {
> +		dev_err(dev, "Calibration failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = nxp_sar_adc_dma_probe(dev, info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize the dma\n");
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &nxp_sar_adc_trigger_handler,
> +					      &iio_triggered_buffer_setup_ops);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Couldn't initialise the buffer\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't register the device\n");
> +
> +	return 0;
> +}
> +

...

> +static const struct nxp_sar_adc_data s32g2_sar_adc_data = { .vref_mV = 1800 };

Why have this if there is only one option?

> +
> +static const struct of_device_id nxp_sar_adc_match[] = {
> +	{ .compatible = "nxp,s32g2-sar-adc", .data = &s32g2_sar_adc_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nxp_sar_adc_match);
> +

