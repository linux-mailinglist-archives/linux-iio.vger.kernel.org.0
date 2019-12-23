Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F674129989
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLWRsx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWRsx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:48:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC825206CB;
        Mon, 23 Dec 2019 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577123332;
        bh=gwIjikF5zlFCDz92LN6JzJQC6G/G+pyURfALwli8AmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KCR41FXkmWF9YX77mJiBDrov0QMSYrMxxuliD5KxxjgZw0MPIwGDW2nP6MzUBhfQb
         UAQ7vkfO12wqVmD5gj1j22UgkSWPSct93lfMG/Ju4pdRq8XIvaj/CoMcdhT4wimZGp
         KhY1TBiFcNXIu8UzC9bps04lSfXiDKhoqsDdhNGI=
Date:   Mon, 23 Dec 2019 17:48:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] bindings: iio: pressure: Add documentation for
 dlh driver
Message-ID: <20191223174848.2883abee@archlinux>
In-Reply-To: <20191211095946.7904-4-tomislav.denis@avl.com>
References: <20191211095946.7904-1-tomislav.denis@avl.com>
        <20191211095946.7904-4-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 10:59:46 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> Add a device tree binding documentation for DLH series pressure
> sensors.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
A few things I fixed up whilst applying this.

Applied with these tweaks to the togreg branch of iio.git.

Please take a look and check I didn't mess this up.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/pressure/asc,dlh.yaml  | 51 ++++++++++++++++++++++

Name is now asc,dlhl60d.yaml

>  MAINTAINERS                                        |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml
> new file mode 100644
> index 0000000..c2c1817
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/dlh.yaml#

This was already wrong, now has asc,dlhl60d.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: All Sensors DLH series low voltage digital pressure sensors
> +
> +maintainers:
> +  - Tomislav Denis <tomislav.denis@avl.com>
> +
> +description: |
> +  Bindings for the All Sensors DLH series pressure sensors.
> +
> +  Specifications about the sensors can be found at:
> +    http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
> +
> +properties:
> +  compatible:
> +    enum:
> +      - asc,dlhl60d
> +      - asc,dlhl60g
> +
> +  reg:
> +    description: I2C device address
> +    maxItems: 1
> +
> +  interrupts:
> +    description: interrupt mapping for EOC(data ready) pin
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c0 {
Spacing is pretty random in here. Now consistent 4 space indent
throughout.


> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pressure@29 {
> +          compatible = "asc,dlhl60d";
> +          reg = <0x29>;
> +          interrupt-parent = <&gpio0>;
> +          interrupts = <10 IRQ_TYPE_EDGE_RISING>;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0fa24df..7e181b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -674,6 +674,7 @@ W:	http://www.allsensors.com/
>  S:	Maintained
>  L:	linux-iio@vger.kernel.org
>  F:	drivers/iio/pressure/dlh.c
> +F:	Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml
>  
>  ALLEGRO DVT VIDEO IP CORE DRIVER
>  M:	Michael Tretter <m.tretter@pengutronix.de>

