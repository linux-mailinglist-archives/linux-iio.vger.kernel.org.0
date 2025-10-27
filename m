Return-Path: <linux-iio+bounces-25545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B689AC11691
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 21:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC2264F3B3A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3859131E0E1;
	Mon, 27 Oct 2025 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="imLC85TG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C224E4B4
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597400; cv=none; b=ZUOK4e1SVWc/4rieawzkPUYDRnyZC4CZ/sBW2cbHN4EMFJaw/d44rJj/Q2bATzGunallomkLKvjuQj6DsxjfRayHJ4O2r5xbSY7jsS4DVS5E8DrBAxF/O1ff7tQHGpLtyswjBANHRZAgrAyIuzH95VJcQil9pgVkkEViZYq1XtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597400; c=relaxed/simple;
	bh=/r2MfbgwYvoichm3JC/D/FFVTkLEq2beh9dnGy2yNG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPz2Z0yu6Rgw8N9NDiXF7a1Tz6RYcs5gTyO+xwj1eAnWzQgnThtCxOgntehnx6GkUC3Q2wy+jlT1vLoFWdCbuei+RYpBz9FavxCz2o7QwwYJUArmhKJs+v9MFJbnNoIyaeVG3Nn4MoIyvYCfHBPvHo4o7jyzpcSYvbj8W+tqSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=imLC85TG; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3d5bb138b2cso217047fac.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761597396; x=1762202196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miYvjijH+yAVme5tPHTAIByBBOWcjgVoClU7HRgNuqk=;
        b=imLC85TG9Lf+kvx4n1uUtp6jTuFWoxZJx/oaIU1zbOs/Lvcra2Cam/pWIEj5Cn/QFM
         BnNxseLtp4ysettSwXYwhogXbmQvxz/f9m38A58g2CRE831ZZfuatoUTsfnYDr/hbW8L
         Gd+MF046NdmPvxiJargU+PGOGOrGzw6s3xIYzlYKdqbNwW4ienXEYJndgv7Vt9R+rk/z
         J5cF3jjR20eHcTHPIhcQ5S0j0N2/7CJgvcP9YUQMYjM2yW+VogjcvRJrRspUQzBkUT9k
         ISEpqSA8ComJL+Vx+AKPs1SMoqgn/pVAp+d1aZLr8UX+q6hdc/AiFALxacurdXUDgYxK
         CL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761597396; x=1762202196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miYvjijH+yAVme5tPHTAIByBBOWcjgVoClU7HRgNuqk=;
        b=aeWGO9BwUL4LD9HSy3w4JZ+OfhefnsVeyj+6Fxxu7hiHX4rNGlotkenzZi/p+CraKy
         4vBSfA7f1W9OdrNtGvZ8KUN27dATJxFXp5z8IIqEWNCaPDNzUi5zNV4CyaeT8ypREQ3L
         RDj737nSlj70c+xVUB9UYdTjrAUy4nFIKbUVQFv6ka33zzCN//nIydI1IIpIKzpB3blM
         IndgAZiWpLcybS04vJwFdRWdpP9bl6nJqgLRuhCrHZKjZTHS78lIK3Tc5bbt8770FHCe
         muFL8UCBwcuZihgx8gkJdjEwyYc5GFGuMCcIpLWd2kFX/bFDsprPb82JkeaZu67+YxdU
         KO6w==
X-Forwarded-Encrypted: i=1; AJvYcCXOt+0pJRc06utsmLPLDWfyA9xV0SaGb/b3r1bALupzfZpPpAGEGpkKYyu1zEBHjFNOQBic97zVPlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmERezY5BIW1F7Z8cWKDQT5OeCBgFncJkSD0CCnx+Yv4LB8Obo
	84osjHC20ExqF7TSBM3FEfECf9JF1I2aW/NE4Z31vcuLxSMptohc94Ul5m6H2x5KsdA=
X-Gm-Gg: ASbGncthUi3OM7eo6Arl/2N13zM3/oNPfp9S8Qp02k+Nf1EM81pyAvCZoPjP5onvCaH
	npZ0JYWiwJ3uDlwNNsxHLluyU0b0RoK4yt3aCcUeUSCTZqDN45MtGQVIwPoWrPSbhGIPbnus6VO
	PKRuC843MAmodTzDVxNVWBZ6540/5vkoqumRsWmZVWfPKhLcr8pvigy1S1PfjeJM/XCdj5HRnoA
	4vdSGxCWUUh3Ld7JAcznDrQvBU1OtHHppxyrWSeULOA5CY72Y/fX+Pv/wa2CplLW67ywMCaWRuk
	gEsMnsleOlkoJkBO0sESQspBqgZTc8/Ur6lD9mbHvZWuMdd8X5TlvYml4fCsHHsWMarEHMwrhl+
	kzdoJcJlSLrq2MgWwuSLG3cI2BfOcPx9PetxOgzn9I8VXcvW4kDe+GvzvEghGGKxbWxacsIFvwn
	u7j6+TAr8eC/U1+/bOFLG2ZPNR/CwPnYHw0/1REeTMA30fAtH6eA==
