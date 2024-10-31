Return-Path: <linux-iio+bounces-11689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B349B7949
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 12:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4DCCB2419E
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69513199FD7;
	Thu, 31 Oct 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTBPMv1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DEA19925A
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372592; cv=none; b=W3iqSGtZvQE9MXD+GsDtcGBNcpmQgPocAJHRkbLo9oD/75tj9oZ8+1e36y2SFMw/WI0WkcerGSxOcbIzC7U+nQ1Lk/k/jRungoc/6QUl9E7Hu5kruiv/OMqAmtHCl7zBr23gRhzk7nGf+XjyR6Kz2Ikx76GhFmU1Yr3MqZvpgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372592; c=relaxed/simple;
	bh=0Bt5LTg7vL5N+VdcE6SWBvlJfb0aEl6cLE8AigdCTpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sN9yc+prT1Ys7Hw2lyhaHoWDi/vgoilGtxOU8ZsHEWvMScB62KVKTz2xmE/eQuPFX/7+dDe8+aBPMLPuhmoGHIaAKaSHhShoNWOBF4GppkR4u7AH5bbTtm3pv1iM82UJpNXE6AKVIq1tRu2WVngYmDHcloQAvjFrrS9PY6U79dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NTBPMv1Z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4eac48d8so36835f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730372588; x=1730977388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo88u10AiueQwvU4VBGK/VQSQWRw8gLUSxPNaLTjLm4=;
        b=NTBPMv1ZDG60bgl7AbiVpYnSEdf2BilnpJbKMdZuwKhw51ynkm+inMPR/EiqJF6r1M
         CC7NFSwTwEa8CELBmMYjfQiqZtyFbDQ+2O5AeZEfHHfVSCXZGoaki3a+rCSUPJdR9db1
         T87pzdwFHINMTRTrocnRT3bldJzMvWI6dmldmCw35WeesVFgnRZLIouQh2u55nT8mABK
         t3Y9NLxi3gMzYOw6UnD+jNIrb25WvZXsilWLTeZ99uGBsLXxUw49rhMIjOonvELQORgx
         KtlgFHn8+pjQRG7NC8N3d7XRe8BSfXyFZDygUNLTGzB0+Md025uxbVkmAvHN62Yq8RcK
         DvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730372588; x=1730977388;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qo88u10AiueQwvU4VBGK/VQSQWRw8gLUSxPNaLTjLm4=;
        b=Ge+yzfAqhFNtHPrK1uahS50GKuNB1fL+gVgrnRlokvLFAa8wDxbtq9gSeKPJ6GbwvS
         wo4XONvQna2qfy5j9L3ByXPC2ho646ZFMTvA5DCC8LvGdBc9Aws0z1LsM0qaroA0m2Kz
         Rqs+POj9bQozwpKKPKC7XRqUPgYbE9gtN1cmxfeZpqsaQ7BzIjTo8c5lVsdxY1eCAxqm
         x7jZRIATioZ0WISxDLybpX/1qfk56uRAWa/vtp7xqY1tbLkcnUTlyMU+SL/N79Dlp3+e
         B3tu7ZdvuqdM56Qs5wsQXFkNSHO+LQ9Hn95U0tIeOhLBtE00/3v/UsEMcJHP7Q1T7gnF
         aYKg==
X-Forwarded-Encrypted: i=1; AJvYcCWsAOaYJW+iWMBFgakqzy0rcXUVdDWyJwt9Mhmog3vF4FbBC8KSIALgTstDRpOys7BhWnS1jl31O94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/5PO780q/UDTvz18GyqNpNtQUqja+KHXno/SDA+lvq2tRTHL
	VDMsnDZE/7HdOH3fs/umFobnVn/CtVCgH6Q5Q0e8cRCqann+0mIceOemrM7QqMo=
X-Google-Smtp-Source: AGHT+IGpz05VAvoftrmqHGfIqbT6FeVhxMMAZYmAw+E/a0Z2XhM7QtyYiu84O24YpcEKqkICIt9TLg==
X-Received: by 2002:a05:6000:2a3:b0:37c:f388:cd48 with SMTP id ffacd0b85a97d-380611a4f13mr7093799f8f.8.1730372588137;
        Thu, 31 Oct 2024 04:03:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e6aasm1797059f8f.67.2024.10.31.04.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:03:07 -0700 (PDT)
Message-ID: <d0511a78-8eca-4342-949b-9dea293e064f@linaro.org>
Date: Thu, 31 Oct 2024 12:03:04 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
 konrad.dybcio@linaro.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
 quic_amelende@quicinc.com, quic_kamalw@quicinc.com, amitk@kernel.org
Cc: lee@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, lars@metafoo.de, quic_skakitap@quicinc.com,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-4-quic_jprakash@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241030185854.4015348-4-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 19:58, Jishnu Prakash wrote:
> +
> +static int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
> +			  u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_read(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
> +}
> +
> +static int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
> +			   u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_write(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
> +}
> +
> +/*
> + * Worst case delay from PBS in readying handshake bit
> + * can be up to 15ms, when PBS is busy running other
> + * simultaneous transactions, while in the best case, it is
> + * already ready at this point. Assigning polling delay and
> + * retry count accordingly.
> + */
> +
> +#define ADC5_GEN3_HS_DELAY_MIN_US		100
> +#define ADC5_GEN3_HS_DELAY_MAX_US		110
> +#define ADC5_GEN3_HS_RETRY_COUNT		150
> +
> +static int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
> +				  unsigned int sdam_index)
> +{
> +	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	int ret, count;
> +	u8 status = 0;
> +
> +	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
> +		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, 1);
> +		if (ret)
> +			return ret;
> +
> +		if (status == ADC5_GEN3_HS_READY) {
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
> +					     &conv_req, 1);
> +			if (ret)
> +				return ret;
> +
> +			if (!conv_req)
> +				return 0;
> +		}
> +
> +		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US, ADC5_GEN3_HS_DELAY_MAX_US);
> +	}
> +
> +	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n", sdam_index, status);
> +	return -ETIMEDOUT;
> +}
> +
> +static void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data)
> +{
> +	/* Update calibration select and decimation ratio select */
> +	*data &= ~(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK | ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK);
> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK, prop->decimation);
> +}
> +
> +static int adc5_gen3_status_clear(struct adc5_device_data *adc,
> +				  int sdam_index, u16 offset, u8 *val, int len)
> +{

Wait, what? Why are you defining functions in header causing multiple
copies of them? And even if: why this is not inline? But regardless:
this is a strong NAK from me.

Best regards,
Krzysztof


