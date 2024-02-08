Return-Path: <linux-iio+bounces-2302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D388B84DB34
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 09:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C086287BB2
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828846A038;
	Thu,  8 Feb 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYyNMCOD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE376A01A
	for <linux-iio@vger.kernel.org>; Thu,  8 Feb 2024 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380288; cv=none; b=tz/pwBSzH/7jn5OR4VUfnTtReg8VmOZ1F6KKXkxnrIoLCzID7IlmINYd8L+KyyRo9W5hLQCiNw8dXWg2WwrLyzaKswILt7co0uezvgTSDcXoB1IbciU5/1ZeKa9UMVt5m0kvy1ZbPzyeYzzqWCE0jk4N46+UDZ9GsfioUdOr4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380288; c=relaxed/simple;
	bh=nbZq8i68KoLoazBRqiYw3VADDcHa5yKyxI+OQdEIV+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ugd9zw+RWLabOP0/3nCp96vLyYBrNGLMUVWRAndkv6sgXFmLjYNYScc/wJWh89gqZcq/CcITLk/P+V88Nvpeku9HAu0tXtHDKUMa+SFyBGoChCRweI3jQkoQhgkvuP08HG22AjoUEbE60Stu/zskNcOYf7J8pz++QGV7zFDx8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYyNMCOD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so13110985e9.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Feb 2024 00:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707380285; x=1707985085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzjDELNKVw9+VYjbOMlBmirR01kGz4g7bnNKXxzZc/Y=;
        b=ZYyNMCODNzj6Nn1hMDGIucnFQELTrUeMRtZ+mie6RVDtaYgjbq/CnLIEDkJ4svl7/d
         uKtNZB7lhlGny/2mJ/XonDvr+jCBnyhtQ0x1yIdqgF7710ujV6rmIteOjIjc2Yk30PBf
         BANuwY+PwFED4oZc+FiXIm1IUTsC5Nt7zT3SmFX5rv+MhhOf9569j1IaA3vutZacyGEv
         9akW1olLuGeMq+LbTrM/8LvjHY9fAISV55Nl/bJLObWzSs+/YMVBdJQweAfDKVFmn1qQ
         ZetxsNucjzhAeutrWOAfuuWIPLbw6IwacVrQW6VQoaJjI2WKF/pf3oO/KMPwirE1YTFG
         Whkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380285; x=1707985085;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzjDELNKVw9+VYjbOMlBmirR01kGz4g7bnNKXxzZc/Y=;
        b=eiorsLdBv/IDLU9eFcRcsPEVNjoDaMIL9lR5kbMbeaPQr5wbLVAnFbtqRmsUyNxjb5
         fYeAMHia2CaPqC4Ql/BcVVnaYdvjF3lc01a6QgEObEKP/NPy7J9YSfXRG8abTxWt+Zto
         9x9vzEznRuK4EdGdO7deAuksky7PDVMRa6h8ZppSy9vDlNrV/ph5oHezStFPuRM0a/D4
         WryiAk3EhcU/mypq8g6H35Pw2X2NCex8da79OPDOr/icS6jHQPqNHYP7uNDVL0y2+xZu
         +/ch3Tan6obwaVov4Nt8/GYC3GU1aSWjw7/5csk3ic6rxBRTCZhZgjt+Oa9+I2yCxrmK
         ljfw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Qjpa+cHmKz8DVawLL58w5l/9VKCWyZo3NHzY6bP3UvQ0RhfD9640dQA1yuhqIGAymG5AbgcHeRoGfg+/0fPw2uedrbx6hhgC
X-Gm-Message-State: AOJu0YzTE6AVcA+/w5aAIoSIbvIQVt4wthEASqA9cZiTW6sxKOXP+00t
	ToNmImF8wABdijA/cUvPa0u+xb9v1rn1wT1yRiBMT6WyzcKx/gWZVr8QLZSSqY0=
X-Google-Smtp-Source: AGHT+IGX1v0DNa6dk68DpbamK9VoNLElNByYhFwXU8R28IKxKgIJVYtrPhtGs//RCuvvKJJ9Ajgcbw==
X-Received: by 2002:a05:600c:1e1a:b0:40f:f069:8d13 with SMTP id ay26-20020a05600c1e1a00b0040ff0698d13mr4941390wmb.9.1707380285134;
        Thu, 08 Feb 2024 00:18:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRKzqwGexCKu9ihoWDvIG6+anTtzBOWv/L9gC2rIKWjRWlI0/WAKrEUQG4UcXSw8IJTjkLZj9DbAm1YXocYilPt2cfBwpYvGE7k7IUShWDAd228NrjY+/fBN3VTQ2p4imYjf8dFXy3y3/DgNWS5DXJ677mkmIBjVuUjt87mEy6jzNGuH+Q14vIAAca0JD93o2LTT+0asBVe1l1PlaSjLzhXajA7OOxOuzXcsMzMzX+N+AM9eyWwZY3IMKVpa3j63Hn0jGUIFAgALb/LxtNl4JBkQU8QN0VROb64YGUVQ9R+ztGXaT0bllW+ptW3CGjz9PTELApxdYttMh4pOz9CBHEmk8C4xpyeoTkN8NQ/3l3wFzXUuA0DXZKjp47vrDjKaSEa8rTPg68CmhX09bPdcKXiehoLz+6pXuuhEH2801y1dVuBJnsPycYCHnK/IDQWsyRKuItSk26SJsnAdNKQf+2Wnwj4xWY52dcvMXkYEWqOIpoGddP9+iVMTYy8xsESHxgAOxUsqtbjVR2TWNXB+7dmB7H+w==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r20-20020adfb1d4000000b00337d6f0013esm3099374wra.107.2024.02.08.00.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 00:18:04 -0800 (PST)
Message-ID: <4647ae5a-b700-4eb0-91a2-d9885bd60431@linaro.org>
Date: Thu, 8 Feb 2024 09:18:03 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] dt-bindings: iio: light: adps9300: Update
 interrupt definitions
Content-Language: en-US
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-4-subhajit.ghosh@tweaklogic.com>
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
In-Reply-To: <20240206130017.7839-4-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 14:00, Subhajit Ghosh wrote:
> Include irq.h and irq level macro in the example for readability
> 
> this patch depends on patch:
> "dt-bindings: iio: light: Add property vdd-supply"

Please, don't write such useless dependencies. This is neither true nor
useful.


Best regards,
Krzysztof


