Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4BE196739
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgC1QEh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 12:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgC1QEh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 12:04:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A153E206DB;
        Sat, 28 Mar 2020 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585411476;
        bh=AKUkbkRfY/IcOObociTk2nIYvu/Ff33DG1VMwOD9g5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S4ncorX9/KaT0XSmf6TJ8KnvM08wuIwzilUC8FVfJJ2oJbGXjjkuBubGh4zJFvRwd
         UWWmvXQp9lq6Tr3cuMeiq/aCTngvnUTlurTregvu9p0ZMnH08AIdsAhequE7DHt/hV
         3fQ/tMDTlWuYJVJAFbZIa/kEDYVA1dkPFKuSRO4A=
Date:   Sat, 28 Mar 2020 16:04:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: accel: Add bmi088
 accelerometer bindings
Message-ID: <20200328160431.365ee392@archlinux>
In-Reply-To: <20200324080309.12171-1-mike.looijmans@topic.nl>
References: <20200324080309.12171-1-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 09:03:07 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Ah. For some reason I missed there was a v5. Comments on the v4 binding.

Jonathan

> ---
> v2: convert to yaml format
> v3..v4: -
> v5: submit together with driver code as patch series
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

