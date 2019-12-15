Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4311F99F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 18:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfLORTz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 12:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfLORTz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 12:19:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6102465E;
        Sun, 15 Dec 2019 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576430393;
        bh=aTFw+ue28k3fWWpmU7kl52EDBOR30STcBywtYtrnGF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j4r4yhx31Xgac1qbS50FGIx+Z95MtzryAfqk6mzcfRvNkpDr5PX2PZ0ljNvSk95lu
         V6Sc10+aZcik5533OOqz9+tD1ByYkqBgfCv1Q20d2Xf+6db0c4HxSZ8MEzTvH6NdKJ
         WSOYoIPO2DV/NKCEebae4sARRrWQX0g+EwcXk33Y=
Date:   Sun, 15 Dec 2019 17:19:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     ruantu <mtwget@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: chemical: Add bindings for
 Dynament Premier series single gas sensor
Message-ID: <20191215171949.1b817a40@archlinux>
In-Reply-To: <20191210053744.732093-1-mtwget@gmail.com>
References: <20191210053744.732093-1-mtwget@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Dec 2019 13:37:44 +0800
ruantu <mtwget@gmail.com> wrote:

> Dynament Premier series single gas sensor.
> 
> Signed-off-by: ruantu <mtwget@gmail.com>
> ---
>  .../iio/chemical/dynament,premier.yaml        | 43 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  1 +
>  3 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> new file mode 100644
> index 000000000000..076ae9d90cee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0

The dt maintainers are asking if possible for all new bindings to be dual licensed
with BSD as it makes them easier to reuse outside linux.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/dynament,premier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynament Premier series single gas sensor
> +
> +maintainers:
> +  - ruantu <mtwget@gmail.com>
> +
> +description: |
> +  single gas sensor capable of measuring gas concentration of dust
> +  particles, multi-gas sensor are not supported.
> +
> +  Specifications about the sensor can be found at:
> +    https://www.dynament.com/_webedit/uploaded-files/All%20Files/SIL%20Data/tds0045_1.44.pdf, read chapter 1.5.2 Read live data simple
> +
> +properties:
> +  compatible:
> +    enum:
> +      - dynament,premier
> +
> +  vcc-supply:
> +    description: regulator that provides power to the sensor
> +
> +  reset-gpios:
> +    description: GPIO connected to the RESET line
> +    maxItems: 1
Good to have the regulator and reset defined from the start.  It may be worth adding
the regulator enable to the driver.  Reset is actually optional I assume whereas
power isn't (it's just a question of whether it is already turned on or not!)
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
Bindings have indented in multiples of 4 spaces I believe.  That needs tidying
up in this example.

Thanks,

Jonathan

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
> index 18c26558ddfe..84592789e01b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13137,6 +13137,7 @@ DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
>  M:	ruantu <mtwget@gmail.com>
>  S:	Maintained
>  F:	drivers/iio/chemical/premier.c
> +F:	Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
>  
>  PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>

