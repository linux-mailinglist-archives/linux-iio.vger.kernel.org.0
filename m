Return-Path: <linux-iio+bounces-19393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E782CAB1900
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020A5165F9F
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074522FDFA;
	Fri,  9 May 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e14K1hQs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD922F76E
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805217; cv=none; b=j0IjEf5vymkhjqZDOlCapEqRWPTGUAQwcLMonyZiITgfVuD6W4CONLdK8nUdlumdvqXB7Gzne3bhjbBIpqB5gRy+2oSZ3aXlndgAGgQdp41IEhHJFHgLCnqwmHm6Y0N6GzASkduEdW166tt44bsGQRNuuO3kWXkgyT/d0sI8d0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805217; c=relaxed/simple;
	bh=MPZiMyQ9cicJ7t9mgeGHtcgthIv5U2+429WHNCME1Mo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cRSZdPepoocvYUJGFURiZt/wscRJCd3IUn75NjluZP4hCH4/gU+mCWtj7dwmGR60QU7q8OS6kTcSpd9VEsXWf+/qIXQ/gKlp4wwswmOj2128kmPRCOHXANmrAS/qhDiEQ8OF7LSdlZmujvfN68NRJWQz35JWc7OixoL0fwA9EY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e14K1hQs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0b6aa08e5so2014553f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746805212; x=1747410012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eQ56jk2xbPNHWgXWhjwXNsd4CIZUbINayRrplupK88=;
        b=e14K1hQsAkDOj9rA9RRAEgBDoE+aXeiQpZCr+FAvIitmo9nNjWhDcQcsiZOLm0Zghx
         5tUUdtSezAgpFRNcDcxJ30d6j67wkKkkWW0Xsgzydv+eJvwYyfXfBm6cin5OvUpznuHM
         Rv4j88ZtZLrdwOuhjqlyJq/U9iRsYVyDUjVRNbPWgiBevpq8zxJsL2DnkkF/NpUWjG1h
         xGg/u9cYsSiGJITPk905ubPl/3v92la19Tnpc9eL2onWqKZ81VsDWSO5omtruDa4CZIP
         t68U5hf5D5a0c9ClSmPkHtrT0VfVNGk+8VSaLb2j2lEt9+URq3EGdllMnx27QlJjHQvc
         vIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746805212; x=1747410012;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0eQ56jk2xbPNHWgXWhjwXNsd4CIZUbINayRrplupK88=;
        b=ifb1Bj5RWz+GldsMQE5Wvjj8jvD/00fSZoGsawKbKNgYzXykCC5AlNV2ZF4JAj11vM
         PxsphtKA2ktVWa1ybu0ISDnKV4LbpLHu22Sdl2mk7CLqNHNyLfe5DDBzlWBgY8L7uw68
         d26R2KKEbmOl619yMuH/od2vwPNq4HADegMS6yUKL6+GM+HooDYH3jl4UZ+NLGrKZWwG
         R3qDpRkzz9/6+quHLu6fD39AYRTYsWbj6l0G7gb/AQMrSzVHw2/Vi3lMCbRYDz0GbXTs
         uRlL9MfG65wYNGpV6PqadyqiAX0bYEn0HJXYwnwPoVESDxWxs5aPmk2NiVlpwF1+Aclm
         Ul7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIsDGou9/UoKGNVVlcxilxpJxKPDH6r8Gx+F7Cr7q5i49wdhQPzhiaw/PaB5rWlvlIcfSgVk+S/As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzert/b/H9PmIZs4YSRIYUIKtDpNVRNDxbakRed5H6WYjzApY5r
	a9rj5OWbUTR+emJrn9/5rXDju2CIH9o0DTHVYiqUo+H52xFMwFEFM8EwIIoFh/s=
X-Gm-Gg: ASbGnctXWAFRfbsyvgRMp4LtMHq0jvOBfWfwWHBevXWLCDtLwx4Oh/u5kWWpQmK/Dly
	ZwGgy28UEZxmaD1uxXy5GPPGH78PcvLMYOzDWakkgPIVRgJ++1IaC2iFJdXj/0gl0liXWtVYo6u
	gPQynFw6v8gqYb917qNjrvj7SPG6Gfy2+xK7RlrNTnbJaWMsT0MZiRImqsn/cX5Joor9WbQ0Y7S
	A1FY5F0oyqN57R0FYxID3qb2pATcad8yf+d0UbKqx4H7pnU3YXtFF2WI12yFjJNi38xENIFM6S9
	nxxrGSMSYXdS0w2UHBfn8IG1Wujb0jZnmCoFEQ+JbSjyn75PC1/fRZQhYq5HnfY1gLpVhFUbxFB
	GK75j3TYGVW1AGX4=
X-Google-Smtp-Source: AGHT+IFDoOde3obaPFc5EV8QLa4aIpUMknqJSn3nH8XVtREoWe8Q+oeMqZDrlbZ+zG4SyBG1nzOiBQ==
X-Received: by 2002:a05:6000:144b:b0:3a0:92d9:dae with SMTP id ffacd0b85a97d-3a0b98fce76mr6262348f8f.5.1746805211980;
        Fri, 09 May 2025 08:40:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3550308f8f.4.2025.05.09.08.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 08:40:11 -0700 (PDT)
