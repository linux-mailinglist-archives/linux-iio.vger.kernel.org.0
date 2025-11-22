Return-Path: <linux-iio+bounces-26387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 909CCC7D3EB
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7C0B4E6631
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526D28D83F;
	Sat, 22 Nov 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XA/BJ3xn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70723E33D
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763828269; cv=none; b=g1Y9/1v54JX4w1oWJJej7EexNd6qU+xRlaBUJz92Dey5ZSdemmn1rr6Tnv4rODz3HcJKcZtg7+HcEb8TrD+wWItb+jg6Dl8GawyjvRJvWxk4lkD5aBL5kEiQAXQBqYfuomd0sMYAAOavcQElMkD8r1EBskggpypjx2d6XUjavm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763828269; c=relaxed/simple;
	bh=lD9qw3+1a2fCxGBU3gwPJvHWcZKfYC2qwL6ybCaX3Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eMUErhUhIzI9cSKCOiTdXmhFy/L4I2R1f4o17Fi3BkKE1xZuRtovf1KpSYYracvjGl0m+9wN3tT0EHaNRGCaf0PIc7vkTVB4mX9dfyKBF0ufXDhixq6BocOpgJXygg/vN0XS2GO1edBhxdM2efr4Ul8hNalTXKFPYEoB2SZpV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XA/BJ3xn; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c76f65feb5so2128343a34.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763828266; x=1764433066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dW4WI4aGenKIk+vJ5jzi4PBdSmIWJZ8GDl4yIS/elNc=;
        b=XA/BJ3xnl/myhIa2tEWRSWxwMOEpXYMDu1LOw6G8uMJuU8eWNDs2N3kHMmpfCd1bMZ
         ZInj8mMr9cyi9q9SMAkcqjKTwxyMIizncnA04Ti+dVF7SNjrIKqrNpHjIM9OGSPHXRhL
         IVoiRu7ZvIMFfELdaHDNTw0OTeRArnuEerpx8ics1QDE5cBJUE9FMMB/jlpQnxJBpZBt
         3tnqX9JUybWffUXSMdu7FrArtUc4GEE/apeCuM+IcQwLhTqyBuoUvIt5V1A7AxnezdVZ
         maf5zwjc6D35zYIrTjV8r4wdUWXziif500v2SYv1bsAvmi2pTtKC8hgaVsqQ3UOvMzT6
         vZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763828266; x=1764433066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW4WI4aGenKIk+vJ5jzi4PBdSmIWJZ8GDl4yIS/elNc=;
        b=SI/XuN6PaaCXLkzTXn6pkLZqNC8ubIidkuWYU2YLYrZsBn9kB9RyPxq2UX/6jt5EAU
         lpR9V5KWvH/toM4Kb5RYRtL9mRREdVQaoh0qk3L5LcTQIP43bc12qMKCVvflE4BK+jxB
         mJA5TLBQuc6dAoNE4tHH+GBd1fgH+P/o2ACgnvpkDK5b7nBfYvLAbZtwEIRuKWTHpRFD
         l8xFdwqgVR8VvuDPp5g/aVRdJd/VjSkEkO4G4ZW4Zw9LBBX5yfmoGV0V/xdba2IhFREG
         wm3oOBzo8vb0I3RCnMFowj0sCpjpyDfNmclM3dN4ftPu34Id0edMEyavlX8MTqGLQAwh
         tzZg==
X-Forwarded-Encrypted: i=1; AJvYcCUHN7ZiX89BdVtAhXH1bmGcahnrbe4k1tZd18aVe5sw2NyPOSVs1cz6SlLDUpkOPbqPLEeXGkL7SYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQ3eXVuTq14UxCmxvVNWeZqC1Z3lya+DmRwK6qN0r1Uq13c3H
	0ChBmCyv2VKzKw+dUv9xfoMl/g25l9pvc01tQrzSZ84llZrNWvYIwek1ZEArmmv8nkM=
X-Gm-Gg: ASbGncu8Hg8ihs5D8v5+WivvS24U84fVMtpj56c+ywcuz+8s6KAJW2zHAvR79SxmFHi
	D7HXTFG5dHmAiXJUmTlFNwXnNC1BGd7tgbcds13S/bzcAWSiNm+MnKxt/lkW4E6KeVHepgPONbG
	xXG94qlPalCHF9NoT3R7o5YsaVOQUbxR1fdz8qA2EmIZM3TAtUo61V6YPCvx89bW1+VQ941LJGL
	TAyvfvJ94TdbsRID5awgivwbjQ3Ooo407F9ZiPk4m4PhNN+RQqmrJ5Rr2g6k86u93mUcKujmjlt
	zyuCi2v23GpWOARge9gtCQta9wfm9TVQpGqlxJgLas4W4km1JY7oaUkoABCLImg/ItQ6zIuzG4r
	Y/i8kWYFl5vpSXRm5IPIniv4PX+Ihk03nNm/iUz4BY97K524jsKPEA44ey8U0RgFQvHrek5EeFs
	XHlNNycE8OfEsIZ7tLbZWRRyVKDe99eLa647ARyP5HJQc+w8uoFis1v4AvmIrMvTs/zKOBQoA=
X-Google-Smtp-Source: AGHT+IFti6Ssxoxl9NGiyka2llGTdisHj8XfjS9EhnJKtMTFuf2G5Pwk4x+RwXnK9OMFRROfrbn9pg==
X-Received: by 2002:a05:6830:4107:b0:7c7:6558:277a with SMTP id 46e09a7af769-7c798bff0d0mr2805281a34.15.1763828265880;
        Sat, 22 Nov 2025 08:17:45 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e782:93d8:7c2f:f9df? ([2600:8803:e7e4:500:e782:93d8:7c2f:f9df])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d428edfsm3562699a34.31.2025.11.22.08.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 08:17:45 -0800 (PST)
Message-ID: <7db1158c-c29c-4788-a3d2-b9e7b1042708@baylibre.com>
Date: Sat, 22 Nov 2025 10:17:44 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: amplifiers: add adl8113
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251121095204.18574-1-antoniu.miclaus@analog.com>
 <20251121095204.18574-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251121095204.18574-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 3:52 AM, Antoniu Miclaus wrote:
> Add devicetree bindings for adl8113.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> 

...

> +  adi,external-bypass-a-gain-db:

Hmm... are we sure we will never need a non-integer value? Maybe we should add
"-microdb$" to dtschema?

https://github.com/devicetree-org/dt-schema/blob/7033eb7cec1abe55f496309f0f6f271524f5d612/dtschema/schemas/property-units.yaml#L52

> +    description:
> +      Gain in dB of external amplifier connected to bypass path A (OUT_A/IN_A).
> +      When specified, this gain value becomes selectable via the hardwaregain
> +      attribute and automatically routes through the external A path.

The dt-bindings should not specify how the driver should operate. We can
leave out the last sentence. We could say though that when omitted it
means nothing is connected.


