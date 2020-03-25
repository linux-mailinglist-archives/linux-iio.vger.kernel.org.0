Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3617B1930D9
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgCYTFt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 15:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgCYTFs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Mar 2020 15:05:48 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86522076F;
        Wed, 25 Mar 2020 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585163147;
        bh=++J1l22iODPsdFUfxz8jQjkKIYHE5X8erMXa2/ilh3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kqV2+isT+3mowQAoVTiPQgQ2DjtFWvGZpTKQwUYikcmB/fWfPgUOzc28y2M7gktVI
         w9tzmg7fhk5C331Kc/oMpWM1lLNsHzDQFQvRYDdyCdR87r7160m86Jcs369tMsYf4c
         TwyDfgeNuVOacPiiJrzD7oOc/pPLFvQrdRNJADYU=
Received: by mail-qv1-f51.google.com with SMTP id v38so1662572qvf.6;
        Wed, 25 Mar 2020 12:05:47 -0700 (PDT)
X-Gm-Message-State: ANhLgQ16jCYPmu0lN2Sh5en7ug2ds8Z/wJC70bUK3PzGZpr0DsHAH57x
        CM6D6q9a28uGAZBm6inuyhm68po2AR16OHyixg==
X-Google-Smtp-Source: ADFU+vsyukn7zvIPawA++JIpoRR33DaG19B2BoYv9ZrgL4BE0crMXNzCbxcpYD7SVqS9OR2ZR0zCz4JJu7zGUp7IlWY=
X-Received: by 2002:ad4:4bc3:: with SMTP id l3mr4462107qvw.79.1585163146836;
 Wed, 25 Mar 2020 12:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200324094506.55938-1-alexandru.tachici@analog.com> <20200324094506.55938-3-alexandru.tachici@analog.com>
In-Reply-To: <20200324094506.55938-3-alexandru.tachici@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 25 Mar 2020 13:05:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKFdcACQtXd5h=4Pxbij+=uoHr2rLTFZMq4fVX8ph398g@mail.gmail.com>
Message-ID: <CAL_JsqKFdcACQtXd5h=4Pxbij+=uoHr2rLTFZMq4fVX8ph398g@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] dt-bindings: iio: dac: AD5570R fix bindings errors
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 24, 2020 at 3:45 AM <alexandru.tachici@analog.com> wrote:
>
> From: Alexandru Tachici <alexandru.tachici@analog.com>
>
> Replaced num property with reg property, fixed errors
> reported by dt-binding-check.
>
> Fixes: ea52c21268e6 ("iio: dac: ad5770r: Add AD5770R support")
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad5770r.yaml         | 77 ++++++++++---------
>  1 file changed, 40 insertions(+), 37 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> index d9c25cf4b92f..d1755dbc1a41 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> @@ -2,7 +2,7 @@
>  # Copyright 2020 Analog Devices Inc.
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/iio/dac/adi,ad5770r.yaml#
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5770r.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Analog Devices AD5770R DAC device driver
> @@ -49,83 +49,84 @@ properties:
>        asserted during driver probe.
>      maxItems: 1
>
> -  channel0:
> +  channel@0:
>      description: Represents an external channel which are
>        connected to the DAC. Channel 0 can act both as a current
>        source and sink.
>      type: object
>
>      properties:
> -      num:
> +      reg:
>          description: This represents the channel number.
> -        items:
> -          const: 0
>
>        adi,range-microamp:
>            description: Output range of the channel.
>            oneOf:
> -            - $ref: /schemas/types.yaml#/definitions/int32-array
>              - items:
> -                - enum: [0 300000]
> -                - enum: [-60000 0]
> -                - enum: [-60000 300000]
> +                - const: 0
> +                - const: 300000
> +            - items:
> +                - const: -60000
> +                - const: 0
> +            - items:
> +                - const: -60000
> +                - const: 300000
>
> -  channel1:
> +  channel@1:
>      description: Represents an external channel which are
>        connected to the DAC.
>      type: object
>
>      properties:
> -      num:
> +      reg:
>          description: This represents the channel number.
> -        items:
> -          const: 1

This should be:

reg:
  const: 1

>
>        adi,range-microamp:
>            description: Output range of the channel.
>            oneOf:
> -            - $ref: /schemas/types.yaml#/definitions/uint32-array
>              - items:
> -                - enum: [0 140000]
> -                - enum: [0 250000]
> +                - const: 0
> +                - const: 140000
> +            - items:
> +                - const: 0
> +                - const: 250000
>
> -  channel2:
> +  channel@2:
>      description: Represents an external channel which are
>        connected to the DAC.
>      type: object
>
>      properties:
> -      num:
> +      reg:
>          description: This represents the channel number.
> -        items:
> -          const: 2
>
>        adi,range-microamp:
>            description: Output range of the channel.
>            oneOf:
> -            - $ref: /schemas/types.yaml#/definitions/uint32-array
>              - items:
> -                - enum: [0 140000]
> -                - enum: [0 250000]
> +                - const: 0
> +                - const: 55000
> +            - items:
> +                - const: 0
> +                - const: 150000
>
>  patternProperties:
>    "^channel@([3-5])$":
>      type: object
>      description: Represents the external channels which are connected to the DAC.
>      properties:
> -      num:
> +      reg:
>          description: This represents the channel number.
> -        items:
> -          minimum: 3
> -          maximum: 5

reg:
  minimum: 3
  maximum: 5

>
>        adi,range-microamp:
>            description: Output range of the channel.
>            oneOf:
> -            - $ref: /schemas/types.yaml#/definitions/uint32-array
>              - items:
> -                - enum: [0 45000]
> -                - enum: [0 100000]
> +                - const: 0
> +                - const: 45000
> +            - items:
> +                - const: 0
> +                - const: 100000

This can be simplified to:

items:
  - const: 0
  - enum: [ 45000, 100000 ]

>
>  required:
>  - reg
> @@ -150,34 +151,36 @@ examples:
>                          vref-supply = <&vref>;
>                          adi,external-resistor;
>                          reset-gpios = <&gpio 22 0>;
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
>
>                          channel@0 {
> -                                num = <0>;
> -                                adi,range-microamp = <(-60000) 300000>;
> +                                reg = <0>;
> +                                adi,range-microamp = <0 300000>;
>                          };
>
>                          channel@1 {
> -                                num = <1>;
> +                                reg = <1>;
>                                  adi,range-microamp = <0 140000>;
>                          };
>
>                          channel@2 {
> -                                num = <2>;
> +                                reg = <2>;
>                                  adi,range-microamp = <0 55000>;
>                          };
>
>                          channel@3 {
> -                                num = <3>;
> +                                reg = <3>;
>                                  adi,range-microamp = <0 45000>;
>                          };
>
>                          channel@4 {
> -                                num = <4>;
> +                                reg = <4>;
>                                  adi,range-microamp = <0 45000>;
>                          };
>
>                          channel@5 {
> -                                num = <5>;
> +                                reg = <5>;
>                                  adi,range-microamp = <0 45000>;
>                          };
>                  };
> --
> 2.20.1
>
