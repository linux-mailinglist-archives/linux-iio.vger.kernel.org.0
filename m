Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB733E3548
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 14:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhHGMMA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 08:12:00 -0400
Received: from www381.your-server.de ([78.46.137.84]:57020 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhHGML7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 08:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=p/2uIS9loTstr/6ATLiPIAUixixK0W2QnJLyes2cUb4=; b=gVdC4CaR/f+9OrY99BqLpD3jSf
        4o0kWhW0HMc6F4QVEVirPKtphalhTEKSckPGZVOSpZYzeqqcEbWN/p5zCvHOlYW8OzoRJEwqKuudv
        8Ax5r3hBgL87Z01otwAMRv/8WnDJhpPPvWrq3Z6eA/HmWmiIUe2uYBipy8PT/eQBCBE0l965tRuVa
        A28TgpAktqTuZ0G5AXwKyt7vd09rmLECGZJquODJJ0lWe6XEli+v7AHHbRABfDKAIygLCTZaFBg2M
        2JUVlVsO6sDFaIVvyhfuhh03T/IrJXsjIWMbOZxsNigZ/YIxF/ZJ1p+0eaUP0lnAf1JF8nZvyo2xH
        w6rwU7BQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mCLAn-0009Qm-Ee; Sat, 07 Aug 2021 14:11:29 +0200
Received: from [62.216.202.4] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mCLAn-0008qM-2T; Sat, 07 Aug 2021 14:11:29 +0200
Subject: Re: [PATCH 2/2] iio: potentiometer: Add driver support for AD5110
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20210807050900.10075-1-dmugil2000@gmail.com>
 <20210807050900.10075-3-dmugil2000@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <53306463-668e-e291-4539-caca2352ea05@metafoo.de>
Date:   Sat, 7 Aug 2021 14:11:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210807050900.10075-3-dmugil2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26256/Sat Aug  7 10:20:00 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/7/21 7:08 AM, Mugilraj Dhavachelvan wrote:
> The AD5110/AD5112/AD5114 provide a nonvolatile solution
> for 128-/64-/32-position adjustment applications, offering
> guaranteed low resistor tolerance errors of ±8% and up to
> ±6 mA current density.
>
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>

Thanks for the patch. This looks really good!


> [...]
>
> +static int ad5110_write(struct ad5110_data *data, u8 cmd, u8 val)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	data->buf[0] = cmd;
> +	data->buf[1] = val;
> +
> +	ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
> +	mutex_unlock(&data->lock);

This returns the number of bytes written, which can be less then the 
number of bytes requested if there was an error. This should check if 
the right amount of bytes was written and return -EIO otherwise. Same 
for the other places that read/write from I2C.

> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int ad5110_resistor_tol(struct ad5110_data *data, u8 cmd, int val)
> +{
> +	int ret;
> +
> +	ret = ad5110_read(data, cmd, &val);
> +	if (ret)
> +		return ret;
> +
> +	data->tol = FIELD_GET(GENMASK(6, 3), val);
> +	data->tol = ((val & GENMASK(2, 0)) * 1000 / 8) + data->tol * 1000;
> +	data->tol = data->cfg->kohms * data->tol / 100;

This is not wrong, but it can be implemented a bit simpler. The 
tolerance is encoded as a fixed point number, you don't have to treat 
them as two independent fields, but can treat it as one fixed point number.

     data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 1000 / 100 / 8;


> +	if (!(val & BIT(7)))
> +		data->tol *= -1;
> +
> +	return 0;
> +}
> +
> +static ssize_t ad5110_eeprom_read(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad5110_data *data = iio_priv(indio_dev);
> +	int val = AD5110_WIPER_POS;
> +	int ret;
> +
> +	ret = ad5110_read(data, AD5110_EEPROM_RD, &val);
> +	if (ret)
> +		return ret;
Maybe apply shift to get consistent behavior with `raw`.
> +
> +	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +}
> +
> +static ssize_t ad5110_eeprom_write(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad5110_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad5110_write(data, AD5110_EEPROM_WR, 0);
> +	if (ret) {
> +		dev_err(&data->client->dev, "RDAC to EEPROM write failed\n");
> +		return ret;
> +	}
> +	msleep(20);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(wiper_pos_eeprom, 0644,
> +		       ad5110_eeprom_read,
> +		       ad5110_eeprom_write, 0);
This is new custom ABI and needs to be documented.
> +static int ad5110_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad5110_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val >= data->cfg->max_pos || val < 0)
val == data->cfg->max_pos is a valid setting. Writing max_pos puts it in 
top-scale mode which gives maximum resistance.
> +			return -EINVAL;
> +
> +		return ad5110_write(data, AD5110_RDAC_WR, val << data->cfg->shift);
> +	case IIO_CHAN_INFO_ENABLE:
> +		if (val < 0 || val > 1)
> +			return -EINVAL;
> +		if (data->enable == val)
> +			return 0;
> +		ret = ad5110_write(data, AD5110_SHUTDOWN, val);
Doesn't val have to be inverted to get the right behavior?
> +		if (ret)
> +			return ret;
> +		data->enable = val;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
[...]
