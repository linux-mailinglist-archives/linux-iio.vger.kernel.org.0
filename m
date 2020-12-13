Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46A2D8F0C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436639AbgLMRV2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395405AbgLMRV2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:21:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AED2313B;
        Sun, 13 Dec 2020 17:20:45 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:20:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio:common:ms_sensors:ms_sensors_i2c: add support
 for alternative PROM layout
Message-ID: <20201213172042.76b2e028@archlinux>
In-Reply-To: <20201209234857.1521453-6-alexandre.belloni@bootlin.com>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
        <20201209234857.1521453-6-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Dec 2020 00:48:56 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Currently, only the 112bit PROM on 7 words is supported. However the ms58xx

PROM _with_ 7 words (perhaps?)

> family also have devices with a 128bit PROM on 8 words. See AN520:
> C-CODE EXAMPLE FOR MS56XX, MS57XX (EXCEPT ANALOG SENSOR), AND MS58XX SERIES
> PRESSURE SENSORS and the various device datasheets.
> 
> The difference is that the CRC is the 4 LSBs of word7 instead of being the
> 4 MSBs of word0.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../iio/common/ms_sensors/ms_sensors_i2c.c    | 70 ++++++++++++++++---
>  1 file changed, 59 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index 872f90459e2e..d97ca3e1b1d7 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -488,21 +488,18 @@ int ms_sensors_ht_read_humidity(struct ms_ht_dev *dev_data,
>  EXPORT_SYMBOL(ms_sensors_ht_read_humidity);
>  
>  /**
> - * ms_sensors_tp_crc_valid() - CRC check function for
> + * ms_sensors_tp_crc4() - Calculate PROM CRC for
>   *     Temperature and pressure devices.
>   *     This function is only used when reading PROM coefficients
>   *
>   * @prom:	pointer to PROM coefficients array
>   *
> - * Return: True if CRC is ok.
> + * Return: CRC.
>   */
> -static bool ms_sensors_tp_crc_valid(u16 *prom)
> +static u8 ms_sensors_tp_crc4(u16 *prom)
>  {
>  	unsigned int cnt, n_bit;
> -	u16 n_rem = 0x0000, crc_read = prom[0], crc = (*prom & 0xF000) >> 12;
> -
> -	prom[MS_SENSORS_TP_PROM_WORDS_NB - 1] = 0;
> -	prom[0] &= 0x0FFF;      /* Clear the CRC computation part */
> +	u16 n_rem = 0x0000;
>  
>  	for (cnt = 0; cnt < MS_SENSORS_TP_PROM_WORDS_NB * 2; cnt++) {
>  		if (cnt % 2 == 1)
> @@ -517,10 +514,55 @@ static bool ms_sensors_tp_crc_valid(u16 *prom)
>  				n_rem <<= 1;
>  		}
>  	}
> -	n_rem >>= 12;
> -	prom[0] = crc_read;
>  
> -	return n_rem == crc;
> +	return n_rem >> 12;
> +}
> +
> +/**
> + * ms_sensors_tp_crc_valid_112() - CRC check function for
> + *     Temperature and pressure devices for 112bit PROM.
> + *     This function is only used when reading PROM coefficients
> + *
> + * @prom:	pointer to PROM coefficients array
> + *
> + * Return: CRC.

That's a bit confusing.  Perhaps return if CRC correct
Sometimes CRC is used to refer to particular bits and sometimes
to the check (i.e. whether it is right).

> + */
> +static bool ms_sensors_tp_crc_valid_112(u16 *prom)
> +{
> +	u16 w0 = prom[0], crc_read = (w0 & 0xF000) >> 12;
> +	u8 crc;
> +
> +	prom[0] &= 0x0FFF;      /* Clear the CRC computation part */
> +	prom[MS_SENSORS_TP_PROM_WORDS_NB - 1] = 0;
> +
> +	crc = ms_sensors_tp_crc4(prom);
> +
> +	prom[0] = w0;
> +
> +	return crc == crc_read;
> +}
> +
> +/**
> + * ms_sensors_tp_crc_valid_128() - CRC check function for
> + *     Temperature and pressure devices for 128bit PROM.
> + *     This function is only used when reading PROM coefficients
> + *
> + * @prom:	pointer to PROM coefficients array
> + *
> + * Return: CRC.
> + */
> +static bool ms_sensors_tp_crc_valid_128(u16 *prom)
> +{
> +	u16 w7 = prom[7], crc_read = w7 & 0x000F;
> +	u8 crc;
> +
> +	prom[7] &= 0xFF00;      /* Clear the CRC and LSB part */
> +
> +	crc = ms_sensors_tp_crc4(prom);
> +
> +	prom[7] = w7;
> +
> +	return crc == crc_read;
>  }
>  
>  /**
> @@ -535,6 +577,7 @@ static bool ms_sensors_tp_crc_valid(u16 *prom)
>  int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
>  {
>  	int i, ret;
> +	bool valid;
>  
>  	for (i = 0; i < dev_data->hw->prom_len; i++) {
>  		ret = ms_sensors_read_prom_word(
> @@ -546,7 +589,12 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
>  			return ret;
>  	}
>  
> -	if (!ms_sensors_tp_crc_valid(dev_data->prom)) {
> +	if (dev_data->hw->prom_len == 8)
> +		valid = ms_sensors_tp_crc_valid_128(dev_data->prom);
> +	else
> +		valid = ms_sensors_tp_crc_valid_112(dev_data->prom);
> +
> +	if (!valid) {
>  		dev_err(&dev_data->client->dev,
>  			"Calibration coefficients crc check error\n");
>  		return -ENODEV;

