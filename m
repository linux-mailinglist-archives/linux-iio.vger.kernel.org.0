Return-Path: <linux-iio+bounces-24667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F0EBB481B
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B55317141A
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF5257830;
	Thu,  2 Oct 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV9G5tuF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D18254B18
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422051; cv=none; b=jFRZLoTq7/aqmEqB1kYFK7X01Ykeq7ML5EYZmxmusVCYm9WenX4dicK4tEylqPMrhPqHAKfLGFGwza+MGLrmCiybyBKeBnb0B+NW/z7BYBSZkkuh+xhHjRzPV81Q/GT5kNFGRvQDNMH0CrIVOsha3t1qOwPiQm9s+cytbput+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422051; c=relaxed/simple;
	bh=gKyyhk1fpwldfpjLQBa/D4FQewIdYo7qBumYIiDDnaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzKIISq697ynFAgcoz7qwtVqxNGY1R1ByqmYBrF47ws78BNgOAcGSPfPS+3W90OJ8j765aClXve0kJ3U2TDh/D4iLL1mgLZmqhVor0GPxW8+DXalgQqPBLYBhbWir40O6jOTEDAjlb9NjwTz/JJ6aaCamZbx9XxIY8T17Qg803Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV9G5tuF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78af9ebe337so931022b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422049; x=1760026849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge1wH9wa2ypd3GTYHtwr8nkyK2BaURlOW97tKSsa3bw=;
        b=LV9G5tuFKxcwMvXx1ZoeCG6crJ3OR4/O1JOMdG3T8ttFa3KzlkU41ysBUNKHL+r4WF
         mait03kszQqvjVhshL3Q8xG1YdTSq99foFPsl2E57NrrtJARyLsBHaZc6ZGO1MV+xWwF
         PJ3jhxlL022BxD8Oo5m0234gu8OYkVXvWqFzw143rBW3u4cczVkAuqDpNiXCaMWvDV4e
         b/4pbdabYCpDzGn57aWWRYoNLknhRxEF1jkKX0dAL5PR+Jf4fT61qUEFEWWpNRZ+2IW0
         MZty8m1LYXLg3dx/ijfkNDYEGG61YbwCwNDCucFhJUznEEFj1LWVywMR4ceqQMp0OgQu
         5FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422049; x=1760026849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge1wH9wa2ypd3GTYHtwr8nkyK2BaURlOW97tKSsa3bw=;
        b=pSGyQGfOCDrj6Z9gnsxCt9xVRD2OFNzEMTpgkqHzWeKgupOpSw6f50Qoy58v6KAwT8
         ZDAjMYezYCFxF/WK3xD9s7QE1aCd4a+6YW0Ov7tL2GHJ0GfTIA6NvQA472Os/ZiyDnsv
         94oISqqqlANnYLN2+VhZQpdZYr1MGAxeb8mJlvyVqaSj+JS4LulDyLuxOU6AVSN/itlI
         nr1BkaQK+qykWq9aEifhoiOTDowqSikk2EH79eNqtnL27WvDi8Ck79CDYriUmnlyQvGl
         vdUGQIb9w78vVVapFHcL/3vztkVc36ButSU3YIc2zII9KKp2OkWCU5fAXYuDhCIRvtNv
         gJww==
X-Gm-Message-State: AOJu0Yy/eOsrFLbBDDXUyYc37rxVcGe/rHdl5yZYn9aNZDWGuOgaN01J
	EIRpUtomnDtjea9ttijcYrJRuAiEgkx69XekpAm2PHUuYgnmV8gM2xuQdOMMIICZB3F/fCjDWmW
	qqsS0AwoRYpYcQrIuwCgyeFSMlGOfCfU=
X-Gm-Gg: ASbGncv7OOQLEdELGq/R61ted78+koJr3i4mZ0cOok2GNtq+0Cd9FixGtIQrlizDfwo
	ASCstv6+LEFySmaROzT0PvYTCHaBerXw/W0ahpG+TY+ri14OC6bm8YKdB1vOWFGntr7ZLpO0UBo
	bWnZOUrqzbctVvEQpEv4624X3mp5aMC122AN8THUwXkNgKV/Blx9qLEgpsd0WsLoqDO0uwLwQXT
	jNJewPnCBNgNbqqs3zsnijq81ZiSAQ=
