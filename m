Return-Path: <linux-iio+bounces-23390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BFDB3C1F2
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E053D7AA1F8
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD071EF091;
	Fri, 29 Aug 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d2hAqdtQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63615342CA1
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489176; cv=none; b=bPGMIDTPIHSJq7IIe/Gmrqsfqhc878hHpjtA/ctAHR5bpdKGrvANz40ajlO/DGP6nBzDzP3azq4pJaCVCERbRd9gUtHpj4sQc0OVMtNvdrCp1NJVsm3Kyn/70mC+7csVcuieAoYKEk7IgUwTEYlilZG0p1zc/98B72ecDJvH0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489176; c=relaxed/simple;
	bh=qQjs5GDGkvcvFun76J+EWArVcumILWtYVXrqlvPj73Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNkWenXLQABavH4SW7rcoH17CzyB+rxpbLA82vvhhlNHH6gNHWZy/Q95HkVN28uj0NY+QqJXi2GHxVgYHp5XM8yTFbCemzaI2JSBhs6ZRxWyx+RiFsbVoSQIdvpaki2qEd88xJUiux2Ivg7lLFOjWl1iMVg4V2EX2Gc/o5v/fv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d2hAqdtQ; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30cce86052cso1420568fac.1
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756489172; x=1757093972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyTrrC0VRvJoF9rtObeEzNC1mAjV1qvohGvctYe1UZ0=;
        b=d2hAqdtQJpnDVJ7HNCoyUDUbb5JDzbSM5Daexay5I+hJZCS197G1yNozlVQayIE2VZ
         WTox20cmxTfO5WHd130soPs9alBHzwNtYHmEa4WFGSe03+tUz468x62Vgts7O2BCiT1j
         2MKtEpUxNmPcIArHDtX1bEuOy17jTgYzSE129WC+rPwjC1tCaYKdGrj7UK4sJbSftesl
         NVxJ5J3t3soxEPCHqTOPhcxjm6ByumHCIZN5/JpK7dV5OmgeczFNGFax+6qYk3wUhFSU
         lyRn/Fw9HhTjyraLeAxB+ec63W8XdmzUXzOgFrkq4N6DcuMJkBOBhIfJ4U0eCUcc0QjR
         w2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756489172; x=1757093972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyTrrC0VRvJoF9rtObeEzNC1mAjV1qvohGvctYe1UZ0=;
        b=lAQvOJD5J0nQa8WQ2yKtV8ifOeFKzZ8AcjcEu/lnHtE7DVBiQc14PiTi2fppofY6rI
         ohyUNFYw/XBAMgx4U7N24YekV5Qq7C6iCm0/d+I9PD7QHIPzIy50TDe1XYcOR0erLlym
         8JINv0Hb/0FJccQoo/Sd9zcKbNADluGcjwJdBC7sg/pK6ylFUfWRcHYh2PtVPZxORWBv
         TfqohSSzFGpc4ekFf3Ginto6/HVNYdv74nk2xiWPHKaaG2gPSFtST2QJwV0DykdCcwYT
         JN2H5e9GwBODDodcPO/5vHMRj7r/OEUMkztAVM+dvU3o1MCzZQYJh7XlkLL7J283IAdg
         74eg==
X-Forwarded-Encrypted: i=1; AJvYcCUHjcONv9HiFmSKDji4cfaqnTfUBqz45agydpsdVxLh6FqjNITslPiXNV+n8+5Xu22MTU3htfS+q2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlKNCtxvzoaf9Ky8EC+UfQ2LZRSUOzP5iaTZLun4dQnCueWeD
	S/34kou4cC7qPsiyhFT5OJzi8npUq91E0fEeJAvEoYhT6YLylnMcl/m8RShCKG7+XRM=
X-Gm-Gg: ASbGncunN9QZj04kF08eEvE2KrsMlhpojET2mPnys8YrD/AgyiyQc3y0MWaZgUegfDL
	EtfeOCQmMpcOJCcjEJa81ddLiaQOLT4djv1tJCZq5HYz5W/0LoUo20QCtJCj/Bs9twinDkj4NfG
	GqOpdNs+Z2z7uQJ1l2mamySf0Zx9f90cnIf5yp0lRWih6NuMI4Sqiu+Svc4uQp4RNUi54agSw9B
	E2hLDcaQPVEUdi/IV+njWynEJlCfnKbUJFX9K6cIhmBFkQD0RS1fP4HD4us/E9/rY2uPxDpiCsR
	pfIisiVH1yFvmzJZtekB2MjF039ixiq5QpGK09z6dXoFea3Fkoc+yZqDsuc8O9yLN1bKe+XNcbS
	H56/de7MUH99HwWOOkzA2etH7D92TH1BDK4OLtMngCdPhtLrpKmIuidcROuetkTGfYFlzptvs0w
	M=
X-Google-Smtp-Source: AGHT+IESMHvlCtBzcRBdU7jRG2XMNsNINqPRQCqVz5I0okbAWpHF0/0FHmvHrhMDXKCe2hPr9vw9+g==
X-Received: by 2002:a05:6871:e49b:b0:2f3:4720:f7ca with SMTP id 586e51a60fabf-314dcad7cfbmr13935852fac.2.1756489172303;
        Fri, 29 Aug 2025 10:39:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe62235sm1497011fac.23.2025.08.29.10.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:39:31 -0700 (PDT)
