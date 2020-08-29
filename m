Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DAB256992
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgH2R6D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgH2R6C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Aug 2020 13:58:02 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A057DC061236
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2020 10:58:01 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 317669E01D1;
        Sat, 29 Aug 2020 18:57:55 +0100 (BST)
Date:   Sat, 29 Aug 2020 18:57:53 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Phil Reid <preid@electromag.com.au>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/13] dt-bindings: iio: adc: tlc4541 - recover
 accidentally dropped binding doc
Message-ID: <20200829185753.5d6bef4a@archlinux>
In-Reply-To: <20200809111753.156236-13-jic23@kernel.org>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-13-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  9 Aug 2020 12:17:52 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Phil Reid <preid@electromag.com.au>
> 
> JC: Seems that I messed up applying the original driver patches, and
> this file never actually made it into the tree.
> 
> I have picked up original Ack and Sign-off so as to record the
> history.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied.

> ---
>  .../devicetree/bindings/iio/adc/ti-tlc4541.txt  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
> new file mode 100644
> index 000000000000..6b2692723a04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
> @@ -0,0 +1,17 @@
> +* Texas Instruments' TLC4541
> +
> +Required properties:
> + - compatible: Should be one of
> +	* "ti,tlc4541"
> +	* "ti,tlc3541"
> +	- reg: SPI chip select number for the device
> + - vref-supply: The regulator supply for ADC reference voltage
> + - spi-max-frequency: Max SPI frequency to use (<= 200000)
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,tlc4541";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <200000>;
> +};

