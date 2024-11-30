Return-Path: <linux-iio+bounces-12897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB79DF325
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FAAB20FBD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF81AA78C;
	Sat, 30 Nov 2024 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYmAJlCV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAE145B18;
	Sat, 30 Nov 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732999810; cv=none; b=dJ/g/PHprng27aB15/SPFXbhriWaMGbxZJzdl2zwLy85w0Dpgk3HH4Lmw1uXB8xUPl7OrPD80ZDd88ngVMW+cULWyuBYVCMTZgw4wkpxRE3H3nWGh/VDWibL9cG45h4cSJC//cluUu7FQOSeVMm4yWkjexjKgfnk7xp0N7N3IEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732999810; c=relaxed/simple;
	bh=XEfSwcDRbYfhzPLNai2sIFnPBLDsPhkMq536BQm2oGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awmwfWH/9i0WCrfPolaZNBCuip4nWrKJycziquf2JsjEATDQFN6UcaigUJF2SrB/qGKK0/rDXSdqrhzGratF+ydWTF0TW+SBh7TL5OehGXTsXQMuIdBOjhTcFV2sY/0g3Ln/GNQ0BJhVlGEjh2mxAJQqEKKtES62Qeikd5aI0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYmAJlCV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21561af95c3so5041435ad.3;
        Sat, 30 Nov 2024 12:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732999808; x=1733604608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OT4atFMu8JviXPF/7EG/3/vXBKPHmJnFdFWMC/87YMk=;
        b=BYmAJlCVo8MEDxLf3WV/2pu2ff+ovvRBkILh69HvZWoPJ/t+3rA0Yj+lbfimifHBYB
         tFScw3HP/95blf77Lj9+PF1qtNsNo6TA0R7N9KxQ/0P1NbNL2ty8bZe1wMAlMLquCqRy
         0x80oarjBm/dnPeMf+ogQpQYDejKHGU+BhDZryUWrLe0WljgeUetGz7OWEuxTqb7cftV
         l/yZfrLcGOh+vNjjveEAB0Ck6AS3mQZnlBXk+mv6eDQt+mfReXXC+n0OnFn07flrL2Wo
         FG7w6vlc6A4upv89Fuu2Lo7GNNnFYUuxpm+EnEN7LMRirwgLY6LZbIjtJK6xFBqv41aD
         3lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732999808; x=1733604608;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT4atFMu8JviXPF/7EG/3/vXBKPHmJnFdFWMC/87YMk=;
        b=mS3Cfy4N8UE0zprYOtaBMAPMbr8uSFglZzLkyJlEAeMbIvZtoV2hhqpQ1648oV8yCw
         Fss8bdovEYEsjU25l2gR+StoHj4lH4Op3AXWS8aE4k9X2iuhd/rMlxEQ7vG1T/Dsc0W3
         AFVOYWS7M0nsbwjQRg+QWvFY30uV9rrM2eP++C7z3zhocdsOMgQmXOi37RmUPqBBwS+i
         lfGxsAIBn4IHxnglp5aS0mAhjP1gvrKIN2dJlC3sMGR2159S+lwOmltpXo02kwnMdIWc
         52gvgl4R1PaiNoltGMyrnmvTbln0fPKsulVLjeX+i9rAbGiFutlWH1OcuVljDzKsuN90
         yHFA==
X-Forwarded-Encrypted: i=1; AJvYcCUayVI5m9q0pBI+aeyX2zCTa5WgjuAot+Hte1eBtrdd5lov+rSoIZYPMO7f1a3CTANQ4MuyNcjgJIBe@vger.kernel.org, AJvYcCWCz8ISVfE4yfRJOwHCus7KdT7tWltgNZDKZA3ciMCQhxaH3tqp0L3Kzj09e4w9lKTQaJrooDdOBTRo0hHg@vger.kernel.org, AJvYcCXrE1dhFzei97kJKp1heDuEsICSRAeVV8IIxhDR7QWIp7L5cflbN0z30wEcAG66E/cj73lKZWNg80Uc@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhaT+jKDYPWej+CxrAzkibN1UL98rEDJpWTTkoFqlqk+y7YmJ
	Sm4z4WLpWePRXRu1JFeSF0bIrwBSN/KEM8LypRKFQ24LBxZlASXx
