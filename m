Return-Path: <linux-iio+bounces-22341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6973B1C8C6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD2318907CD
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82828EA4B;
	Wed,  6 Aug 2025 15:31:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018522E370A;
	Wed,  6 Aug 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494311; cv=none; b=hl3B+U7OBAo/YqdJ4vpJUY2++znJw28HfflS6Wspj0iZGcuPZNdrzSFM/s/OOrtBo4jyDwU7EibS5EKoZOTR2tLCOZ8kRmuzYWwkUKbTdjGOAL3Sqop54oVYztAiFH7tiSL6s3DsO6e2ijTzFalht7VuH49zsCalnlBx7cR/uq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494311; c=relaxed/simple;
	bh=RsvaOTpIAHltuIjZWM7I5SwR3disuxoHnJKNhDT8xPk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MD8ccEazLQQxbJl4RM3lcfqLjKRNk37lEPF6vn0WI0Y3a8bqFibBwoyquyWFgQWG2DNlGAy8VoLVdR4WNjE+orHmP47F06IIvDo8RVmqnpu9UP9I96rFpzpklPDcys9ohgrx6NjQkT09q2G+ggFqB6CMn3vCLBJjGBPDCWZmXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxvKr1Stxz6GDGT;
	Wed,  6 Aug 2025 23:27:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ACBF314037D;
	Wed,  6 Aug 2025 23:31:45 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 17:31:44 +0200
Date: Wed, 6 Aug 2025 16:31:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
CC: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/15] iio: adc: at91-sama5d2_adc: adapt the driver for
 sama7d65
Message-ID: <20250806163141.00005d83@huawei.com>
In-Reply-To: <20250804100219.63325-10-varshini.rajendran@microchip.com>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
	<20250804100219.63325-10-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 4 Aug 2025 15:32:13 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add support to sama7d65 ADC. The differences are highlighted with the
> compatible. The init and parsing of the temperature sensor and
> calibration indexes are the main differences.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
...

>  static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
>  {
>  	int i;
> @@ -2319,6 +2360,56 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
>  	return ret;
>  }
>  
> +static int at91_sama7d65_adc_temp_sensor_init(struct at91_adc_state *st,
> +					      struct device *dev)
> +{
> +	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
> +	struct nvmem_cell *temp_calib;
> +	u32 *buf = NULL;

As per earlier comment and I see Andy raised it as well. __free()
magic dust is useful here.

> +	size_t len;
> +	int ret = 0;
> +
> +	if (!st->soc_info.platform->temp_sensor)
> +		return 0;
> +
> +	/* Get the calibration data from NVMEM. */
> +	temp_calib = devm_nvmem_cell_get(dev, "temperature_calib");
> +	if (IS_ERR(temp_calib)) {
> +		ret = PTR_ERR(temp_calib);
> +		if (ret != -ENOENT)
> +			dev_err(dev, "Failed to get temperature_calib cell!\n");
> +		return ret;
> +	}
> +
> +	buf = nvmem_cell_read(temp_calib, &len);
> +	if (IS_ERR(buf)) {
> +		dev_err(dev, "Failed to read calibration data!\n");
> +		return PTR_ERR(buf);
> +	}
> +
> +	if (len < AT91_SAMA7D65_ADC_TS_CLB_IDX_MAX * sizeof(u32) ||
> +	    buf[0] != AT91_TEMP_CALIB_TAG) {
> +		dev_err(dev, "Invalid calibration data!\n");
> +		ret = -EINVAL;
> +		goto free_buf;
> +	}
> +
> +	/* Store calibration data for later use. */
> +	clb->p1 = buf[AT91_SAMA7D65_ADC_TS_CLB_IDX_P1];
> +	clb->p4 = buf[AT91_SAMA7D65_ADC_TS_CLB_IDX_P4];
> +	clb->p6 = buf[AT91_SAMA7D65_ADC_TS_CLB_IDX_P6];

only these indexes and the MAX check above make this different from
the existing function.  Maybe we could just store those instead
of a function pointer in the device type specific structure.

> +
> +	/*
> +	 * We prepare here the conversion to milli from micro to avoid
> +	 * doing it on hotpath.
> +	 */
> +	clb->p1 = clb->p1 / 1000;
> +
> +free_buf:
> +	kfree(buf);
> +	return ret;
> +}

