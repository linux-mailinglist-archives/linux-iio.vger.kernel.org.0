Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90531DD5F2
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgEUS1l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 14:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUS1l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 14:27:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64125207D3;
        Thu, 21 May 2020 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590085661;
        bh=AJq8D1sezcTscWFiqfDbRHe+iBg/UCAk68lU7qLM8lE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w8sYnXA6MaeQs1jOkoEPeFI9nt+VIVx0taLtldCp9peobh9Nsgf6zzDWVVcshMKmR
         NsPgqmkPIgWI9s8XE6GhPILhnuDflKr5MnC0oHiDJNW4pe1dUzA6AIg7fv0WBZytdF
         k7Z0JwLXj4i+nMfsRM7qvTx4vz5N9EMPqfluuAN8=
Date:   Thu, 21 May 2020 19:27:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt
 format to yaml
Message-ID: <20200521192736.4818f17b@archlinux>
In-Reply-To: <20200520072423.GF3361@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
        <20200519075111.6356-2-jonathan.albrieux@gmail.com>
        <20200519184933.00003f00@Huawei.com>
        <20200520072423.GF3361@ict14-OptiPlex-980>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 May 2020 09:24:23 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> On Tue, May 19, 2020 at 06:49:33PM +0100, Jonathan Cameron wrote:
> > On Tue, 19 May 2020 09:50:57 +0200
> > Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> >   
> > > Converts documentation from txt format to yaml 
> > > 
> > > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > > ---
> > >  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
> > >  .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
> > >  2 files changed, 84 insertions(+), 37 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
> > >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> > > deleted file mode 100644
> > > index 900c169de00f..000000000000
> > > --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> > > +++ /dev/null
> > > @@ -1,37 +0,0 @@
> > > -Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
> > > -and externally connectable Magnetometer
> > > -
> > > -https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> > > -
> > > -Required properties:
> > > - - compatible : should be "bosch,bmi160"
> > > - - reg : the I2C address or SPI chip select number of the sensor
> > > - - spi-max-frequency : set maximum clock frequency (only for SPI)
> > > -
> > > -Optional properties:
> > > - - interrupts : interrupt mapping for IRQ
> > > - - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
> > > -   input, set to "INT2" if INT2 pin should be used instead
> > > - - drive-open-drain : set if the specified interrupt pin should be configured as
> > > -   open drain. If not set, defaults to push-pull.
> > > -
> > > -Examples:
> > > -
> > > -bmi160@68 {
> > > -	compatible = "bosch,bmi160";
> > > -	reg = <0x68>;
> > > -
> > > -	interrupt-parent = <&gpio4>;
> > > -	interrupts = <12 IRQ_TYPE_EDGE_RISING>;
> > > -	interrupt-names = "INT1";
> > > -};
> > > -
> > > -bmi160@0 {
> > > -	compatible = "bosch,bmi160";
> > > -	reg = <0>;
> > > -	spi-max-frequency = <10000000>;
> > > -
> > > -	interrupt-parent = <&gpio2>;
> > > -	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> > > -	interrupt-names = "INT2";
> > > -};
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > > new file mode 100644
> > > index 000000000000..6b464ce5ed0b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > > @@ -0,0 +1,84 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/imu/bmi160.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Bosch BMI160
> > > +
> > > +maintainers:
> > > +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>  
> > 
> > Daniel is still active in the kernel, just not at Intel any more. +CC
> >   
> 
> Oh ok thank you! Daniel are you still maintaining this driver?
> 
> > > +
> > > +description: |
> > > +  Inertial Measurement Unit with Accelerometer, Gyroscope and externally
> > > +  connectable Magnetometer
> > > +  https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: bosch,bmi160
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: the I2C address or SPI chip select number of the sensor  
> > 
> > As standard for i2c and spi, usually no need to have a description line for
> > this element.
> >   
> 
> Thank you, will remove the description then.
> 
> > > +
> > > +  spi-max-frequency:
> > > +    maxItems: 1
> > > +    description: set maximum clock frequency (required only for SPI)  
> > 
> > Standard spi binding.  Probably doesn't need to be included here.
> >   
> 
> So should I completely remove it from properties?

Yes


Thanks,

Jonathan
