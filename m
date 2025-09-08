Return-Path: <linux-iio+bounces-23872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584FB48384
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2138217B068
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 05:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F72222C4;
	Mon,  8 Sep 2025 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnw0yq7F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD24A2D;
	Mon,  8 Sep 2025 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757308085; cv=none; b=JJgPaf9PuUaTsxZOskidVQQaSGhl2iZo1FyEMA5nWG2ENNbu3K/KJi79BGIltGfmbiVSeRnGvmwynhSKp8NcwW9sbw/x0tJbfHY3u6hLdf60skJeMKGq9sNW53MkbmOLgU+la7xVvZEjIsmZ+8OQAcDZxM9kzh+MeKw6ngSJsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757308085; c=relaxed/simple;
	bh=yeq5g3PtPphoN4z2zlR3qmZI0I18mREA+/PFX5OoE8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovwC9b5Xq93BquN7iBiz82W1A8EhgsiRVMN43v59XzBQV76855IrIDeAxbBKWNK8Cjs0ssZbVkeyf0JysL7CxJ6TO5aMLsnQERjb9ImdibVa3hmzJLPAV+MDNwrOCDog9HY3w19MZ6hwGuST+tZReNTr9Tly3xndCze9AOnQxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnw0yq7F; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f72452a8eso4708148e87.3;
        Sun, 07 Sep 2025 22:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757308081; x=1757912881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=as3xT6MPvGIJCNXfedJvXUOI5VUtpAJaWQgOxXjkisU=;
        b=Bnw0yq7FAGZt6a2t1dh5Ldx3KhBQv9jGKjpW7fGRspD4hBExWovrJJ88XJ/LDUbSxi
         zu+YjZ6PwrGwVwrkReQcVjEHITGwAktuM7gb4FPP1otj+OHQaGqjKBTAg4BhFJWRoGpi
         1DH7Ht2zJBht4X+DMrwPZbjva4ZMa2yfpLqPogkzZMw1O0SCPUAFrvJrRT2ADAcnKyHy
         kXciZPyTV1UQwGkynOSrc+6Nbeo89iSCJ7ORyDkajgiCunbWabXan+fb06e1EzdYb68M
         dM3/D6e6IVMfJe7Yw/mh6O0ZAP9jFVaiPtCU/qhDY/nvb2ARR6SBFP3qerNXadB0u3yf
         K9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757308081; x=1757912881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=as3xT6MPvGIJCNXfedJvXUOI5VUtpAJaWQgOxXjkisU=;
        b=p6JXzRVfBT1BL2GM44e1jGwj0yt2xybmfcNLLf9svLP4/IYU/iWkPI9cI0xplwruae
         IZXRPPeG+CpN2cKM2LxrSqgZoO1hLHfoSZtlBIhUVaXlqHLTFDyI06s+Rq/kTX1e1rd/
         Oa2pFjmeU59J6Qz8iqakMQ+XYG4saK8bp7aCLL9SEMbs+FW5l+0Ms48r3Y7851QQQIQO
         DWSsG+1t7oKBgbtV8r26J0gKF2PwgadlDVVzblJVaNiacp3UBsLLN+5wJDo23DegLjSp
         V7uA3Mv1NX0Qqq94SdD/IesaZdJwfGjgXLn/iPO8x26I1jNQrB7KQbRnlLHlgt6NiueO
         ETSg==
X-Forwarded-Encrypted: i=1; AJvYcCUp9ZbOW69s9Phxn0irHsbXom8UOQKa5de0etruNP2EBOqMcBYWObmOVPgYK6BmwaKMIFoRoJAJf38+@vger.kernel.org, AJvYcCVEPxewHcsfPMf/yybz3zuTZM5JrCM5mU00QHeRklqB2SzQcpdi7wy6uCxoymCa1Oe6UU1tLOyr8hkPHw==@vger.kernel.org, AJvYcCXPZHObbTXkZ+dRnMgDyX9jn3jeFVDfN6jizYg/Fjc5BTcyoBBRVAa7PhTPw/rqM4ohAb+sKOnvOg2ZJ/ML@vger.kernel.org, AJvYcCXg1fJkVN5tLlVghPOeI5xOY9n1m6Rv/0nc6k5x2I+/FvfSqfgUrUD7Lghel5axsMgNjmeLsSBR/+V8@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMx44AJS1BlAJlCx6qa8C6h21l1zwbSFMVZMQkhxElHoGutjU
	BpzHIRBQ2IPiRXz/l5Jddvqn0GfSJLN5JG0agIuIyoK/fMSIgPzUu8mD
