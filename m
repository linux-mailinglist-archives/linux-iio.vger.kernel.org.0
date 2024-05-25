Return-Path: <linux-iio+bounces-5300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAC88CF063
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 19:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A31281C6D
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CEC8662F;
	Sat, 25 May 2024 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcoDDGJ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93938382;
	Sat, 25 May 2024 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716657465; cv=none; b=TL+JjvPajucQWW+94kbyGogPbFmK+7VleyDJCRrM629tXkKopgZx+yZbhWGxncAc2kut1WnpIJtTB0bcREMcZfIRWqYh8R8hf5QkCfmQOG2wejoSE3bM26oLtVSCW4d4nSFAgpvVPY2O+Mhvq3dbsFb/LwB/ZHf1CXfVyEcRMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716657465; c=relaxed/simple;
	bh=B1F5K+I2rON4uX6Ud7Trur0KVSRn4kdoQl2TEA9EphQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAPCaVXqZ7shUh2w7Rq3YZqrgx08+zur+idoJERLdU4GjDbHOQqOSH5tEJvRFb8pO2r2hQfRNoJTspmR12aiXqFRXKimEKFn8vdvg6dAaWTyKr0SthhGXO1obHP5hXJDRoa7ePnyupRjpUZkC/Q8bTVnG17kHmFw8L1uOGP3Iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcoDDGJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB0CC2BD11;
	Sat, 25 May 2024 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716657465;
	bh=B1F5K+I2rON4uX6Ud7Trur0KVSRn4kdoQl2TEA9EphQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WcoDDGJ1+ZD44CCgyTZIdcDHW97MgBfOOfQc+rQ/g1xMpINaf0MlI3fhlt46f8x3Y
	 hbB9sN0+ZliA8rbYb9Qitu/XK17ToYeU/KgBu32CAUiv+m1MpmbvXGV+qoypRmG/+1
	 1hQlbDjKRZmAXB/wCbQnhkeUb7gvnMMfzVDQmiQTeAc9cuoB5xKJEd7NsLPvNNlrSf
	 iYVF3yS4YMUPs8lFFS1Ggmn+0ZGH3v1eyImlu8zhHuUVt9ama3E9A7uYey5ilds7xj
	 vBFb2LeU/zna2k2kjp0Ohe01MFK/Sq1/VtCO/v6DI9yeBUJZxCZCCMXjKDrqhrnlO/
	 Qql57wnTAWMnQ==
Date: Sat, 25 May 2024 18:17:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael Hennerich"
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240525181730.6cccec73@jic23-huawei>
In-Reply-To: <20240523031909.19427-4-kimseer.paller@analog.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
	<20240523031909.19427-4-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


A few comments inline.

> +  adi,manual-span-operation-config:
> +    description:
> +      This property must mimic the MSPAN pin configurations. By tying the MSPAN
> +      pins (MSP2, MSP1 and MSP0) to GND and/or VCC, any output range can be
> +      hardware-configured with different mid-scale or zero-scale reset options.
> +      The hardware configuration is latched during power on reset for proper
> +      operation.
> +        0 - MPS2=GND, MPS1=GND, MSP0=GND
> +        1 - MPS2=GND, MPS1=GND, MSP0=VCC
> +        2 - MPS2=GND, MPS1=VCC, MSP0=GND
> +        3 - MPS2=GND, MPS1=VCC, MSP0=VCC
> +        4 - MPS2=VCC, MPS1=GND, MSP0=GND
> +        5 - MPS2=VCC, MPS1=GND, MSP0=VCC
> +        6 - MPS2=VCC, MPS1=VCC, MSP0=GND
> +        7 - MPS2=VCC, MPS1=VCC, MSP0=VCC (enables SoftSpan feature)
Could you add to the description to say what results of the entries are
(like you have done for 7)
e.g.
          0 - MSP2=GND, MPS1=GND, MSP0=GND (+-10V, reset to 0V)
at least I think that's what reset to mid scale means.

This seems like a reasonable level of information to convey here.

I was going to suggest making this a 3 value array, but that would
make ti hard to add such docs, so perhaps what you have here
is the right approach.


> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +    default: 7
> +
> +  io-channels:
> +    description:
> +      Analog multiplexer output. VOUT0-VOUT3, MUXIN0-MUXIN3, REFLO, REF, V+, V-,
> +      and a temperature monitor output can be internally routed to the MUXOUT pin.
> +
That's a little confusing.   What you are specifying here is the ADC
channels that is connected to. This description sort of suggests it's about
what is routed there.




