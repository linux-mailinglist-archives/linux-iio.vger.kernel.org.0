Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED32A2C16CD
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgKWUgO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 15:36:14 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:50500 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWUgO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 15:36:14 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id DBF889E01B5;
        Mon, 23 Nov 2020 20:36:11 +0000 (GMT)
Date:   Mon, 23 Nov 2020 20:36:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH 31/46] dt-bindings:iio:adc:x-powers,axp209-adc: txt to
 yaml conversion
Message-ID: <20201123203609.7da36d2e@archlinux>
In-Reply-To: <CAGb2v64KwkN5z_3nH-kUhJSAMeUfrU+zzn2tivJniT7c38BeAA@mail.gmail.com>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-32-jic23@kernel.org>
        <20201122181525.52410a84@archlinux>
        <CAGb2v64KwkN5z_3nH-kUhJSAMeUfrU+zzn2tivJniT7c38BeAA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Nov 2020 11:02:58 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Hi,
> 
> On Mon, Nov 23, 2020 at 2:22 AM Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> >
> > On Sat, 31 Oct 2020 18:48:39 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > This is a very small binding.  It might make sense at some stage
> > > to just roll it into the parent mfd.  For now, converted as is.
> > > The main advantage of this document is the identification of the
> > > channel index values when this is used as a provider of ADC channels
> > > to consumers.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Quentin Schulz <quentin.schulz@bootlin.com>  
> > Quentin's email address is boucing so for now I've put myself as maintainer
> > of this binding.
> >
> > +CC Chen-Yu Tsai who 'might' be the a better choice.  
> 
> Yes you can list me as the maintainer if you yourself don't wish to be.
> I am listed as the maintainer for all AXP hardware, excluding the AXP288.
> 
Great thanks - you are more likely to be able to answer questions on this
than I am so I've put you in as maintainer + I'll get them anyway
as IIO maintainer :)

Jonathan

> ChenYu
> 
> 
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to poke at it.
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  .../bindings/iio/adc/axp20x_adc.txt           | 48 -------------
> > >  .../bindings/iio/adc/x-powers,axp209-adc.yaml | 67 +++++++++++++++++++
> > >  2 files changed, 67 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> > > deleted file mode 100644
> > > index 7a6313913923..000000000000
> > > --- a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> > > +++ /dev/null
> > > @@ -1,48 +0,0 @@
> > > -* X-Powers AXP ADC bindings
> > > -
> > > -Required properties:
> > > -  - compatible: should be one of:
> > > -    - "x-powers,axp209-adc",
> > > -    - "x-powers,axp221-adc",
> > > -    - "x-powers,axp813-adc",
> > > -  - #io-channel-cells: should be 1,
> > > -
> > > -Example:
> > > -
> > > -&axp22x {
> > > -     adc {
> > > -             compatible = "x-powers,axp221-adc";
> > > -             #io-channel-cells = <1>;
> > > -     };
> > > -};
> > > -
> > > -ADC channels and their indexes per variant:
> > > -
> > > -AXP209
> > > -------
> > > - 0 | acin_v
> > > - 1 | acin_i
> > > - 2 | vbus_v
> > > - 3 | vbus_i
> > > - 4 | pmic_temp
> > > - 5 | gpio0_v
> > > - 6 | gpio1_v
> > > - 7 | ipsout_v
> > > - 8 | batt_v
> > > - 9 | batt_chrg_i
> > > -10 | batt_dischrg_i
> > > -
> > > -AXP22x
> > > -------
> > > - 0 | pmic_temp
> > > - 1 | batt_v
> > > - 2 | batt_chrg_i
> > > - 3 | batt_dischrg_i
> > > -
> > > -AXP813
> > > -------
> > > - 0 | pmic_temp
> > > - 1 | gpio0_v
> > > - 2 | batt_v
> > > - 3 | batt_chrg_i
> > > - 4 | batt_dischrg_i
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> > > new file mode 100644
> > > index 000000000000..288a5ac31a16
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> > > @@ -0,0 +1,67 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/x-powers,axp209-adc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: X-Powers AXP ADC bindings
> > > +
> > > +maintainers:
> > > +  - Quentin Schulz <quentin.schulz@bootlin.com>
> > > +
> > > +description: |
> > > +  ADC is frequently used as a provider to consumers of the ADC channels.
> > > +  Device is a child of an axp209 multifunction device
> > > +  ADC channels and their indexes per variant:
> > > +
> > > +  AXP209
> > > +  ------
> > > +   0 | acin_v
> > > +   1 | acin_i
> > > +   2 | vbus_v
> > > +   3 | vbus_i
> > > +   4 | pmic_temp
> > > +   5 | gpio0_v
> > > +   6 | gpio1_v
> > > +   7 | ipsout_v
> > > +   8 | batt_v
> > > +   9 | batt_chrg_i
> > > +  10 | batt_dischrg_i
> > > +
> > > +  AXP22x
> > > +  ------
> > > +   0 | pmic_temp
> > > +   1 | batt_v
> > > +   2 | batt_chrg_i
> > > +   3 | batt_dischrg_i
> > > +
> > > +  AXP813
> > > +  ------
> > > +   0 | pmic_temp
> > > +   1 | gpio0_v
> > > +   2 | batt_v
> > > +   3 | batt_chrg_i
> > > +   4 | batt_dischrg_i
> > > +
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - x-powers,axp209-adc
> > > +      - x-powers,axp221-adc
> > > +      - x-powers,axp813-adc
> > > +
> > > +  "#io-channel-cells":
> > > +    const: 1
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    axp221 {
> > > +        adc {
> > > +            compatible = "x-powers,axp221-adc";
> > > +            #io-channel-cells = <1>;
> > > +        };
> > > +    };
> > > +...  
> >  

