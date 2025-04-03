Return-Path: <linux-iio+bounces-17591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC95A7A1BB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 13:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F201897C7A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4C2459FB;
	Thu,  3 Apr 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6vyvNds"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A8481B6;
	Thu,  3 Apr 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678933; cv=none; b=b9dIZ4HeraQUNo95mgKrr4N6aC4ImiZhxAiZEkfN5aEpGR+mgEWfX6Aacrs4nvTjFao8DN51f7KKiahfi+SZVkik7gRFznRyEulcFXKNIXW6tQMfTAGGmD++g1ntD/ry7gX/h71DaJUqZ7JAuQKRRy89Qhx2G88FNqslpZQzx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678933; c=relaxed/simple;
	bh=hiHWGoy3TfSy1ZTXTxz57Op4hmlZMwz8uSjR3DobCU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bs2KitN5MwXIQBZeSt5y3Q9GiJ0c8+0IHMBFyc8qo44QJtliBfOMHhH1rSjlawokSOt//Ad22EHUo+VB0wNb+4w+al2TstGklJn5k8/+P7QG+DV85cbX56khNmASaCl3QdoVyatIEbgPDyEuOraTVbu7b12vCf9n1j+eZNJVZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6vyvNds; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso6322355e9.2;
        Thu, 03 Apr 2025 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743678930; x=1744283730; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hiHWGoy3TfSy1ZTXTxz57Op4hmlZMwz8uSjR3DobCU0=;
        b=P6vyvNdsupziMIn3B17zEGWeHANwKGHUrzfCzJDYnVYLLe83n4tuPOlLjPOUpfPpYN
         nF9DrWUIfvU3aXN7EfvEJO8NU1Gs01VyWsoBv1qLtL3LoLwR/gwMxITlt3yJpPe5YO5R
         Fr8rCGAPq13CPAGuoB9sm5DdWXRvUjJQyDphIcQmPKCX44oE1WQ0IfAVKjtqB9pJ+mJS
         BZkghjM6LO6xgdqCqOe/8Ae3m7yRZNtApXNzLIVge22O5yIhx9JzlfRBkAMo68GDwxbk
         Be1i8PWPc1e6zPcgXhyWHR0jCGpchukW0YMgTg4ndBxR9tg283aKw+7AHN9vn8iqCuUK
         nxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743678930; x=1744283730;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hiHWGoy3TfSy1ZTXTxz57Op4hmlZMwz8uSjR3DobCU0=;
        b=SXy5fJQd+DR8uFJVmeKLAhxSCmxnIrCvrr41A29ihx8TeHQwRcKC6QwYbxnB7HXSZg
         +y+I4YFUdIrrIB8Kr7Xe3IKD+W7W7Dqm10Cn+IytQ+AujIy23SYqUL3ytfrS6GwBNVLs
         h1zf8fxOq3bwyAfkfNFaKpICOXSZ2wni/Ch3dsoPnWe7OKMD6EPkRYJ3h/iMlm47qlOv
         lQlDoaCZAtJtZbCyb1oMBTxBYLKsMb9TItdv4ODKnqK4NRVc/XEjXTq7l0Hf3exiFRRx
         yIlRK6cm7Ki64CLA8bmclX1TyQyZ2ZGvExJOGBmZSSPC7TEwSAlV20ZgtP8H9uOvJOqI
         Hw3w==
X-Forwarded-Encrypted: i=1; AJvYcCULj+cNnvD1WVFViglCCBJX4JTsD8UBFSAPJmqDjX4HqZUqa1HM1404bNF+PRWKve6CVh9PiG8q91V+mXAI@vger.kernel.org, AJvYcCVANmCY5kAmxgzWQDQoO+omVUcDhgz2XgZLM8LNAYiNLjjSZY6H3So62vq7U7tpXJ953h7YkVqDmwK6@vger.kernel.org
X-Gm-Message-State: AOJu0YzitGRtfBhotD+NKtBawAOgIOUHoSjSCaAkkuoDtYEs44uThvhf
	j1XNJ1vM3ndHYyeVLIqk+uleVLfx8K+4Dx5dxVwnX4S8FnbwEfJivCnaZRc4Cfg=
