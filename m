Return-Path: <linux-iio+bounces-23677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C91B41CEC
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 13:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518F63B0931
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B782F60C4;
	Wed,  3 Sep 2025 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmwPwkwx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2727A476;
	Wed,  3 Sep 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898421; cv=none; b=VUjP0O6WkepZSMrG6DfmsCSDxQjzKF0tg3Wr41LhZfaVMd7NwLMcRWzVyqMCfAheyMjIiuzarz2fZd0mFFr87OXQe4488EZ/vrwApAKgLx8x6i9dOpw32Vg9HFZVa61Mmb0vmP8kxTNeecrlhFIJPaTsFq8mTIEbu7MYUxsExa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898421; c=relaxed/simple;
	bh=nojevgTngRlhQutvQIJzpXl0k8G3ysr1dXU/Sr6hsX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=di2Ww7uI5wax9hbZbt77jjJTNlvUTAC53ji5dfwFQOUBiHjZHYADCxD0j/NtTvxP0t4lHwoBVJP/a6kZrUp5ptSvuCnNFB5yjt18CmzWc7OC8RWV1qvgO8JzUNqY5M/BTT7GctIp17n2lTILEAr4t/ECUU5ikxH4EINUjNiZTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmwPwkwx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cebce2f78so12152201a12.1;
        Wed, 03 Sep 2025 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756898418; x=1757503218; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KtAxsxXK0P1tOOwUvNynJ2BMlxIk6bZ5OgW7dBmj+MY=;
        b=RmwPwkwxpPMh9R57DIMv6S9+tN4O1kDE1hG/QF1voA8uwBBFaHiTzuhfHRjMwk7Gxx
         PhalOJ8XCEo1Yq73FD3jTNgIYVpwIs6G8Zv1DLi4HXdd2VkC9ZgISTVYPuCzxnJFnDg1
         pmHoCXnQn0ZXjjLYqhUR39/Qj5xZK3BZqUU/BzEC6Tzx6uck99n0IFGaVC6WZy89bG4Y
         OgM2JkT8DTtRkbfB1Kt5Xh+Lbpr6OcrgJrga4vow8N+rif/wkQGlwaXcPKyNxNlSKmVV
         4mwY+Pjr4QcszCiZKxhZKz1IGSN/NtD4cfFGurhZmi8/VCm+qgJdYqfZRbReOGYdL/f+
         igkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898418; x=1757503218;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtAxsxXK0P1tOOwUvNynJ2BMlxIk6bZ5OgW7dBmj+MY=;
        b=Xz8I6honpS4A4nkrTFzCYdPDVO4MlLxXcnk5fQXdDAO0DPZ4mrqA9meudQomDyi/CS
         G7u3udW/lBy6F4JVls6mSYe6+gz9Yqv6uqH2zLZg1l4bJ7FzdD+s5S6Kr3wW8tZUsKZR
         72jP35mNn5x575c6K8Iesdg2g3EdGC3zHKI0utg8tHKihIpv2+deJHG1TV0gTYgCZz77
         cYyc//NTi4mFGgRhLyL6YPMunk9cHkWXMCU+8CDkDJVdFKmYPfCA4kOP6Pb/0VZBUB89
         Onusww8EP4ciLlUzCd84Nd9Eozz3zj5hHUIL3fe+ACWZ1nZiO8T7SvOfsz8rt9puhX8e
         D6+g==
X-Forwarded-Encrypted: i=1; AJvYcCX0jr3cTTp9+e5430UiQc96fU+1tEv2SSqx6rFMkGJ6FW/SsBtLJXy6FHpafAPQyg7lDBb0qKQ2xY3v@vger.kernel.org, AJvYcCXYI6JMRJJKM+18fanbPhQ3p9r6fGse4UrzBGXvZS3AasP+Dzpt5OqZQeeCpi2RJltykoDuEUvmblyAwHzU@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnCEHP+UDXL5FY8WijVX3yeqT6EGm8LS7V0W55i+6b+EgE3IH
	6q9KIyUcc9rdSS+NCYHshlpln4cMZ6/hEhRwO2NmGoU/ZYo41x3nhJQY
X-Gm-Gg: ASbGncvVbny3vpL4y91u1vreN/VCxOJcO7/uZBR1TGmAWjzaAUagQH2P6ZZEPthHKw7
	HEMmBBALONo+7w1v6NBAciKZ7vwuHvHR6n/tZG1Cis5TLpztzPCzij2YmDiBo6zwX3htY+9dwDn
	CH5paq7V2M91pZQi6qeAMan7hr16fXwrvDvuJ9NoS58pX0EvztGTH76IztHaIsSemG5FghskKUg
	Wih9buHFdKACYZ83VwRkDPP5Wpexvx09OflQ/UIFdYxuYyX0VPIZHRESVPOeLAXPD9bInifyXjb
	g+yv0F0BOz0AhaDkoTOicsC/LS3IAd27RB8NMBKP3rsGAo9onSdDHy4K0ejxFcpY9lfghvROypZ
	gdH5gMHj0C3GoRoclYH89HVp6DkQ31fWIO60j+HCoS8wT7w==
