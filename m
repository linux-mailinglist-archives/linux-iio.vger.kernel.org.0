Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D54434DB
	for <lists+linux-iio@lfdr.de>; Tue,  2 Nov 2021 18:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhKBRxS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Nov 2021 13:53:18 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:33632 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhKBRxR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Nov 2021 13:53:17 -0400
Received: by mail-ot1-f50.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so64316otg.0;
        Tue, 02 Nov 2021 10:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yPvvkuP6wSo8ADJDMNg71sUzxM80K2elYZt4mG0jpAM=;
        b=1TJE1jL+npYZ5T0SfFLLFoWAQfkj2+oBksMABNl2L81ZVWHSJkgGYEh/MnynZ38r/y
         9wTOIdcQ7xRYnRcA1MsAE+yXqc0HAaD2Pvpj534Do9YPRHMiv2B0D4u/5aHwqTiSM4SA
         I9lztqgI6NMcf42nnruFMYnIYgo9ri19TcRUaD1TyGw2E07Bm8R+iwaI/MIgkZl54VxD
         F5Vyvk/eafn/9Q/LW6lPkJHcHY4FJicWATqzLoAThyOzpGaYuSH2o40Ums5jIQG6CQly
         mXA7uS3fXfdgDaQ31YOtf8WIcpN2eHxJWrJDZgYbdBDmshU/U0NBWP44QvI6Ibc+HMVY
         xKVw==
X-Gm-Message-State: AOAM530ZEMDowvTeMZrGHNmbNkjqYQYVg8Rpc6zHZuL/xO/7zIZhO9lO
        +VtWrs9bKJ+VFt1bxWTFQ/AQHGl3qg==
X-Google-Smtp-Source: ABdhPJwf0d7iJQpNv4f6evwJK8mqUHisrlchhPNiYkQ6SWK7/17DUmKlueIL36RhGU9Z2i5aPTU4mw==
X-Received: by 2002:a05:6830:25d1:: with SMTP id d17mr11892441otu.257.1635875442145;
        Tue, 02 Nov 2021 10:50:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d18sm4987248ook.14.2021.11.02.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:50:41 -0700 (PDT)
Received: (nullmailer pid 3153909 invoked by uid 1000);
        Tue, 02 Nov 2021 17:50:40 -0000
Date:   Tue, 2 Nov 2021 12:50:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nuno.sa@analog.com
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
Message-ID: <YYF6cPSDroPz/wun@robh.at.kernel.org>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
 <20211101100420.70304-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101100420.70304-2-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 01, 2021 at 12:04:20PM +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV1013 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> new file mode 100644
> index 000000000000..47993253a586
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv1013.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV1013 Microwave Upconverter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Wideband, microwave upconverter optimized for point to point microwave
> +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> +
> +   https://www.analog.com/en/products/admv1013.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv1013
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  clocks:
> +    description:
> +      Definition of the external clock.
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  vcm-supply:
> +    description:
> +      Analog voltage regulator.
> +
> +  adi,vga-powerdown:
> +    description:
> +      Power Down the Voltage Gain Amplifier Circuit available at
> +      BG_RBIAS2 pin.
> +    type: boolean
> +
> +  adi,mixer-powerdown:
> +    description:
> +      Power Down the Mixer Circuit. Enable to put the block in
> +      a power down state.
> +    type: boolean
> +
> +  adi,quad-powerdown:
> +    description:
> +      Power Down the Quadrupler. Enable to put the block in
> +      a power down state.
> +    type: boolean
> +
> +  adi,bg-powerdown:
> +    description:
> +      Power Down the Transmitter Band Gap. Enable to put the part in
> +      a power down state.
> +    type: boolean
> +
> +  adi,mixer-if-enable:
> +    description:
> +      Enable the Intermediate Frequency Mode. Either IF Mode or I/Q Mode
> +      can be enabled at a time.
> +    type: boolean
> +
> +  adi,detector-enable:
> +    description:
> +      Enable the Envelope Detector available at output pins VENV_P and
> +      VENV_N. Disable to reduce power consumption.
> +    type: boolean
> +
> +  adi,quad-se-mode:
> +    description:
> +      Switch the LO path from differential to single-ended operation.
> +      Set value 6 for Single-Ended Mode, Negative Side Disabled.
> +      Set value 9 for Single-Ended Mode, Positive Side Disabled.
> +      Set value 12 for Differential Mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [6, 9, 12]

All these vendor properties are fixed based on the board design or 
something a user may want to change? The latter does not belong in DT.

Rob
