Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D010EC5F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLBPg1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 10:36:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36542 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfLBPg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 10:36:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so44821765wru.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 07:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8wyFz77X9P9devbBt56St4WsuUkvphEpHjMscZ5/3xM=;
        b=WxewZutobfMUUiXHUdbrcl9ghLRuskgkLHoglzYIvhIUGsdvXaYVqy6iAzmrOpEy58
         YZ9a5j4i7y+RvlTcsNVolvbTT946vOnH0EwCp+mkq0EcorXjmXxIrZIbiWaUsgJWDccM
         eLAhE+VH3iEILflFXeuoYaj39r65veHC6QC692OlA7uzYVzODCHtmJTgy9qEIk3PuWF6
         dBiVMJKO34WnhVMAUZdMoA531Uz2dsCfgyXbaOw+VRtv8d6gVl3ujXYZUzVYS0MbYD16
         yXsrDopNuWxoLd8wpH737yOdXgmK/lMzanozxbAUL6cIv0zv76S9G8SLsew9pxkva0mE
         oU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8wyFz77X9P9devbBt56St4WsuUkvphEpHjMscZ5/3xM=;
        b=M5ijIqqCwbJlQNfKPa/NpWcQ+gE7aK7qcf18M+9mg7IMMq2MO3FGRQrcMu/90aiW8c
         +RVLcZFxAuN4ME8jNQCMO5Y/+zce31r4dCWx1VXP3nURKzoQJzg1SSjFYQFHhEP/Bo0D
         aoA9kESM1cNzoYYk515rmT7ve2KJjcIC8DAq4wpnblqBTAQoVSPW3WnAhDxVy2Zf9Yme
         tVx3GzcM6fHsdV4Xk3wSYrM/zpzI7joL/aNst35/TPjlWTPBBd+oVjpil17uF66yBp5g
         h0mibiwO2cYyvpl/AAzK+Ztmwtq139bzIfuxjrTx+PFfy9hUERQnJ/iFkc4W1UUCVR0Q
         qu6Q==
X-Gm-Message-State: APjAAAXFZ8N2yxA6v6/gKJrJlRYvDtfmIWOqWdOe2S1VN5AidMrjSLp0
        VIPUMOeynXCE1FHJI8oikrwbN4Vdltg=
X-Google-Smtp-Source: APXvYqzbedqp+BoozVy56G3fqZT8C144Ajx+/3rXN9cOVTB/trRZkmVj8vpwsT8WAZNhHiOSHnJZfA==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr19309257wrp.171.1575300981354;
        Mon, 02 Dec 2019 07:36:21 -0800 (PST)
Received: from [192.168.1.37] (230.120-247-81.adsl-dyn.isp.belgacom.be. [81.247.120.230])
        by smtp.gmail.com with ESMTPSA id a24sm21486649wmb.29.2019.12.02.07.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 07:36:20 -0800 (PST)
Subject: Re: [v2] iio: ad7949: fix channels mixups
To:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org
Cc:     Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <9ea595fc-d53b-3cd4-a511-db2b09726606@essensium.com>
 <20191202141336.4507-1-andrea.merello@gmail.com>
From:   Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <c3f3367f-cc78-23f3-ec89-439b9bc8f433@essensium.com>
Date:   Mon, 2 Dec 2019 16:36:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202141336.4507-1-andrea.merello@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Le 02/12/2019 à 15:13, Andrea Merello a écrit :
>   drivers/iio/adc/ad7949.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 5c2b3446fa4a..2c6f60edb7ce 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -89,6 +89,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>   				   unsigned int channel)
>   {
>   	int ret;
> +	int i;
>   	int bits_per_word = ad7949_adc->resolution;
>   	int mask = GENMASK(ad7949_adc->resolution, 0);
>   	struct spi_message msg;
> @@ -100,12 +101,23 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>   		},
>   	};
>   
> -	ret = ad7949_spi_write_cfg(ad7949_adc,
> -				   channel << AD7949_OFFSET_CHANNEL_SEL,
> -				   AD7949_MASK_CHANNEL_SEL);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * 1: write CFG for sample N and read old data (sample N-2)
> +	 * 2: if CFG was not changed since sample N-1 then we'll get good data
> +	 *    at the next xfer, so we bail out now, otherwise we write something
> +	 *    and we read garbage (sample N-1 configuration).
> +	 */
> +	for (i = 0; i < 2; i++) {
> +		ret = ad7949_spi_write_cfg(ad7949_adc,
> +					   channel << AD7949_OFFSET_CHANNEL_SEL,
> +					   AD7949_MASK_CHANNEL_SEL);
> +		if (ret)
> +			return ret;
> +		if (channel == ad7949_adc->current_channel)
> +			break;
> +	}
>   
> +	/* 3: write something and read actual data */
>   	ad7949_adc->buffer = 0;
>   	spi_message_init_with_transfers(&msg, tx, 1);
>   	ret = spi_sync(ad7949_adc->spi, &msg);

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>

Regards,
Charles-Antoine Couret
