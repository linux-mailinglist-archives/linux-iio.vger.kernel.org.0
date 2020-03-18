Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF4189F4E
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 16:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCRPKN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 11:10:13 -0400
Received: from www381.your-server.de ([78.46.137.84]:42922 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgCRPKN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 11:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fVkLEgRzM/r0AyOZ8ZF2WRxdioYlNEatN5ixEHTn2Mw=; b=IPjbKREKP5ktPaPLKl56Z5kfgs
        zMxcPemxNVIrqOhPpFuAe+bgIi7HUS/0fA7Cm4KHGOnyQ2yX+GFTFRv8+bP3l67c6g2De2/DMUx4W
        38gOqzDg16WE1LsaB5qVMah58eip4ovBRgh8Y8PyTIyjGZTaNT/aKKZx1ujo8LsUxNNG93YbymBe7
        kmyGQt6hnLB7ZPhgIhHd+2I7yAq3BKWRacBr4u1eQRI/ulmtBvmS5AaJPvoJ5P3D2QElkp9yKuUk8
        ZZcvCBHao4+GQNLKP9NuK2AJPcESrpLekirPtQ2olYLg3F6AvUljKlA0wuptx9gZKa1DGrkqDRSYG
        /p+UgaeA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEaKg-0002za-7F; Wed, 18 Mar 2020 16:10:10 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEaKf-000JOc-SW; Wed, 18 Mar 2020 16:10:09 +0100
Subject: Re: [PATCH 5/5] iio: adc: ad7793: use read_avail iio hook for scale
 available
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, renatogeh@gmail.com,
        jic23@kernel.org, mircea.caprioru@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
References: <20200318134042.30133-1-alexandru.ardelean@analog.com>
 <20200318134042.30133-6-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ffe8008d-5506-0e88-7ab2-6b221e36afba@metafoo.de>
Date:   Wed, 18 Mar 2020 16:10:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318134042.30133-6-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25755/Wed Mar 18 14:14:00 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 2:40 PM, Alexandru Ardelean wrote:
> This change uses the read_avail and '.info_mask_shared_by_type_available'
> modifier to set the available scale.
> Essentially, nothing changes to the driver's ABI.
> 
> The main idea for this patch is to remove the AD7793 driver from
> checkpatch's radar. There have been about ~3 attempts to fix/break the
> 'in_voltage-voltage_scale_available' attribute, because checkpatch assumed
> it to be an arithmetic operation and people were trying to change that.


Yeah, probably a good idea!

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>   drivers/iio/adc/ad7793.c | 53 +++++++++++++++++++++++++++-------------
>   1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 5592ae573e6b..fad98f1801db 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -354,29 +354,28 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>   static IIO_CONST_ATTR_NAMED(sampling_frequency_available_ad7797,
>   	sampling_frequency_available, "123 62 50 33 17 16 12 10 8 6 4");
>   
> -static ssize_t ad7793_show_scale_available(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> +static int ad7793_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
>   {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>   	struct ad7793_state *st = iio_priv(indio_dev);
> -	int i, len = 0;
>   
> -	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
> -		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
> -			       st->scale_avail[i][1]);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_avail;

Can you change the type of scale_avail to int so we don't need the cast?

> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		/* Values are stored in a 2D matrix  */
> +		*length = ARRAY_SIZE(st->scale_avail) * 2;
>   
> -	len += sprintf(buf + len, "\n");
> +		return IIO_AVAIL_LIST;
> +	}
>   
> -	return len;
> +	return -EINVAL;
>   }