Message-ID: <1c7a3c58-8e78-4615-82d8-c76f1d4838a6@linaro.org>
Date: Fri, 9 May 2025 17:40:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH V6 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, quic_kamalw@quicinc.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com,
 stephan.gerhold@linaro.org
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
 <20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2025 13:09, Jishnu Prakash wrote:
> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS.
> 
> One major difference is that the register interface used here is that
> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> channels, which may be used for either immediate reads (same functionality
> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> (same as ADC_TM functionality).
> 
> By convention, we reserve the first channel of the first SDAM for all
> immediate reads and use the remaining channels across all SDAMs for
> ADC_TM monitoring functionality.
> 
> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> driver.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v5:
> - Split mutex function exported to ADC_TM driver into separate functions
>    for acquiring and releasing mutex.
> - Updated logic for acquiring IRQ numbers to account for removing
>    "interrupt-names" DT property.
> - Addressed other reviewer comments related to kernel-doc formatting and
>    other changes.
> 
> Changes since v4:
> - Moved out common funtions from newly added .h file into a separate .c
>    file to avoid duplicating them. Updated interrupt name as suggested
>    by reviewer. Updated namespace export symbol statement to have a string
>    as second argument to follow framework change.
> 
> Changes since v3:
> - Split out TM functionality into auxiliary driver in separate patch and
>    added required changes in main driver.
> - Addressed other reviewer comments in main driver patch.
> 
> Changes since v1:
> - Removed datashet_name usage and implemented read_label() function
> - In probe, updated channel property in iio_chan_spec from individual
>    channel to virtual channel and set indexed property to 1, due to the
>    above change.
> - Updated order of checks in ISR
> - Removed the driver remove callback and replaced with callbacks in a
>    devm_add_action call in probe.
> - Addressed other comments from reviewers.
> 
>   drivers/iio/adc/Kconfig                       |  30 +
>   drivers/iio/adc/Makefile                      |   2 +
>   drivers/iio/adc/qcom-adc5-gen3-common.c       | 104 +++
>   drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 763 ++++++++++++++++++
>   include/linux/iio/adc/qcom-adc5-gen3-common.h | 193 +++++
>   5 files changed, 1092 insertions(+)
>   create mode 100644 drivers/iio/adc/qcom-adc5-gen3-common.c
>   create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>   create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ad06cf556785..f2f1ee15b3da 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1220,6 +1220,36 @@ config QCOM_SPMI_ADC5
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called qcom-spmi-adc5.
>   
> +config QCOM_ADC5_GEN3_COMMON
> +	tristate
> +
> +config QCOM_SPMI_ADC5_GEN3
> +	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
> +	depends on SPMI && THERMAL
> +	select REGMAP_SPMI
> +	select QCOM_VADC_COMMON
> +	select QCOM_ADC5_GEN3_COMMON
> +	select AUXILIARY_BUS
> +	help
> +	  IIO Voltage PMIC5 Gen3 ADC driver for Qualcomm Technologies Inc.
> +
> +	  The driver supports reading multiple channels. The ADC is a 16-bit
> +	  sigma-delta ADC. The hardware supports calibrated results for
> +	  conversion requests and clients include reading phone power supply
> +	  voltage, on board system thermistors connected to the PMIC ADC,
> +	  PMIC die temperature, charger temperature, battery current, USB
> +	  voltage input and voltage signals connected to supported PMIC GPIO
> +	  pins. The hardware supports internal pull-up for thermistors and can
> +	  choose between a 30k, 100k or 400k ohm pull up using the ADC channels.
> +
> +	  In addition, the same driver supports ADC thermal monitoring devices
> +	  too. They appear as thermal zones with multiple trip points. A thermal
> +	  client sets threshold temperature for both warm and cool trips and
> +	  gets updated when a threshold is reached.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called qcom-spmi-adc5-gen3.
> +
>   config RCAR_GYRO_ADC
>   	tristate "Renesas R-Car GyroADC driver"
>   	depends on ARCH_RCAR_GEN2 || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07d4b832c42e..8adbb5f42285 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -103,8 +103,10 @@ obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>   obj-$(CONFIG_PAC1921) += pac1921.o
>   obj-$(CONFIG_PAC1934) += pac1934.o
>   obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
> +obj-$(CONFIG_QCOM_ADC5_GEN3_COMMON) += qcom-adc5-gen3-common.o
>   obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>   obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
> +obj-$(CONFIG_QCOM_SPMI_ADC5_GEN3) += qcom-spmi-adc5-gen3.o
>   obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>   obj-$(CONFIG_QCOM_SPMI_RRADC) += qcom-spmi-rradc.o
>   obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
> diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
> new file mode 100644
> index 000000000000..edd618b0d39f
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
> + * of type ADC5 Gen3.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +
> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
> +		   u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_read(adc->regmap,
> +				adc->base[sdam_index].base_addr + offset,
> +				data, len);
> +}
> +EXPORT_SYMBOL(adc5_gen3_read);
> +
> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
> +		    u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_write(adc->regmap,
> +				 adc->base[sdam_index].base_addr + offset,
> +				 data, len);
> +}
> +EXPORT_SYMBOL(adc5_gen3_write);
> +
> +/*
> + * Worst case delay from PBS in readying handshake bit
> + * can be up to 15ms, when PBS is busy running other
> + * simultaneous transactions, while in the best case, it is
> + * already ready at this point. Assigning polling delay and
> + * retry count accordingly.
> + */
> +
> +#define ADC5_GEN3_HS_DELAY_US			100
> +#define ADC5_GEN3_HS_RETRY_COUNT		150
> +
> +int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
> +			   unsigned int sdam_index)
> +{
> +	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	int ret, count;
> +	u8 status = 0;
> +
> +	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
> +		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, sizeof(status));
> +		if (ret)
> +			return ret;
> +
> +		if (status == ADC5_GEN3_HS_READY) {
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
> +					     &conv_req, sizeof(conv_req));
> +			if (ret)
> +				return ret;
> +
> +			if (!conv_req)
> +				return 0;
> +		}
> +
> +		fsleep(ADC5_GEN3_HS_DELAY_US);
> +	}
> +
> +	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n",
> +	       sdam_index, status);
> +	return -ETIMEDOUT;
> +}
> +EXPORT_SYMBOL(adc5_gen3_poll_wait_hs);
> +
> +void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data)
> +{
> +	/* Update calibration select and decimation ratio select */
> +	*data &= ~(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK | ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK);
> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK, prop->decimation);
> +}
> +EXPORT_SYMBOL(adc5_gen3_update_dig_param);
> +
> +int adc5_gen3_status_clear(struct adc5_device_data *adc,
> +			   int sdam_index, u16 offset, u8 *val, int len)
> +{
> +	u8 value;
> +	int ret;
> +
> +	ret = adc5_gen3_write(adc, sdam_index, offset, val, len);
> +	if (ret)
> +		return ret;
> +
> +	/* To indicate conversion request is only to clear a status */
> +	value = 0;
> +	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &value, sizeof(value));
> +	if (ret)
> +		return ret;
> +
> +	value = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &value, sizeof(value));
> +}
> +EXPORT_SYMBOL(adc5_gen3_status_clear);
> +
> +MODULE_DESCRIPTION("Qualcomm ADC5 Gen3 common functionality");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..25b58b9be3b7
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -0,0 +1,763 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/unaligned.h>
> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> +
> +#define ADC5_GEN3_VADC_SDAM			0x0
> +
> +struct adc5_chip;
> +
> +/**
> + * struct adc5_channel_prop - ADC channel structure
> + * @common_props: structure with ADC channel properties (common to TM usage).
> + * @adc_tm: indicates TM type if the channel is used for TM measurements.
> + * @chip: pointer to top-level ADC device structure.
> + */
> +struct adc5_channel_prop {
> +	struct adc5_channel_common_prop common_props;
> +	int adc_tm;
> +	struct adc5_chip *chip;
> +};
> +
> +/**
> + * struct adc5_chip - ADC private structure.
> + * @dev: SPMI ADC5 Gen3 device.
> + * @dev_data: Top-level ADC device data.
> + * @nchannels: number of ADC channels.
> + * @chan_props: array of ADC channel properties.
> + * @iio_chans: array of IIO channels specification.
> + * @complete: ADC result notification after interrupt is received.
> + * @lock: ADC lock for access to the peripheral, to prevent concurrent
> + * requests from multiple clients.
> + * @data: software configuration data.
> + * @n_tm_channels: number of ADC channels used for TM measurements.
> + * @tm_aux: pointer to auxiliary TM device.
> + */
> +struct adc5_chip {
> +	struct device *dev;
> +	struct adc5_device_data dev_data;
> +	unsigned int nchannels;
> +	struct adc5_channel_prop *chan_props;
> +	struct iio_chan_spec *iio_chans;
> +	struct completion complete;
> +	/*
> +	 * lock for access to the peripheral, to prevent concurrent
> +	 * requests from multiple clients.
> +	 */
> +	struct mutex lock;
> +	const struct adc5_data *data;
> +	unsigned int n_tm_channels;
> +	struct auxiliary_device *tm_aux;
> +};
> +
> +static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
> +{
> +	u8 rslt[2];
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_CH_DATA0(0), rslt, sizeof(rslt));
> +	if (ret)
> +		return ret;
> +
> +	*data = get_unaligned_le16(rslt);
> +
> +	if (*data == ADC5_USR_DATA_CHECK) {
> +		dev_err(adc->dev, "Invalid data:%#x\n", *data);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(adc->dev, "voltage raw code:%#x\n", *data);
> +
> +	return 0;
> +}
> +
> +#define ADC5_GEN3_READ_CONFIG_REGS 7
> +
> +static int adc5_gen3_configure(struct adc5_chip *adc,
> +			       struct adc5_channel_common_prop *prop)
> +{
> +	u8 buf[ADC5_GEN3_READ_CONFIG_REGS];
> +	u8 conv_req = 0;
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID,
> +			     buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	/* Write SID */
> +	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
> +
> +	/*
> +	 * Use channel 0 by default for immediate conversion and
> +	 * to indicate there is an actual conversion request
> +	 */
> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | 0;
> +
> +	buf[2] = ADC5_GEN3_TIME_IMMEDIATE;
> +
> +	/* Digital param selection */
> +	adc5_gen3_update_dig_param(prop, &buf[3]);
> +
> +	/* Update fast average sample value */
> +	buf[4] = FIELD_PREP(ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK,
> +			    prop->avg_samples) | ADC5_GEN3_FAST_AVG_CTL_EN;
> +
> +	/* Select ADC channel */
> +	buf[5] = prop->channel;
> +
> +	/* Select HW settle delay for channel */
> +	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
> +			    prop->hw_settle_time_us);
> +
> +	reinit_completion(&adc->complete);
> +
> +	ret = adc5_gen3_write(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID,
> +			      buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			       ADC5_GEN3_CONV_REQ, &conv_req, sizeof(conv_req));
> +}
> +
> +/*
> + * Worst case delay from PBS for conversion time can be
> + * up to 500ms, when PBS has timed out twice, once for
> + * the initial attempt and once for a retry of the same
> + * transaction.
> + */
> +
> +#define ADC5_GEN3_CONV_TIMEOUT_MS	501
> +
> +static int adc5_gen3_do_conversion(struct adc5_chip *adc,
> +				   struct adc5_channel_common_prop *prop,
> +				   u16 *data_volt)
> +{
> +	unsigned long rc;
> +	int ret;
> +	u8 val;
> +
> +	guard(mutex)(&adc->lock);
> +	ret = adc5_gen3_poll_wait_hs(&adc->dev_data, ADC5_GEN3_VADC_SDAM);
> +	if (ret)
> +		return ret;
> +
> +	ret = adc5_gen3_configure(adc, prop);
> +	if (ret) {
> +		dev_err(adc->dev, "ADC configure failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* No support for polling mode at present */
> +	rc = wait_for_completion_timeout(&adc->complete,
> +					 msecs_to_jiffies(ADC5_GEN3_CONV_TIMEOUT_MS));
> +	if (!rc) {
> +		dev_err(adc->dev, "Reading ADC channel %s timed out\n",
> +			prop->label);
> +		return -ETIMEDOUT;
> +	}
> +
> +	ret = adc5_gen3_read_voltage_data(adc, data_volt);
> +	if (ret)
> +		return ret;
> +
> +	val = BIT(0);
> +	return adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +				      ADC5_GEN3_EOC_CLR, &val, 1);
> +}
> +
> +static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
> +{
> +	u8 status, tm_status[2], eoc_status, val;
> +	struct adc_tm5_auxiliary_drv *adrv_tm;
> +	struct adc5_chip *adc = dev_id;
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_STATUS1, &status, sizeof(status));
> +	if (ret) {
> +		dev_err(adc->dev, "adc read status1 failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_EOC_STS, &eoc_status, sizeof(eoc_status));
> +	if (ret) {
> +		dev_err(adc->dev, "adc read eoc status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
> +		dev_err_ratelimited(adc->dev,
> +				    "Unexpected conversion fault, status:%#x, eoc_status:%#x\n",
> +				    status, eoc_status);
> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
> +		adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* CHAN0 is the preconfigured channel for immediate conversion */
> +	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
> +		complete(&adc->complete);
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_TM_HIGH_STS, tm_status, sizeof(tm_status));
> +	if (ret) {
> +		dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (tm_status[0] || tm_status[1]) {
> +		adev = adc->tm_aux;
> +		if (!adev || !adev->dev.driver) {
> +			dev_err(adc->dev,
> +				"adc_tm auxiliary device not initialized\n");
> +			return IRQ_HANDLED;
> +		}
> +
> +		adrv_tm = container_of(adev->dev.driver,
> +				       struct adc_tm5_auxiliary_drv,
> +				       adrv.driver);
> +
> +		if (adrv_tm && adrv_tm->tm_event_notify)
> +			adrv_tm->tm_event_notify(adev);
> +		else
> +			dev_err(adc->dev,
> +				"adc_tm auxiliary driver not initialized\n");
> +	}
> +
> +	dev_dbg(adc->dev,
> +		"Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
> +		status, eoc_status, tm_status[0], tm_status[1]);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adc5_gen3_fwnode_xlate(struct iio_dev *indio_dev,
> +				  const struct fwnode_reference_args *iiospec)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	int i, v_channel;
> +
> +	for (i = 0; i < adc->nchannels; i++) {
> +		v_channel = V_CHAN(adc->chan_props[i].common_props);
> +		if (v_channel == iiospec->args[0])
> +			return i;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val,
> +			      int *val2, long mask)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	struct adc5_channel_common_prop *prop;
> +	u16 adc_code_volt;
> +	int ret;
> +
> +	prop = &adc->chan_props[chan->address].common_props;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = adc5_gen3_do_conversion(adc, prop, &adc_code_volt);
> +		if (ret)
> +			return ret;
> +
> +		ret = qcom_adc5_hw_scale(prop->scale_fn_type, prop->prescale,
> +					 adc->data, adc_code_volt, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adc5_gen3_read_label(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan, char *label)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	struct adc5_channel_prop *prop;
> +
> +	prop = &adc->chan_props[chan->address];
> +	return sprintf(label, "%s\n", prop->common_props.label);
> +}
> +
> +static const struct iio_info adc5_gen3_info = {
> +	.read_raw = adc5_gen3_read_raw,
> +	.read_label = adc5_gen3_read_label,
> +	.fwnode_xlate = adc5_gen3_fwnode_xlate,
> +};
> +
> +struct adc5_channels {
> +	unsigned int prescale_index;
> +	enum iio_chan_type type;
> +	long info_mask;
> +	enum vadc_scale_fn_type scale_fn_type;
> +};
> +
> +/* In these definitions, _pre refers to an index into adc5_prescale_ratios. */
> +#define ADC5_CHAN(_type, _mask, _pre, _scale)	\
> +	{						\
> +		.prescale_index = _pre,			\
> +		.type = _type,				\
> +		.info_mask = _mask,			\
> +		.scale_fn_type = _scale,		\
> +	},						\
> +
> +#define ADC5_CHAN_TEMP(_pre, _scale)		\
> +	ADC5_CHAN(IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
> +
> +#define ADC5_CHAN_VOLT(_pre, _scale)		\
> +	ADC5_CHAN(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
> +
> +#define ADC5_CHAN_CUR(_pre, _scale)		\
> +	ADC5_CHAN(IIO_CURRENT, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
> +
> +static const struct adc5_channels adc5_gen3_chans_pmic[ADC5_MAX_CHANNEL] = {
> +	[ADC5_GEN3_REF_GND]		= ADC5_CHAN_VOLT(0, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_1P25VREF]		= ADC5_CHAN_VOLT(0, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_VPH_PWR]		= ADC5_CHAN_VOLT(1, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_VBAT_SNS_QBG]	= ADC5_CHAN_VOLT(1, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_USB_SNS_V_16]	= ADC5_CHAN_TEMP(8, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_VIN_DIV16_MUX]	= ADC5_CHAN_TEMP(8, SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_GEN3_DIE_TEMP]		= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_PMIC_THERM_PM7)
> +	[ADC5_GEN3_TEMP_ALARM_LITE]	= ADC5_CHAN_TEMP(0,
> +						SCALE_HW_CALIB_PMIC_THERM_PM7)
> +	[ADC5_GEN3_AMUX1_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX2_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX3_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX4_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX5_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX6_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX1_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX2_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX3_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +	[ADC5_GEN3_AMUX4_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
> +					SCALE_HW_CALIB_THERM_100K_PU_PM7)
> +};
> +
> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
> +					 struct adc5_channel_prop *prop,
> +					 struct fwnode_handle *fwnode)
> +{
> +	const char *name = fwnode_get_name(fwnode);
> +	const struct adc5_data *data = adc->data;
> +	u32 chan, value, varr[2], sid = 0;
> +	struct device *dev = adc->dev;
> +	const char *channel_name;
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "invalid channel number %s\n",
> +				     name);
> +
> +	/*
> +	 * Value read from "reg" is virtual channel number
> +	 * virtual channel number = sid << 8 | channel number
> +	 */
> +	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
> +	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
> +
> +	if (chan > ADC5_GEN3_OFFSET_EXT2)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "%s invalid channel number %d\n",
> +				     name, chan);
> +
> +	prop->common_props.channel = chan;
> +	prop->common_props.sid = sid;
> +
> +	channel_name = name;
> +	fwnode_property_read_string(fwnode, "label", &channel_name);
> +	prop->common_props.label = channel_name;
> +
> +	value = data->decimation[ADC5_DECIMATION_DEFAULT];
> +	fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
> +	ret = qcom_adc5_decimation_from_dt(value, data->decimation);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "%#x invalid decimation %d\n",
> +				     chan, value);
> +	prop->common_props.decimation = ret;
> +
> +	prop->common_props.prescale = adc->data->adc_chans[chan].prescale_index;
> +	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
> +	if (!ret) {
> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "%#x invalid pre-scaling <%d %d>\n",
> +				chan, varr[0], varr[1]);
> +		prop->common_props.prescale = ret;
> +	}
> +
> +	value = data->hw_settle_1[VADC_DEF_HW_SETTLE_TIME];
> +	fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
> +	ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "%#x invalid hw-settle-time %d us\n",
> +				     chan, value);
> +	prop->common_props.hw_settle_time_us = ret;
> +
> +	value = BIT(VADC_DEF_AVG_SAMPLES);
> +	fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
> +	ret = qcom_adc5_avg_samples_from_dt(value);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "%#x invalid avg-samples %d\n",
> +				     chan, value);
> +	prop->common_props.avg_samples = ret;
> +
> +	if (fwnode_property_read_bool(fwnode, "qcom,ratiometric"))
> +		prop->common_props.cal_method = ADC5_RATIOMETRIC_CAL;
> +	else
> +		prop->common_props.cal_method = ADC5_ABSOLUTE_CAL;
> +
> +	prop->adc_tm = fwnode_property_read_bool(fwnode, "qcom,adc-tm");
> +	if (prop->adc_tm) {
> +		adc->n_tm_channels++;
> +		if (adc->n_tm_channels > ((adc->dev_data.num_sdams * 8) - 1))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Number of TM nodes %u greater than channels supported:%u\n",
> +					     adc->n_tm_channels,
> +					     (adc->dev_data.num_sdams * 8) - 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct adc5_data adc5_gen3_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.adc_chans = adc5_gen3_chans_pmic,
> +	.info = &adc5_gen3_info,
> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
> +				{85, 340, 1360},
> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> +				{ 15, 100, 200, 300, 400, 500, 600, 700,
> +				  1000, 2000, 4000, 8000, 16000, 32000,
> +				  64000, 128000 },
> +};
> +
> +static const struct of_device_id adc5_match_table[] = {
> +	{
> +		.compatible = "qcom,spmi-adc5-gen3",
> +		.data = &adc5_gen3_data_pmic,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc5_match_table);
> +
> +static int adc5_get_fw_data(struct adc5_chip *adc)
> +{
> +	const struct adc5_channels *adc_chan;
> +	struct adc5_channel_prop *chan_props;
> +	struct fwnode_handle *child = NULL;
> +	struct iio_chan_spec *iio_chan;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	adc->nchannels = device_get_child_node_count(adc->dev);
> +	if (!adc->nchannels) {
> +		dev_err(adc->dev, "No ADC channels found\n");
> +		return -EINVAL;
> +	}
> +
> +	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchannels,
> +				      sizeof(*adc->iio_chans), GFP_KERNEL);
> +	if (!adc->iio_chans)
> +		return -ENOMEM;
> +
> +	adc->chan_props = devm_kcalloc(adc->dev, adc->nchannels,
> +				       sizeof(*adc->chan_props), GFP_KERNEL);
> +	if (!adc->chan_props)
> +		return -ENOMEM;
> +
> +	chan_props = adc->chan_props;
> +	adc->n_tm_channels = 0;
> +	iio_chan = adc->iio_chans;
> +	adc->data = device_get_match_data(adc->dev);
> +
> +	device_for_each_child_node(adc->dev, child) {
> +		ret = adc5_gen3_get_fw_channel_data(adc, chan_props, child);
> +		if (ret < 0)
> +			return ret;
> +
> +		chan_props->chip = adc;
> +		adc_chan = &adc->data->adc_chans[chan_props->common_props.channel];
> +		chan_props->common_props.scale_fn_type = adc_chan->scale_fn_type;
> +
> +		iio_chan->channel = V_CHAN(chan_props->common_props);
> +		iio_chan->info_mask_separate = adc_chan->info_mask;
> +		iio_chan->type = adc_chan->type;
> +		iio_chan->address = index;
> +		iio_chan->indexed = 1;
> +		iio_chan++;
> +		chan_props++;
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void adc5_gen3_uninit_aux(void *data)
> +{
> +	auxiliary_device_uninit(data);
> +}
> +
> +static void adc5_gen3_delete_aux(void *data)
> +{
> +	auxiliary_device_delete(data);
> +}
> +
> +static void adc5_gen3_aux_device_release(struct device *dev)
> +{
> +	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device,
> +						    dev);
> +
> +	kfree(aux);
> +}
> +
> +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> +{
> +	struct tm5_aux_dev_wrapper *aux_device;
> +	int i, ret, i_tm = 0;
> +
> +	aux_device = devm_kzalloc(adc->dev, sizeof(*aux_device), GFP_KERNEL);
> +	if (!aux_device)
> +		return -ENOMEM;
> +
> +	aux_device->aux_dev.name = "adc5_tm_gen3";
> +	aux_device->aux_dev.dev.parent = adc->dev;
> +	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
> +
> +	aux_device->tm_props = devm_kcalloc(adc->dev, adc->n_tm_channels,
> +					    sizeof(*aux_device->tm_props),
> +					    GFP_KERNEL);
> +	if (!aux_device->tm_props)
> +		return -ENOMEM;
> +
> +	aux_device->dev_data = &adc->dev_data;
> +
> +	for (i = 0; i < adc->nchannels; i++) {
> +		if (!adc->chan_props[i].adc_tm)
> +			continue;
> +		aux_device->tm_props[i_tm] = adc->chan_props[i].common_props;
> +		i_tm++;
> +	}
> +
> +	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
> +
> +	aux_device->n_tm_channels = adc->n_tm_channels;
> +
> +	ret = auxiliary_device_init(&aux_device->aux_dev);
> +	if (ret) {
> +		kfree(&aux_device->aux_dev);
> +		return ret;
> +	}
> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
> +				       &aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_device_add(&aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
> +				       &aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +
> +	adc->tm_aux = &aux_device->aux_dev;
> +
> +	return 0;
> +}
> +
> +void adc5_gen3_mutex_lock(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	mutex_lock(&adc->lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
> +
> +void adc5_gen3_mutex_unlock(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	mutex_unlock(&adc->lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_unlock, "QCOM_SPMI_ADC5_GEN3");
> +
> +int adc5_gen3_get_scaled_reading(struct device *dev,
> +				 struct adc5_channel_common_prop *common_props,
> +				 int *val)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	u16 adc_code_volt;
> +	int ret;
> +
> +	ret = adc5_gen3_do_conversion(adc, common_props, &adc_code_volt);
> +	if (ret)
> +		return ret;
> +
> +	return qcom_adc5_hw_scale(common_props->scale_fn_type,
> +				  common_props->prescale,
> +				  adc->data, adc_code_volt, val);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_get_scaled_reading, "QCOM_SPMI_ADC5_GEN3");
> +
> +int adc5_gen3_therm_code_to_temp(struct device *dev,
> +				 struct adc5_channel_common_prop *common_props,
> +				 u16 code, int *val)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	return qcom_adc5_hw_scale(common_props->scale_fn_type,
> +				  common_props->prescale,
> +				  adc->data, code, val);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
> +
> +static int adc5_gen3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct adc5_chip *adc;
> +	struct regmap *regmap;
> +	int ret, i;
> +	u32 *reg;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev_data.regmap = regmap;
> +	adc->dev = dev;
> +
> +	ret = device_property_count_u32(dev, "reg");
> +	if (ret < 0)
> +		return ret;
> +
> +	adc->dev_data.num_sdams = ret;
> +
> +	reg = devm_kcalloc(dev, adc->dev_data.num_sdams, sizeof(u32),
> +			   GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(dev, "reg", reg,
> +					     adc->dev_data.num_sdams);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read reg property\n");
> +
> +	adc->dev_data.base = devm_kcalloc(dev, adc->dev_data.num_sdams,
> +					  sizeof(*adc->dev_data.base),
> +					  GFP_KERNEL);
> +	if (!adc->dev_data.base)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	init_completion(&adc->complete);
> +	mutex_init(&adc->lock);
> +
> +	for (i = 0; i < adc->dev_data.num_sdams; i++) {
> +		adc->dev_data.base[i].base_addr = reg[i];
> +
> +		ret = platform_get_irq(pdev, i);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Getting IRQ %d failed\n",
> +					     adc->dev_data.base[i].irq);
> +
> +		adc->dev_data.base[i].irq = ret;
> +
> +		adc->dev_data.base[i].irq_name = devm_kasprintf(dev, GFP_KERNEL,
> +								"sdam%d", i);
> +		if (!adc->dev_data.base[i].irq_name)
> +			return -ENOMEM;
> +	}
> +
> +	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
> +			       adc5_gen3_isr, 0,
> +			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
> +			       adc);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to request SDAM%d irq\n",
> +				     ADC5_GEN3_VADC_SDAM);
> +
> +	ret = adc5_get_fw_data(adc);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (adc->n_tm_channels > 0)
> +		adc5_gen3_add_aux_tm_device(adc);
> +
> +	indio_dev->name = pdev->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc5_gen3_info;
> +	indio_dev->channels = adc->iio_chans;
> +	indio_dev->num_channels = adc->nchannels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static struct platform_driver adc5_gen3_driver = {
> +	.driver = {
> +		.name = "qcom-spmi-adc5-gen3",
> +		.of_match_table = adc5_match_table,
> +	},
> +	.probe = adc5_gen3_probe,
> +};
> +module_platform_driver(adc5_gen3_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 Gen3 ADC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> new file mode 100644
> index 000000000000..4f476cd77b37
> --- /dev/null
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
> + * of type ADC5 Gen3.
> + */
> +
> +#ifndef QCOM_ADC5_GEN3_COMMON_H
> +#define QCOM_ADC5_GEN3_COMMON_H
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/adc/qcom-vadc-common.h>
> +
> +#define ADC5_GEN3_HS				0x45
> +#define ADC5_GEN3_HS_BUSY			BIT(7)
> +#define ADC5_GEN3_HS_READY			BIT(0)
> +
> +#define ADC5_GEN3_STATUS1			0x46
> +#define ADC5_GEN3_STATUS1_CONV_FAULT		BIT(7)
> +#define ADC5_GEN3_STATUS1_THR_CROSS		BIT(6)
> +#define ADC5_GEN3_STATUS1_EOC			BIT(0)
> +
> +#define ADC5_GEN3_TM_EN_STS			0x47
> +#define ADC5_GEN3_TM_HIGH_STS			0x48
> +#define ADC5_GEN3_TM_LOW_STS			0x49
> +
> +#define ADC5_GEN3_EOC_STS			0x4a
> +#define ADC5_GEN3_EOC_CHAN_0			BIT(0)
> +
> +#define ADC5_GEN3_EOC_CLR			0x4b
> +#define ADC5_GEN3_TM_HIGH_STS_CLR		0x4c
> +#define ADC5_GEN3_TM_LOW_STS_CLR		0x4d
> +#define ADC5_GEN3_CONV_ERR_CLR			0x4e
> +#define ADC5_GEN3_CONV_ERR_CLR_REQ		BIT(0)
> +
> +#define ADC5_GEN3_SID				0x4f
> +#define ADC5_GEN3_SID_MASK			GENMASK(3, 0)
> +
> +#define ADC5_GEN3_PERPH_CH			0x50
> +#define ADC5_GEN3_CHAN_CONV_REQ			BIT(7)
> +
> +#define ADC5_GEN3_TIMER_SEL			0x51
> +#define ADC5_GEN3_TIME_IMMEDIATE		0x1
> +
> +#define ADC5_GEN3_DIG_PARAM			0x52
> +#define ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK	GENMASK(5, 4)
> +#define ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK	GENMASK(3, 2)
> +
> +#define ADC5_GEN3_FAST_AVG			0x53
> +#define ADC5_GEN3_FAST_AVG_CTL_EN		BIT(7)
> +#define ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK	GENMASK(2, 0)
> +
> +#define ADC5_GEN3_ADC_CH_SEL_CTL		0x54
> +#define ADC5_GEN3_DELAY_CTL			0x55
> +#define ADC5_GEN3_HW_SETTLE_DELAY_MASK		GENMASK(3, 0)
> +
> +#define ADC5_GEN3_CH_EN				0x56
> +#define ADC5_GEN3_HIGH_THR_INT_EN		BIT(1)
> +#define ADC5_GEN3_LOW_THR_INT_EN		BIT(0)
> +
> +#define ADC5_GEN3_LOW_THR0			0x57
> +#define ADC5_GEN3_LOW_THR1			0x58
> +#define ADC5_GEN3_HIGH_THR0			0x59
> +#define ADC5_GEN3_HIGH_THR1			0x5a
> +
> +#define ADC5_GEN3_CH_DATA0(channel)	(0x5c + (channel) * 2)
> +#define ADC5_GEN3_CH_DATA1(channel)	(0x5d + (channel) * 2)
> +
> +#define ADC5_GEN3_CONV_REQ			0xe5
> +#define ADC5_GEN3_CONV_REQ_REQ			BIT(0)
> +
> +#define ADC5_GEN3_VIRTUAL_SID_MASK			GENMASK(15, 8)
> +#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
> +#define V_CHAN(x)		\
> +	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)
> +
> +enum adc5_cal_method {
> +	ADC5_NO_CAL = 0,
> +	ADC5_RATIOMETRIC_CAL,
> +	ADC5_ABSOLUTE_CAL,
> +};
> +
> +enum adc5_time_select {
> +	MEAS_INT_DISABLE = 0,
> +	MEAS_INT_IMMEDIATE,
> +	MEAS_INT_50MS,
> +	MEAS_INT_100MS,
> +	MEAS_INT_1S,
> +	MEAS_INT_NONE,
> +};
> +
> +/**
> + * struct adc5_sdam_data - data per SDAM allocated for adc usage
> + * @base_addr: base address for the ADC SDAM peripheral.
> + * @irq_name: ADC IRQ name.
> + * @irq: ADC IRQ number.
> + */
> +struct adc5_sdam_data {
> +	u16 base_addr;
> +	const char *irq_name;
> +	int irq;
> +};
> +
> +/**
> + * struct adc5_device_data - Top-level ADC device data
> + * @regmap: ADC peripheral register map field.
> + * @base: array of SDAM data.
> + * @num_sdams: number of ADC SDAM peripherals.
> + */
> +struct adc5_device_data {
> +	struct regmap *regmap;
> +	struct adc5_sdam_data *base;
> +	int num_sdams;
> +};
> +
> +/**
> + * struct adc5_channel_common_prop - ADC channel properties (common to ADC and TM).
> + * @channel: channel number, refer to the channel list.
> + * @cal_method: calibration method.
> + * @decimation: sampling rate supported for the channel.
> + * @sid: ID of PMIC owning the channel.
> + * @label: Channel name used in device tree.
> + * @prescale: channel scaling performed on the input signal.
> + * @hw_settle_time_us: the time between AMUX being configured and the
> + *	start of conversion in uS.
> + * @avg_samples: ability to provide single result from the ADC
> + *	that is an average of multiple measurements.
> + * @scale_fn_type: Represents the scaling function to convert voltage
> + *	physical units desired by the client for the channel.
> + */
> +struct adc5_channel_common_prop {
> +	unsigned int channel;
> +	enum adc5_cal_method cal_method;
> +	unsigned int decimation;
> +	unsigned int sid;
> +	const char *label;
> +	unsigned int prescale;
> +	unsigned int hw_settle_time_us;
> +	unsigned int avg_samples;
> +	enum vadc_scale_fn_type scale_fn_type;
> +};
> +
> +/**
> + * struct tm5_aux_dev_wrapper - wrapper structure around TM auxiliary device
> + * @aux_dev: TM auxiliary device structure.
> + * @dev_data: Top-level ADC device data.
> + * @tm_props: Array of common ADC channel properties for TM channels.
> + * @n_tm_channels: number of TM channels.
> + */
> +struct tm5_aux_dev_wrapper {
> +	struct auxiliary_device aux_dev;
> +	struct adc5_device_data *dev_data;
> +	struct adc5_channel_common_prop *tm_props;
> +	unsigned int n_tm_channels;
> +};
> +
> +/**
> + * struct tm5_aux_dev_wrapper - wrapper structure around TM auxiliary driver
> + * @adrv: TM auxiliary driver structure.
> + * @tm_event_notify: TM callback to be called by parent driver.
> + */
> +struct adc_tm5_auxiliary_drv {
> +	struct auxiliary_driver adrv;
> +	void (*tm_event_notify)(struct auxiliary_device *adev);
> +};
> +
> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
> +		   u16 offset, u8 *data, int len);
> +
> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
> +		    u16 offset, u8 *data, int len);
> +
> +int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
> +			   unsigned int sdam_index);
> +
> +void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop,
> +				u8 *data);
> +
> +int adc5_gen3_status_clear(struct adc5_device_data *adc,
> +			   int sdam_index, u16 offset, u8 *val, int len);
> +
> +void adc5_gen3_mutex_lock(struct device *dev);
> +void adc5_gen3_mutex_unlock(struct device *dev);
> +int adc5_gen3_get_scaled_reading(struct device *dev,
> +				 struct adc5_channel_common_prop *common_props,
> +				 int *val);
> +int adc5_gen3_therm_code_to_temp(struct device *dev,
> +				 struct adc5_channel_common_prop *common_props,
> +				 u16 code, int *val);
> +
> +#endif /* QCOM_ADC5_GEN3_COMMON_H */

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

With the following DT change:
https://git.codelinaro.org/neil.armstrong/linux/-/commit/0776fd6eeaf08c568674bacfe075f3a26c840356

Thanks,
Neil