X-Gm-Gg: ASbGncuBJdYbX6faaAHDA1vJBb5kdTwe8Ah9jeeb4PTp5F5W0rcDu6eTaC1hBBkDRTg
	HJjKNPDfjCKnMk2CPDW3l57CP+uhrox1HKlEretqbS79xuOxnXH0ZQjbrxjY5nV6ndVR2EBSwP6
	Hj8jsnOnVko9Ez+2O1tPdQAC+xsvTcrGEzg1IYZZ0oJvc9S/m/HXUuOo+ei0Wne7vv3/Cz4Eg/o
	jeR/KpyPuIRr9f75JQDt2QGf1JKOzQ/X+NHV9WpMK8u9sD7xhsaYbEbqBDc/vdYKfJsRbtfTbTw
	EdnOJJk/swAv0T+KVrqYorE=
X-Google-Smtp-Source: AGHT+IE7PnRN7wEiixIFUi8FMoIH4qsWII2hYFgx6R9nvx3X2XfoVrsTvzCRXCsP5DLp6M+dUvELSw==
X-Received: by 2002:a17:902:f68e:b0:212:4582:37fa with SMTP id d9443c01a7336-21501f6fcbbmr193299595ad.53.1732999807626;
        Sat, 30 Nov 2024 12:50:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157432818bsm3890835ad.154.2024.11.30.12.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 12:50:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9174d169-6037-400e-8ec5-6e2653c07a1b@roeck-us.net>
Date: Sat, 30 Nov 2024 12:50:04 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Add Nuvoton NCT7718W IIO driver
To: Jonathan Cameron <jic23@kernel.org>, Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, cmo@melexis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>
References: <20241126074005.546447-1-tmyu0@nuvoton.com>
 <20241130202849.13eedb04@jic23-huawei>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241130202849.13eedb04@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/24 12:28, Jonathan Cameron wrote:
> On Tue, 26 Nov 2024 15:40:03 +0800
> Ming Yu <a0282524688@gmail.com> wrote:
> 
>> NCT7718W is an I2C based thermal sensor chip from Nuvoton.
> Hi Ming Yu,
> 
> +CC Jean and Guenter,
> 
> Why an IIO driver rather than a HWMON one?  Superficially this looks like a hwmon
> chip.  We do have the means to put a generic driver in IIO and bridge to hwmon, but
> when a device is very much intended for monitoring of hardware temperatures etc
> the IIO driver rarely has any purpose and a simpler hwmon only solution makes sense.
> 
> For temperature sensors IIO normally makes sense if:
> 1) They are part of a series of devices some of which have more functionality than temp
> 2) Fast devices where hwmon sysfs interfaces become a bottleneck - note you have to have
> a usecase for reading them fast, not simply a device that is capable of it.
> 3) 'Unusual' temperature sensors such as infrared thermometers or very high precision
>     thermocouple interfaces.
> 
> Any of those apply here?
> 

Also, it looks like this chip is compatible to LM90. It isn't entirely clear to me
why this would require a new driver.

Guenter

> Note that hwmon has better threshold and critical temperature handling than we can do
> in IIO and it seems your part has those as well.
> 
> Thanks,
> 
> Jonathan
> 
> 
>>
>> Ming Yu (2):
>>    dt-bindings: iio: temperature: Add support for NCT7718W
>>    iio: temperature: Add Nuvoton NCT7718W support
>>
>>   .../iio/temperature/nuvoton,nct7718.yaml      |  44 ++
>>   MAINTAINERS                                   |   7 +
>>   drivers/iio/temperature/Kconfig               |  10 +
>>   drivers/iio/temperature/Makefile              |   1 +
>>   drivers/iio/temperature/nct7718.c             | 505 ++++++++++++++++++
>>   5 files changed, 567 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml
>>   create mode 100644 drivers/iio/temperature/nct7718.c
>>
> 


