Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D163BAE1E
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGDRwx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhGDRwx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jul 2021 13:52:53 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A8C061574;
        Sun,  4 Jul 2021 10:50:17 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id m18-20020a9d4c920000b029048b4f23a9bcso3889985otf.9;
        Sun, 04 Jul 2021 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i7vtfxgWArI6PRyfxRknmFmM4IPjEg4AR4ZIWuTijqY=;
        b=UaMdlOW3gPF7HbUZf7UCaa+MbtbmoGWg/pePMxXnjLfZNYBR6FouSzVYbxyFH75hXu
         ts88vM36Kfq8X/HEK0LQKFjpqp2nPUco0gvZm/CMEMmQo1PPLeJuWE3rgEntoYSaDUy5
         sQr3VUelb7OIphnaIquTI3zMtBTyaugfd360zeY2zsimkeDqBZVT/ZiwRfDjAjBSAmCi
         zK6Pu0i2x+zOcGMHf2kKGRidCxCedKEj7lie0ECANRd+OjjJnXBRHjDNwOPq1itK37qr
         RH9trbYVk9nk6GJ8M2u573zPk65kLQ+t6GJD2jrYd459f6UKn2pkBJRsZx0iRucAqqvC
         Vq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i7vtfxgWArI6PRyfxRknmFmM4IPjEg4AR4ZIWuTijqY=;
        b=I0kUxMys3OdMZ1BAmWwxv/wtF04/sUU63UCLYE5sc7rIG6czIUS0feNPc8qdbsDAvj
         cQM8KcyKZ3Kt16CMppI+KAO+OvBsWp/A2W084p9cs7q+LLmBrz5knWAAgTQ6lsy1fu+f
         QUaLpYF8z93FW9vQChazFDuKwQ6qWPtknXIyXeXQ1AWOfNbeT7hKk2DDqUHXWfjWbN+R
         awWnVu05eEE+itEbdRW8hEAtubOKd7l7Z7H3O6SO9ofy0VXH5cxxC1/wNjvKlGNW/VYN
         l7dWBK4UI8xL08XSNjVKYRByHLWNuaQotglseDy5RWPR7dMd9G8BxmPSjMs80iVk3/Vi
         Cd6g==
X-Gm-Message-State: AOAM532uLKbGjDG9hv9C92fh8r/mmhAadBtGZ9P0sl2E4jRXub0u0Feq
        8VHXPdC+pyp3o4No7js+gd2Mx5K3MWU=
X-Google-Smtp-Source: ABdhPJwy40okOT1AQ+ckQ24ILmAtTmqlhaSibd5DSNLg5kqQ8W495KlqP36KxasWWdXyb+CKsc8wag==
X-Received: by 2002:a9d:3e08:: with SMTP id a8mr5518782otd.42.1625421016079;
        Sun, 04 Jul 2021 10:50:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p203sm1172871oih.38.2021.07.04.10.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 10:50:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
References: <20210703180131.4036589-1-linus.walleij@linaro.org>
 <20210704171406.61235987@jic23-huawei>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (ntc_thermistor): Use library interpolation
Message-ID: <eecc85ba-0a8b-969b-3979-82304198437c@roeck-us.net>
Date:   Sun, 4 Jul 2021 10:50:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210704171406.61235987@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/4/21 9:14 AM, Jonathan Cameron wrote:
> On Sat,  3 Jul 2021 20:01:31 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> The kernel has a helper function for linear interpolation so
>> use it. It incidentally makes the code easier to read as well.
>>
>> Cc: Peter Rosin <peda@axentia.se>
>> Cc: Chris Lesiak <chris.lesiak@licor.com>
>> Cc: linux-iio@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Potential precision problem because the multiplication by 1000 is now done
> post division whereas before it was before it?
> 
> I'm only eyeballing the code so no idea if it makes a practical difference.
> 

I think so, since the code now only reports temperatures in full degrees C
which wasn't the case earlier. That should be easy to fix though by
passing data->comp[low].temp_c * 1000 and data->comp[high].temp_c * 1000
as parameters to fixp_linear_interpolate().

Also, the if/else in get_temp_mc() seems now unnecessary since
fixp_linear_interpolate() effectively does the same checks.

Guenter

>> ---
>>   drivers/hwmon/ntc_thermistor.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
>> index 8587189c7f15..61bd0e074ec9 100644
>> --- a/drivers/hwmon/ntc_thermistor.c
>> +++ b/drivers/hwmon/ntc_thermistor.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/err.h>
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>> +#include <linux/fixp-arith.h>
>>   
>>   #include <linux/platform_data/ntc_thermistor.h>
>>   
>> @@ -557,10 +558,12 @@ static int get_temp_mc(struct ntc_data *data, unsigned int ohm)
>>   		/* Unable to use linear approximation */
>>   		temp = data->comp[low].temp_c * 1000;
>>   	} else {
>> -		temp = data->comp[low].temp_c * 1000 +
>> -			((data->comp[high].temp_c - data->comp[low].temp_c) *
>> -			 1000 * ((int)ohm - (int)data->comp[low].ohm)) /
>> -			((int)data->comp[high].ohm - (int)data->comp[low].ohm);
>> +		temp = fixp_linear_interpolate(data->comp[low].ohm,
>> +					       data->comp[low].temp_c,
>> +					       data->comp[high].ohm,
>> +					       data->comp[high].temp_c,
>> +					       ohm);
>> +		temp *= 1000;
>>   	}
>>   	return temp;
>>   }
> 

