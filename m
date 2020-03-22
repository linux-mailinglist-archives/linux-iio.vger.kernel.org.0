Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45F918E9FD
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgCVQDP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVQDO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 12:03:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D41C20724;
        Sun, 22 Mar 2020 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584892994;
        bh=zXKtvWmOJZYh/9N09ZMXjZg48/WZSaCWDDWdoRddous=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T4WEWq3BiPOuIWj+WyDBysIh74u8ToS7YKTHCRhb7dWRQL1NF4DPhjt5ASy9DjMlg
         LIWf1c05pLqpu47rWmp7NGnKIwFzJdiC3SlZCu5MrACHZZoEuuUkbYnEQEogMT+EMn
         oJUaz8jHoB07xaBShIQ5UN7ySxpq4PMagywpL/Iw=
Date:   Sun, 22 Mar 2020 16:03:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Message-ID: <20200322160310.67365997@archlinux>
In-Reply-To: <1C2C8CD5-4BF0-40AE-932A-4AD506664B9D@norphonic.com>
References: <84EE5291-D8C4-40D3-A75C-92362BF9DF8B@norphonic.com>
        <1C2C8CD5-4BF0-40AE-932A-4AD506664B9D@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Mar 2020 20:09:48 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

> Device tree bindings for the HDC2010/2080 driver.
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Hi Eugene

A few minor things inline

Jonathan

> 
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	2020-02-12 14:28:42.562903814 +0100
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/hdc2010.yaml#

As Rob's bot pointed out... ti,hdc2010.yaml preferred.

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
> +  vddd-supply:

ddd rather than dd?

> +    description:
> +      digital voltage regulator (see regulator/regulator.txt)

For main supply probably don't need to bother with description.

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

Naming should be 'generic'. 
humidity@40 {

Is probably appropriate though not on the explicit list in the devicetree
spec yet.

> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;
> +      };
> +    };
> 

