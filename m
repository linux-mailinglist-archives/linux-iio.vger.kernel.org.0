Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4DB2BC851
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgKVSu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 13:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgKVSu1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 13:50:27 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B029620760;
        Sun, 22 Nov 2020 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606071026;
        bh=hlcEGsVEJROX3fqxLFaIKYiUewk3W7pnaxmh2MnBvwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ahjACLArsbIuxWnbwIjVnS508FAxWf5MO51URga/askkYQr5803MV7cXZsmavH6Nk
         V7EgkAJPBXcXvNgVB1AbMXls+NtcD+gjasZvEQXanAVXjQd4uG50FG0Lr9oKhU465m
         Txkf82u2ONdLgJ0aCLGSu3eNtlIIonC82gZcXWfs=
Date:   Sun, 22 Nov 2020 18:50:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 42/46] dt-bindings:iio:accel:fsl,mma8452: txt to yaml
 conversion.
Message-ID: <20201122185021.75ebc33b@archlinux>
In-Reply-To: <20201103163407.GG1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-43-jic23@kernel.org>
        <20201103163407.GG1754553@bogus>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Nov 2020 10:34:07 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Oct 31, 2020 at 06:48:50PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple binding so mostly straight forward to convert.
> > Original binding was unclear on how many interrupts there are.
> > The device has two such lines, whilst I believe the driver currently
> > only uses one at a time.  The binding should allow both to be specified.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> > ---
> >  .../bindings/iio/accel/fsl,mma8452.yaml       | 62 +++++++++++++++++++
> >  .../devicetree/bindings/iio/accel/mma8452.txt | 35 -----------
> >  2 files changed, 62 insertions(+), 35 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
> > new file mode 100644
> > index 000000000000..3b8e5ebdf90c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/accel/fsl,mma8452.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title:
> > +  Freescale MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC or FXLS8471Q
> > +  triaxial accelerometer
> > +
> > +maintainers:
> > +  - Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,mma8451
> > +      - fsl,mma8452
> > +      - fsl,mma8453
> > +      - fsl,mma8652
> > +      - fsl,mma8653
> > +      - fsl,fxls8471
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description:
> > +      2 highly configurable interrupt lines exist.
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    description: Specify which interrupt line is in use.
> > +    enum:
> > +      - INT1
> > +      - INT2  
> 
> This will default to only 1 item allowed. You need minItems/maxItems.
> 
Done, plus stuck the enum under an items: to avoid a build error.

Thanks,

Jonathan

> > +
> > +  vdd-supply: true
> > +  vddio-supply: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        accel@1d {
> > +            compatible = "fsl,mma8453";
> > +            reg = <0x1d>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <5 0>;
> > +            interrupt-names = "INT2";
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> > deleted file mode 100644
> > index e132394375a1..000000000000
> > --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> > +++ /dev/null
> > @@ -1,35 +0,0 @@
> > -Freescale MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC or FXLS8471Q
> > -triaxial accelerometer
> > -
> > -Required properties:
> > -
> > -  - compatible: should contain one of
> > -    * "fsl,mma8451"
> > -    * "fsl,mma8452"
> > -    * "fsl,mma8453"
> > -    * "fsl,mma8652"
> > -    * "fsl,mma8653"
> > -    * "fsl,fxls8471"
> > -
> > -  - reg: the I2C address of the chip
> > -
> > -Optional properties:
> > -
> > -  - interrupts: interrupt mapping for GPIO IRQ
> > -
> > -  - interrupt-names: should contain "INT1" and/or "INT2", the accelerometer's
> > -		     interrupt line in use.
> > -
> > -  - vdd-supply: phandle to the regulator that provides vdd power to the accelerometer.
> > -
> > -  - vddio-supply: phandle to the regulator that provides vddio power to the accelerometer.
> > -
> > -Example:
> > -
> > -	mma8453fc@1d {
> > -		compatible = "fsl,mma8453";
> > -		reg = <0x1d>;
> > -		interrupt-parent = <&gpio1>;
> > -		interrupts = <5 0>;
> > -		interrupt-names = "INT2";
> > -	};
> > -- 
> > 2.28.0
> >   

