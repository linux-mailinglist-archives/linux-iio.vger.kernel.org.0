Return-Path: <linux-iio+bounces-352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94767F8C50
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4378FB2106B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA8E2942E;
	Sat, 25 Nov 2023 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaHFe7G/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C571EA;
	Sat, 25 Nov 2023 08:17:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so413983466b.3;
        Sat, 25 Nov 2023 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700929030; x=1701533830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxAFuoH6q+b3E7KE6lTOQk4oIEsxkT+mBon/AmAe0l4=;
        b=OaHFe7G/ftcVRuAAYV0BCCFl2ZMEGjQ2Mj21CZurVQw4rprYAPR+T+Gpr6D4MAzVK6
         4bVJasYdmvH90K3nX8MQPbUSAv6aK7EVzO52Od9YJxIcdQXtVHlqUPZMuGGsLuNp1jYM
         De2N7vkO2TE+d8oPnaAOawiBJ/O+qy+F8lOEQm+05OjkRnlbJnHc5nKzV0FoRu20n+rU
         0rx8G2/ECgK2pMI74wVWd9JQNMsYR12h85zRnqhi0DS6Y1TXl1KyeTdP61RKhLw+7bLU
         pGqkSJZ4U5ge6pkNWUnhOBhF0BaEkiDl/qaZMxGj/0QaAHUzKgUyL8FSM9WvfyjTkC3O
         kdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700929030; x=1701533830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxAFuoH6q+b3E7KE6lTOQk4oIEsxkT+mBon/AmAe0l4=;
        b=hmuO4SuW+e0CvpdBAh0chxDfquX0qktsaD7BfhrmFQzkKwt+XG7OnVm31rjEZ/gUdC
         YTRe9K1dhTy9WsVPEiIhPNPwzB4jGHeb/Foea03S/TIZu/N9rjSvaqtAOjWX9be7drE3
         Iy+TaGFrF+jm5Rkq9JB1PmMqNas5AAcrxiVzeAze37empq3q1+qwsiZOjfbYtU913nu+
         //COEHKr2yec8IpcwvQaYUr91Tn6/fMKU843qmuCeTbDE8ASHSXx71dwV2XcHXA2t3m0
         74dnnqBGRD/qCACVd34C7Np6PmsRx+WagRn7QIaQ5zL2Mkgc6rc5SjUIlSWWZsVCbdyl
         brQg==
X-Gm-Message-State: AOJu0YzJIZ6IGQWy5ATOD3NIWV2K28/lqcjaIL8MpRyLWpN3kLNxjQ+K
	fgWIQG97rF+3XGrQKdwX/sY=
X-Google-Smtp-Source: AGHT+IHr8EGcpfAJfVpHWeH78RPSXIcNJn7c11bxHZBqpyZXSitqxAs9MvB4dHf6iDZdikRe+lhV8w==
X-Received: by 2002:a17:907:d407:b0:9d0:51d4:4d87 with SMTP id vi7-20020a170907d40700b009d051d44d87mr5934216ejc.62.1700929029242;
        Sat, 25 Nov 2023 08:17:09 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:af1a:8ac9:af5a:a70d? (2a02-8389-41cf-e200-af1a-8ac9-af5a-a70d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:af1a:8ac9:af5a:a70d])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b009fd727116b4sm3635839eji.129.2023.11.25.08.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 08:17:08 -0800 (PST)
Message-ID: <659d5d74-4861-45c4-8b95-218f3a7e60cf@gmail.com>
Date: Sat, 25 Nov 2023 17:17:06 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iio: light: add VEML6075 UVA and UVB light sensor
 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
 <20231110-veml6075-v2-3-d04efbc8bf51@gmail.com>
 <20231125151116.6d9b6e46@jic23-huawei>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20231125151116.6d9b6e46@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.11.23 16:11, Jonathan Cameron wrote:
> On Sat, 25 Nov 2023 12:56:57 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The Vishay VEMl6075 is a low power, 16-bit resolution UVA and UVB
>> light sensor with I2C interface and noise compensation (visible and
>> infrarred).
>>
>> Every UV channel generates an output signal measured in counts per
>> integration period, where the integration time is configurable.
>>
>> This driver adds support for both UV channels and the ultraviolet
>> index (UVI) inferred from them according to the device application note
>> with open-air (no teflon) coefficients.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Hi Javier,
> 
> A few more minor things. Looks good in general.
> 
> Jonathan
> 
>> +struct veml6075_data {
>> +	struct i2c_client *client;
>> +	struct regmap *regmap;
>> +	struct mutex lock; /* integration time/measurement trigger lock */
> 
> Could perhaps be clearer. Maybe something like
> 	/* Prevent integration time changing during a measurement */
> 
It prevents integration time changing as well as measurement triggers
while a measurement is underway. I just wanted to cover both usages with
a short comment in the same line.
>> +
>> +static int veml6075_uva_comp(int raw_uva, int comp1, int comp2)
>> +{
>> +	int comp1a_c, comp2a_c, uva_comp;
>> +
>> +	comp1a_c = (comp1 * VEML6075_A_COEF) / 1000U;
>> +	comp2a_c = (comp2 * VEML6075_B_COEF) / 1000U;
>> +	uva_comp = raw_uva - comp1a_c - comp2a_c;
>> +
>> +	return clamp_val(uva_comp, 0, U16_MAX);
>> +}
>> +
>> +static int veml6075_uvb_comp(int raw_uvb, int comp1, int comp2)
>> +{
>> +	int comp1b_c, comp2b_c, uvb_comp;
>> +
>> +	comp1b_c = (comp1 * VEML6075_C_COEF) / 1000U;
> 
> Any of units.h appropriate here?  I'm not sure if the / 1000U is a units
> thing or not.
> 
These divisions are used to scale the coefficients down, as they are
defined as entire numbers. These coefficients have no units and the
resulting value is a count.

I have nothing to add to the rest of your comments. I will start working
on v3.

Thanks again for your thorough review.

Best regards,
Javier Carrasco

