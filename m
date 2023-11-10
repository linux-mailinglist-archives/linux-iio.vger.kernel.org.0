Return-Path: <linux-iio+bounces-1-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013BA7E7F0C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Nov 2023 18:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218971C20F19
	for <lists+linux-iio@lfdr.de>; Fri, 10 Nov 2023 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C83D38D;
	Fri, 10 Nov 2023 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9xuSCtg"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80323C09D
	for <linux-iio@vger.kernel.org>; Fri, 10 Nov 2023 17:46:54 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9742AD2D
	for <linux-iio@vger.kernel.org>; Fri, 10 Nov 2023 02:59:11 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c79d8b67f3so10685711fa.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Nov 2023 02:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699613950; x=1700218750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YtnsbkjgNmMK4oNQZ7/5K+J2+w6BQuYkA1R55uanv0=;
        b=H9xuSCtgkd1Sge/1+o+eAXBgf1VOw6JF7k8n1LTvU79ZEoxEBKaI2d5ZWY1uNpHj3v
         y7c+ht+oJLkH/2pYb2mxBhS4m5aHfRWApEGmxoESQRCZzEOYLfy7ycc3YKP0gdqT6jPq
         G440DDmzcP897L86yXklBylW5UDVXcjk1srblmTCraQNopxQPuWxP8ev1cI/vbgeLkAw
         HfBRXccCQ4DwP82b8Y1AsuuXkEOUejvyjrWu31Zw5e8PmHili6m8ZT+mTSNAXISVTbfU
         OLl+hhpfHxagm29fwkE+2vOebAYo8uSCxU2qr2fncUIUZhmiYjcrxWrv8QTVKz0lwnNA
         Rm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699613950; x=1700218750;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YtnsbkjgNmMK4oNQZ7/5K+J2+w6BQuYkA1R55uanv0=;
        b=uQ+rzAberYRqlTYlXvS1b1jnP/Esh1J0K3bzEZQ0QqHa6jvMJXpJrSwKhSqfKBEQDL
         zIJkowAf7bpyLyNnMBVz8hcS+iauNlemwpR8xheAxLrmWLYlyMRJz3nWK+rPtgriQ5/W
         gIk5/+gsJukXd0WH0UioKDoJI+XzGWGYtnOrcftg63QMmbWTI21DQdsJCV1Z2wroaRMr
         c3FJT2NX08zzGxUBR5VsmsCmAujP9SBYRTnDWRjLNdD2NyOAkkIZdBmQQLag4cCQ/rHw
         l3JiNuW4OJ17AoUajB8L/RWYQwVNtP0B8xhUcCX0JY8P04ondHDrSjYWNU1St4By9Qqe
         X0/w==
X-Gm-Message-State: AOJu0YwsHA5SC+yYOR/I7kq7WZqhaqxXgwMXz3ye+Ch+PfpPVhCk/+xt
	2E5FLU5cNcV+/UAOHSdqYJehxw==
X-Google-Smtp-Source: AGHT+IFSVrapyybW2AyJuImHeeidk8TiEnVGijxqBCd8mmjR/9eba809vpDi5XMmGFAGFZO7KB9ltA==
X-Received: by 2002:a05:651c:2dd:b0:2c0:318a:6ee1 with SMTP id f29-20020a05651c02dd00b002c0318a6ee1mr5343889ljo.49.1699613949943;
        Fri, 10 Nov 2023 02:59:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z12-20020a1c4c0c000000b003fe61c33df5sm4758021wmf.3.2023.11.10.02.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 02:59:09 -0800 (PST)
Message-ID: <8114d2f9-43d8-4761-adfa-aad9ae249cbc@linaro.org>
Date: Fri, 10 Nov 2023 11:59:06 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] ARM: dts: qcom: Update devicetree for ADC7 rename
 for QCOM PMICs
Content-Language: en-US
To: Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linus.walleij@linaro.org, Jonathan.Cameron@huawei.com, sboyd@kernel.org,
 dmitry.baryshkov@linaro.org, quic_subbaram@quicinc.com,
 quic_collinsd@quicinc.com, quic_kamalw@quicinc.com,
 marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 linux-arm-msm@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-4-quic_jprakash@quicinc.com>
 <839cfac2-8f74-3386-5854-e3fb2ba4e07f@linaro.org>
 <27b5806f-ef15-7a90-5adc-5ee12690f2ca@quicinc.com>
 <7af782f3-fe6c-415b-a993-55962845a102@linaro.org>
 <7ccaf08e-0add-33e5-fbea-ce737e53fa28@quicinc.com>
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
In-Reply-To: <7ccaf08e-0add-33e5-fbea-ce737e53fa28@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2023 09:22, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 10/23/2023 12:02 PM, Krzysztof Kozlowski wrote:
>> On 23/10/2023 08:09, Jishnu Prakash wrote:
>>> Hi Krzysztof,
>>>
>>> On 7/9/2023 10:48 PM, Krzysztof Kozlowski wrote:
>>>> On 08/07/2023 09:28, Jishnu Prakash wrote:
>>>>> The name "ADC7" needs to be replaced with the name "ADC5_GEN2"
>>>>> everywhere to match the convention used for these ADC peripherals
>>>>> on Qualcomm Technologies, Inc. PMICs. Update devicetree files for
>>>> We do not rename compatibles to match convention. Please provide proper
>>>> rationale.
>>> I'll avoid renaming the compatible directly, will just mark it
>>> deprecated - but is it fine to do the other changes, for updating the
>>> macro names used in devicetree (replacing the ADC7 macros with the ADC5
>>> Gen2 macros)?
>> Please provide proper rationale why "ADC7 needs to be replaced". Your
>> marketing is not a proper rationale.
> 
> 
> The name "ADC7" was the one used internally at first, but it got changed 
> later to "ADC5 Gen2" by our HW team, after we had added this support 
> both downstream and upstream. Since we are now adding support for the 
> next generation named "ADC5 Gen3", we thought it would be helpful to 
> indicate in some way that this generation (ADC7) lies between the 
> earlier ADC5 and the latest ADC5 Gen3.

You keep replying with the same arguments as before. I wrote that
marketing, so how you call your devices and then change your mind, is
not the valid rationale.

> 
> Since you do not want us to modify the existing bindings, is it fine if 
> I just add a new compatible for ADC5 Gen2 and comments to indicate the 
> ADC7 compatible should be considered deprecated?

No, because adc7 compatible is valid and there is no reason to replace
it. Just because you changed naming does not matter for compatibles.
It's just unique string, that's it. Don't touch it.


> 
> If you are not convinced, we can drop the Gen2 name related changes from 
> the patch series.

Feel free to add comments or descriptions, if you want to map some
marketing name to real hardware or to compatibles.


Best regards,
Krzysztof


