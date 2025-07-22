Return-Path: <linux-iio+bounces-21874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE316B0DE80
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD43AC3B33
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C123F413;
	Tue, 22 Jul 2025 14:17:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12992EE5F2;
	Tue, 22 Jul 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193835; cv=none; b=m9z5Ip3rm5x03bV9rryA1uuDqgBwJduqNdgB8ho/AjZ7mtJ6rTkZZ8Wani3T+FONZOeoYXE9L3m2s2cB/W8hvxfF8qSUVbW9ku8aN0uz5xrQSbB3t3E6C3fiUDRmVsC0ytM3NRgZ/ut+c7ZzGRaVI+tdtrW+DejxlyXmA+9Hexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193835; c=relaxed/simple;
	bh=/a4y1XiBHLNmGKeVaBpsb5VBLuRas+GgFAWJsa2vBu8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8tnmcLjrUqw1mEd7i8gOql3IsmEbPOYQ42jluUq5Ks+NULqsTndGuBxQimEz3zrTorTKCBdsAWHv/hsrtGwCQ/1MtPhaxOFHgSKPHyZQEOrE7QX2LtVlL/ReYo9/bmxNb0Gk3DzIqgkJLB7Sb7zB06ydSt5BKxHpVB1tAZ+AQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmfSL5p7Xz6H7Wq;
	Tue, 22 Jul 2025 22:15:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C4510140114;
	Tue, 22 Jul 2025 22:17:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 16:17:09 +0200
Date: Tue, 22 Jul 2025 15:17:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <sboyd@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <srini@kernel.org>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <sre@kernel.org>, <krzysztof.kozlowski@linaro.org>,
	<u.kleine-koenig@baylibre.com>, <linux-arm-msm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<kernel@collabora.com>, <wenst@chromium.org>, <casey.connolly@linaro.org>
Subject: Re: [PATCH v2 6/7] iio: adc: qcom-spmi-iadc: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <20250722151708.00000873@huawei.com>
In-Reply-To: <20250722101317.76729-7-angelogioacchino.delregno@collabora.com>
References: <20250722101317.76729-1-angelogioacchino.delregno@collabora.com>
	<20250722101317.76729-7-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Jul 2025 12:13:16 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Some Qualcomm PMICs integrate an Current ADC device, reachable
> in a specific address range over SPMI.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device and
> initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Mostly fine. Trivial comments inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

>  
>  static int iadc_reset(struct iadc_chip *iadc)
> @@ -270,7 +269,7 @@ static int iadc_poll_wait_eoc(struct iadc_chip *iadc, unsigned int interval_us)
>  
>  static int iadc_read_result(struct iadc_chip *iadc, u16 *data)
>  {
> -	return regmap_bulk_read(iadc->regmap, iadc->base + IADC_DATA, data, 2);
> +	return regmap_bulk_read(iadc->regmap, IADC_DATA, data, 2);

Perhaps not the time for it, but I'd prefer that 2 replaced with sizeof(*data)

>  }
>  
>  static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
> @@ -483,12 +482,22 @@ static const struct iio_chan_spec iadc_channels[] = {
>  
>  static int iadc_probe(struct platform_device *pdev)
>  {
> +	struct regmap_config iadc_regmap_config = {
> +		.reg_bits = 16,
> +		.val_bits = 8,
> +		.max_register = 0x100,
> +		.fast_io = true,
> +	};
>  	struct device_node *node = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
> +	struct spmi_subdevice *sub_sdev;
> +	struct spmi_device *sparent;
>  	struct iio_dev *indio_dev;
>  	struct iadc_chip *iadc;
>  	int ret, irq_eoc;
> -	u32 res;
> +
> +	if (!dev->parent)

How would this happen?

> +		return -ENODEV;
>  