X-Google-Smtp-Source: AGHT+IFU8VGlsiC9J8Z+X3r/HK350bLU+mKTbWQJm58irX10X1WcOxpbIYpLR6QYJtRE7FKv3T27WjOLklIbMC5WGLU=
X-Received: by 2002:a17:90b:4d8a:b0:335:2823:3683 with SMTP id
 98e67ed59e1d1-339a6e9aa97mr9192058a91.9.1759422048896; Thu, 02 Oct 2025
 09:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755778211.git.marilene.agarcia@gmail.com> <6690320bcf9f0b8a5bf58048673e4f6a884c724b.1755778212.git.marilene.agarcia@gmail.com>
In-Reply-To: <6690320bcf9f0b8a5bf58048673e4f6a884c724b.1755778212.git.marilene.agarcia@gmail.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:25:45 -0400
X-Gm-Features: AS18NWBD33DqNii_mjGXdVPhvxJT8nXTgN3ChO-5Vkyd0fP6ujIJhurj3yeloa8
Message-ID: <CALC8CXcHcF59YHiWQVui1FYm7cxuyeMARQyhB01GOLpgQpWtmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add MAX14001
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt <Marcelo.Schmitt@analog.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Jonathan Santos <Jonathan.Santos@analog.com>, 
	Dragos Bogdan <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The MMAALLLEEE hackers were thrown out of linux...
for documentation.

On Thu, Aug 21, 2025 at 9:53=E2=80=AFAM Marilene Andrade Garcia
<marilene.agarcia@gmail.com> wrote:
>
> Add device-tree documentation for MAX14001/MAX14002 ADCs.
> The MAX14001/MAX14002 are isolated, single-channel analog-to-digital
> converters with programmable voltage comparators and inrush current
> control optimized for configurable binary input applications.
>
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> ---
>  .../bindings/iio/adc/adi,max14001.yaml        | 78 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max1400=
1.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> new file mode 100644
> index 000000000000..3b2a2e788a17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Marilene Andrade Garcia
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX14001-MAX14002 10-bit ADCs
> +
> +maintainers:
> +  - Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> +
> +description:
> +  Bindings for the Analog Devices MAX14001-MAX14002 Configurable,
> +  Isolated 10-bit ADCs for Multi-Range Binary Inputs.
> +
> +  Datasheet can be found here
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
MAX14001-MAX14002.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max14001
> +      - adi,max14002
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Isolated DC-DC power supply input voltage.
> +
> +  vddl-supply:
> +    description:
> +      Logic power supply.
> +
> +  vrefin-supply:
> +    description:
> +      ADC voltage reference supply.
> +
> +  interrupts:
> +    items:
> +      - description: |
> +          Interrupt for signaling when conversion results exceed the con=
figured
> +          upper threshold for ADC readings or fall below the lower thres=
hold for
> +          them. Interrupt source must be attached to COUT pin.
> +      - description: |
> +          Alert output that asserts low during a number of different err=
or
> +          conditions. The interrupt source must be attached to FAULT pin=
.
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vddl-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      max14001: adc@0 {
> +        compatible =3D "adi,max14001";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <5000000>;
> +        vdd-supply =3D <&vdd>;
> +        vddl-supply =3D <&vddl>;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af1c8d2bfb3d..0aeab5dbd39d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14984,6 +14984,13 @@ W:     https://ez.analog.com/linux-software-driv=
ers
>  F:     Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
>  F:     drivers/iio/adc/max11205.c
>
> +MAXIM MAX14001/MAX14002 DRIVER
> +M:     Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +W:     https://ez.analog.com/linux-software-drivers
> +F:     Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> +
>  MAXIM MAX17040 FAMILY FUEL GAUGE DRIVERS
>  R:     Iskren Chernev <iskren.chernev@gmail.com>
>  R:     Krzysztof Kozlowski <krzk@kernel.org>
> --
> 2.34.1
>
>

