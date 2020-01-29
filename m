Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8114D02E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgA2SPT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jan 2020 13:15:19 -0500
Received: from www381.your-server.de ([78.46.137.84]:48004 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgA2SPT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2020 13:15:19 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1iwrrs-0008Vd-UB; Wed, 29 Jan 2020 19:15:13 +0100
Received: from [93.104.127.234] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1iwrrs-000OrG-Kw; Wed, 29 Jan 2020 19:15:12 +0100
Subject: Re: [PATCH V3] iio: adc: ad7124: Add direct reg access
To:     Mircea Caprioru <mircea.caprioru@analog.com>, jic23@kernel.org
Cc:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20200129085356.28899-1-mircea.caprioru@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <eb4d0972-f95c-39f7-0520-c71c8370428d@metafoo.de>
Date:   Wed, 29 Jan 2020 19:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129085356.28899-1-mircea.caprioru@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25710/Wed Jan 29 12:38:38 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[...]
>   
> +static int ad7124_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7124_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (reg >= AD7124_REG_NO)

How about ARRAY_SIZE(ad7124_reg_size)? That will make sure that the 
check is always correct and does not depend on an extra constant that 
might go out-of-sync with the array. It also makes it easier for 
reviewers to check that the code is correct. Otherwise they'll have to 
count how many entries there are in ad7124_reg_size.

> +		return -EINVAL;
> +
> +	if (readval)
> +		ret = ad_sd_read_reg(&st->sd, reg, ad7124_reg_size[reg],
> +				     readval);
> +	else
> +		ret = ad_sd_write_reg(&st->sd, reg, ad7124_reg_size[reg],
> +				      writeval);
> +
> +	return ret;
> +}
> +
>   static IIO_CONST_ATTR(in_voltage_scale_available,
>   	"0.000001164 0.000002328 0.000004656 0.000009313 0.000018626 0.000037252 0.000074505 0.000149011 0.000298023");
>   
> @@ -375,6 +406,7 @@ static const struct attribute_group ad7124_attrs_group = {
>   static const struct iio_info ad7124_info = {
>   	.read_raw = ad7124_read_raw,
>   	.write_raw = ad7124_write_raw,
> +	.debugfs_reg_access = &ad7124_reg_access,
>   	.validate_trigger = ad_sd_validate_trigger,
>   	.attrs = &ad7124_attrs_group,
>   };
> 

