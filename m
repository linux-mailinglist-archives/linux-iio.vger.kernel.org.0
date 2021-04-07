Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD3B3566BD
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 10:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhDGIZO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 04:25:14 -0400
Received: from www381.your-server.de ([78.46.137.84]:51256 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbhDGIZN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 04:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=i5z8vIX5++eLc4QF/YGiMmJYLPuXjQP6lKVPsWZFrBI=; b=KRXJkQwz5U1hFSpfFbTxB01qqX
        xwcOZe2YbKvT030v0P24/5zoRSPj92tHvy8S6Nma0m8KSghQk6YFiPN8JN6BRQUav60jcDiMnLm9t
        6RB0e/BdNr8Xer77AXazTKxJyYUHzI/o3nNrLt4LKlVFrJBrPgUzQ/AKT7tZAxj1Q/GJCF8zbxrR/
        yN/+aDUFMcexpPVWntzZM95q+CIzzdNwBkDom/9N1GJXTR9557AsnH1gqYAm5h3egPu+L140ZWbS6
        W2Gglryt6cMF5u0cU51f0+gRYsNDPEjMEAMWv5vZokX4u8Japr7SgrSNTlHUd0tCQBttIAh/9vdId
        Sn+J/wyA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lU3Uk-0009Ix-Rm; Wed, 07 Apr 2021 10:25:02 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lU3Uk-000S7E-Mz; Wed, 07 Apr 2021 10:25:02 +0200
Subject: Re: [PATCH] iio: adis16480: support burst read function
To:     Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20210406151424.110477-1-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b62f72d8-4d9a-dfb6-685c-3e5985aae8c6@metafoo.de>
Date:   Wed, 7 Apr 2021 10:25:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406151424.110477-1-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26132/Tue Apr  6 13:06:05 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/6/21 5:14 PM, Nuno Sa wrote:
> Some supported devices support burst read function. This provides a method
> for reading a batch of data (status, temperature, gyroscopes,
> accelerometers, time stamp/data counter, and CRC code), which does not
> require a stall time between each 16-bit segment and only requires one
> command on the DIN line to initiate. Devices supporting this mode
> are:
>
>    * adis16495-1
>    * adis16495-2
>    * adis16495-3
>    * adis16497-1
>    * adis16497-2
>    * adis16497-3
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Looks good to me, just some thoughts on CRC and endiness conversion.

> ---
>   drivers/iio/imu/adis16480.c | 157 +++++++++++++++++++++++++++++++++---
>   1 file changed, 144 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index f81b86690b76..341945f8339e 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -5,6 +5,7 @@
>    * Copyright 2012 Analog Devices Inc.
>    */
>   
> [...]
> +static bool adis16480_validate_crc(const u16 *buf, const u8 n_elem, const u32 crc)
const __be16 *buf
> +{
> +	u32 crc_calc;
> +	u16 crc_buf[15];
> +	int j;
> +
> +	for (j = 0; j < n_elem; j++)
> +		crc_buf[j] = swab16(buf[j]);
be16_to_cpu(buf[j])
> +
> +	crc_calc = crc32(~0, crc_buf, n_elem * 2);
> +	crc_calc ^= ~0;
> +
> +	return (crc == crc_calc);
> +}
> +
> +static irqreturn_t adis16480_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adis16480 *st = iio_priv(indio_dev);
> +	struct adis *adis = &st->adis;
> +	int ret, bit, offset, i = 0;
> +	__be16 *buffer;
> +	u32 crc;
> +	bool valid;
> +	const u32 cached_spi_speed_hz = adis->spi->max_speed_hz;
> +
> +	adis_dev_lock(adis);
> +	if (adis->current_page != 0) {
> +		adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
> +		adis->tx[1] = 0;
> +		ret = spi_write(adis->spi, adis->tx, 2);
> +		if (ret) {
> +			dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
> +			adis_dev_unlock(adis);
> +			return ret;
> +		}
> +	}
> +
> +	adis->spi->max_speed_hz = ADIS16495_BURST_MAX_SPEED;
> +
> +	ret = spi_sync(adis->spi, &adis->msg);
> +	if (ret) {
> +		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
> +		adis_dev_unlock(adis);
> +		return ret;
> +	}
> +
> +	adis->spi->max_speed_hz = cached_spi_speed_hz;
> +	adis->current_page = 0;
> +	adis_dev_unlock(adis);
> +
> +	/*
> +	 * After making the burst request, the response can have one or two
> +	 * 16-bit responses containing the BURST_ID depending on the sclk. If
> +	 * clk > 3.6MHz, then we will have two BURST_ID in a row. If clk < 3MHZ,
> +	 * we have only one. To manage that variation, we use the transition from the
> +	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5A5. If
> +	 * we not find this variation in the first 4 segments, then the data should
> +	 * not be valid. We don't return right away since the crc validation should
> +	 * fail anyways...
> +	 */
> +	buffer = adis->buffer;
> +	for (offset = 0; offset < 4; offset++) {
> +		u16 curr = be16_to_cpu(buffer[offset]);
> +		u16 next = be16_to_cpu(buffer[offset + 1]);
> +
> +		if (curr == ADIS16495_BURST_ID && next != ADIS16495_BURST_ID) {
> +			offset++;
> +			break;
> +		}
> +	}

I think offset can be up to 4 here, in which case offset + 16 is 
out-of-bounds for buffer. Maybe return right away if offset is 4.

> +
> +	crc = be16_to_cpu(buffer[offset + 16]) << 16 | be16_to_cpu(buffer[offset + 15]);
> +	valid = adis16480_validate_crc((u16 *)&buffer[offset], 15, crc);
> +	if (!valid) {
> +		dev_err(&adis->spi->dev, "Invalid crc\n");
> +		goto irq_done;
> +	}
> +
> [...]