X-Google-Smtp-Source: AGHT+IG9JEEg1mNWi+tFl2h+MpCVt+cH7Rf89qYUiLcNyweFqHAapC6agRl2IVJ0aTJuqK1Md9c7Ew==
X-Received: by 2002:a05:6808:1a09:b0:442:e596:1189 with SMTP id 5614622812f47-44f6bb3e516mr563791b6e.45.1761597395041;
        Mon, 27 Oct 2025 13:36:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:46d5:c880:64c8:f854? ([2600:8803:e7e4:500:46d5:c880:64c8:f854])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44da3e48249sm2013281b6e.5.2025.10.27.13.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 13:36:34 -0700 (PDT)
Message-ID: <506feaa8-5808-48d4-8cc7-baadd8f43976@baylibre.com>
Date: Mon, 27 Oct 2025 15:36:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect
 calibration values
To: Antony Kurniawan Soemardi <linux@smankusors.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
 <0eea7e4c-ec3b-421c-8522-aa3f52b5cb13@baylibre.com>
 <003c5cf7-2498-4ff3-a8b4-2911941b1464@smankusors.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <003c5cf7-2498-4ff3-a8b4-2911941b1464@smankusors.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/25 2:53 PM, Antony Kurniawan Soemardi wrote:
> On 10/28/2025 1:35 AM, David Lechner wrote:
>> On 10/27/25 12:29 PM, Antony Kurniawan Soemardi wrote:
>>> On msm8960 phones, the XOADC driver was using incorrect calibration
>>> values:
>>> absolute calibration dx = 625000 uV, dy = 4 units
>>> ratiometric calibration dx = 1800, dy = -29041 units
>>>
>>> As a result, reading from the IIO bus returned unexpected results:
>>> in_voltage_7 (USB_VBUS): 0
>>> in_voltage_10 (125V): 0
>>>
>>> The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
>>> from the predefined channels. Additionally, the downstream code always
>> Mentioning downstream kernels is usually a red flag. :-)
>>
>> We can justify it here though by saying that there is no documentation
>> available other than downstream source code, so we are just using it
>> as a reference.
> ah ok, rewording needed then
>>> set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
>>> That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
>>> those bits caused calibration errors too, so they were removed.
>>>
>>> With these fixes, calibration now uses the correct values:
>>> absolute calibration dx = 625000 uV, dy = 6307 units
>>> ratiometric calibration dx = 1800, dy = 18249 units
>>>
>>> Reading from the IIO bus now returns expected results:
>>> in_voltage_7 (USB_VBUS): 4973836
>>> in_voltage_10 (125V): 1249405
>> Would be useful to mention which hardware you tested with in case
>> it turns out that there is some other hardware that does require the
>> SHIFT0/1 bits to be set.
> I did mention Sony Xperia SP from cover letter, but I haven't
> referenced it in this commit yet. Also I tried to search on Github for
> SHIFT0/1 bits, but couldn't find any usage of them...
>>> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
>>>
>> Since this is a fix, it should have a Fixes: tag. And it sounds like
>> possibly two separate fixes. In that case, it should be two separate
>> patches.
> Fixes into 63c3ecd946d4ae2879ec0d8c6dcb90132a74d831?

The correct format is:

Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC")

See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes

>>> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
>>> ---
>>>   drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>> index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
>>> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>> @@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
>>>           goto unlock;
>>>         /* Decimation factor */
>>> -    ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
>>> -               ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
>>> -               ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
>>> -               ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
>>> +    ret = regmap_update_bits(adc->map,
>>> +                 ADC_ARB_USRP_DIG_PARAM,
>>> +                 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
>>> +                 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,
>>> +                 ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
>> As a follow-up patch, it would be nice to update the driver to use FIELD_PREP().
>>
>> I.e. remove ADC_ARB_USRP_DIG_PARAM_DEC_RATE0, ADC_ARB_USRP_DIG_PARAM_DEC_RATE1
>> and ADC_DIG_PARAM_DEC_SHIFT macros and replace them with one macro:
>>
>> #define ADC_ARB_USRP_DIG_PARAM_DEC_RATE        GENMASK(6, 5)
>>
>> Then use it like:
>>
>>     ret = regmap_update_bits(adc->map,
>>                  ADC_ARB_USRP_DIG_PARAM,
>>                  ADC_ARB_USRP_DIG_PARAM_DEC_RATE,
>>                  FIELD_PREP(ADC_ARB_USRP_DIG_PARAM_DEC_RATE,
>>                         ch->decimation));
>>
>> This should be done for all of the similar multi-bit fields.
> as a follow up patch, you mean next version of this patch series, or
> separate patch series?

Either way is fine. It's just a "nice to have" change.

>>>       if (ret)
>>>           goto unlock;
>>>   @@ -783,6 +784,7 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
>>>       ch->calibration = VADC_CALIB_ABSOLUTE;
>>>       /* Everyone seems to use default ("type 2") decimation */
>>>       ch->decimation = VADC_DEF_DECIMATION;
>>> +    ch->amux_ip_rsv = hwchan->amux_ip_rsv;
>>>         if (!fwnode_property_read_u32(fwnode, "qcom,ratiometric", &rsv)) {
>>>           ch->calibration = VADC_CALIB_RATIOMETRIC;
>>>
> 