Message-ID: <1aa4d7d1-be47-471a-8411-1adaffc1659f@baylibre.com>
Date: Fri, 29 Aug 2025 12:39:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
To: victor.duicu@microchip.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: marius.cristea@microchip.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829143447.18893-1-victor.duicu@microchip.com>
 <20250829143447.18893-2-victor.duicu@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829143447.18893-2-victor.duicu@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 9:34 AM, victor.duicu@microchip.com wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the devicetree schema for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>  .../iio/temperature/microchip,mcp9982.yaml    | 203 ++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> new file mode 100644
> index 000000000000..2f092e376fe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> @@ -0,0 +1,203 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9982.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive
> +       Temperature Monitor Family
> +
> +maintainers:
> +  - Victor Duicu <victor.duicu@microchip.com>
> +
> +description: |
> +  The MCP998X/33 and MCP998XD/33D family is a high-accuracy 2-wire multichannel
> +  automotive temperature monitor.
> +  The datasheet can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp9933
> +      - microchip,mcp9933d
> +      - microchip,mcp9982
> +      - microchip,mcp9982d
> +      - microchip,mcp9983
> +      - microchip,mcp9983d
> +      - microchip,mcp9984
> +      - microchip,mcp9984d
> +      - microchip,mcp9985
> +      - microchip,mcp9985d
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2

Why can't we just have one of the interrupt pins wired up?

> +
> +  interrupt-names:
> +    description:
> +      -alert-therm is used to handle a HIGH or LOW limit.
> +      -therm-addr is used to handle a THERM limit on chips
> +      without "D" in the name.
> +      -sys-shutdown is used to handle a THERM limit on chips
> +      with "D" in the name.

Descriptions can be moved below:

> +    items:
> +      - const: alert-therm
           description: Interrupt line connected to the ALERT/THERM pin.
> +      - const: therm-addr
           description: ...
> +      - const: sys-shutdown
           description: ...

The device tree only cares how things are wired, not how they are used
so I suggested a different description.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  microchip,enable-anti-parallel:
> +    description:
> +      Enable anti-parallel diode mode operation.
> +      MCP9984/84D/85/85D and MCP9933/33D support reading two external diodes
> +      in anti-parallel connection on the same set of pins.
> +    type: boolean
> +
> +  microchip,parasitic-res-on-channel1-2:
> +    description:
> +      Indicates that the chip and the diodes/transistors are sufficiently far
> +      apart that a parasitic resistance is added to the wires, which can affect
> +      the measurements. Due to the anti-parallel diode connections, channels
> +      1 and 2 are affected together.
> +    type: boolean
> +
> +  microchip,parasitic-res-on-channel3-4:
> +    description:
> +      Indicates that the chip and the diodes/transistors are sufficiently far
> +      apart that a parasitic resistance is added to the wires, which can affect
> +      the measurements. Due to the anti-parallel diode connections, channels
> +      3 and 4 are affected together.
> +    type: boolean
> +
> +  vdd-supply: true
> +
> +patternProperties:
> +  "^channel@[1-4]$":
> +    description:
> +      Represents the external temperature channels to which
> +      a remote diode is connected.
> +    type: object
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 1
> +          maximum: 4
> +
> +      microchip,ideality-factor:
> +        description:
> +          Each channel has an ideality factor.
> +          Beta compensation and resistance error correction automatically
> +          correct for most ideality errors. So ideality factor does not need
> +          to be adjusted in general.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 18

Are there minimum and maximum values?

> +
> +      label:
> +        description: Unique name to identify which channel this is.
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp9982d
> +              - microchip,mcp9983d
> +              - microchip,mcp9984d
> +              - microchip,mcp9985d
> +              - microchip,mcp9933d

Could use a pattern instead of listing all matches.

		pattern: .+d$

> +    then:
> +      properties:
> +        interrupts-names:
> +          items:
> +            - const: alert-therm
> +            - const: sys-shutdown
> +    else:
> +      properties:
> +        interrupts-names:
> +          items:
> +            - const: alert-therm
> +            - const: therm-addr
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp9982
> +              - microchip,mcp9983
> +              - microchip,mcp9982d
> +              - microchip,mcp9983d
> +    then:
> +      properties:
> +        microchip,enable-anti-parallel: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp9982d
> +              - microchip,mcp9983d
> +              - microchip,mcp9984d
> +              - microchip,mcp9985d
> +              - microchip,mcp9933d

This looks like the same "if" as above, so could be combined.

> +    then:
> +      properties:
> +        microchip,parasitic-res-on-channel1-2: false
> +        microchip,parasitic-res-on-channel3-4: false

> +        microchip,ideality-factor: false

microchip,ideality-factor is a channel property, so this has no effect.
It needs to be moved to the correct place under patternProperties.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@4c {
> +            compatible = "microchip,mcp9985";
> +            reg = <0x4c>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            microchip,enable-anti-parallel;
> +            microchip,parasitic-res-on-channel1-2;
> +            microchip,parasitic-res-on-channel3-4;
> +            vdd-supply = <&vdd>;
> +
> +            channel@1 {
> +                reg = <1>;
> +                label = "CPU Temperature";
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +                label = "GPU Temperature";
> +            };
> +        };
> +    };
> +
> +...


