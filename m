Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273042A4A65
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 16:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgKCPz2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 10:55:28 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:39947 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgKCPz2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 10:55:28 -0500
Received: by mail-oo1-f68.google.com with SMTP id p73so4308844oop.7;
        Tue, 03 Nov 2020 07:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pd/7g4iwFMyEwfpQ6qtHGRfaaXNB49jazvbptOlmcI4=;
        b=M/M0qUDI0tBGUUzUO/MkJhappWOLbio3kPAbPx/ksAAnlXDRpjYaMoxiO5Zqo2YF/D
         TvxBGN8erjIrn6LTvlAywCwKSFi9lRSV7hhqc4fvXUj0fCAJT3vhi0eHrqMhbKrwoynU
         niXwhgUFlH110KDBPCGm/Zofp+1PE7uXcsHrhGNX1v8qCNwUIw1XTDJoixU/wj0MeibF
         Gt+UwgsJb19MvF8r6VTMUEGwAne78/ioohDBGm5Omr/20BHvoma/X8i63jSKL8Rt1dBS
         J9F5rMwvR1RRfkJ6hLeqTKlMnvTyESi0r4/RSyC6N4prBf5KfRUdqZKI7zTud/9SkM2M
         zB3g==
X-Gm-Message-State: AOAM532SKEWuCaExFRSak/d3vY2ZVCuI4N8Fb84sVVtFvaB1zmUKBGQ4
        O05mW6KeLbOnrihsCUBH2HnX4N0BkA==
X-Google-Smtp-Source: ABdhPJzgsnnhDiqdRT6UePLy0Gvt2V8DN7hT2hjUFrCWn1d75jT20YCBFDQhnQ8vszLp0sKO8Sh4sg==
X-Received: by 2002:a4a:ea4b:: with SMTP id j11mr15885984ooe.56.1604418927298;
        Tue, 03 Nov 2020 07:55:27 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l204sm4190620oia.32.2020.11.03.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:55:25 -0800 (PST)
Received: (nullmailer pid 1737973 invoked by uid 1000);
        Tue, 03 Nov 2020 15:55:24 -0000
Date:   Tue, 3 Nov 2020 09:55:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 05/10] dt-bindings:iio:afe:current-sense-amplifier: txt
 to yaml conversion.
Message-ID: <20201103155524.GA1732900@bogus>
References: <20201031181242.742301-1-jic23@kernel.org>
 <20201031181242.742301-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031181242.742301-6-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:12:37PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note this includes a fix in the example where we had *-mul instead of
> *-mult.  The binding doc and driver agree that it should be *-mult
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Rosin <peda@axentia.se>
> ---
>  .../iio/afe/current-sense-amplifier.txt       | 26 ---------
>  .../iio/afe/current-sense-amplifier.yaml      | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
> deleted file mode 100644
> index 821b61b8c542..000000000000
> --- a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Current Sense Amplifier
> -=======================
> -
> -When an io-channel measures the output voltage from a current sense
> -amplifier, the interesting measurement is almost always the current
> -through the sense resistor, not the voltage output. This binding
> -describes such a current sense circuit.
> -
> -Required properties:
> -- compatible : "current-sense-amplifier"
> -- io-channels : Channel node of a voltage io-channel.
> -- sense-resistor-micro-ohms : The sense resistance in microohms.
> -
> -Optional properties:
> -- sense-gain-mult: Amplifier gain multiplier. The default is <1>.
> -- sense-gain-div: Amplifier gain divider. The default is <1>.
> -
> -Example:
> -
> -sysi {
> -	compatible = "current-sense-amplifier";
> -	io-channels = <&tiadc 0>;
> -
> -	sense-resistor-micro-ohms = <20000>;
> -	sense-gain-mul = <50>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
> new file mode 100644
> index 000000000000..920bdd8d12d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/current-sense-amplifier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Current Sense Amplifier
> +
> +maintainers:
> +  - Peter Rosin <peda@axentia.se>
> +
> +description: |
> +  When an io-channel measures the output voltage from a current sense
> +  amplifier, the interesting measurement is almost always the current
> +  through the sense resistor, not the voltage output. This binding
> +  describes such a current sense circuit.
> +
> +properties:
> +  compatible:
> +    const: current-sense-amplifier
> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  sense-resistor-micro-ohms:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type for props with unit suffix.

> +    description: The sense resistance.
> +
> +  sense-gain-mult:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Amplifier gain multiplier. The default is <1>.
> +
> +  sense-gain-div:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Amplifier gain divider. The default is <1>.
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - sense-resistor-micro-ohms
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sysi {
> +        compatible = "current-sense-amplifier";
> +        io-channels = <&tiadc 0>;
> +
> +        sense-resistor-micro-ohms = <20000>;
> +        sense-gain-mult = <50>;
> +    };
> +...
> -- 
> 2.28.0
> 