X-Gm-Gg: ASbGncs0+botVtPCKWQ7rgDQygAEILbFkV10uJ0Oo1x73NwTYS5tSoLdQiSjXvtIUmf
	RmzbPJbSzjOaJI8S4TScOmAQYoKNfVBWUDkbNoLMPFbN7QvRiT5dCe2qdwnErRxb2ss0viRy5Lb
	YqJ3uwl9hs2W4zbjj/XehWU43oxQlW3TQvaIZcF7DOqAEJCHaY/OuUU6bkOkOECyZCR1mrG0X0E
	UPxEjumVu/+dUBZxzKzexa0oMHF+tSlIa9hzmkmmKcQlF2w/K3o1eqZhlJC65OLFL5vGLpy4CIr
	OJs+SpQhUAu7qcTeAdniNVUocUurREt22hh4vggXl06IcrM4wz3tMRcmB/9GxFbB2fhhzl8Egby
	w1HZVJ+kp0BAToWq4
X-Google-Smtp-Source: AGHT+IEW5ki3AoxruBMnNGyEvSVtl7GToIRQYVQ5Fb2tPTJE3GsnsJfpbLNttRdS9ddC0XQ+Dt4fGw==
X-Received: by 2002:a05:600c:358c:b0:43c:e7ae:4bc9 with SMTP id 5b1f17b1804b1-43ec13247admr14727665e9.1.1743678929452;
        Thu, 03 Apr 2025 04:15:29 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec366a699sm15116095e9.38.2025.04.03.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 04:15:28 -0700 (PDT)
Message-ID: <b2082b59fcbffe9f546bb681eb33276a3c5896c5.camel@gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>, Jonathan Cameron	
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Thu, 03 Apr 2025 12:15:28 +0100
In-Reply-To: <20250403-togreg-v3-2-d4b06a4af5a9@analog.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
	 <20250403-togreg-v3-2-d4b06a4af5a9@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Hi Kim,

On Thu, 2025-04-03 at 13:33 +0800, Kim Seer Paller wrote:
> Document the AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel)
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls. They provide full-scale output spans of 2.5V
> or 5V for reference voltages of 2.5V. These devices operate on a single
> 2.7V to 5.5V supply and are guaranteed to be monotonic by design.
> The "R" variants include a 2.5V, 5ppm/=C2=B0C internal reference, which i=
s
> disabled by default.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> =C2=A0.../devicetree/bindings/iio/dac/adi,ad3530r.yaml=C2=A0=C2=A0 | 99
> ++++++++++++++++++++++
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++
> =C2=A02 files changed, 106 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..cf4a3eb98f1fa30afdeb0740bba7f05=
2d8ec
> 2cd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad3530r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD3530R and Similar DACs
> +
> +maintainers:
> +=C2=A0 - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +=C2=A0 The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are=
 low-
> power,
> +=C2=A0 16-bit, buffered voltage output digital-to-analog converters (DAC=
s) with
> +=C2=A0 software-programmable gain controls, providing full-scale output =
spans of
> 2.5V
> +=C2=A0 or 5V for reference voltages of 2.5V. These devices operate from =
a single
> 2.7V
> +=C2=A0 to 5.5V supply and are guaranteed monotonic by design. The "R" va=
riants
> +=C2=A0 include a 2.5V, 5ppm/=C2=B0C internal reference, which is disable=
d by default.
> +=C2=A0 Datasheet can be found here:
> +=C2=A0
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad353=
0_ad530r.pdf
> +
> +properties:
> +=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0 enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad3530
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad3530r
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad3531
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad3531r
> +
> +=C2=A0 reg:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 spi-max-frequency:
> +=C2=A0=C2=A0=C2=A0 maximum: 50000000
> +
> +=C2=A0 vdd-supply:
> +=C2=A0=C2=A0=C2=A0 description: Power Supply Input.
> +
> +=C2=A0 iovdd-supply:
> +=C2=A0=C2=A0=C2=A0 description: Digital Power Supply Input.
> +
> +=C2=A0 io-channels:
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADC channel used to monitor internal die =
temperature, output voltages,
> and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 current of a selected channel via the MUX=
OUT pin.
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
>=20

I'm a bit puzzled... Isn't this device the provider of such a channel?
Therefore, I believe we should have #io-channel-cells, right?

- Nuno S=C3=A1


