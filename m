Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F324C23FDED
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHILmI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHILmF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:42:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F430206B5;
        Sun,  9 Aug 2020 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596973325;
        bh=SXd31qhIHTOsuMWmdS7B/a+qIW0feHpAlIkdm499JMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hWmZmaMJPt6X2x2O2uSifqBCDfF6Xb5u2rBTtng7P14AfN4RhiUtwpq0reWkV7Ljf
         sLzZD1eKgc3AFdnXzq7MCHTpDXH9lmsI3t9CdP8j9qYGhMnVLvXx2Zfu1OXhBy9dJ9
         u76eixjabh1ydcnffTWOONchwLKsNXPwQ+/No6mA=
Date:   Sun, 9 Aug 2020 12:42:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zaikonnikov <ez@norphonic.com>
Cc:     Rob Herring <robh+dt@kernel.org>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v10 2/2] dt-bindings: iio: humidity: Add TI HDC20x0
 support
Message-ID: <20200809124200.5c90342d@archlinux>
In-Reply-To: <86h7te34hu.fsf@norphonic.com>
References: <86imdu35gs.fsf@norphonic.com>
        <86h7te34hu.fsf@norphonic.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 07 Aug 2020 16:38:53 +0200
Eugene Zaikonnikov <ez@norphonic.com> wrote:

> Add device tree bindings for HDC2010/HDC2080 family of humidity and
> temperature sensors.
> 
> Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Both applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> No changes since v9.
> 
> Changes since v8:
> - document the use of reg
> - change the license terms to GPL-2.0-only or BSD-2-clause
> 
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	2020-07-10 13:08:46.818076734 +0200
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/ti,hdc2010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC2010/HDC2080 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Eugene Zaikonnikov <ez@norophonic.com>
> +
> +description: |
> +  Relative humidity and tempereature sensors on I2C bus
> +
> +  Datasheets are available at:
> +    http://www.ti.com/product/HDC2010/datasheet
> +    http://www.ti.com/product/HDC2080/datasheet
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,hdc2010
> +      - ti,hdc2080
> +
> +  vdd-supply:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      humidity@40 {
> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;
> +      };
> +    };

