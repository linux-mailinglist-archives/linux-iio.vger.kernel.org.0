Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3A115640
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2019 18:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFROP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 12:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfLFROO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 12:14:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3426321835;
        Fri,  6 Dec 2019 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575652454;
        bh=9JpTaDgIVyzU2wRzhv291fihCdjvrJVjxLn/vHo0e1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXsAw+PmsM6gEdwyT9WQx0yeTvmUo6VjSnujVqfGOpmB6GZzAoqsl3NymIfrlsp6Y
         trIDQeen3yM4WINOVBL8KbC3rzXecveLfEIbxkTIkfTTmT1SNbyHeIVd0zAg6y6JNC
         FvXXAWPXSiUOLO7H+iQQW3WT3haLKoee7jkIFjzc=
Date:   Fri, 6 Dec 2019 17:14:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20191206171409.35f7f776@archlinux>
In-Reply-To: <76F5F343-49E1-4D7D-9A7C-FB5A3C1C5862@norphonic.com>
References: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
        <E9781938-9BFB-4978-83AB-B17B0BE01BC3@norphonic.com>
        <20191201123807.41f62181@archlinux>
        <EF648C3D-28B1-4509-AE3D-F24668A6849B@norphonic.com>
        <76F5F343-49E1-4D7D-9A7C-FB5A3C1C5862@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Dec 2019 11:41:20 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

> The previous was mis-formatted, sorry for that.
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

Please resend as a separate thread. It should not be in reply to the
previous one or have a title that makes no sense for this patch.

Otherwise looks fine to me.

Thanks,

Jonathan
> 
> diff -uprN linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010 linux-5.3.8_docs/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
> --- linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	2019-12-02 11:09:25.803326999 +0100
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
> +KernelVersion:	5.3.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Controls the heater device within the humidity sensor to get
> +		rid of excess condensation.
> +
> +		Valid control values are 0 = OFF, and 1 = ON.
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml	2019-12-02 08:43:32.508277082 +0100
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
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