X-Google-Smtp-Source: AGHT+IHzKw/iXmKFTJVozAqWsJMfUxKKEsIm03nvxS1xExBLbrKKhUPPSNbqGwHu7Y0o4TJn1sZodw==
X-Received: by 2002:a05:6402:524a:b0:61e:c42e:825f with SMTP id 4fb4d7f45d1cf-61ec42eac2emr4418689a12.2.1756898417796;
        Wed, 03 Sep 2025 04:20:17 -0700 (PDT)
Received: from [10.5.0.2] ([192.145.38.183])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61ec9fba340sm2871182a12.12.2025.09.03.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:20:17 -0700 (PDT)
Message-ID: <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com
Date: Wed, 03 Sep 2025 12:20:39 +0100
In-Reply-To: <20250903102756.1748596-3-daniel.lezcano@linaro.org>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
	 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>=20
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
>=20
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
>=20
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers, while the author refers to
> the initial BSP driver file creator.
>=20
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.
>=20
> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.c=
om>
> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com=
>
> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi David,

Just some minor review for now...

> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 13 +
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/nxp-sar-adc.c | 1046 ++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 1060 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/nxp-sar-adc.c
>=20
>=20

...

> +
> +static int nxp_sar_adc_dma_probe(struct device *dev, struct nxp_sar_adc
> *info)
> +{
> +	struct device *dev_dma;
> +	int ret;
> +	u8 *rx_buf;
> +
> +	info->dma_chan =3D devm_dma_request_chan(dev, "rx");
> +	if (IS_ERR(info->dma_chan))
> +		return PTR_ERR(info->dma_chan);
> +
> +	dev_dma =3D info->dma_chan->device->dev;
> +	rx_buf =3D dma_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
> +				=C2=A0=C2=A0=C2=A0 &info->rx_dma_buf, GFP_KERNEL);
> +	if (!rx_buf)
> +		return -ENOMEM;
> +

The above needs some discussion at the very least. Have you considered the =
IIO
DMA buffer interface? It should be extendable to accommodate any particular=
ity
of your usecase (or we should at least discuss it).

With it, you also gain a userspace interface where you can actually share D=
MA
buffers in a zero copy fashion.=C2=A0You can also share these buffers with =
USB
gadgets. For instance, with libiio, you would be able to fetch samples from=
 your
host machine (through USB) in a very fast way (zero copy between IIO and US=
B).

Setting up DMA to then "having" to push it to a SW buffer and needing a sys=
call
to retrieve the data seems counter-productive.=20

