Return-Path: <linux-iio+bounces-23358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F5B3B6C7
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD5F178B16
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596A2F83C9;
	Fri, 29 Aug 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2FkHgOT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1BD2D8DAA
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458716; cv=none; b=P0u6A2g2QkzW9cFCVzrmQFT5IRmEmSA2Ds23IfzQl9Y5kHQiPLAddqRnBhmCB9lHOpnzI9dJ9mzQtI7D+Nx02GCmg/dWS8KayuZEAFKzENxLggbRBNAcriKyCQ2BAWMMjj+DTwUd5M0Yinw3BXRHjihIBON2ruDhsvl7TGmQFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458716; c=relaxed/simple;
	bh=0i4LozO4Hmms7wOEJWvhLFea7FPG9Dmd7MeRmpA2G3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e556WetuVYiBxLsX+ycrIANukXPrDWRsNKbKu0zYs/Ca5NtmzDHhlJMiR/f/Swb2B5135DAKU7OIclq7mLV2ZUTt+qxU5OEelD138u/L8NIaw9WuACQM6BjhbltLIWCguh6laPz7jt9NRQauafgv6SIAjUOffqafhisBaSUytpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2FkHgOT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b76f3b24eso2123085e9.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756458712; x=1757063512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NURphdCsa4oweALAHtli+ooWY+I8uEnacO3hp4q0Hc4=;
        b=j2FkHgOT+smGlVoJgW3LZawM1nEN0fpi08iW/9i4OUfnh0HkBGOC7nnrvz69Os/xXc
         SmQFche7L9ssksUv7jEHx7CkBY0gLO4Ym+4wR+ZWL6tyeblNCb3VUC/ZvfMUymwYlsG9
         O2FS09ygAUpUf2CM/Hxq4ekdVrO4Pud1Ge6HYHmidj12Zrg3ERuGfbV9CCiZytcBjpCe
         AgU7KG88yxcoHLp0OiO3T/BQCmuUWb7ktId9fcukzkKwwS1Ddkxg2OQEsMJzWT+O1833
         BWfInW4BmxmgVuu1YYTQ3NeN31RY6Z9oqkG9dYaoZI+rJYo5fOJ729y47j0pjigOoTy0
         NXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756458712; x=1757063512;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NURphdCsa4oweALAHtli+ooWY+I8uEnacO3hp4q0Hc4=;
        b=jQzdyRWY43/lSGVqq/1p6sMDbRHYT6ML1KZOzmRZBe1+xtXx/LkA/E4fKt0zJY8Fh1
         x88q00sdUPeINZDS7WxN+vNk2h3+zWSczxM/ZVAfFdVjEKn2z6L5LRsCIxfQO0cT6cPN
         KZBzsOFV+yQtyPozyXA1M+ERnL8G229yrUl1D1NgwpKhZZx/SpoIWDO6tvi9i41oI8d7
         a2YwPKPJQkLWzEtMikqls8BE3WIo5XUbEc5/PgB3Jsj+B4h3MLj/8Z3SC//UpJAbKSum
         vcxHsmuDOGNN6uZ5SpnC7kR/P3202B9kmbOxyzpqVJzYD4pBjAShak6OeB7uke3eSPb4
         axqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvn/fuVKtnSyzunN1q9W6anv4I2vzJ5yBkBe6PfLV6K6RX6D7KDfKA8znT55Rf6TgtzVvZg10l1Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9JAG2xO0qGqkAQTPmPupDO5KZmWcI5z8faSukKOCmiC5EFkW9
	fCJQFFnrt1XyrWostY5AO3MvG7XzyZV/vq8jj0an4Q6KB4SwCm4Pof2DZ1GGKqfFhU0=
X-Gm-Gg: ASbGncsYriDOXJVqIHCme6YV3OYKWwls672Jx/gx5ABbnzkFe1i4NDUXReMS0LpnkiM
	vKPb7YO78Ogd7deURzpAodkrXS0nGrEqr1z/eT8A776NIWm1qgou5JYYczlVZLlqR2VQLIF8w6m
	VgydchzLOBI9cCZPm2VRyTm3pR5VQvNDbWxu9MCUTnUm86w4c8MlqKiQGnoVK1z6ppAIE0vUUj6
	0oBNZYmDA152l8BYsJAWefC2W/uUMHO26iFgyxtgJB5yaNjHVCNGuY2qW+DlsVYSgePgsHSERCO
	WPz+5v8QyYc0lBzrvPeemUscFe0gDYLuGMggJrKQ5gMaRyN6Ho9R++Tpjqcf3eDLUvEok7AQhie
	PMdCq52MO2Wn0Rij2dvF3Xstc6+BjZy0Ga8kPYrvvJU25tRdCH/TB8g==
X-Google-Smtp-Source: AGHT+IGanHkEycB+cb5o4yQBjLRrkMQcj6kfkETKqQg4XSQo5M2B3ihnvsgAnsPhaxcAA8NHmvKbpQ==
X-Received: by 2002:a05:600c:1907:b0:456:7cf:5268 with SMTP id 5b1f17b1804b1-45b81f1e9d3mr2918385e9.4.1756458711623;
        Fri, 29 Aug 2025 02:11:51 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66c39f72sm74343425e9.2.2025.08.29.02.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 02:11:51 -0700 (PDT)
Message-ID: <8fdc99b6-4ad2-4a08-9dca-6289c8fdddd6@linaro.org>
Date: Fri, 29 Aug 2025 11:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, lumag@kernel.org, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
 neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250829-demonic-soft-guppy-512c13@kuoka>
 <zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
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
In-Reply-To: <zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2025 10:09, Dmitry Baryshkov wrote:
> On Fri, Aug 29, 2025 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:
>> On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:
>>>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
>>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
>>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
>>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
>>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
>>>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
>>>
>>>
>>> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
>>
>> What's the base commit?
>>
>> git show 0f4c93f7eb861acab537dbe94441817a270537bf
>> fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250822&id=0f4c93f7eb861acab537dbe94441817a270537bf

I see:
"Notice: this object is not reachable from any branch."

I guess you think this is 20250822?

Best regards,
Krzysztof

