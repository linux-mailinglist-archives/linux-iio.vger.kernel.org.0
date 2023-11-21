Return-Path: <linux-iio+bounces-230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4577F2B75
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 12:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6702E282775
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE63EA79;
	Tue, 21 Nov 2023 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQg+S3KV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84CC1
	for <linux-iio@vger.kernel.org>; Tue, 21 Nov 2023 03:08:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b2c9ee8ecso142275e9.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Nov 2023 03:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700564910; x=1701169710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjdtNxULy8GpfsKCvdM83K03LmtKeMMcPxb4JkNuP7s=;
        b=HQg+S3KVP48LXRMu5SOhU8+U+frPxkptm0p8FqeNlrdZA3ns0HFm1T+EJQxBgBQs/X
         bpeNzRlcBmYXPGFcWWJCXffc9sla89E2NrnTVuDPyslg3dUUp4bTiNJOYEDazHEOaEeK
         3PhCrmUba6mk7VOnopmO0PQD1LD9mQFY9c41q5D0nAEgtNB+VoznXMoY8s5cN/7PsOnq
         bHhNRiyeOuB8cg6AcFoK3g9RHddNxLEPApzDNGPL1tC51/f11xZlchirW667d4EkwdOI
         aMZHDRxoLYdBRIX8AvT/c1Zs+2QhD9Fxux7taBtFk+/OBFxhmCieQLIDMEAeS/1Q0Yji
         G3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564910; x=1701169710;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjdtNxULy8GpfsKCvdM83K03LmtKeMMcPxb4JkNuP7s=;
        b=ub2Kh0vwVwB5mWzo2kVQ0q8oJtlfaBCRYhJjLBqnjBkj71WI1V9Vcu0auCCKZbkI1A
         NC5RwS8H3k/Qyc4DkIUhdkWv9F0M88XJ7aSb4aLbXEbH0/9LWEU9Cwp28IQoyADqrjpi
         RkmwSuDHPii+28C992an1FYqgK2zS70gWBRPzpwxT/VFHm1fKE6//I2S4NSREX9ffNvG
         dJ3Fx1cEiJgdJ7rLQ1ec8uPdKmnuPk0h7MU4X/nY0gI/k39hpgf42cy3FuV8r/168KOq
         BZyz4gaydIU4Vwuf/PPelDJT/KbM7ATlwwgyxsmwPY6BFjpHJgT+Oey1CJpxw6LEmCiW
         D3QA==
X-Gm-Message-State: AOJu0YwxLXEhGiPmn7FwmwZC1Qtv0F8kvXa6FXSyZGXlkZDpAcNYf/xI
	0pVyOE2KaJQhhSguKaIchbpW1mFEB6CV2yE7hk73DNtX
X-Google-Smtp-Source: AGHT+IE06AyXcbIInK/ALarbb+zk6R0IAgBeYBiZpcgR5OQCTkC4jUkRjeSmSTNHO5ygCD7WzMWbLg==
X-Received: by 2002:a05:600c:230a:b0:408:37d4:b5ba with SMTP id 10-20020a05600c230a00b0040837d4b5bamr8384988wmo.12.1700564910505;
        Tue, 21 Nov 2023 03:08:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a39:bc19:20b6:16a? ([2a01:e0a:982:cbb0:2a39:bc19:20b6:16a])
        by smtp.gmail.com with ESMTPSA id jg6-20020a05600ca00600b0040b2c195523sm449723wmb.31.2023.11.21.03.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 03:08:30 -0800 (PST)
Message-ID: <f693f5c2-7103-4d32-bc38-6832b0f46453@linaro.org>
Date: Tue, 21 Nov 2023 12:08:28 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] iio: adc: meson: add separate config for axg SoC family
Content-Language: en-US, fr
To: George Stark <gnstark@salutedevices.com>, jic23@kernel.org,
 lars@metafoo.de, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, andriy.shevchenko@linux.intel.com,
 nuno.sa@analog.com, u.kleine-koenig@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 kernel@salutedevices.com
References: <20231121075000.133711-1-gnstark@salutedevices.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231121075000.133711-1-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2023 08:50, George Stark wrote:
> According to Amlogic custom kernels ADC of axg SoC family requires
> unique number of setting so add dedicated config for it.

Please rephrase precising AXG has vref_select and requires this setting
to work nominally and thus requires a separate config.

With this:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   drivers/iio/adc/meson_saradc.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index db280da9edbf..34555a85f131 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1242,6 +1242,20 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>   	.cmv_select = 1,
>   };
>   
> +static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
> +	.has_bl30_integration = true,
> +	.clock_rate = 1200000,
> +	.bandgap_reg = MESON_SAR_ADC_REG11,
> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
> +	.resolution = 12,
> +	.disable_ring_counter = 1,
> +	.has_reg11 = true,
> +	.vref_volatge = 1,
> +	.has_vref_select = true,
> +	.vref_select = VREF_VDDA,
> +	.cmv_select = 1,
> +};
> +
>   static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
>   	.has_bl30_integration = false,
>   	.clock_rate = 1200000,
> @@ -1286,7 +1300,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>   };
>   
>   static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
> -	.param = &meson_sar_adc_gxl_param,
> +	.param = &meson_sar_adc_axg_param,
>   	.name = "meson-axg-saradc",
>   };
>   


