Return-Path: <linux-iio+bounces-22336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A121B1C87F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704F0175BC4
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93D21D5BF;
	Wed,  6 Aug 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y1bilnj0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0B28FAB5
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493315; cv=none; b=UGkoT6zsrMCGPfUxiE44WmJFHGTJ6IAx/HjNyCeccGlPGARRDfTzlQovM9iitZAfkyFCsdPzAdHO3UtCc49izY+TATpt9gQPc9ZKf0+KAd3OERC87e1On1u2qUbLrHg2wUKeqAtJhRT33VyYtOXy1NOPtWsrqrOIeMdzLcHcqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493315; c=relaxed/simple;
	bh=4jBazG5zYk2rS+2cf/v/0ufmFOcZH62LVA+dp+dr8mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifUK4ztDn1I4+cCbyqKBQz4TIE8WnIiN+20h9f4byVdSXvS4k5X2wkycspeQmgZyHWEJCbtthDo/LJIpNCACGYG/G+hEpMb+NGf9f/OlmFS31yuoUw7pRXc3gj665olmBJNcMVceo6CbSEp7fUiY2reLvvfONazN+6XTwgz7ORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y1bilnj0; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-741a5e8fa94so14458a34.2
        for <linux-iio@vger.kernel.org>; Wed, 06 Aug 2025 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754493312; x=1755098112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwjt9aIF2ZwUy5PzdCx1sYJ/afXlRKHayAs+g7h+FzM=;
        b=y1bilnj0Fr/M/rRmUkj7GhgVlu8eq1IYY8V8i6+Z7vkPsBkzy1/C0xm7PimnBcl11l
         jw7b+qdcpN7QH13Ib2Rl7WebpZwRrozmOyMwisMuYx+E+sgcjBBCjF7KXjJzrqn4FV5w
         zsR8SQApKHejsX9OHXgYk1ZK3TJNE322dEgVcwPEMI9dQSzI+QCi909SUIDHFD+Mypyc
         o0ZX3yFlEyFJ/LmiGZdZ0CHhMaZ9Ax6fewUt7WxbmyIDVfz8B22om0pOdJP8o4caAhzC
         XrIRGUH4ltIvCdwlLmyY2fu14uDJgsKOWcdjbOgrsft59peKaKwhvfPqUGXNUkMfqREP
         C2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493312; x=1755098112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwjt9aIF2ZwUy5PzdCx1sYJ/afXlRKHayAs+g7h+FzM=;
        b=KfqnYoH3ei5HYKHmjy3SpvrQkjypOI9L8sAeljjUgLUwwh+HOFfbq84JtC4ZpQwkhD
         GkfkV1JPVzDGwGDPzuBqTaBGzVLqB94cdYTDx+EegRMhHLXHspzdGZQy6fsdBQs8+iVX
         zGsx3OEwHt/1KjuIxa9ohvEThvNw+/92H9RvUiq+YnXoDsujuMWRkQ6dKECKBpu2HA7k
         i8LOrW0iCBGLy5GYEqHWg1SofWk11nU5V0vonQarqyjmYGlvjwEKbwz7LDtlBwWhwneG
         51hTxAeOIdSdkzFbJJLBXRfM0mmB4GpFza2r5LQKeFfCPIwJJ30PThMB+ZmhPibzKWLt
         4kTA==
X-Forwarded-Encrypted: i=1; AJvYcCV38WBdXR2H+gJxxACGxT2If3ZAlQuKK8kHssmLBJrbM7kMkKS+ZWmJUkdyGWMsQVV1d0dWleOnGrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqum7bAgET1CtH+tqiE61PmoUe9+pjsWT0S7rgByGPJePshMtM
	Cvakd8PB+6RVYccE45cS+DJzL7jz0AfJcYN/gAJkE5nGUDgU9Q/BRd4JaonIplAvknI=
X-Gm-Gg: ASbGnct766tH+aDJgAddlnL2y4qEHESv701HUZeFWwMz5r+Ab4jk9mCEdWnMyGIwMHn
	y2wDROEGVDYkipcS0+DkDpT2QxiQIVdk8qQOaPQUdHuPCZg3CtnxZ+KB6REaM7bbILZEu5h5xIN
	0RLelTeMQ+zEb+LKY2zjmkgi/IueFDp2XHi8bl1Kv9urBBVZrvXfC32f0Ij7O6c5i2bpwZHsN12
	0MGlOlJlyIKxM/XjAb/ilRbcXn8XlQ3O//tfM2NDHfdDI7UGHiyER7WnPEPp7Fwprk9zydg3W7B
	MTj+dtwc7H0T0R4KO17npGQ6LY9fE0cbO1Qsae3xtr/lIY/tYYAXn0rtXjOLS90oc1p/lV7lDC7
	bpKRbfJfjeomuBMfdOcfVI+MjMhHaql1tGLAJMko7DNTRgh6m4NFNRxmMLJezAFrI17ShvFIidC
	o=
X-Google-Smtp-Source: AGHT+IGCESCBCXrWJZWUhhFLLtiv++FNPRq4nMWQZi2pwIQ9FHPV1Mrzbz1pksW3SKTGn1YPFjak+g==
X-Received: by 2002:a05:6830:2a0c:b0:741:b263:4ded with SMTP id 46e09a7af769-74308eb9546mr2175713a34.15.1754493312449;
        Wed, 06 Aug 2025 08:15:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-741abaa74c0sm2163802a34.3.2025.08.06.08.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:15:11 -0700 (PDT)
Message-ID: <d37371a8-4a03-4893-a6bc-48b7f367c916@baylibre.com>
Date: Wed, 6 Aug 2025 10:15:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] dt-bindings: iio: adc: ad7476: Add ROHM bd79105
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <3066337cb183afa5f53a4e6cf94ce15a36d14ec8.1754463393.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3066337cb183afa5f53a4e6cf94ce15a36d14ec8.1754463393.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 2:04 AM, Matti Vaittinen wrote:
> The ROHM BD79105 is a simple, 16-bit, 1-channel ADC with a 'CONVSTART'
> pin used to start the ADC conversion. Other than the 'CONVSTART', there
> are 3 supply pins (one used as a reference), analog inputs, ground and
> communication pins. It's worth noting that the pin somewhat confusingly
> labeled as 'DIN', is a pin which should be used as a chip-select. The IC
> does not have any writable registers.
> 
> The device is designed so that the output pin can, in addition to
> outputting the data, be used as a 'data-ready'-IRQ. This, however, would
> require the IRQ to be masked from host side for the duration of the data
> reads - and it wouldn't also work when the SPI is shared. (As access to
> the other SPI devices would cause data line changes to be detected as
> IRQs - and the BD79105 provides no means to detect if it has generated
> an IRQ).
> 
> Hence the device-tree does not contain any IRQ properties.

There are lots of other ADC chips that have a ready signal like this
and we've made them work. Since devicetree bindings should be as
complete as possible even if the driver doesn't use all of the
features, I think we should be including the interrupt in the binding.
We have also found that some interrupt controllers won't work
as you have suggested and in that case we also needed a ready-gpios
to be able to read the state of the pin.


