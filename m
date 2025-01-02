Return-Path: <linux-iio+bounces-13875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC649FF78C
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 10:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FEF1621C1
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F5619D087;
	Thu,  2 Jan 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLUjKYXF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C719993D
	for <linux-iio@vger.kernel.org>; Thu,  2 Jan 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810841; cv=none; b=M7vegN0QWQ0uT5d3iAR0ELso62ytMAzWXY6SIhmk8JljagD6pTdfUvWmfc3ulm8+1kEAfjbDtPOUfvcXQOfTHlJ1kY7e3rkpCTC+YuWhmXIJZrYLU8b8lNJIxn/jUmqrkw/3h/QY3YPgdWaQj27Ym0YeTup6ZuSGxYwkBXL43S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810841; c=relaxed/simple;
	bh=c62rokAxa7lt3ak5B6yxvE6j4P7LwpjOFp0oIonMUxE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=glpAXd1TjtFbgsRyx64YJjjAYlp/lYLSyt0Kr2N+IfBkqRHDVftpjs1nPEplzanZtYdioz2Et1UiSbDXtyAAWGOQFNEBn2nEg7x17qls7Tlmeczbl1M0/boijs+tZ3WBXHTHFhRbqrlkx8ryAcBbr9aW8wShDJE/cWWsSApJ3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLUjKYXF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso9550966f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Jan 2025 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735810838; x=1736415638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBrc7EuOMXY8yTx/TbXVRV+IK2Cs6RWnPvid7BqXfWc=;
        b=gLUjKYXF9YCoWRHR4iC91wBlO4HP5ZpCOB4PH6B/KFWuzT2o5nK18YZ79DKlrrfYtA
         EKGaQMVmi/siGZoNBqFkcCtptxSwkhMLPh3Iiy9mk/+L+vmI56uMNqVoar60du0JzxB7
         1LMmZ0jc60ED4cmUDZkYogljmwqv66sCJumicBoCYCDTNJIlGEQKJBhBqA3cW+LV29az
         iDsBEuKi0x0X9KgNT+PIfiHkFdctLwpY/0NHx9qC2EVALiHVNkVhl6XbhywwQgd+bppn
         PuxhGLKaVJ0mKmSQLICWLRenddA5TWhYQWpfNpiH/FTLVFSQ/oZZH3rQBNoqmWDP0wHf
         JtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735810838; x=1736415638;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vBrc7EuOMXY8yTx/TbXVRV+IK2Cs6RWnPvid7BqXfWc=;
        b=a1UiT+tUD3u6vOgyc9IE9QoJAU0ZaNV/8LZZuVxk+YWS7vWgg45a9/TQwpWeSIH7kS
         4KQgQsBF0fNlTqNLVPSIs6VnTdj1kFobzLXaPfUr02xIy2QvAsOCZ2+OkQ81LMGht3Ew
         9f98BhJ3v/edMFQaithjU1p4lWhDZwkAkdGLWi0aJmuUeFqack6GlIaDmCYqnmYByV8V
         ul8XGHSR8ckPzDPR3w8267WQJeMEJdh+K1ZViJtYe1efqC4W/nHNzEJ7NnvwTwreqifx
         rTv9/gmHRvwBpWCOb+ntFP1mEflUz5VFQj5UKdDxafoAscaoy+UKrQ3ubdVNWv4a2EKP
         NTmg==
X-Forwarded-Encrypted: i=1; AJvYcCVDY2zPyCvptO1V1DADsZvpbzAXFi8mQwvUz1zZti2DYXatcb+INk5O1W4V2VdEuKDpIqZZ9rNGmEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQnjCS05nOyczNRSUNvokjXZzirQpv6WnLf8VIt79dpnKAzMP
	T8mhPkKBxVTLElfFsqhALt+gxLaoKOQNK4smrLhyH9tj+R75twvyqP886/PApfo=
X-Gm-Gg: ASbGncscVxlPitOMHO1ZIFVq7lmyJjaAlBDhiYeFi82rI1af6A2SMtsEJYBtQBt1mFf
	kd9MOwEEMF/TZfC1AuyCHg+cuewHX/hqHUTO6b9WQN/tHFQhOWSoe83aFTiy/NTauuTWjqJ2rVN
	7eXWartM2bYi05TVDHQ1OMyMhGeTyOFpo4VttGDizsV2MNIb2q50bfaQhABBGpfd4jVRGh/TVUp
	rq6xQShiuqiI9+ABBzc58OEMPuUcZSuUFre56PYcC5Z/enIL9s1dJUvnwg1Zl1NE9+4Nc8Ty93q
	SaewObCMhtdQpFbgwY80oPCe+210W3DU3Q==
X-Google-Smtp-Source: AGHT+IFyQxq7+SLmgC3lEOJrijlLY/blJUqn/3ChXyKJbxUPuO43SDrq1oyRFY0OkutfbUe85tJpHQ==
X-Received: by 2002:a05:6000:2ae:b0:385:ed16:c97 with SMTP id ffacd0b85a97d-38a224088aemr34478674f8f.49.1735810837548;
        Thu, 02 Jan 2025 01:40:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1cfa:329a:aa2e:f0be? ([2a01:e0a:982:cbb0:1cfa:329a:aa2e:f0be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828bd3sm37151921f8f.10.2025.01.02.01.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 01:40:37 -0800 (PST)
Message-ID: <f888d948-d79e-41a0-8844-b3a9659498c2@linaro.org>
Date: Thu, 2 Jan 2025 10:40:36 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v1 0/2] iio: adc: meson: add MPLL clock workaround for
 GXLX
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lars@metafoo.de,
 robh@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gnstark@salutedevices.com,
 krzk+dt@kernel.org, jic23@kernel.org
References: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/12/2024 20:42, Martin Blumenstingl wrote:
> Hello,
> 
> Amlogic GXLX SoCs seem to be mostly the same silicon as GXL. The only
> known differences are:
> - one less Mali-450 GPU core
> - no VP9 codec
> - and an odd one: the three MPLL clocks need a bit toggled in the SAR
>    ADC register space
> 
> This series attempt to fix audio output (which relies on the MPLL
> clocks) on the GXLX boards. Unfortunately all we have is a downstream
> commit [0] without any further explanation (or anyone who wants to
> provide details on this). Since it's not clear if this is a gate, a
> reset or some other hardware fix: the driver side includes a warning
> for users to update their .dtb along with kernel images in case we
> ever figure out what these bits do and how to model them properly.
> 
> 
> [0] https://github.com/khadas/linux/commit/d1d98f2ed8c83eb42af8880ed8e206aa402dd70a#diff-c5aaf54323ef93777c5083de37f933058ea8d0af79a1941e0b5a0667dc0f89b3
> 
> 
> Martin Blumenstingl (2):
>    dt-bindings: iio: adc: amlogic,meson-saradc: Add GXLX SoC compatible
>    iio: adc: meson: add support for the GXLX SoC
> 
>   .../iio/adc/amlogic,meson-saradc.yaml         |  1 +
>   drivers/iio/adc/meson_saradc.c                | 34 +++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 

LGTM

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

