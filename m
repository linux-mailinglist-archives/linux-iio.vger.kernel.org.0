Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D427185C19
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 11:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgCOK6k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 06:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgCOK6k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 06:58:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E757E206BE;
        Sun, 15 Mar 2020 10:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584269918;
        bh=GKvZg20vaGmZ0h4NBf/C9EDtK/ii4Ksp0xz+3VPzmhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FD3xSF49EZqCtfgRx4gsGhywyNgjqk5rW1lcjV/lJBiDw4GQIx9qrLjpPOykh2+10
         Pyl4H6LO0Oee2K5LtcFwJGXOqr9/v5sRjLRSwbNCRyFIuXvQ0B9srUvcmyy25Rx65c
         wmihRAgNYeB8EjLFWxBQBiY5CfC9zjr5f1myB7Ms=
Date:   Sun, 15 Mar 2020 10:58:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, sre@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: tsl2563: convert bindings to YAML
Message-ID: <20200315105834.7a5f4475@archlinux>
In-Reply-To: <20200314134237.12187-1-nish.malpani25@gmail.com>
References: <20200314134237.12187-1-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Mar 2020 19:12:37 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Convert the TSL2563 device tree bindings to the new YAML format.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> ---
> 
> The link for the datasheet is not attached in the binding document
> because it was not available on the manufacturer's (AMS) website [1].

Very old part now, though plenty of them in circulation or least there
used to be.  I have though not powered up that board for a while.

When doing these conversions, do sanity check them against the driver
as the old docs aren't always entirely accurate ;)

Jonathan

> 
> [1] https://ams.com/ambient-light-sensors
> ---
>  .../devicetree/bindings/iio/light/tsl2563.txt | 19 --------
>  .../bindings/iio/light/tsl2563.yaml           | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.txt b/Documentation/devicetree/bindings/iio/light/tsl2563.txt
> deleted file mode 100644
> index f91e809e736e..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/tsl2563.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -* AMS TAOS TSL2563 ambient light sensor
> -
> -Required properties:
> -
> -  - compatible : should be "amstaos,tsl2563"
> -  - reg : the I2C address of the sensor
> -
> -Optional properties:
> -
> -  - amstaos,cover-comp-gain : integer used as multiplier for gain
> -                              compensation (default = 1)
> -
> -Example:
> -
> -tsl2563@29 {
> -	compatible = "amstaos,tsl2563";
> -	reg = <0x29>;
> -	amstaos,cover-comp-gain = <16>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.yaml b/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
> new file mode 100644
> index 000000000000..2a70b8d62760
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/tsl2563.yaml#

Convention is now to name files and this with the manufacturer part
as well.

light/amstaos,tsl2563.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS TAOS TSL2563 ambient light sensor
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |
> +  Ambient light sensor with an i2c interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amstaos,tsl2563

The original binding was wrong on this.   Check the driver :)
I'm a bit embarrassed I never noticed during review as I have
a tsl2561, be it on a board that was never converted to DT.

> +
> +  reg:
> +    maxItems: 1
> +
> +  amstaos,cover-comp-gain:
> +    description: Multiplier for gain compensation
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 16]

Not sure it's that restricted...  or to be honest what
that is for at all.  Superficially it looks like
a multiplier to change the 'range' of the the sysfs control.

I wonder if anyone cares or if we can just start ignoring that going
forwards?  Sebastian, anyone else?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      light-sensor@29 {
> +        compatible = "amstaos,tsl2563";
> +        reg = <0x29>;
> +        amstaos,cover-comp-gain = <16>;
> +      };
> +    };
> +...

