Return-Path: <linux-iio+bounces-124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F048B7EE562
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211A01C20A3F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48534574;
	Thu, 16 Nov 2023 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2YWOJBm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E52B7;
	Thu, 16 Nov 2023 08:45:19 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507cee17b00so1316098e87.2;
        Thu, 16 Nov 2023 08:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700153117; x=1700757917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiPd8UEBNEHtj74GdSCio3vEpqLG/F50AgqDf2lR2Ak=;
        b=L2YWOJBmzhVRlQ70JS3Jq5L1w8qDgQ3zRlpw2EEmqMfRr6+891iNFwQZ+fcQiT8+HA
         VS7eY6bbQhFdkRgpi/ZKAyKz8WidlIKwcX66eSj/uGHoiYyaIcnvAaAv4sMDVqJ3788+
         pl1wjCyd76nxECxqRgZaaiuLUXlxJVIDoRXeQrg59oXMw7y4fDwP6UklA8eByDkr8Ztn
         DX5xO6dVH/tk/p8Z0HJUJMzCawbBpiZngNvSYTthNBPmg8TwjGXjgiXhhcdSulmKlW0b
         4nMdrqhchQ+gy5iuTJEi7q8TJV0+i9TL+ETSqnhkmUuVIChW3RLeX/mYZ0t46D/VsLUG
         nZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153117; x=1700757917;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiPd8UEBNEHtj74GdSCio3vEpqLG/F50AgqDf2lR2Ak=;
        b=mKrD1dFL6rpwmsbrH8NgUM3NRrvUlPBiTCwDbossmUznT22LAGzyzqzeNJPMuGnLfT
         JMcDovGYARR4qT2kln4qGmMjT3feIOwxPvx+SwmQuipXXKalK1CQzwsNJpe/RkzjY0Cp
         UGEbWq5pjmoS7nKDcvV2TqF3tRnT5Zf0OjmVGr2yn2oaUp/E9YLb622WLeka0MeYv12J
         ENGAj82xMqVUa7QtUE+lWpVpyVteVDMvDeCPbZjEfMvF5eZfKWfoRqsUMidYkW0geG9W
         oWni7sduIdjr22iyOBR5348PJkDvW4uDZ/PR6Frs6+ddofZ7P7Mca7Ljhedw737FHDP2
         BcQQ==
X-Gm-Message-State: AOJu0Yz2ra+iJXv1ES4ICa2MHPI9kO3aKDfg2Da02KBsqWSBZ4ObYbDA
	FayOooIkS/2YbUXk3TQco/8=
X-Google-Smtp-Source: AGHT+IHNDgUcA7fd3nCJF5IFw8HKbQRnqPIlT5sDlAw5kPbjf2/KxRL+e9J6ifiCwEJzHciHM3PK0w==
X-Received: by 2002:a05:6512:3b20:b0:507:aaab:528c with SMTP id f32-20020a0565123b2000b00507aaab528cmr14128591lfv.69.1700153116925;
        Thu, 16 Nov 2023 08:45:16 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id p28-20020ac246dc000000b00509447753c5sm39897lfo.308.2023.11.16.08.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 08:45:16 -0800 (PST)
Message-ID: <f2ca7f12-4a4c-441e-932d-5f03057e4c5d@gmail.com>
Date: Thu, 16 Nov 2023 18:45:15 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231116131329.6801-1-marex@denx.de>
 <20231116131329.6801-2-marex@denx.de>
 <493c138c-ca67-4244-bcd7-c1c3d596048d@gmail.com>
In-Reply-To: <493c138c-ca67-4244-bcd7-c1c3d596048d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/16/23 18:25, Matti Vaittinen wrote:
>> +
>> +static int isl76682_write_raw(struct iio_dev *indio_dev,
>> +                  struct iio_chan_spec const *chan,
>> +                  int val, int val2, long mask)
>> +{
>> +    struct isl76682_chip *chip = iio_priv(indio_dev);
>> +    int ret;
>> +
>> +    if (chan->type != IIO_LIGHT)
>> +        return -EINVAL;
>> +
>> +    if (mask != IIO_CHAN_INFO_SCALE)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&chip->lock);
>> +    ret = isl76682_set_als_scale(chip, val);
>> +    mutex_unlock(&chip->lock);
> 
> This looks a bit odd to me. I was under impression that the values would 
> by default be IIO_VAL_INT_PLUS_MICRO unless the format is given in 
> iio_info struct. If so, I'd expect the val to be zero for all of the 
> scales because all scales are smaller than 1. (I may be wrong though). 
> Eg, I'd expect that when range 1000 is set (scale 1000 / 65535), val = 
> 0, val1 roughly 15259 (to mean 0.015259).

I mean val2 is 15259. There is no val1. Well, as you see you can trust 
me, numbers are my strong "thing" :rolleyes:




