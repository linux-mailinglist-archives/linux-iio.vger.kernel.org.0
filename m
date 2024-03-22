Return-Path: <linux-iio+bounces-3680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53EB886806
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 09:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494FE1F252BD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD65168CC;
	Fri, 22 Mar 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTLgMdpM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53B15EA2
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095272; cv=none; b=HOYiZBYkVLD1QjCOaavOWK3976HxLszIxZCiCMnae2ApjT2bczQ0eym0+AMKcdIGOW91v6HUXc+MEEtTEGKdAOl2lm7aYiAqpYWtYupQvp4LlGpQEinxNQ8/HI/ZU0DxgqQrEHNXGDijIZq80oJI9vdpHBArt2vRj7aPOQqhS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095272; c=relaxed/simple;
	bh=5NxkKnYnAWqvndvTJC/nAmRPYG/qomKWsy0dEUlGdxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgQVHhiRZiMoqV7mhk4VXW9fbxb9BzvldrSOInrD4wEWPGc2RCknuPzJzXYfy9Ff1Z7nhCbHb8guVocalTUTv73D6Kym15prBoFekRaoy3Gl/l5cmpOpScETnlWs0LkNjuzntzlbTwV+we/z7MPgk1BBkeyTp59YEGaMM2dEkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTLgMdpM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56be32b9775so378192a12.1
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711095269; x=1711700069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1y1OqSeUozXLMg+O0cSRVQLEYNdP2WzjHRZHRLzryiI=;
        b=RTLgMdpMkfPhIRj+XlE8LxKP06JYzuySpvJB5+xCzlre/x0TF/C4CxEY1ZyjWwqHj1
         E9TDZ6Ht3ZZ+fGAexMI8tmCgMdnm8DVoHGNoWaPytsN8hoqze58yrlSwa0TrMXlgDDqk
         EhWpQt/ze6aspYJX5ggVtoY1twlpXGB8sr0ZN30fLlOA9nOJbZEhy6wUSoNYWnErYCA8
         4Tq7pOJnR200OkVPkKyN6jjypmsv/MRWhSqCGPlEXyrIk5AOHNXJ3mXDHjuaV+mzCGgv
         IKfZALmOlcsI43icUk2za/in0PLldCAfxmqoWT7AhaGc5K14gPtqDwNhv65pm+j1QiYI
         CvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095269; x=1711700069;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y1OqSeUozXLMg+O0cSRVQLEYNdP2WzjHRZHRLzryiI=;
        b=PkBRHLA1gwno1ySWiRiPBrTk9CKMVmdIM2s3Y4RjMBv4XY5VeT5uB0fwGSTRge1nrx
         kLM7pVdhQ2qxWWaVK9QZggY+fxupYgGfeQbY0Jj8+XiEx8jEO2Q09KfIn9bEtRluBqq2
         NFmU5OVIzrwhXszqXXLbusH/gArfRjYzPcgSJ6aVwR8qCmXIu6+CoDT+dFgY442BAJd7
         h3RV/6/qPDM1OAhcxNikix79gXRSGx9CUvdQlojl/zClLlH51iziIKhkAhhp8JyDoD9G
         6SCtdFRNO9nMWpw5K4pqZGxgTGxtqNkns5PzS7Xl0PQwhmlAJbqpb7I3Sz7OsPwDhbJY
         8dGg==
X-Forwarded-Encrypted: i=1; AJvYcCX/P62TRI4cK2eYEdCrrMZjsczFB2hLhz6Gm8tIvbhMgkpJHT12fgpmH/SBnkoR4+UlmNFmrWec46Z409ZtMZfXsjL8Dsyvi0Ue
X-Gm-Message-State: AOJu0YzfZDeZy/oVgh8RvbQWNagL1UURiVzN+7Qs/tho9qjFnD0Ft+AB
	O0dDgpepTMxggL6ZaUeTLvE5aEegwe2y19e4KHzfwHH5DN6zioTexxpKR99Ck6qs+WuqE3nYtgG
	f
