Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562C6388ED1
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353570AbhESNTB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 May 2021 09:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346669AbhESNTB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 May 2021 09:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621430261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+phD2vnx+Y99FQqG0Ix+frREH9GlIsEm8UwrCqQZFs=;
        b=UOZhHAH8zwqyFnxHvRW7Eluap4xRQeRVN88XQi2E+m5xWnG7dStwfC1jzsBr4hynYKYLum
        FFH07Don4T0pzyZk5MIYeWOQpcU7tL+MbpZPGOzPMnOCh3HGNNROtnJlpobq7vIwdpyvGD
        nelqSXm8oeHb2oQj2ySz3HKbqpzkVHA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-HuSRXErtMXiORhjRWQpL8g-1; Wed, 19 May 2021 09:17:38 -0400
X-MC-Unique: HuSRXErtMXiORhjRWQpL8g-1
Received: by mail-ej1-f71.google.com with SMTP id w13-20020a170906384db02903d9ad6b26d8so1809423ejc.0
        for <linux-iio@vger.kernel.org>; Wed, 19 May 2021 06:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+phD2vnx+Y99FQqG0Ix+frREH9GlIsEm8UwrCqQZFs=;
        b=eYO/58Xg6CUnxsPume9/8tKlYHaUYjEgmq5Tagz3W7WodGxj+UoRenGr0dKONmtfPH
         pbj5cAHwqh4R8zSjjm6BB/6GQwkz1mM4hYebvUTeTbJteW+8jW/u0RFMEmovaDxgZTVk
         mxhJax5nhFJbMAUvnzjaFstYGXPKyb36544pOjxF38M7KUkcGISmRgemDGmwpvuREDTz
         d21Z/bkvzcrI9hXCHH79SYtBKjm9H7xOgG04eJ7/FbmH4ozG2cLqqVd+kkfpzAMqwCce
         dBXlV3sfbHmVivhyE+Z3lK6QEA0yqmJXFvYn6+eOuSw4fNiiW7PD3Jlj7i0lgOWTI5MG
         8Yaw==
X-Gm-Message-State: AOAM531NqcsJdoKV5T27JqJrBmPJnEYyoTqEcu8TXw4lr/IyTr4oJFup
        vdrnzXldKMUM1LBEJtYMzLuk4re1HSvZLCdzX2UkI1WLWDEf+QKwe2wI/JQA3r5UhJPtfYFAyqN
        4SdbfVUbgUmnfwzDEefgl
X-Received: by 2002:a17:906:7203:: with SMTP id m3mr12386921ejk.381.1621430257312;
        Wed, 19 May 2021 06:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7DPvyRih7b/9GA0INObrR79tWMqhpoqQ79pSFnVIhn1dgaMIKzTJku5KlSLpVzc1DrSq0ZA==
X-Received: by 2002:a17:906:7203:: with SMTP id m3mr12386902ejk.381.1621430257183;
        Wed, 19 May 2021 06:17:37 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dk21sm8511488ejb.54.2021.05.19.06.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:17:36 -0700 (PDT)
Subject: Re: [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20210518230722.522446-1-linus.walleij@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <323cc45a-6db2-8732-d3b0-784b1250d7f7@redhat.com>
Date:   Wed, 19 May 2021 15:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518230722.522446-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/19/21 1:07 AM, Linus Walleij wrote:
> Extend ST_SENSORS_LSM_CHANNELS() to a version that will accept extended
> attributes named ST_SENSORS_LSM_CHANNELS_EXT() and wrap the former as a
> specialized version of the former.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans


> ---
> ChangeLog v2->v3:
> - Rebase and resend.
> ChangeLog v1->v2:
> - New helper patch from Stephan.
> ---
>  include/linux/iio/common/st_sensors.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 0b9aeb479f48..8e0d76b42db9 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -48,8 +48,8 @@
>  #define ST_SENSORS_MAX_NAME			17
>  #define ST_SENSORS_MAX_4WAI			8
>  
> -#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
> -					ch2, s, endian, rbits, sbits, addr) \
> +#define ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod, \
> +				    ch2, s, endian, rbits, sbits, addr, ext) \
>  { \
>  	.type = device_type, \
>  	.modified = mod, \
> @@ -65,8 +65,14 @@
>  		.storagebits = sbits, \
>  		.endianness = endian, \
>  	}, \
> +	.ext_info = ext, \
>  }
>  
> +#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
> +				ch2, s, endian, rbits, sbits, addr)	\
> +	ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod,	\
> +				    ch2, s, endian, rbits, sbits, addr, NULL)
> +
>  #define ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL() \
>  		IIO_DEV_ATTR_SAMP_FREQ_AVAIL( \
>  			st_sensors_sysfs_sampling_frequency_avail)
> 

