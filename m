Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3511966E6
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 16:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgC1PTd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 11:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgC1PTd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 11:19:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B7B20716;
        Sat, 28 Mar 2020 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585408772;
        bh=3FpOqlp62zWsadRbpg8ISDnWML7ZQ6fDKR5Cz7RJ+g8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z1PRnsmUmGISBlei7hEHBrqg8rGQ1FABnyjr2RG6UbhySsO8mypi7rlSYlh1A95eV
         JDDM02bi57ZWMGxQGGU9QL5da7q4a9PYSMYY65Uv9weJsugR+HPoXC4tLXbLzl5+SE
         ahJf0wcXi2hM9GjOVUjDFhwvj/UBNxlCCw+q/6H0=
Date:   Sat, 28 Mar 2020 15:19:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v2] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
Message-ID: <20200328151928.12f5517e@archlinux>
In-Reply-To: <20200323095551.23500-1-mike.looijmans@topic.nl>
References: <20200323095551.23500-1-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Mar 2020 10:55:51 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Hi Mike

The binding should look to be as complete as possible, independent on what
we are actually using in the driver.

A quick glance at the datasheet shows me this device has 2 interrupt lines
dedicated to the accelerometer and 2 power supplies, vddio and vdd.

Interrupt lines for flexible parts like this are fiddly to do, so take
a look at how we do this in other drivers.  Hmm. the interrupt line to set
a tag is 'interesting'.  I'd ignore that for now...

> ---
> v2: convert to yaml format
> 
>  .../bindings/iio/accel/bosch,bmi088.yaml      | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> new file mode 100644
> index 000000000000..715f79c3b2a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#

Should reflect the compatible so include the accel part.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI088 IMU accelerometer part
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Acceleration part of the IMU sensor with an SPI interface
> +
> +  Specifications about the sensor can be found at:
> +    https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,bmi088_accel
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
> +  spi {
> +    bmi088_accel@1 {
> +      compatible = "bosch,bmi088_accel";
> +      reg = <1>;
> +      spi-max-frequency = <10000000>;
> +    };
> +  };

