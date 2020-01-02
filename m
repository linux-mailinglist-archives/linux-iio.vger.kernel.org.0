Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B912E197
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2020 03:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgABCGD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jan 2020 21:06:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35957 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgABCGD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jan 2020 21:06:03 -0500
Received: by mail-io1-f65.google.com with SMTP id r13so26993897ioa.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Jan 2020 18:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHVPj5/UF7FmXw5E/6Coz8EOtDK8UfYd1n1yDId2PbU=;
        b=XwQN52HFHiN4fB5kwYTv9zn1C76bI0Iz71wHNgvVewPn60QLGI/53rhJcn0f8qP7wG
         sYdC1zIp6TQZ1YvNlqMDGXJ9S/iB8GP3sVWi03ibUV1M0gGPnF9lkzJYdq5Sihm1aCxD
         JQsB5mHL8hEMMmYlnX96DExdAaIOIfSU1FKTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHVPj5/UF7FmXw5E/6Coz8EOtDK8UfYd1n1yDId2PbU=;
        b=ad/czyjvVuTr+DdlyoflGp3ptQxsvbvf3/MWMXO/L9O7R3XU0zrdkrYasKDe2FjsBa
         CPaSXMyrlBNGNH7v0ZuXjm4vLugBeRZsl0NSEeVZaOWL5Mq3WEyYB/XdzCQJymEg1CXg
         TJM2Du0JcjTUHfQGSpVp8jthPhLl56mOpSWXnk3XaiFEAM8Kv8xp5KDFQEkCYi90LOGF
         dKudNq2bQ2p2HEJFcDFaWXM6FczC74OFBZbxqthisdAdhlHSxPAx1PrTFf6clqcbLIFa
         EJAk18xDX0L1b/zV6UhZwF7KHtJBJ/ewGoZrMa4LtsHvBKqMKbeUTb7IGhOF/CKzp9pV
         rCgg==
X-Gm-Message-State: APjAAAWu/gcjV0OPMRLRn8/VeUKhk7yCmHqpaKWXS9fF8Ra+dKQGH6Vs
        uzs1WVTAobKcMDKBXX4LXjMzkCU3g23dmXHCfbJlvg==
X-Google-Smtp-Source: APXvYqwGWLjQw3gcajosmfzURd5ps+qyn12aquFWSg8sHauYhmdDjIpsc9fULZuWJKPuLIwEScJP+9CPNw9R1+t3PaY=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr64525970jad.136.1577930761321;
 Wed, 01 Jan 2020 18:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20191217102930.26102-1-mtwget@gmail.com>
In-Reply-To: <20191217102930.26102-1-mtwget@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 2 Jan 2020 10:05:49 +0800
Message-ID: <CAJCx=gnyF69PxHVh38nP1AYwi=Tt4J9bYYR-w00uGODUfCrKyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for
 Dynament Premier series single gas sensor
To:     YuDong Zhang <mtwget@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 17, 2019 at 6:29 PM YuDong Zhang <mtwget@gmail.com> wrote:
>
> Dynament Premier series single gas sensor.
>
> Signed-off-by: YuDong Zhang <mtwget@gmail.com>
> ---
>  .../iio/chemical/dynament,premier.yaml        | 39 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  1 +
>  3 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> new file mode 100644
> index 000000000000..e2bbae4dd086
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/dynament,premier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynament Premier series single gas sensor
> +
> +maintainers:
> +  - YuDong Zhang <mtwget@gmail.com>
> +
> +description: |
> +  single gas sensor capable of measuring gas concentration of dust
> +  particles, multi-gas sensor are not supported.
> +
> +  Specifications about the sensor can be found at:
> +    https://www.dynament.com/_webedit/uploaded-files/All%20Files/SIL%20Data/tds0045_1.44.pdf, read chapter 1.5.2 Read live data simple

Typo of sample?

- Matt

> +
> +properties:
> +  compatible:
> +    enum:
> +      - dynament,premier
> +
> +  vcc-supply:
> +    description: regulator that provides power to the sensor
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    serial {
> +      single-gas-sensor {
> +        compatible = "dynament,premier";
> +        vcc-supply = <&reg_vcc5v0>;
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 6046f4555852..5afca0586c41 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -261,6 +261,8 @@ patternProperties:
>      description: Dragino Technology Co., Limited
>    "^dserve,.*":
>      description: dServe Technology B.V.
> +  "^dynament,.*":
> +    description: Dynament, Ltd.
>    "^ea,.*":
>      description: Embedded Artists AB
>    "^ebs-systart,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae228ac7adc9..4842a0afe32b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5796,6 +5796,7 @@ DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
>  M:     YuDong Zhang <mtwget@gmail.com>
>  S:     Maintained
>  F:     drivers/iio/chemical/premier.c
> +F:     Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
>
>  DYNAMIC DEBUG
>  M:     Jason Baron <jbaron@akamai.com>
> --
> 2.24.1
>
