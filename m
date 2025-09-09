Return-Path: <linux-iio+bounces-23907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7501BB50268
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE325E182C
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3EF350D69;
	Tue,  9 Sep 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvYiNVeX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AE342C9E
	for <linux-iio@vger.kernel.org>; Tue,  9 Sep 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434925; cv=none; b=OuE35uPZpo1JuwS5Apl5fk4SUyiQJSaH+6OGNPBLNJO5zL9PRBwkxxRTY8d8w/NVaW+h25+frf7nAjdwMB/7um9is10cy/84+mMIppwOgQbdpSAg4+vZKF+UTclnSZ+3VU68h9Eufs1CdXoKQMjkiB2hjx8B1YtEy+AQerE9i4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434925; c=relaxed/simple;
	bh=5NEls3RautMWjf7fmx/h17K5+vxU6Xp1Jd5Y5X7kUVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mo8ww8tRcQMlA91xEWjNh0aN4FoxnE/UQep7GA7uV7dRvwWPNL179S1hV51zg75DSELqSDJd4P1WzMRjLDAzbkQyBLb7ukEBj5nnMb5h31bqFwWB50/Tm13PHXG6hC6KC5piK1jNWgosN+33c0ddxw08GfS93gXex1g/RGZq4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvYiNVeX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e751508f15so763104f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Sep 2025 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757434922; x=1758039722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vB6vel85xH/3moH+g+uQmnmcTAMVpwBdAUJ6dS/hQ0o=;
        b=gvYiNVeXu5uADjRR2MmJUy2uI7e67WSccTi1Du44hF35vPy7XCSVviAZo/mkAjcnbN
         6OO3DlHVM+E0sETda7750zlnF/LuUxVUOLkBrGHNow1wx1lE/upMMRrUwkTg31YeBq4V
         s7sFWc5w6/Fto3I4nowgBiNBMv2huw3KzDJ3Bmr7j8HEZWclBHU2M4zu6htP/3sI5Bd6
         Zpw+BbCFnEoQU9xPH56SvtGiJABw1HUi65+Zn/u5bf9L9PLWBDvqIcrAFLkb5NILhiz3
         ABvYqbWUG50QXS1ZlpSiUlvjV5AQYCHBpWHDB4C2SU4ys0M66qOOyAY6jwrfdnrxNQKJ
         Y8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434922; x=1758039722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vB6vel85xH/3moH+g+uQmnmcTAMVpwBdAUJ6dS/hQ0o=;
        b=DfxyIk8P8sc6ryGXw7R4sqi/WY0GiCb1GquXGssU6Ec+Gx7Naig9N3opka4ctnsAD5
         IV8/o2J46j0BCllkQABfOc/vMuDhSd6eK3jpK6yoGUCfbQnjpoM/LOrkPQtPayLpUVzD
         ibCwRD1AiZ0zcRVCLz7lo4jDXgSeQYTBr4ClKIWVBVyXdp5faldfOb+jPFSDvd91J76d
         /n4pHSz1ydUohk2UCvBi+ujcTLh+GnlRwMC6SljVENjD/YmyikGEv2qW1HTU2kkmv8y8
         mem5BipefAy2XAYDv/C7QcctAVDN/NODs/1yKUl/Z8dtke6T/deGJ0Bd+uVHc0JYUULp
         GAdg==
X-Gm-Message-State: AOJu0YwfnXfML1+7ltKIqEIE+1q9TAw2uVCClC5Dtk3Re8U4krepxVoV
	WW3V7UCvx1qB6VNooitCrvoiNDcuv14HvemECcN4o4MUbXOi5E5P8irRISBzqk4e6F8=
X-Gm-Gg: ASbGnctydrOPC1dMIZAvdjVk3ZsJgVvGxUweUBw43DTGER4k6wiWoNrd4NKA3KeOOhS
	1yJDHLmJvJk0cVrJeuSewOjxc+o7C6WFFHastaZtfnGqF+JdcccfkeeSO5DQdKCaRZxeLH6rtC/
	TRkdXIlQi+q8c2eKMYAJbXbs2rInl30wze82INhIfK5tZUL4t3g0O1qMLvrUUaY2mH4+bKDL1uu
	8AZZFk4AyuhyPBajY7EltlMKKV55PXsPpG9klA9dLI6lfais2tVv2MO4YKOJSahpqIlejDF6chV
	tnmiHejmcjTvOJ13H3d6PzceHu2gx51E50P1yU0+jbxvIEuQnC20VciX1XEcHNtbhhAl8SMunYe
	YgrDnvo38+0GBZ2ygZaM6VNb5H5Qu034kEYaMyOi2oDFcnoa8sRctM0YcaevJ+52ZTsxW5888PR
	7sDw==
