Return-Path: <linux-iio+bounces-171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B54B7F082C
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 18:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2981C208A5
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF014AA8;
	Sun, 19 Nov 2023 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixQBB7wC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B3511D;
	Sun, 19 Nov 2023 09:40:20 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so162406366b.1;
        Sun, 19 Nov 2023 09:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700415619; x=1701020419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9Hteg4XMK0Hthf2Z6YUi6WL0kiCnYnKAdT14d+QRy8=;
        b=ixQBB7wCZJ8mrDG9P8cX3x5uuAt4larH9Rimg2hTttSG4vzZy2bqWxqds/0FMbve0n
         PiD6R7NVStGBE0Km2Q89xX0aRMzDjV5v/MJ9aBEk0Gvva/DKySfXDbQh4e3/bhjaeNbW
         WC+L9UaUxNro9a+K44s7on2q5i9wYGG+QCE9zGJgIS+bWUuroKEusZJxjnrXlC/sV5KL
         9wTq7udsfybyX3XhvpjYwrzl05WsNrE6wMsrhl0Kd6pRDuJXm7iK/zUQGf5SrZe7ug5O
         nTtLtAUeBVBija4ExiUaRXH2v5au45TWY6qGQtA+jOdeWeDfRJ6lNsKy/ypc3spu6jLm
         hZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415619; x=1701020419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9Hteg4XMK0Hthf2Z6YUi6WL0kiCnYnKAdT14d+QRy8=;
        b=MNQR7WCo+u5m37/hcqu2sRQ8+w+ikJcAfPgHuA15ITTtCR4DkgyI6Nup9vWOlnRjer
         A+nM5PETlsxOqFyv2OciHULPpyBX0JTZNG2czguZq7qtwBivE/vBfS7PL+tTKUN6lgZe
         SW1molhFn8LoGrlKUrpRLyx/eetLmsVGrx1C1VIcmMrukgfc/x1BRyilEBpaETxZ3Hia
         3+z0H3Ie0in5nKyaCap7mqq4bomwsM2bjsg2l26yqhjm5Vg1KSxoXlw6SnhOHzMYTIL5
         jGzjahq8TrCo/gNleO/MO5DBNmjRpVFNO6BjKiH3L9lv9dY4BAIy/q9HQdOoHauzDGC/
         8euQ==
X-Gm-Message-State: AOJu0YyajKZZQLksz3QgRNDDFR+Hx6h0Z1tf3xKEcb/TrRit5UJEKU1+
	98Dq3PoALgysIVhztGHTF909973mHPfsaw==
X-Google-Smtp-Source: AGHT+IHxkCcm1/ToZyIbojFo4fZZpb75XeQ3QjFH14Aghgv4d/B1c/UnXHjMoAal1El4IPtreQhnnQ==
X-Received: by 2002:a17:907:a683:b0:9e7:3af8:1fcd with SMTP id vv3-20020a170907a68300b009e73af81fcdmr5413082ejc.76.1700415618858;
        Sun, 19 Nov 2023 09:40:18 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:d0f6:1482:ec53:c448? (2a02-8389-41cf-e200-d0f6-1482-ec53-c448.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d0f6:1482:ec53:c448])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906709300b009e5eaf7a9b6sm3045266ejk.139.2023.11.19.09.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 09:40:18 -0800 (PST)
Message-ID: <588dd3f4-bea5-4453-9ef6-f92fb42c7514@gmail.com>
Date: Sun, 19 Nov 2023 18:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: light: add VEML6075 UVA and UVB light sensor
 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
 <20231110-veml6075-v1-1-354b3245e14a@gmail.com>
 <20231119150233.10fdc66e@jic23-huawei>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20231119150233.10fdc66e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.11.23 16:02, Jonathan Cameron wrote:
>> +
>> +struct veml6075_data {
>> +	struct i2c_client *client;
>> +	struct regmap *regmap;
>> +	struct mutex lock; /* register access lock */
> 
> regmap provides register locking as typically does the bus lock, so good to
> say exactly what you mean here.  Is there a Read Modify Write cycle you need
> to protect for instance, or consistency across multiple register accesses?
> 
What I want to avoid with this lock is an access to the measurement
trigger or an integration time modification from different places while
there is a measurement reading going on. "register access lock" is
probably not the best name I could have chosen though.

I was not aware of that guard(mutex) mechanism. I guess it is new
because only one driver uses it in the iio subsystem (up to v6.7-rc1).
I will have a look at it.
>> +};
> 
>> +
>> +static const struct iio_chan_spec veml6075_channels[] = {
>> +	{
>> +		.type = IIO_INTENSITY,
>> +		.channel = CH_UVA,
>> +		.modified = 1,
>> +		.channel2 = IIO_MOD_LIGHT_UV,
>> +		.extend_name = "UVA",
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +			BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
>> +	},
>> +	{
>> +		.type = IIO_INTENSITY,
>> +		.channel = CH_UVB,
>> +		.modified = 1,
>> +		.channel2 = IIO_MOD_LIGHT_UV,
>> +		.extend_name = "UVB",
> 
> Extent name is very rarely used any more.  It's a horrible userspace interface
> and an old design mistake. 
> Instead we use the channel label infrastructure.  Provide the read_label()
> callback to use that instead.
> 
> I'm not sure this is a great solution here though.  For some similar cases
> such as visible light colours we've just added additional modifiers, but that
> doesn't really scale to lots of sensitive ranges.
> 
> One thing we have talked about in the past, but I don't think we have done in
> a driver yet, is to provide actual characteristics of the sensitivity graph.
> Perhaps just a wavelength of maximum sensitivity?
> 
> Visible light sensors often have hideous sensitivity curves, including sometimes
> have multiple peaks, but in this case they look pretty good.
> Do you think such an ABI would be more useful than A, B labelling?
> 
My first idea was adding new modifiers because I saw that
IIO_MOD_LIGHT_UV and IIO_MOD_LIGHT_DUV coexist, but then I thought _UVA
and _UVB might not be used very often (wrong assumption?) and opted for
a local solution with extended names. But any cleaner solution would be
welcome because the label attributes are redundant.

Maybe adding UV-A, UV-B and UV-C modifiers is not a big deal as these
are fairly common bands. Actually DUV is pretty much UV-C and could be
left as it is.

This sensor has a single peak per channel, but I do not know how I would
provide that information to the core if that is better than adding UVA
and UVB bands. Would that add attributes to sysfs for the wavelengths or
extend the channel name? In that case two new modifiers might be a
better  and more obvious solution.
> Jonathan
> 
> 
I will work on the other issues you pointed out. Thanks a lot for your
review.

Best regards,
Javier Carrasco

