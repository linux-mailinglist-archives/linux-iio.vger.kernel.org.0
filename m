Return-Path: <linux-iio+bounces-22373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA613B1D31C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C255E174991
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E675233713;
	Thu,  7 Aug 2025 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPIF4UBG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358283FE7;
	Thu,  7 Aug 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550853; cv=none; b=Pm1eUerxRy7PZjmJrY+k98qZxD/NL13+ZVYPLLIhvnih2dS8L0GtvdCKBd5ks79UzsYJxQ5+gesvY/0Vc7Wns/li0bKOkDI5sR6ZX43C0IMDusJlTu152X2PE4ac0TywSIL96JJvFvvBvHD1Wd4Itq75cBKGFgV476GcUX9vy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550853; c=relaxed/simple;
	bh=3rWOqfJ9s4nsk42+0Lkf3fShUfgDtrdrHgjnMnJOx5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdSdOopNI/dZSCWROoZkH7A2ZdhtIH5xGA/ml9VOaBpBz4E/DvENTyqllP8CbYzO/v6fyCF8Qn5ogcFoiL8B4K3R15GIb19Y1hWYiD++3Km6wOcKNwo2vr38iOmKZcXtIq7QPldHkkePNhBpQzmdALIO7h5QtnmAofa8KmtOJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPIF4UBG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3323b99094fso5610411fa.0;
        Thu, 07 Aug 2025 00:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754550849; x=1755155649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNZ6B8Gr4WCNsBSx0OnMQeHirAX7DQf2f3C5knNNIbk=;
        b=aPIF4UBGm1lGAT8Z6SB8q6r6Xbakbpu2aQkjlTFwpXhbsKMOcRTv2ZUpUpRXelNvAg
         5M0vy+JBzD1T67lFWso+ZScey55O2siyS3uelzPB5k1W65Eo60HzpnTNQcRHLAW2F6zj
         ZY/27wwdTMHtgBs8RGA6OgldMzuOVhWG1X83reBmdIfwVWRc+6Dlhm6L/UoawW/F1uDc
         oSXmBNK3M7wVsDLAWn5gqICd5p1X53MsdJ0oGk36L7E6CNT1+DEi2k8PCMsHtRSz6uqp
         ku/4NH6MaUY5dFBg7kObesbY9dsxULRAjsz6IAQ8lrZdxX1SGOibq9v9CL5YSy7d4/TE
         o0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754550849; x=1755155649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNZ6B8Gr4WCNsBSx0OnMQeHirAX7DQf2f3C5knNNIbk=;
        b=DC7EOUWozPMugjuSvFwHyuQpuCH/APiNVloipJX4FzW/Oh5S+/2JKmksrp1n2VYKGy
         ClZ7XlVg0bkeiuZ7kdM5RmfYIlWk5imDEPlsgjk/UiRcSVa+ib+zS5b8PZja6Kj/k04a
         RiCXYp5l634FrZmvUWo2uSGkFhOiC4j04ynt6hRdA74qaqODHyZmo1MWXfG+G/pXITjS
         sa7oG1bOX4P+uKr0QPBJ4GIfyWhNXwLak7CHmjcN22vYvgK5I+kTvJpytljlkQJjVzqQ
         z+bRDVpAWzCjT7IRd+mHI746n89AbFVfPwKKoLitZkv6c8dZ/Kp0CnzBUXvPiakP0E7K
         5HMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXBE8YsaVTRMz5XTuS61I1oFykskkJJIFOq1eHMI1dIHAk0dFTgdXX5iKPbNwichOfhy4oS+dYkFgo/LL6@vger.kernel.org, AJvYcCXOnUM8T+11BWrgYgst4Y88SbKn1+4NWu9612s0TLiZa2z1ukkAzclAYdCvhO3n36vcRyQvDTFMqYzU@vger.kernel.org, AJvYcCXgMyIp9DlPYiwa/6XtoXh9fnZfzl/4PhWSQN6V7nuO/EH7qyDftLrMwiU/fhYcwlnc6xqUJrFzeLxX@vger.kernel.org
