Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C10139ADA
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 21:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgAMUld (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 15:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgAMUld (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 15:41:33 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5A224655;
        Mon, 13 Jan 2020 20:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578948092;
        bh=5+/QttMFBTDDwggNuisVLgzB3SWlxubJiVA9nfjskkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cpfntGbdsRS2I6uTn4k8+dkBla5PNezHWPeFDOuKQVaes84OAnAi/zMEP3l2JbRry
         y2R4sAn45tbCim9mZFk8Ua8iiVdppbOwa46dE566UK71NPZYMhC5iwXzfdw5dRZmsU
         trCWiLWeEOJzNRlIhLpnYiIQEZ+M1oPJ77apu46M=
Received: by mail-qv1-f46.google.com with SMTP id n8so4648981qvg.11;
        Mon, 13 Jan 2020 12:41:31 -0800 (PST)
X-Gm-Message-State: APjAAAVHOVCyb2/bRHnSWuQm6aFDE/6EWLTQSYs0Ra0MWME4WRbMbxIy
        6D1/UyPAXEDu0rnkjpadKNlrUnbllbp3+wFzFw==
X-Google-Smtp-Source: APXvYqwBh8rgbcv6WzjXYOWH4WoTlhfdYVgJpvcmQqGHfiRse1JHvRooPMQAyv3dmdw8NTILDX0JlPQ8wyDZJVjozMc=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr12930551qvn.79.1578948091025;
 Mon, 13 Jan 2020 12:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20200113141555.16117-1-beniamin.bia@analog.com> <20200113141555.16117-2-beniamin.bia@analog.com>
In-Reply-To: <20200113141555.16117-2-beniamin.bia@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Jan 2020 14:41:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKX5X6X72Rq7wY7=RRLnUST+eKTPyEbuXKbFJB0_n5QXQ@mail.gmail.com>
Message-ID: <CAL_JsqKX5X6X72Rq7wY7=RRLnUST+eKTPyEbuXKbFJB0_n5QXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: amplifiers: Add docs for HMC425A
 Step Attenuator
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        biabeniamin@outlook.com, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 13, 2020 at 8:14 AM Beniamin Bia <beniamin.bia@analog.com> wrote:
>
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> Document support for Analog Devices MC425A Step Attenuator.
>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml

Check your bindings with 'make dt_binding_check'. It fails:

Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml:
while scanning a simple key
  in "<unicode string>", line 24, column 5
could not find expected ':'
  in "<unicode string>", line 25, column 5

>
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> new file mode 100644
> index 000000000000..6f4a292395e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,hmc425a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HMC425A 6-bit Digital Step Attenuator
> +
> +maintainers:
> +- Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Digital Step Attenuator IIO device with gpio interface.
> +  HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
> +
> +properties:
> +compatible:
> +    enum:
> +    - adi,hmc425a

nit: this should be indented 2 more spaces.

Or use 'const' instead if there's not more similar parts.

> +
> +vcc-supply:
> +    description:
> +    digital voltage regulator (see regulator/regulator.txt)

Text must be indented under the key.

> +    maxItems: 1
> +
> +ctrl-gpios:
> +    description:
> +    Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
> +    connected to the control pins V1-V6.
> +    maxItems: 6
> +
> +required:
> +- compatible
> +- ctrl-gpios
> +
> +examples:
> +- |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    &gpio {
> +    #address-cells = <1>;
> +    #size-cells = <0>;
> +      gpio_hmc425a: hmc425a {
> +        compatible = "adi,hmc425a";
> +        ctrl-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>,
> +          <&gpio 39 GPIO_ACTIVE_HIGH>,
> +          <&gpio 38 GPIO_ACTIVE_HIGH>,
> +          <&gpio 37 GPIO_ACTIVE_HIGH>,
> +          <&gpio 36 GPIO_ACTIVE_HIGH>,
> +          <&gpio 35 GPIO_ACTIVE_HIGH>;
> +
> +        vcc-supply = <&foo>;
> +      };
> +    }
> --
> 2.17.1
>
