Return-Path: <linux-iio+bounces-4053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAE8898508
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 12:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6B91C21D16
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0176F1B;
	Thu,  4 Apr 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBye+VUW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65626AC2
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226772; cv=none; b=GlzWfDljMTCfeBWAQcfJ7dxZAIlTUw+nB93xc7uk9XvifiRkW0bkKqr9IkHyayPfO+tYD8KUuRTA0FppdO2rp/k+C1QmbI83TN0OLhNeTFKH8HZJYPDZNIIrvwjkUVQ2/STFd9BZ3xGsuVKvjAmfIF97RIsPHx8kFs7Dx0xZMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226772; c=relaxed/simple;
	bh=2tmnlwMrEbblML/RTG5OIDUhuSLFTklLsvkxM6XMqHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGw5SVt8VNYGrtmmOV1vATPJ+zeG9LCJY6FiSA47N9wwyDn10FPFmmclP33Q7vTkAABOkddC3PTH8Q8O71//gBtGZB9DchHom0twer8AQq4L1n0R7urP6SdKsDmnpcOXXTdTo7pAm+Qv55iBKXLQ/CcyQWg+M9yz7ZJ9xcUA01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBye+VUW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44ad785a44so100363866b.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 03:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712226769; x=1712831569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FFWtRoupfOP9RI4YS4XE0eTHYz+U+gVMZ5NU+Ifwu8U=;
        b=CBye+VUWiR5peB32a+zOi4XWC7Zf1YBgtwYui4s+yqf8lfcDWx/DtLcsNCwUaj0+Zr
         ATRLHPTGzMvAxEQ5rLJpurbIBG4WRPABAkJQHeXj6IozdVBCrypQxF/sFF2drvoz5KXu
         QJIooAaA3dJBidJfHBkosoOsJoms/lk44IBoY9BTNhT+01Iea4A/xlwPMqqyF9lYyuQe
         Crml00yPHgjRSxOpQmSygls7M2Ndci7Bf6rYLKtXbhQnPjpZj9UbN7ANgA2An3qy4oIA
         tqqlUxPbhxrPZPF6v+7Hf+Nauciv2g795GzKRBEHgUjQN/7vjqhXr9RM/DNNBZBVsSqN
         o8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712226769; x=1712831569;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFWtRoupfOP9RI4YS4XE0eTHYz+U+gVMZ5NU+Ifwu8U=;
        b=FPEwWOWw9x4q0x6hHGHOwCzs+SHCaD5ADUmyH/mKDBQcFI02Gf1U3YdxcCf0Pac6Z6
         8g6tNH9U0NlaAASNH63SnKw3eYGF6GYRZEt9f371YJ2wnrCDDcim0kWtJp512CX+Sy5q
         fDM7bH+4Vk1H9PrTMQyWgNiXmJkWSP5j0cP240DrMfSVbGcC748CUEwCMbRCVbO9upsv
         w1JPaWVa8kErPFlipwJud6kyucee5Thao/kLsPYcIzSkOUiFZHDZg4KhPb+ylaAWnCNS
         g1Yaqn1+VrVt/Ip4hJOUPGg7770PKpqacybwKvBVGMuhmE6RSi1ECbwOpwYWE1r4xVRf
         IXJg==
X-Forwarded-Encrypted: i=1; AJvYcCVkB6CluUU34ZaXKzXpNqDbIg0JpzwzoIx+jXGX8mzUF6DJ0XA1BGJQx3uX0xnmnkaOt63F7mJpeb8H0+mSsI7KksfAMxtmX5Ng
X-Gm-Message-State: AOJu0Yy/wRd5h+LQniQxdxan4QSzr9yUYCodD1+C+edrJvXGhnVsfVFX
	JKMqu+9MOP6DlA3ptXkdgxmnRbh3tN4pcpjHdjmTSk+bYjchyZq2leyfbcsEkQg=
X-Google-Smtp-Source: AGHT+IHkzcWcnSbBANU26vUAdkogIg3vkiEoZnM5ZBOE6LjQahnZzypWZByf9cDJ3vWQlBz3xcq4Ww==
X-Received: by 2002:a17:907:7e99:b0:a4e:95eb:34a6 with SMTP id qb25-20020a1709077e9900b00a4e95eb34a6mr1541590ejc.49.1712226769639;
        Thu, 04 Apr 2024 03:32:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id kf16-20020a17090776d000b00a46bf6d890bsm8962854ejc.91.2024.04.04.03.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 03:32:49 -0700 (PDT)
Message-ID: <744c154f-328a-4d06-84ca-e42a09b44ec2@linaro.org>
Date: Thu, 4 Apr 2024 12:32:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 INV Git Commit <INV.git-commit@tdk.com>, "jic23@kernel.org"
 <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240402090046.764572-1-inv.git-commit@tdk.com>
 <20240402090046.764572-2-inv.git-commit@tdk.com>
 <beb68fc5-1ad8-4052-80c6-b706b62c267b@linaro.org>
 <FR3P281MB175794A23F9A706C6E532836CE3C2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
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
In-Reply-To: <FR3P281MB175794A23F9A706C6E532836CE3C2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 12:28, Jean-Baptiste Maneyrol wrote:
> Hello,
> 
> sorry about this mess, this is due to a problem in mail system configuration.
> 
> These patches are obviously not confidential. And IP from TDK-Micronas obviously is not applying to TDK-InvenSense products.
> 
> I will resend the patches when the issue is fixed.
> 
> Sorry for the inconvenience.

Consider b4 web relay for this:
https://b4.docs.kernel.org/en/latest/contributor/send.html

Best regards,
Krzysztof


