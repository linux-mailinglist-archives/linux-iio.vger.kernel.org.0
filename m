Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2810E1E9
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 13:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfLAMiL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 07:38:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfLAMiL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 07:38:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3702A20748;
        Sun,  1 Dec 2019 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575203891;
        bh=YUHmSOBJj4OlC3XLzBTmwmeHkMj4d/d8XPF3I7BpMYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ioEEbEcOwBo8ayfmnn1rQLkTa1VYnnC+jGBEPgszUFNS6/16DejeR7esmYF68WJ/F
         TiSbv2A+q1DRYhCQPyNTNYPhpcb4kK+o1bZ39se7Ip2ka6/LcfnMJpfL74mfua9FnS
         R9Ajpx+RHx4o8b61iWq+VUvr8wMDX1ImPpYT5boU=
Date:   Sun, 1 Dec 2019 12:38:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20191201123807.41f62181@archlinux>
In-Reply-To: <E9781938-9BFB-4978-83AB-B17B0BE01BC3@norphonic.com>
References: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
        <E9781938-9BFB-4978-83AB-B17B0BE01BC3@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Nov 2019 20:12:17 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

> Device tree bindings for HDC2010/HDC2080 driver.
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> 
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml	2019-11-28 15:35:17.874477013 +0100
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0
Rob has been asking for new bindings to be dual licensed
# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)

If you are happy to do so that would be great.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/hdc2010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC2010/HDC2080 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Eugene Zaikonnikov <eugene.zaikonnikov@norophonic.com>
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
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hdc200x@40 {
> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;
> +      };
> +    };
> 

