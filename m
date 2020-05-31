Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30C41E9729
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgEaLBL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 07:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgEaLBF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 07:01:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D79206E2;
        Sun, 31 May 2020 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590922865;
        bh=6IAidZY1+gI+o1s3JqU4Fc3R0wczrkHkqpDvrhYNkhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yq0DoSx+qprYgkZSJWSG4L5TorTjlIgbYyOOMRxmPX68+d/zZpnMYhcqT2reIJ2mE
         xah/bVD1Eh9CmdTRtR8m/4FSXVuu6uTQ8Bis20JaSHMrh8DSC5CH2nGssgDXd1kq0a
         zlmFXxX8yW5Sxi+8xz6oKkd0BK8I2ZoaF9U7ercE=
Date:   Sun, 31 May 2020 12:01:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: Re: [PATCH v7 3/5] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
Message-ID: <20200531120101.463d031b@archlinux>
In-Reply-To: <20200528145930.11860-1-jonathan.albrieux@gmail.com>
References: <20200528145930.11860-1-jonathan.albrieux@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 May 2020 16:59:28 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Add reset-gpio support.
> 
> Without reset's deassertion during ak8975_power_on(), driver's probe fails
> on ak8975_who_i_am() while checking for device identity for AK09911 chip.
> 
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheet says that, if not used, reset pin should be connected
> to VID. This patch emulates this situation.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> ---
>  .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> index 55b18784e503..e8af53d60759 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> @@ -47,6 +47,11 @@ properties:
>    mount-matrix:
>      description: an optional 3x3 mounting rotation matrix.
>  
> +  reset-gpios:
> +    description: |
> +      an optional pin needed for AK09911 to set the reset state. This should
> +      be usually active low
> +
>  required:
>    - compatible
>    - reg
> @@ -54,6 +59,7 @@ required:
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
>      i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -64,6 +70,7 @@ examples:
>              interrupt-parent = <&gpio6>;
>              interrupts = <15 IRQ_TYPE_EDGE_RISING>;
>              vdd-supply = <&ldo_3v3_gnss>;
> +            reset-gpios = <&msmgpio 111 GPIO_ACTIVE_LOW>;
>              mount-matrix = "-0.984807753012208",  /* x0 */
>                             "0",                   /* y0 */
>                             "-0.173648177666930",  /* z0 */