X-Gm-Gg: ASbGncv4frWkRw8BDFuhjTCHeEvJPGHS9DC+0j4NuKsaYPU5dPaMAlcgOOjhclpCchB
	PQE7AmbWwBqw8f1YO+/Lc7uoFRZHdCxiqJTodQfm6d9B5rQ3ZXPaJyEOZ3c43IQ/ucE+US9hK+5
	AIE5Hdu6hzpxuIpTsmfxtLMkKl//yBwsvqoFevZxdw98dajKT3Th6ua2/LJaWL/NPcXE5isgDT6
	5+b4R5oooHDw8Z+gumHGcfB7r1t1JLEvyS9tY+BgOr+/4NrocRaqdNa+E6mw/Y7N/AEdnTXMT8b
	v/aViEUYEzHLzSysKkjjM7kh8CsHTCA1810KDcNezfn03FCSyr2Y1hsqcacAaqG9OjnSIvu8wPh
	JYmTl2aOuhMje5DlyyDsbrxLkl1YdXnN1oksh1O6amMnQjVUd3Kx7+31ZRWWMElARdenYd2msdm
	Yi4n6eVxyadEJbuHY=
X-Google-Smtp-Source: AGHT+IGiX/1/ENJ1OMCPL4OhX3Hl6u0NHGST1RoTPvj9EogARurWfU9+Z2sMOteCHIoQwBonguXSgA==
X-Received: by 2002:a05:6512:b90:b0:55f:3996:4f82 with SMTP id 2adb3069b0e04-56261314783mr1881384e87.1.1757308081052;
        Sun, 07 Sep 2025 22:08:01 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfbb87sm3407637e87.105.2025.09.07.22.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 22:08:00 -0700 (PDT)
Message-ID: <09dc1c16-00bb-4b37-8c98-b0463e35b36a@gmail.com>
Date: Mon, 8 Sep 2025 08:07:59 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Pop Ioan Daniel <pop.ioan-daniel@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756988028.git.mazziesaccount@gmail.com>
 <facc8b9255a754f767807b7e5c79c0eb20c680e4.1756988028.git.mazziesaccount@gmail.com>
 <aLmVzDB4bk-z5d16@smile.fi.intel.com>
 <796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
 <20250907121647.425fb8d1@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250907121647.425fb8d1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2025 14:16, Jonathan Cameron wrote:
> 
>>>> +/* ADC channels as named in the data-sheet */
>>>> +static const char * const bd79112_chan_names[] = {
>>>> +	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A",	/* 0 - 4 */
>>>> +	"AGIO5A", "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A",	/* 5 - 9 */
>>>> +	"AGIO10A", "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A",	/* 10 - 14 */
>>>> +	"AGIO15A", "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",	/* 15 - 19 */
>>>> +	"AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B", "AGIO8B",	/* 20 - 24 */
>>>> +	"AGIO9B", "AGIO10B", "AGIO11B", "AGIO12B", "AGIO13B",	/* 25 - 29 */
>>>> +	"AGIO14B", "AGIO15B",					/* 30 - 31 */
>>>
>>> O-o-key, but why not power-of-two per line (esp. taking into account
>>> the whole size)? (Whatever, it's not something I would fight for.)
>>
>> I just filled the rows to the maximum width, while keeping the item
>> count same for each row and adding the comment.
>>
>> I'm not really sure having 4 items / row, and adding one row more would
>> be much better, but not much worse either. I can do this if you think
>> it's better. (No need to even fight for that).
> 
> In this case I'd do it in 4s purely because then the B ones start on
> a new line and that looks nicer ;)

Ok.

>>
>>>> +};
>>>
>>> ...
>>>    
>>>> +	data->vref_mv = ret / 1000;
>>>
>>> Yeah, mV, (MICRO / MILLI) and other things I leave to other people to discuss.
>>
>> Thanks Andy. I've a feeling we were somewhat stuck on this discussion
>> anyways. I suppose it's nice to hear other's opinions if someone else
>> really cares. This was approaching bikeshedding.
>>
> I'll just throw a quick comment in here.
> 
> I'm absolutely in favour of the defines as they help in several ways.
> - Stop counting 0s when there are lots of them.

I do agree on this when there is more than 3 zeroes. Although, for 
example 100 * 1000 is still clear to me. 100 * MILLI is not quite as 
obvious (again, to me).

> - Provide information on the unit conversion not otherwise visible
>    where they happen to be used (often avoids need for local variables etc).

Speaking only on my behalf but I'd rather see the local variables 
instead of constructs like (MICRO / MILLI) - which does not really feel 
right to me.

> - Consistency across a code base.

This probably means much more to a subsystem maintainer than to me! :) 
I'd still claim that consistency could be also achieved by consistently 
using dividers like / 1000 :)

> In this particular case none apply strongly enough to force the issue.
> Even so I'd prefer the units.h macros are used for the consistency reason
> but I won't refuse to merge the driver over this.
> 
> One of those perfect (to me) being the enemy of good cases.
> 
> p.s. Matti, 3 versions in 4 days?  Perhaps slow down a little.

I should've indeed throttled sending the versions a bit. I just did 
fixes suggested by Andy/David immediately - and then I thought I could 
just do a decent change-log for reviewers, and send them while at it.

I didn't consider someone like You who will probably skim through all 
the versions and discussion. Sorry!

Thanks for the input!

Yours,
	-- Matti

