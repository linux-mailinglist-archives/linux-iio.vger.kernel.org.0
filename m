Return-Path: <linux-iio+bounces-24237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF9B825B4
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 02:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9F61C201D0
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 00:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3F1DB125;
	Thu, 18 Sep 2025 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYkktR/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E5194A65
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758154522; cv=none; b=JaFaIRAnGZoQRftUunlNuhkRPM1dqZ2RTA+SODFUPrfaq4H79ZhQu+vVye2fMLui/g57HPr3b70CiE3VyBfPkKD0IMqNUsIU831K0ILukferlrwMgBV3iTrRJhuBq6JibflgfnyIyEdYqfV1Yp2taYJtecZgaNFtIkSAMljpHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758154522; c=relaxed/simple;
	bh=Y1RP96XHVNYsIg6nosSNc/bCO4wroBeq77zJK4DJUzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwstnVzFlqk3161kXmd93TT2evZ2khRnEP4oRHRBD1Q0NcS+93ke4Qtxld1fd4fHzQv1ocFP6VoTAW+SDP9mTdQtEjx+4HIV/BpxkNvl/guyi5fLbo2hv6hj1c3UKW76Y7URP5RHZVwNhp1qjwRfFl8gEcS6KQ7GFQa6Hk28Zcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kYkktR/p; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-329b641fda0so34221a91.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 17:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758154520; x=1758759320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AT0AZ6qgFxSyXJFoWhvRS68MW40EiPaJNkN4dekZkq0=;
        b=kYkktR/p7r7+vbk/6Qi00kRyqxlsAOHaDNz6/+lkcjOL3CrwqvM43kdF78akItpB4p
         ahJB9BWjQngW960f5/wriGtMXfGsZ5SGR5x0WdLKpX0BbVzzIkbvZqFCvp5SXWkgqn7a
         1dgXNtYRRF2/hUK/5ah0MDlB+GnfJo+OsgOW5FBWz9KurMidsjach1o6SylQCugsHzV2
         KDsea8EywfsOYnDvLzkD5+WE8KEYf5+sMl1FlIklFKU7uzQGK8vt3pypfKBTR6YV2nGJ
         3wqz1AkOjz3seMOxTc9Jlt7LdJwmBjrN4fn6DSnbDQZAZcjq5CI9zswGqqVcT+lSgfRM
         0ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758154520; x=1758759320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT0AZ6qgFxSyXJFoWhvRS68MW40EiPaJNkN4dekZkq0=;
        b=PToDFd/wJSwjHMmSTDedXx9Nzn7GYKyavqFy0pPtmmYWPdmUwavyBD0cOBJujaIy+3
         +5eqaoDlyfqUnKViqYZT6mp3+QkJeeP85lEtUkFyIMTc/UHp2GtA9ow4xtEQPRozR7z+
         t4Aabhqr0yEgpWTsMZJlhDVxL13qEKJiXrpdSpK5hR/jPwmiJWIGJ5/q2145CVhbq0yu
         uP/DZHWkFFGD52vX7MJa8jS+5SYhxQA4Nc5J6z1Wpdqj0eBz+s/0a/mLj3dEDJNXGYxp
         NDQwF8pzCStTaidNad5QiTZ93cRQQ3DjLpAQE1ZYuZ7aFvH/O6hlvW474s6gaojy9r3q
         m0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUY479NjH0dh7DhFhahPJK0YBsEIXQheaDQDMQP4/V+EAsTjCRFvuY5O9uBCejptbtNBaHty0Xb608=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qy5oppLD78W2DyYg15wWTP2c9ZtmfpjuVBr90gX4joB9pA7e
	OejkPk99LHyAPUVid/Y8i2cV26yyiQGtG0ewZdvy3d6VDF7QCOwCI60WhcKhMb0WHe8=
X-Gm-Gg: ASbGnctzSoU3GwePxL9EyZHe/O7S5OXssh0vKMEVOZAHuR49Q04wEr6jP1fL/Lk7X7Z
	CX+58UNI+ipuWO9kdzaz+2w1vAqoLj0G0xzMMocGON/n4CRzvDrG6wvzwcjO6Lgfyfj0vJbmJH/
	xMUuO7oQRbPwtaep/nRZqDb8TZOxui6r9WFeEqVXix7asejOkt3pXEoN34gXmDHHV2NxGB9zvVB
	PIc9yeWE60Ovk0XpYteqAHaeMaf8cvqsa7MEdRBr53Z2LBA4dNIcUi0rHzeLqFw6zNcuisJ96s/
	/p0nfENXqx1mu+7HU2Gnw0JqERx+X4itvLeTnzi3x1YzO4BhlUwZwrd7v46kQo5hXzyBzC0rmPA
	uyAc8RnH2Ts5EI3P8n1NR15i89WZzrIBv6IQjyvSqSAPRCR5es+292Q2LYI/qEg==
X-Google-Smtp-Source: AGHT+IFnJ+1dJTY69Dwjtmg0S0ct1TjCceyJOpLQlXrD/GOIKZAb8aPR74gwioHcQP8BsSIA4oy8FQ==
X-Received: by 2002:a17:90b:1d88:b0:32e:bcb2:ae85 with SMTP id 98e67ed59e1d1-32ee3f6fd8fmr2537233a91.3.1758154520457;
        Wed, 17 Sep 2025 17:15:20 -0700 (PDT)
Received: from [192.168.35.228] ([218.51.42.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed2685793sm3584081a91.5.2025.09.17.17.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:15:19 -0700 (PDT)
Message-ID: <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
Date: Thu, 18 Sep 2025 09:15:08 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
 neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
 <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2025 04:47, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
>> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>>> You cannot have empty spaces in ID constants. These are abstract
>>>> numbers.
>>>>
>>>> Otherwise please point me to driver using this constant.
>>>
>>> These constants are for ADC channel numbers, which are fixed in HW.
>>>
>>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>>> which is added in patch 4 of this series.
>>>
>>> They can be found in the array named adc5_gen3_chans_pmic[].
>>
>> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
>>
> 
> We may not be using all of these channels right now - we can add them
> later based on requirements coming up. For now, I'll remove the channels
> not used in adc5_gen3_chans_pmic[].

You are not implementing the feedback then. Please read it carefully.

Best regards,
Krzysztof