> +	info->dma_buf.buf =3D rx_buf;
> +
> +	info->dma_config.direction =3D DMA_DEV_TO_MEM;
> +	info->dma_config.src_addr_width =3D NXP_SAR_ADC_DMA_SAMPLE_SZ;
> +	info->dma_config.src_maxburst =3D 1;
> +
> +	ret =3D devm_add_action_or_reset(dev, nxp_sar_adc_dma_remove, info);
> +	if (ret) {
> +		nxp_sar_adc_dma_remove(info);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * The documentation describes the reset values for the
> + * registers. However some registers do not have these values after a
> + * reset. It is a not desirable situation. In some other SoC family
> + * documentation NXP recommend to not assume the default values are
> + * set and to initialize the registers conforming to the documentation
> + * reset information to prevent this situation. Assume the same rule
> + * applies here as there is a discrepancy between what is read from
> + * the registers at reset time and the documentation.
> + */
> +static void nxp_sar_adc_set_default_values(struct nxp_sar_adc *info)
> +{
> +	const u32 mcr_default	=3D 0x00003901;
> +	const u32 msr_default	=3D 0x00000001;
> +	const u32 ctr_default	=3D 0x00000014;
> +	const u32 cimr_default	=3D 0x00000000;
> +	const u32 ncmr_default	=3D 0x00000000;
> +

const does not really bring much here. I would rather have them as #defines=
.

> +	writel(mcr_default, REG_ADC_MCR(info->regs));
> +	writel(msr_default, REG_ADC_MSR(info->regs));
> +	writel(ctr_default, REG_ADC_CTR0(info->regs));
> +	writel(ctr_default, REG_ADC_CTR1(info->regs));
> +	writel(cimr_default, REG_ADC_CIMR0(info->regs));
> +	writel(cimr_default, REG_ADC_CIMR1(info->regs));
> +	writel(ncmr_default, REG_ADC_NCMR0(info->regs));
> +	writel(ncmr_default, REG_ADC_NCMR1(info->regs));
> +}
> +
> +static int nxp_sar_adc_probe(struct platform_device *pdev)
> +{
> +	const struct nxp_sar_adc_data *data;
> +	struct nxp_sar_adc *info;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	struct device *dev =3D &pdev->dev;
> +	int irq;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct nxp_sar_adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info =3D iio_priv(indio_dev);
> +
> +	data =3D of_device_get_match_data(dev);
> +

device_get_match_data()
> +	info->vref =3D data->vref;
> +
> +	info->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> +	if (IS_ERR(info->regs))
> +		return dev_err_probe(dev, PTR_ERR(info->regs),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and remap resource");
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "no irq resource\n");
> +
> +	ret =3D devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(dev), indio_dev);
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "failed requesting irq, irq =3D %d\n",
> irq);
> +
> +	info->regs_phys =3D mem->start;
> +	spin_lock_init(&info->lock);
> +
> +	info->clk =3D devm_clk_get_enabled(dev, "adc");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get the clock\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&info->completion);
> +
> +	indio_dev->name =3D dev_name(dev);
> +	indio_dev->info =3D &nxp_sar_adc_iio_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels =3D nxp_sar_adc_iio_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(nxp_sar_adc_iio_channels);
> +
> +	nxp_sar_adc_set_default_values(info);
> +
> +	ret =3D nxp_sar_adc_calibration(info);
> +	if (ret) {
> +		dev_err(dev, "Calibration failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D nxp_sar_adc_dma_probe(dev, info);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize the dma\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &iio_pollfunc_store_time,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &nxp_sar_adc_trigger_handler,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> &iio_triggered_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(dev, "Couldn't initialise the buffer\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register the device.\n");

dev_err_probe(). Ditto for all other places.

> +		return ret;
> +	}
> +
> +	dev_info(dev, "Device initialized successfully.\n");
>=20
dev_dbg() if you want to keep it but kind of useless IMHO.

> +	return 0;
> +}
> +
> +static void nxp_sar_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +	struct nxp_sar_adc *info =3D iio_priv(indio_dev);
> +
> +	nxp_sar_adc_stop_conversion(info);
> +	nxp_sar_adc_channels_disable(info, REG_ADC_CH_MASK);
> +	nxp_sar_adc_dma_channels_disable(info, REG_ADC_CH_MASK);
> +	nxp_sar_adc_dma_cfg(info, false);
> +	nxp_sar_adc_disable(info);
> +	dmaengine_terminate_sync(info->dma_chan);
> +	iio_device_unregister(indio_dev);

You're using devm_iio_device_register().

> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int nxp_sar_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct nxp_sar_adc *info =3D iio_priv(indio_dev);
> +
> +	info->pwdn =3D nxp_sar_adc_disable(info);
> +	info->inpsamp =3D nxp_sar_adc_conversion_timing_get(info);
> +
> +	clk_disable_unprepare(info->clk);
> +
> +	return 0;
> +}
> +
> +static int nxp_sar_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct nxp_sar_adc *info =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(info->clk);
> +	if (ret)
> +		return ret;
> +
> +	nxp_sar_adc_conversion_timing_set(info, info->inpsamp);
> +
> +	if (!info->pwdn)
> +		nxp_sar_adc_enable(info);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(nxp_sar_adc_pm_ops, nxp_sar_adc_suspend,
> nxp_sar_adc_resume);
> +
> +static const struct nxp_sar_adc_data s32g2_sar_adc_data =3D { .vref =3D =
1800 };
> +
> +static const struct of_device_id nxp_sar_adc_match[] =3D {
> +	{ .compatible =3D "nxp,s32g2-sar-adc", .data =3D &s32g2_sar_adc_data },
> +	{ /* sentinel */ }

No need for the comment. Kind of obvious :)

> +};
> +MODULE_DEVICE_TABLE(of, nxp_sar_adc_match);
> +
> +static struct platform_driver nxp_sar_adc_driver =3D {
> +	.probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D nxp_sa=
r_adc_probe,
> +	.remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D nxp_sar_adc=
_remove,
> +	.driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D {
> +		.name=C2=A0=C2=A0 =3D DRIVER_NAME,
> +		.of_match_table =3D nxp_sar_adc_match,
> +#ifdef CONFIG_PM_SLEEP

You should not need the above. Look at pm_ptr() and friends.

> +		.pm=C2=A0=C2=A0=C2=A0=C2=A0 =3D &nxp_sar_adc_pm_ops,
> +#endif
> +	},
> +};
> +
> +module_platform_driver(nxp_sar_adc_driver);
> +
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("NXP SAR-ADC driver");
> +MODULE_LICENSE("GPL");