X-Gm-Message-State: AOJu0YwXymGgJHgrubCNBeiCwRD0AsX7LKVliguBfyiPbdma5lqWvtz0
	o5vu4kBIyWz7Wy6fX8omPmo4XATJxYkfJmg0AGFRIjeOoVW4wqGsXh3W
X-Gm-Gg: ASbGnct8uTISXKyxck1AjccAeoRq625mohdTDc3rOnd3b7Dt19TIjch9Qi5900uP4xd
	fDQDd0DYL+VuZsinbYy9NdVz7DPEt3Qj/1zaEe8FuuZDuZOfapVgKXMNzK8804lfEL4faTgvXS1
	57aJyRp3mmK3abiZeYiVc9Uy6sWwCT19y+fOyjchCeRqkbgRzbIk3OdfdEdQEziy7AY32RzIWLZ
	5iIXltXkg6TJgFHGFHTQIs8wlWXcmovMiO+Rwu3b/hM8rsO+C2wj4Z+Or6ya4+hjI8iPox26b60
	USSL24Y0pKez4RCpkTWrZEG0vkuA+lXuPXzHmUXkLiFjVnYbbvjKuZDRdLfzh2Q+rg1RfiFd+H+
	+bBMm3bL0tMgYWbD2TVys764IIybnNL5ayZMVcZIbLjxgkdnwosxZVV7mS1P615yMHlcjrsDeQN
	5HZ8I=
X-Google-Smtp-Source: AGHT+IE+pO/21lxZBTuhD0vk4BsBusTBvO4EhD2FklE39MLJ5EoSnynwVxKXC86d216G9BaGwQ8wvg==
X-Received: by 2002:a05:651c:4093:b0:32a:6a85:f294 with SMTP id 38308e7fff4ca-33381432df4mr9870821fa.35.1754550848874;
        Thu, 07 Aug 2025 00:14:08 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33281ad09e9sm7449301fa.63.2025.08.07.00.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 00:14:08 -0700 (PDT)
Message-ID: <cd85d510-b4f3-4e01-b1c2-de84204c5892@gmail.com>
Date: Thu, 7 Aug 2025 10:14:07 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] dt-bindings: iio: adc: ad7476: Add ROHM bd79105
To: David Lechner <dlechner@baylibre.com>,
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
 <d37371a8-4a03-4893-a6bc-48b7f367c916@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <d37371a8-4a03-4893-a6bc-48b7f367c916@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2025 18:15, David Lechner wrote:
> On 8/6/25 2:04 AM, Matti Vaittinen wrote:
>> The ROHM BD79105 is a simple, 16-bit, 1-channel ADC with a 'CONVSTART'
>> pin used to start the ADC conversion. Other than the 'CONVSTART', there
>> are 3 supply pins (one used as a reference), analog inputs, ground and
>> communication pins. It's worth noting that the pin somewhat confusingly
>> labeled as 'DIN', is a pin which should be used as a chip-select. The IC
>> does not have any writable registers.
>>
>> The device is designed so that the output pin can, in addition to
>> outputting the data, be used as a 'data-ready'-IRQ. This, however, would
>> require the IRQ to be masked from host side for the duration of the data
>> reads - and it wouldn't also work when the SPI is shared. (As access to
>> the other SPI devices would cause data line changes to be detected as
>> IRQs - and the BD79105 provides no means to detect if it has generated
>> an IRQ).
>>
>> Hence the device-tree does not contain any IRQ properties.
> 
> There are lots of other ADC chips that have a ready signal like this
> and we've made them work.

Ah. I had no idea. Thanks for the insight!

> Since devicetree bindings should be as
> complete as possible even if the driver doesn't use all of the
> features, I think we should be including the interrupt in the binding.

After what you wrote above, I do agree. There may be systems where the 
IRQ is usable, so dt should have it even if the Linux driver never used it.

> We have also found that some interrupt controllers won't work
> as you have suggested and in that case we also needed a ready-gpios
> to be able to read the state of the pin.

Oh. My thinking was just hard-coding the conversion-time delay, but this 
can indeed make sense - especially if there are other examples :)

Thanks a lot for the insight!

Yours,
	-- Matti


