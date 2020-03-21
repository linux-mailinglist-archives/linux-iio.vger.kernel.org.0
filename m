Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81518DFBA
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 12:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgCULTY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 07:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCULTX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 07:19:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C76620732;
        Sat, 21 Mar 2020 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584789562;
        bh=/4Tg/7Vu94FAj6F1UEbjVB8URukEL7viIow25tsliJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WHRiXzdGrKN3Jxn9uznM6mC+5pmjd4E07ffiO/Z3aAcKoNKh448RTiMgq0EodUc//
         +31DgIXYa1lbgF82RfR1icQKr3We/m33o7IOtK786qKhLooE1naq7Ws9tIveRc/Fcf
         ve0cpVwVvmlSzrkgsZlY7DdTOmr+Ad9gUBVg/PYY=
Date:   Sat, 21 Mar 2020 11:19:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, sre@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: tsl2563: convert bindings to YAML
Message-ID: <20200321111916.4fe23b3e@archlinux>
In-Reply-To: <1cfe5e97-1c0d-8ffe-88f3-90db77e0f03b@gmail.com>
References: <20200314134237.12187-1-nish.malpani25@gmail.com>
        <20200315105834.7a5f4475@archlinux>
        <1cfe5e97-1c0d-8ffe-88f3-90db77e0f03b@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Mar 2020 11:57:20 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> A v3 PATCH [1] was generated taking care of the reviews which can be 
> found inline.
> 
> [1] https://marc.info/?l=linux-iio&m=158451158827441&w=2
> 
> On 15/03/20 4:28 pm, Jonathan Cameron wrote:
> > On Sat, 14 Mar 2020 19:12:37 +0530
> > Nishant Malpani <nish.malpani25@gmail.com> wrote:
> >   
> >> Convert the TSL2563 device tree bindings to the new YAML format.
> >>
> >> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> >> ---
> >>
> >> The link for the datasheet is not attached in the binding document
> >> because it was not available on the manufacturer's (AMS) website [1].  
> > 
> > Very old part now, though plenty of them in circulation or least there
> > used to be.  I have though not powered up that board for a while.
> > 
> > When doing these conversions, do sanity check them against the driver
> > as the old docs aren't always entirely accurate ; >
> > Jonathan
> >   
> >>
> >> [1] https://ams.com/ambient-light-sensors
> >> ---
> >>   .../devicetree/bindings/iio/light/tsl2563.txt | 19 --------
> >>   .../bindings/iio/light/tsl2563.yaml           | 46 +++++++++++++++++++
> >>   2 files changed, 46 insertions(+), 19 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt
> >>   create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.txt b/Documentation/devicetree/bindings/iio/light/tsl2563.txt
> >> deleted file mode 100644
> >> index f91e809e736e..000000000000
> >> --- a/Documentation/devicetree/bindings/iio/light/tsl2563.txt
> >> +++ /dev/null
> >> @@ -1,19 +0,0 @@
> >> -* AMS TAOS TSL2563 ambient light sensor
> >> -
> >> -Required properties:
> >> -
> >> -  - compatible : should be "amstaos,tsl2563"
> >> -  - reg : the I2C address of the sensor
> >> -
> >> -Optional properties:
> >> -
> >> -  - amstaos,cover-comp-gain : integer used as multiplier for gain
> >> -                              compensation (default = 1)
> >> -
> >> -Example:
> >> -
> >> -tsl2563@29 {
> >> -	compatible = "amstaos,tsl2563";
> >> -	reg = <0x29>;
> >> -	amstaos,cover-comp-gain = <16>;
> >> -};
> >> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.yaml b/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
> >> new file mode 100644
> >> index 000000000000..2a70b8d62760
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
> >> @@ -0,0 +1,46 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/light/tsl2563.yaml#  
> > 
> > Convention is now to name files and this with the manufacturer part
> > as well.  
> 
> Got it! Taken care of in v3.
> > 
> > light/amstaos,tsl2563.yaml
> >   
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: AMS TAOS TSL2563 ambient light sensor
> >> +
> >> +maintainers:
> >> +  - Sebastian Reichel <sre@kernel.org>
> >> +
> >> +description: |
> >> +  Ambient light sensor with an i2c interface.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - amstaos,tsl2563  
> > 
> > The original binding was wrong on this.   Check the driver :)
> > I'm a bit embarrassed I never noticed during review as I have
> > a tsl2561, be it on a board that was never converted to DT.
> >   
> 
> You're right. Should have cross-checked with the driver before blindly 
> following the original binding. Corrected in v3.
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  amstaos,cover-comp-gain:
> >> +    description: Multiplier for gain compensation
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +      - enum: [1, 16]  
> > 
> > Not sure it's that restricted...  or to be honest what
> > that is for at all.  Superficially it looks like
> > a multiplier to change the 'range' of the the sysfs control.
> > 
> > I wonder if anyone cares or if we can just start ignoring that going
> > forwards?  Sebastian, anyone else?
> >   
> 
>  From what I understood while reading the datasheet [2] (Page 4), 
> 'amstaos,cover-comp-gain' is used to switch between the low gain and 
> high gain mode which further adjusts the 'Illuminance Responsivity'. 
> Ergo, I've taken it forward even in v3 since the driver also relies on 
> it [3]. Please let me know if my reasoning is erroneous.

My issue here is that might be the intent, but that's not what the driver
uses it for.  All the infrastructure seems to be there to control the
low gain / high gain control but it's not actually hooked up.

The driver currently just applies that number as a multiplier without changing
the state of the chip to match.

Let's leave it there, but at somepoint would be good to dig out some hardware
and actually make this work as expected.  I 'might' get to this at somepoint.

Jonathan
> 
> [2] 
> https://media.digikey.com/pdf/Data%20Sheets/Austriamicrosystems%20PDFs/TSL2562,63.pdf
> 
> [3] 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/light/tsl2563.c#n494
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +
> >> +examples:
> >> +  - |
> >> +    i2c {
> >> +
> >> +      #address-cells = <1>;
> >> +      #size-cells = <0>;
> >> +
> >> +      light-sensor@29 {
> >> +        compatible = "amstaos,tsl2563";
> >> +        reg = <0x29>;
> >> +        amstaos,cover-comp-gain = <16>;
> >> +      };
> >> +    };
> >> +...  
> >   
> 
> With regards,
> Nishant Malpani