X-Google-Smtp-Source: AGHT+IGRU2rKWq35IInj0tVhgizzHHrbNaYzErazl8QGFTy+6FNmiP3W5lm6WU2QhG9W+vt5XQ4D9g==
X-Received: by 2002:a50:951d:0:b0:569:a0ea:9f42 with SMTP id u29-20020a50951d000000b00569a0ea9f42mr937991eda.41.1711095269377;
        Fri, 22 Mar 2024 01:14:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id g24-20020a056402181800b00568a1ce4562sm750145edy.25.2024.03.22.01.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 01:14:28 -0700 (PDT)
Message-ID: <a1b173c0-5120-40f6-9708-cd810b4a2406@linaro.org>
Date: Fri, 22 Mar 2024 09:14:25 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add
 calibration properties
To: Andrej Picej <andrej.picej@norik.com>, haibo.chen@nxp.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 upstream@lists.phytec.de
References: <20240320100407.1639082-1-andrej.picej@norik.com>
 <20240320100407.1639082-3-andrej.picej@norik.com>
 <38637621-1611-4268-ae79-7ac93a72c5ee@linaro.org>
 <e994b756-7f4e-4be3-b8f3-310988174b44@norik.com>
 <7e58bf96-3c38-467f-86b6-06ff5feedb31@linaro.org>
 <40e08a5e-e7e9-47c7-9102-24a2bbba67cf@norik.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
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
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <40e08a5e-e7e9-47c7-9102-24a2bbba67cf@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 08:39, Andrej Picej wrote:
> On 20. 03. 24 13:15, Krzysztof Kozlowski wrote:
>> On 20/03/2024 13:05, Andrej Picej wrote:
>>> Hi Krzysztof,
>>>
>>> On 20. 03. 24 11:26, Krzysztof Kozlowski wrote:
>>>> On 20/03/2024 11:04, Andrej Picej wrote:
>>>>> Document calibration properties and how to set them.
>>>>
>>>> Bindings are before users.
>>>
>>> will change patch order when I send a v2.
>>>
>>>>
>>>> Please use subject prefixes matching the subsystem. You can get them for
>>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>>> your patch is touching.
>>>> There is no file extension in prefixes.
>>>
>>> So: dt-bindings: iio/adc: nxp,imx93-adc: Add calibration properties?
>>
>> Did you run the command I proposed? I don't see much of "/", but except
>> that looks good.
> 
> Ok noted.
> 
>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>>>> ---
>>>>>    .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
>>>>>    1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> index dacc526dc695..64958be62a6a 100644
>>>>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> @@ -46,6 +46,21 @@ properties:
>>>>>      "#io-channel-cells":
>>>>>        const: 1
>>>>>    
>>>>> +  nxp,calib-avg-en:
>>>>> +    description:
>>>>> +      Enable or disable averaging of calibration time.
>>>>> +    enum: [ 0, 1 ]
>>>>> +
>>>>> +  nxp,calib-nr-samples:
>>>>> +    description:
>>>>> +      Selects the number of averaging samples to be used during calibration.
>>>>> +    enum: [ 16, 32, 128, 512 ]
>>>>> +
>>>>> +  nxp,calib-t-samples:
>>>>> +    description:
>>>>> +      Specifies the sample time of calibration conversions.
>>>>> +    enum: [ 8, 16, 22, 32 ]
>>>>
>>>> No, use existing, generic properties. Open other bindings for this.
>>>
>>> You mean I should use generic properties for the ADC calibration
>>> settings? Is there already something in place? Because as I understand
>>> it, these calib-* values only effect the calibration process of the ADC.
>>
>> Please take a look at other devices and dtschema. We already have some
>> properties for this... but maybe they cannot be used?
>>
> 
> I did look into other ADC devices, grep across iio/adc, adc bindings 
> folders and couldn't find anything closely related to what we are 
> looking for. Could you please point me to the properties that you think 
> should be used for this?

Indeed, there are few device specific like qcom,avg-samples. We have
though oversampling-ratio, settling-time-us and min-sample-time (which
is not that good because does not use unit suffix).

Then follow up questions:
 - nxp,calib-avg-en: Why is it a board-level decision? I would assume
this depends on user choice and what kind of input you have (which could
be board dependent or could be runtime decision).
 - nxp,calib-t-samples: what does it mean? Time is expressed in time
units, but there is nothing about units in the property name.

Best regards,
Krzysztof


