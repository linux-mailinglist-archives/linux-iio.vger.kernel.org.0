Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE51898F2
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 11:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCRKKP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 06:10:15 -0400
Received: from www381.your-server.de ([78.46.137.84]:39508 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRKKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 06:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y918cv9dhznYz7P8DDz2eYUjQjO/SEckF+p1tpKIY/0=; b=lPOh02WL+dDTLJaJGhJpr2KP3O
        YDMCSNwAzfFGhxkSkCfjpt5rfFoPYegsjbjLAcjq1+Otn6HunB5KvW113Di4IxczImrDjR4VpnW8x
        cKDsGf3Vb6VgPDvH4U1yoKk0gU8bJ7ZMNlsGsXYM/zdJUUlBIVBZwlIj2KbPutH1fMjx4fDD7BJ3T
        kVX8b423FoO7a6kewugnGGlyO3u4q3qz/wCGaJFvFdxx8x8EcM8D7RBF1b/6vRIg4odBELDaKerlM
        eTNNK7gUF6yDHOm4JLpyAiOkKwuQntzDrq1avhl2Qtq286Bx5CZ4jUyMBEHDccfXvcp/jyfiG68g/
        Uo6OfKhg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEVeN-0006Uj-5Y; Wed, 18 Mar 2020 11:10:11 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEVeM-000XLO-Tl; Wed, 18 Mar 2020 11:10:11 +0100
Subject: Re: [PATCH v3 1/4] iio: accel: adxl372: Add support for FIFO peak
 mode
To:     Alexandru Tachici <tachicialex@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
References: <20200318110958.8621-1-alexandru.tachici@analog.com>
 <20200318110958.8621-2-alexandru.tachici@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7a86c39a-1653-1e06-88df-a7cd15477ecc@metafoo.de>
Date:   Wed, 18 Mar 2020 11:10:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318110958.8621-2-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 12:09 PM, Alexandru Tachici wrote:
> From: Stefan Popa <stefan.popa@analog.com>
> 
> By default, if all three channels (x, y, z) are enabled, sample sets of
> concurrent 3-axis data is stored in the FIFO. This patch adds the option
> to configure the FIFO to store peak acceleration (x, y and z) of every
> over-threshold event. When pushing to iio buffer we push only enabled
> axis data.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>   drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 67b8817995c0..90c37d6f10d3 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -133,6 +133,9 @@
>   
>   /* The ADXL372 includes a deep, 512 sample FIFO buffer */
>   #define ADXL372_FIFO_SIZE			512
> +#define ADXL372_X_AXIS_EN(x)			(((x) >> 0) & 0x1)
> +#define ADXL372_Y_AXIS_EN(x)			(((x) >> 1) & 0x1)
> +#define ADXL372_Z_AXIS_EN(x)			(((x) >> 2) & 0x1)
>   
>   /*
>    * At +/- 200g with 12-bit resolution, scale is computed as:
> @@ -253,6 +256,7 @@ struct adxl372_state {
>   	struct iio_trigger		*dready_trig;
>   	enum adxl372_fifo_mode		fifo_mode;
>   	enum adxl372_fifo_format	fifo_format;
> +	unsigned int			fifo_axis_mask;
>   	enum adxl372_op_mode		op_mode;
>   	enum adxl372_act_proc_mode	act_proc_mode;
>   	enum adxl372_odr		odr;
> @@ -264,6 +268,7 @@ struct adxl372_state {
>   	u8				int2_bitmask;
>   	u16				watermark;
>   	__be16				fifo_buf[ADXL372_FIFO_SIZE];
> +	bool				peak_fifo_mode_en;
>   };
>   
>   static const unsigned long adxl372_channel_masks[] = {
> @@ -522,6 +527,22 @@ static int adxl372_get_status(struct adxl372_state *st,
>   	return ret;
>   }
>   
> +static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
> +{
> +	__be16	axis_sample[3];
> +	int i = 0;
> +
> +	memset(axis_sample, 0, 3 * sizeof(__be16));
> +	if (ADXL372_X_AXIS_EN(st->fifo_axis_mask))
> +		axis_sample[i++] = sample[0];
> +	if (ADXL372_Y_AXIS_EN(st->fifo_axis_mask))
> +		axis_sample[i++] = sample[1];
> +	if (ADXL372_Z_AXIS_EN(st->fifo_axis_mask))
> +		axis_sample[i++] = sample[2];
> +
> +	memcpy(sample, axis_sample, 3 * sizeof(__be16));
> +}
> +
>   static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>   {
>   	struct iio_poll_func *pf = p;
> @@ -553,8 +574,12 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>   			goto err;
>   
>   		/* Each sample is 2 bytes */
> -		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
> +		for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
> +			/* filter peak detection data */
> +			if (st->peak_fifo_mode_en)
> +				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
>   			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +		}
>   	}
>   err:
>   	iio_trigger_notify_done(indio_dev->trig);
> @@ -722,6 +747,43 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
>   	}
>   }
>   
> +static ssize_t adxl372_peak_fifo_en_get(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%d\n", st->peak_fifo_mode_en);
> +}
> +
> +static ssize_t adxl372_peak_fifo_en_set(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	bool val;
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	st->peak_fifo_mode_en = val;
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(hwfifo_peak_mode_enable, 0644,
> +		       adxl372_peak_fifo_en_get,
> +		       adxl372_peak_fifo_en_set, 0);
> +

Rather than going with a non-standard attribute, I'd register a IIO 
trigger for the peak mode and switch between peak and normal mode by 
assigning the corresponding trigger.

At least that's how I understand how this mode works. Data capture is 
triggered by exceeding a threshold.

- Lars

