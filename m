Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5758E1A793
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 12:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfEKKi4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 06:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfEKKi4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 06:38:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B982D21479;
        Sat, 11 May 2019 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557571135;
        bh=R+jGbUpsZf3mEgDQzHaxnGGRxNQzI9w1jb/5WfOujnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BgIOBHua84fxb1WUDKafZQhvvBNVq5C8H4reIaqqlgH8njy1E+F5ZXlwiuND+kmYc
         T4yPsnqVoTIaAyyvtJI89WsOccFZL+Ln358o/zBDbUoCQ/Rjvtrb9035Ns+UZfnStp
         5IE1/M9DUpF6tp7F2Cnt5sbbom5okobotcRivHU4=
Date:   Sat, 11 May 2019 11:38:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Adam Michaelis <adam.michaelis@collins.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Couret Charles-Antoine <charles-antoine.couret@essensium.com>,
        devicetree@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>,
        Clayton Shotwell <clayton.shotwell@rockwellcollins.com>
Subject: Re: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select
Message-ID: <20190511113849.3b15b542@archlinux>
In-Reply-To: <CALMrGWUVnixueCbzKKkZ0af0rWze=N3SLD5EuynC869=nLw3PA@mail.gmail.com>
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
        <1556745423-11368-2-git-send-email-adam.michaelis@rockwellcollins.com>
        <20190505132234.313b78e9@archlinux>
        <CALMrGWUVnixueCbzKKkZ0af0rWze=N3SLD5EuynC869=nLw3PA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 May 2019 13:21:03 -0500
Adam Michaelis <adam.michaelis@collins.com> wrote:

> On Sun, May 5, 2019 at 7:22 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed,  1 May 2019 16:16:59 -0500
> > Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:
> >  
> > > Adding optional parameter to AD7949 to specify the source for the
> > > reference voltage signal. Default value is maintaned with option '6' to
> > > match previous version of driver.
> > >
> > > Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/ad7949.txt         | 22 ++++++++++++++++++++--
> > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > > index c7f5057356b1..14ee9a2cb2a5 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > > +++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > > @@ -6,11 +6,29 @@ Required properties:
> > >       * "adi,ad7682"
> > >       * "adi,ad7689"
> > >   - reg: spi chip select number for the device
> > > - - vref-supply: The regulator supply for ADC reference voltage
> > >
> > > -Example:
> > > +Optional properties:
> > > + - adi,reference-select: Select the reference voltage source to use
> > > + when converting the input voltages. Valid values are:  
> > So my immediate thought here is we are mapping one binding to several
> > different things. Some of which are definitely better described in other
> > ways.
> >
> > So let us break it down:
> >
> > Internal vs external.
> > - External should require a regulator.  If the regulator is there, normal
> > assumption would be you want to use it.
> >
> > Which internal reference?  Hmm. This would be incompatible with the external
> > regulator and I'd expect the presence of such a regulator to override this.
> > That does need a new binding.
> > adi,internal-reference-milivolts = 2500 or 4096.   Much nicer to have
> > real numbers for someone wondering how it is configured than an enum.
> >
> > Temperature sensor enabled: Why is this a devicetree question rather than
> > a runtime decision?
> >
> > Buffer enabled: This needs a custom binding
> > adi,external-reference-buffer-enable or something like that?
> >
> > Makes for a more consistent binding where some elements can be common
> > across similar devices.  It would be good to see if similar bindings
> > already exist.  Potentially tings like the reference-buffer enable
> > may be worth making standard ADC properties rather than device
> > specific.
> >
> > Thanks,
> >
> > Jonathan
> >  
> The property name "adi,reference-select" was copied from the
> adi,ad7124 bindings as a similar hardware register configuration value
> field. If the property was separated into three independent fields,
> there would be a lot of explanation and checking required since many
> of the combinations are invalid (for example, temperature sensor and
> buffer are always enabled if internal reference is used). I could
> possibly see removing the temperature sensor configuration from the
> device tree, but, the current driver (even after these patches) does
> not provide any support to read the temperature sensor's value. I
> include that information in the configuration options as a summary of
> the datasheet.

There would certainly be nothing wrong with ignoring the temperature
sensor element for now.  It is the sort of thing it's possible no one will
ever actually add.

The reference select for 7124 was both much simpler than this and is
per channel.  To use a regulator presence in that case would require
defining a separate regulator for each channel.  The aim is always
to have the most readable possible (and generic) bindings, but
sometimes it really is too hard to do and we fall back on manufacturer
specific ones.  Here I don't think that is true.

I agree there is a small amount of additional complexity to validating
the provided settings, but it's not going to be that complex.

First see if there is an external regulator.
If there is check for buffer enable (and possibly temperature enable).

If no external buffer then check for internal ref.

There is no need to check for invalid combinations. The documentation
needs to include this but the code doesn't.

Thanks

Jonathan



> 
> Adam
> >  
> > > +   0: Internal 2.5V reference; temperature sensor enabled
> > > +   1: Internal 4.096V reference; temperature sensor enabled
> > > +   2: External reference, temperature sensor enabled, no buffer
> > > +   3: External reference, temperature sensor enabled, buffer enabled
> > > +   6: External reference, temperature sensor disabled, no buffer
> > > +   7: External reference, temperature sensor disabled, buffer enabled
> > > + - vref-supply: The regulator supply for ADC reference voltage. Required
> > > + if external reference selected by 'adi,reference-select'.
> > > +
> > > +Examples:
> > >  adc@0 {
> > >       compatible = "adi,ad7949";
> > >       reg = <0>;
> > > +     adi,reference-select = <2>;
> > >       vref-supply = <&vdd_supply>;
> > >  };
> > > +
> > > +adc@0 {
> > > +     compatible = "adi,ad7949";
> > > +     reg = <0>;
> > > +     adi,reference-select = <0>;
> > > +};  
> >  

