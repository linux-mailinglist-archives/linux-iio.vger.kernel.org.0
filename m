Return-Path: <linux-iio+bounces-22340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84918B1C8AE
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5FE188E249
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C282918DB;
	Wed,  6 Aug 2025 15:26:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D21DAC95;
	Wed,  6 Aug 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493993; cv=none; b=BOKrQ8J8N/plf2bM/HElKKKHH7quONUKA8L7wDVZ213lfTVccjEAPYZJD0c86nqb3ZJfsOdciXbClMzj3QSkyo8HnrUYdzgByoa5Vh8C2fR8qwAdQyJ8g+lZO8MXE9m4EUjo79tsaguE+NZTOOQHGVJ2+lMKIhLiKQeIZ330ETk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493993; c=relaxed/simple;
	bh=1pXe9ouFkczo8c71RCreN6c7fcZdupZNH78GTdN1B+o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEDU94Wkam2ezo68Ei9hl1aVyfH5BWCPBI6UmgEXBA7x9SSSiJLDYTH38aCEVtjuXeHDbmvrpq3HdhX/AWsjo0Su4nEDZ0rIc9q3n+lk0Qm2BqRzEzNbhgVx3ddTnsmCIrXhrezAXtMxVDpx72/KJpaHV63cc1KWZLhwjZTyNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxvGL02Q1z6L5W7;
	Wed,  6 Aug 2025 23:24:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D388414027A;
	Wed,  6 Aug 2025 23:26:28 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 17:26:27 +0200
Date: Wed, 6 Aug 2025 16:26:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
CC: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/15] iio: adc: at91-sama5d2_adc: update calibration
 index, validation condition
Message-ID: <20250806162624.000044ce@huawei.com>
In-Reply-To: <20250804100219.63325-5-varshini.rajendran@microchip.com>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
	<20250804100219.63325-5-varshini.rajendran@microchip.com>
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

On Mon, 4 Aug 2025 15:32:08 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add additional condition for validating the calibration data read from
> the OTP through nvmem device interface. Adjust the calibration indexes
> of sama7g5 according to the buffer received from the OTP memory.
Changing those indexes looks to me like either this was broken previously
or we are supporting something new (possibly at the expense of the older
support)

Or is this 'broken' by patch 2 and you are fixing it up here?
If so we normally try not to do that sort of change in multiple steps
because the patches may go via different trees and potentially only
part of it make it to upstream in a particular cycle.

Messy though it is, if you need to change indexes because something
broke doe it all in one patch.

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index c3450246730e..d952109a64a9 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -445,6 +445,14 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  #define at91_adc_writel(st, reg, val)					\
>  	writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
>  
> +/*
> + * The calibration data has a TAG to recognize the packet
> + * The tag has a constant value "ACST" with the ASCII
> + * equivalent 0x41435354. This is used to validate the
> + * calibration data obtained from the OTP.
> + */
> +#define AT91_TEMP_CALIB_TAG	0x41435354

Could we treat it as a string and do a strcmp?  Main advantage
is this comment may become unneeded if the code is clear enough.

> +
>  /**
>   * struct at91_adc_platform - at91-sama5d2 platform information struct
>   * @layout:		pointer to the reg layout struct
> @@ -504,10 +512,10 @@ struct at91_adc_temp_sensor_clb {
>   * @AT91_ADC_TS_CLB_IDX_MAX: max index for temperature calibration packet in OTP
>   */
>  enum at91_adc_ts_clb_idx {
> -	AT91_ADC_TS_CLB_IDX_P1 = 2,
> -	AT91_ADC_TS_CLB_IDX_P4 = 5,
> -	AT91_ADC_TS_CLB_IDX_P6 = 7,
> -	AT91_ADC_TS_CLB_IDX_MAX = 19,
> +	AT91_ADC_TS_CLB_IDX_P1 = 1,
> +	AT91_ADC_TS_CLB_IDX_P4 = 4,
> +	AT91_ADC_TS_CLB_IDX_P6 = 6,
> +	AT91_ADC_TS_CLB_IDX_MAX = 18,
>  };
>  
>  /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
> @@ -2281,7 +2289,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
>  		dev_err(dev, "Failed to read calibration data!\n");
>  		return PTR_ERR(buf);
>  	}
> -	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
> +	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4  || buf[0] != AT91_TEMP_CALIB_TAG) {
>  		dev_err(dev, "Invalid calibration data!\n");
>  		ret = -EINVAL;
>  		goto free_buf;
Not related to this patch, but this would be excellent place to deploy __free
u32 *buf __free(kfree) = nvmem_cell_read(temp_calib, &len);

then can directly return on error here and drop the kfree(buf) below.