X-Google-Smtp-Source: AGHT+IHGjEvpUk4kRe6tL0aUTwHSNc54ByX9LFjKz57zJu5HMFNymvEeL6UiPy8a+Af/hD4XTZIDpg==
X-Received: by 2002:a05:6000:2c0c:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-3e746bffe2dmr8337138f8f.44.1757434921854;
        Tue, 09 Sep 2025 09:22:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:545e:637a:28a6:9ede? ([2a05:6e02:1041:c10:545e:637a:28a6:9ede])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45df65e79desm3405345e9.2.2025.09.09.09.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 09:22:01 -0700 (PDT)
Message-ID: <222acc86-c405-4e05-ac8c-520ba81ef0a0@linaro.org>
Date: Tue, 9 Sep 2025 18:22:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 David Lechner <dlechner@baylibre.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
 <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
 <6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
 <23b80d52-6149-483b-a159-276dd00d12cd@linaro.org>
 <e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
 <fd4c81a5-3b99-448c-92d4-9465f0e76db3@linaro.org>
 <c23ed0cf-8188-49ac-b310-57bbfb54f337@baylibre.com>
 <c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/09/2025 11:29, Nuno Sá wrote:
> Hi *Daniel* (sorry for that :)),
> 
> On Mon, 2025-09-08 at 08:58 -0500, David Lechner wrote:
>> On 9/8/25 7:16 AM, Daniel Lezcano wrote:
>>> On 05/09/2025 23:54, David Lechner wrote:
>>>> On 9/5/25 3:58 PM, Daniel Lezcano wrote:
>>>>> On 05/09/2025 17:25, David Lechner wrote:
>>>>>> On 9/5/25 4:44 AM, Daniel Lezcano wrote:
>>>>>>> On 04/09/2025 19:49, David Lechner wrote:
>>>>>>>> On 9/4/25 12:40 PM, Daniel Lezcano wrote:
>>>>>
>>>>> [ ... ]

[ ... ]

>> Unfortunately, not really. Until the last few years, there wasn't really
>> any users of these APIs. I added devm_iio_dmaengine_buffer_setup_with_handle()
>> for the SPI offloading work I did recently. The only reason it had to be
>> added is because we needed to get the DMA handle from a different devicetree
>> node from the ADC's node. Since this device has dmas and dma-names in
>> the devicetree, then if devm_iio_dmaengine_buffer_setup[_ext]() doesn't work
>> with that, then it might have other problems (assumptions made for a specific
>> use case) than just not calling dma_slave_config().
>>
>> I think maybe Nuno and certainly I are guilty of trying to offer you advice
>> without looking deeply enough into what you already submitted. :-/
>>
> 
> Yes, I pretty much just asked for (at least) some discussion about this and see
> if we could use what we already have in IIO.
> 
>> I see now that what you are doing with the DMA looks more like other SoC ADCs
>> (AT91/STM32/AM335x) which is quite different from how the iio_dmaengine_buffer
>> stuff works, e.g. cyclic vs. not. So unless you are interested in evolving
> 
> Supporting cyclic should be fairly easy (Paul left it almost prepared for it)
> and do I have some patches already. I'm just waiting on having something
> accepted on the ADI DMA IP driver (dmaengine) before sending the IIO patches I
> already have.
> 
>> the iio_dmaengine_buffer code to be more general to handle this case as well,
>> it might not be the right tool for the job currently.
> 
> I think for the STM (IIRC) case they "open" coded it because the IIO DMA support
> we had at the time (if any) was more "rudimentary" - (no real zero copy
> interface with userspace for example). But yeah, it seems there are some gaps
> for your usecase so as David said, you would need to be interested in evolving
> the IIO DMA API to accommodate your needs. Again, if nicely integrated you would
> gain some nice "improvements" in performance (not having to use the fileio
> interface for reading the buffers) for "free".
> 
> As for dma_slave_config(), you're right and we have no usecase needing that
> setup and TBH, I did not looked or have any idea (atm) on how to do it. That
> said, I'll be here to help and contribute if you decide to try and follow the
> IIO DMA buffer API.

I would be glad to help improving the IIO DMA but I don't have enough 
bandwidth ATM. I was hoping to get this driver merged for v6.18 which is 
the next LTS AFAICT. Is it something possible by taking into account all 
the comments without improving the DMA code ?

Do you have a pointer to Paul's series and the patches you mentioned 
above ? I can give a try when having some spare time



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

