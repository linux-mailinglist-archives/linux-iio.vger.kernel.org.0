Return-Path: <linux-iio+bounces-7583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A969304EA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CB02810BA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA456477;
	Sat, 13 Jul 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uO1EAZX3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A045FDA5
	for <linux-iio@vger.kernel.org>; Sat, 13 Jul 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865501; cv=none; b=SGX230qZWcyzzvt3Rx4Gr/PcVsCNS+TUnxamHrL73pDWnI6NblCgNupRiGzAYgZDyDLAEmk2V/M3Vkg7YMJFzaiXJkeBpXtN67ZXvq8QbTwSqCmiimO38IxHM5qRUuCExKPqCOBvO4SPp7/n5+07rinIWZjeos76KsHQZuj6YYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865501; c=relaxed/simple;
	bh=Esx07aahuZTF0j5O8sgpvF030nS1UUqRl0pRVrhReyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdKbHxysm5n/nPFvHlihwLPSBt/0Di51ncFOIMmJogoDLIrP+dZond8xYEI0mJglutl+ezAgKcGChSqoUYtNA3Hvs1R0loVHddVDvxD7LOOPEB5xO0j2/7UG47DKdbMn7Znh5P4qBzLKiYvc5euWNSPctvdsoAnKGJBcdMzgVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uO1EAZX3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367a3d1a378so2370427f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Jul 2024 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720865498; x=1721470298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WVAGkBMmgy90IHIh2pfVhQYyClf4L1Y0FnHpczrA2io=;
        b=uO1EAZX30hhyw5dL9u+6a3qCN44OMZMEkYVGhPLRJ9CKqt76j0rvTrtu4XHlSXQOC9
         BKo3A+rXdYcIXKjdRxzYjUCfWrfog2LGXZou+WHtcndVaoDw4DvlgRYIgTXdMPvpMRmC
         io+9cdU5e8aoz/W90YFoGs/wdfkx9CrhlxiI0zGigK6pJozNroGCq//Eq8jTUkfh+OZY
         LhcT0W3JHZ7zaxeCwrcUsppPNY3t5ZohjZ4hu7cUvjiytbrbW8UQQ04AIBouue+SBwAF
         O+pp8yhBUDslalDc5vkwYFOp4Asj/yFyp1T+Qzr3YOiN5zP2Ul1nYx6M59MMjj3RLFko
         Tkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720865498; x=1721470298;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVAGkBMmgy90IHIh2pfVhQYyClf4L1Y0FnHpczrA2io=;
        b=qirMglNbtZe6TenwWpCpdbx0sSgL+rsdauV/7heKf06WcDwUftx6VGzX/tsXi9acNQ
         E29FvmAkITf3E5XcQ1ge6r6SGYPgK2CIlvRL6RIs2oV6Yy/Nyv+vKvVkxrEs8C7AbkBt
         /RVyUOSOrYh5HJz9F6sP/M3uT81k8T+XJzR4XoUA6x4nQs3h2tNwQ9/TYUt7ei1qL1bC
         q31WJBjJJuF4PYEZHByfdgLJ9YC/5W4XtgINhmedldqyxLmolg4H7ZjfiCEtq0Dmfhpe
         80Qm9qLpxEC0uYVk3SvrIEhqMCjfyug9VllnNJeR801NIaC79h3qgutTmUU2NOC7wQib
         Akhg==
X-Forwarded-Encrypted: i=1; AJvYcCUxbzUZ1qwMhxW6oaQGySg+ZX6zFPAJUhd3fmm19vn5AAWVRCE0SHrJ4ehli4MMluGHZZGq1DLEsTe8lNTZsk5IYV5uh4GnJyWG
X-Gm-Message-State: AOJu0YyUwXLMJFC/7ADALhWQV5oPP47/xtfxowsk0DCRGMJ/AX7FgJ/I
	lleVFvKxi0O9H6tN6ZtA/je7oVqKDYMRcdIVZrriuFHQ74LBMPCyIKXPRKjCjNM=
X-Google-Smtp-Source: AGHT+IEcyX6hLdTLWaXSVs9p1snGMg/hbLRZD4POxRyYXIu9saQeIVCgk36RkDCPiAUz/6Foidcipw==
X-Received: by 2002:adf:a38b:0:b0:367:89e6:e28c with SMTP id ffacd0b85a97d-367cea67d63mr11249206f8f.17.1720865497796;
        Sat, 13 Jul 2024 03:11:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf0ccsm1020563f8f.35.2024.07.13.03.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 03:11:37 -0700 (PDT)
Message-ID: <466a7ea3-52be-43d7-920e-c991f8c4f30a@linaro.org>
Date: Sat, 13 Jul 2024 12:11:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] Add support for AD411x
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/06/2024 16:53, Dumitru Ceclan via B4 Relay wrote:
> This patch series adds support for the Analog Devices AD4111, AD4112,
>  AD4114, AD4115, AD4116 within the existing AD7173 driver.
> 
>   The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications. They integrate an analog front end suitable for processing
> fully differential/single-ended and bipolar voltage inputs.
> 
> Particularities of the models:
> - All ADCs have inputs with a precision voltage divider with a division
> ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
> shunt resistor.
> 
> Discussions from this patch series have concluded with:
> -Datasheets mention single-ended and pseudo differential capabilities by
>  the means of connecting the negative input of a differential pair (IN-)
>  to a constant voltage supply and letting the positive input fluctuate.
>  This is not a special operating mode, it is a capability of the
>  differential channels to also measure such signals.
> 
> -Single-ended and pseudo differential do not need any specific
>  configuration and cannot be differentiated from differential usage by
>  the driver side =>
> 	offer adi,channel-type attribute to flag the usage of the channel
> 
> -VINCOM is described as a dedicated pin for single-ended channels but as
>  seen in AD4116, it is a normal input connected to the cross-point
>  multiplexer (VIN10, VINCOM (single-ended or differential pair)).
>  This does not mean full functionality in any configuration:
>  AD4111:"If any two voltage inputs are paired in a configuration other
>  than what is described in this data sheet, the accuracy of the device
>  cannot be guaranteed".
> 
> -ADCIN15 input pin from AD4116 is specified as the dedicated pin for
>  pseudo-differential but from the datasheet it results that this pin is
>  also able to measure single-ended and fully differential channels
>  ("ADCIN11, ADCIN15. (pseudo differential or differential pair)";
>   "An example is to connect the ADCIN15 pin externally to the AVSS
>    pin in a single-ended configuration")
> 
>  As such, detecting the type of usage of a channel is not possible and
> will be the responsibility of the user to specify.
>  If the user has connected a non 0V (in regards to AVSS) supply to
> the negative input pin of a channel in a pseudo differential
> configuration, the offset of the measurement from AVSS will not be known
> from the driver and will need to be measured by other means.
> 
> Datasheets:
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
> 
> This series depends on patches:
> (iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify error paths.)
> https://lore.kernel.org/all/20240330190849.1321065-6-jic23@kernel.org
> (dt-bindings: iio: adc: Add single-channel property)
> https://lore.kernel.org/linux-iio/20240514120222.56488-5-alisa.roman@analog.com/
> 
> And patch series:
> (AD7173 fixes)
> https://lore.kernel.org/all/20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com/

Three dependencies? That's making it untestable.

Best regards,
Krzysztof


