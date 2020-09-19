Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0450270EB4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgISO5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 10:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgISO5v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:57:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737D72075A;
        Sat, 19 Sep 2020 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600527471;
        bh=rt/WAYv/6WmcXCoFO4glnwYp0aV7M8iokl/Fk3Iipc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yMRoyc+xyJWduhUSFDJFCulfInk0l8tYti59KiiAeqesyrEFEZ81kxAca2H5Utqfr
         AyQkX8St+FqvHA/NGvsVUND4iY28f+JicpWUI19EEujwO5szU+8EdklKs9LSXgbSrh
         8k0gK4sCmmH1ToKCjTkfY36N7paYshEgtu//BBfU=
Date:   Sat, 19 Sep 2020 15:57:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v2 12/20] dt-bindings:iio:adc:dlg,da9150-gpadc yaml
 conversion
Message-ID: <20200919155747.6e206a6a@archlinux>
In-Reply-To: <20200915191230.GA2330650@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-13-jic23@kernel.org>
        <20200915191230.GA2330650@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:12:30 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 09, 2020 at 06:59:38PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This is a small part of an MFD so perhaps ultimately it makes more
> > sense to document it with that MFD binding rather than separately.
> > 
> > In the meantime it's a straightforward conversion from txt to yaml.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  .../bindings/iio/adc/da9150-gpadc.txt         | 16 ---------
> >  .../bindings/iio/adc/dlg,da9150-gpadc.yaml    | 33 +++++++++++++++++++
> >  2 files changed, 33 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
> > deleted file mode 100644
> > index c07228da92ac..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
> > +++ /dev/null
> > @@ -1,16 +0,0 @@
> > -Dialog Semiconductor DA9150 IIO GPADC bindings
> > -
> > -Required properties:
> > -- compatible: "dlg,da9150-gpadc" for DA9150 IIO GPADC
> > -- #io-channel-cells: Should be set to <1>
> > -  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
> > -
> > -For further information on GPADC channels, see device datasheet.
> > -
> > -
> > -Example:
> > -
> > -	gpadc: da9150-gpadc {
> > -		compatible = "dlg,da9150-gpadc";
> > -		#io-channel-cells = <1>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
> > new file mode 100644
> > index 000000000000..15c51d337108
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/dlg,da9150-gpadc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Dialog Semiconductor DA9150 IIO GPADC
> > +
> > +maintainers:
> > +  - Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +
> > +description:
> > +  This patch adds support for general purpose ADC within the
> > +  DA9150 Charger & Fuel-Gauge IC.
> > +
> > +properties:
> > +  compatible:
> > +    const: dlg,da9150-gpadc
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - "#io-channel-cells"  
> 
> additionalProperties...
> 
One day I'll remember to check this in all my patches! Sorry about that.
Fixed.
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied
> 
> > +
> > +examples:
> > +  - |
> > +    adc {
> > +        compatible = "dlg,da9150-gpadc";
> > +        #io-channel-cells = <1>;
> > +    };
> > +...
> > -- 
> > 2.28.0
> >   

