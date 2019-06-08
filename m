Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3556739FD8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfFHNKt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfFHNKt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 09:10:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33622214D8;
        Sat,  8 Jun 2019 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559999447;
        bh=SH5hTI5c11OAq8te0ktGV7fuTcM1q8eDJlQcLervdqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BR8O4kq34VZ4Ba7wqJ4OcPbhW9IvCm/fQ6ec14jvja6VdJGsxlHXSIxtg3Bts+cjk
         Xg2tw3F5wVxSchVgxhgoDpwwC5wy5lguwUoJ7kNcMdP0iUp+eKU05LW7jUAnf8hMsp
         G7HtMkUEv4kPprhb+fWPWY7oF0oKlLgrYvn/XcMQ=
Date:   Sat, 8 Jun 2019 14:10:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>, khilman@baylibre.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/3] Documentation: dt-bindings: add the Amlogic Meson
 Temperature Sensor
Message-ID: <20190608141043.6c7d332e@archlinux>
In-Reply-To: <CAFBinCBN4QC2tPDEQmTW_c+PP5yu2qoK5M1eSye=SmvpieKWQg@mail.gmail.com>
References: <20190604144714.2009-1-glaroque@baylibre.com>
        <20190604144714.2009-2-glaroque@baylibre.com>
        <CAFBinCBN4QC2tPDEQmTW_c+PP5yu2qoK5M1eSye=SmvpieKWQg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Jun 2019 21:16:37 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Guillaume,
> 
> thank you for working on this!
On comment from me inline.

Thanks,

Jonathan

> 
> On Tue, Jun 4, 2019 at 4:47 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
> >
> > This adds the devicetree binding documentation for the Temperature
> > Sensor found in the Amlogic Meson G12 SoCs.
> > Currently only the G12A SoCs are supported.  
> so G12B is not supported (yet)?
> 
> > Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> > ---
> >  .../iio/temperature/amlogic,meson-tsensor.txt | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> > new file mode 100644
> > index 000000000000..d064db0e9cac
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> > @@ -0,0 +1,31 @@
> > +* Amlogic Meson Temperature Sensor
> > +
> > +Required properties:
> > +- compatible:  depending on the SoC and the position of the sensor,
> > +               this should be one of:
> > +               - "amlogic,meson-g12a-cpu-tsensor" for the CPU G12A SoC sensor
> > +               - "amlogic,meson-g12a-ddr-tsensor" for the DDR G12A SoC sensor
> > +               followed by the common :
> > +               - "amlogic,meson-g12a-tsensor" for G12A SoC family
> > +- reg:         the physical base address and length of the registers
> > +- interrupts:  the interrupt indicating end of sampling
> > +- clocks:      phandle identifier for the reference clock of temperature sensor
> > +- #io-channel-cells: must be 1, see ../iio-bindings.txt  
> have you considered using the thermal framework [0] instead of the iio
> framework (see below)?
I had the same thought.  Right now, this doesn't look generic enough
for IIO to make that much sense.

I'll review anyway as may give some useful pointers even if you do move
it over to thermal.

> 
> > +- amlogic,ao-secure: phandle to the ao-secure syscon  
> the driver has some "u_efuse_off" access. do we need to get some
> calibration values from the AO syscon or can we also fetch it from the
> eFuse? you can look at arch/arm/boot/dts/meson8.dtsi where I'm passing
> the temperature sensor calibration data to the SAR ADC (there's no
> dedicated temperature sensor IP block prior to G12A) while reading the
> data from the eFuse
> 
> > +Optional properties:
> > +- amlogic,critical-temperature: temperature value in milli degrees Celsius
> > +       to set automatic reboot on too high temperature  
> as far as I can tell the thermal framework supports multiple trip
> points. I'm seeing this as a benefit because the hardware can raise
> interrupts at four different temperatures (defined by the driver)
> 
> > +Example:
> > +       cpu_temp: temperature-sensor@ff634800 {
> > +               compatible = "amlogic,meson-g12a-cpu-tsensor",
> > +                            "amlogic,meson-g12a-tsensor";
> > +               reg = <0x0 0xff634800 0x0 0x50>;
> > +               interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> > +               clocks = <&clkc CLKID_TS>;
> > +               status = "okay";  
> as far as I know the dt-bindings should not have a status property in
> the examples
> 
> 
> Martin

