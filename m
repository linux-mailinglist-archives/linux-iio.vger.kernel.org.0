Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A31B917
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2019 16:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfEMOvl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 May 2019 10:51:41 -0400
Received: from ch3vs01.rockwellcollins.com ([205.175.226.27]:63465 "EHLO
        ch3vs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730463AbfEMOvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 May 2019 10:51:41 -0400
X-RC-All-From: , 205.175.226.20, No hostname, adam.michaelis@rockwellcollins.com,
 Adam Michaelis <adam.michaelis@rockwellcollins.com>, , 
X-RC-Attachments: , ,
X-RC-RemoteIP: 205.175.226.20
X-RC-RemoteHost: No hostname
X-RC-IP-Hostname: ch3ip01.rockwellcollins.com
X-RC-IP-MID: 135054530
X-RC-IP-Group: GOOGLE_RELAYED
X-RC-IP-Policy: $GOOGLE_RELAYED
X-RC-IP-SBRS: None
Received: from unknown (HELO mail-io1-f72.google.com) ([205.175.226.20])
  by ch3vs01.rockwellcollins.com with ESMTP/TLS/AES128-GCM-SHA256; 13 May 2019 09:51:39 -0500
Received: by mail-io1-f72.google.com with SMTP id i16so2539487ioj.4
        for <linux-iio@vger.kernel.org>; Mon, 13 May 2019 07:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tvz17grq8lMFLRV6ydqUQ4R4+ka2Svkjf/xMQE19nas=;
        b=oui3hcrKx2mrP9ueMJWE4xMo+Bvol0nAbiwuRbXd1XNqwLeWySq/NZ/76rg3pYbV5c
         MbXyfUp8XxEx0M+oRd7dYGKgLLndgAIH8UAhaqgPtzxdGq+tFpUghwgKAUwzZFbRgWvU
         VHgDX0JiTIfv+WIMqjF2Ek6seO04N0qKnZaWn6gpPKJhfibpRObZVQLM8tP7hb9Sjmbm
         FdZM2RL5nMeA9CWUahvNG0J47BBHvI/iSlsVZfB8UWxQ5bNvTOR9SgDzKmR9Gm0uTzah
         QYwO+05l1rYeyRJ4d1i4ZUvptaTjq/KfJfnjW1ZWXHp3w6YwN72zFn9ocujijM6KLinm
         E7LA==
X-Gm-Message-State: APjAAAVs+nBJq2+6AEc3tTpZZsQMOShWX6L1d4Xy2brGgasUoVXXnWHI
        Hdd9LgWTFSf0JWKRYGYgiPcfJ9GSAUshPo/MGFTCZxsfkK5BjpdLLrD1WowdmyZnvl2diveU7FQ
        wboveINeMr//OUHydcK3VK6PeLYfKWtnSyufEQF1VevpF4CFxv9PghPk=
X-Received: by 2002:a5d:9153:: with SMTP id y19mr13493676ioq.38.1557759099145;
        Mon, 13 May 2019 07:51:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyd6lAWvztvcZh5LghAKGmjxghnSLxXArfNCZDmIwexJ3PFWR0Ljt0+tbN31gP7f/akBjyrXd4yYk8zn0OYic0=
X-Received: by 2002:a5d:9153:: with SMTP id y19mr13493652ioq.38.1557759098883;
 Mon, 13 May 2019 07:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
 <1556745423-11368-2-git-send-email-adam.michaelis@rockwellcollins.com>
 <20190505132234.313b78e9@archlinux> <CALMrGWUVnixueCbzKKkZ0af0rWze=N3SLD5EuynC869=nLw3PA@mail.gmail.com>
 <20190511113849.3b15b542@archlinux>
In-Reply-To: <20190511113849.3b15b542@archlinux>
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
Date:   Mon, 13 May 2019 09:51:27 -0500
Message-ID: <CALMrGWVfpeRaHvRZq9nZoz--=soYAkbZ+r4HeHf9qbKFwWYyHA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Couret Charles-Antoine <charles-antoine.couret@essensium.com>,
        devicetree@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>,
        Clayton Shotwell <clayton.shotwell@rockwellcollins.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 11, 2019 at 5:39 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 7 May 2019 13:21:03 -0500
> Adam Michaelis <adam.michaelis@collins.com> wrote:
>
> > On Sun, May 5, 2019 at 7:22 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Wed,  1 May 2019 16:16:59 -0500
> > > Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:
> > >
> > > > Adding optional parameter to AD7949 to specify the source for the
> > > > reference voltage signal. Default value is maintaned with option '6' to
> > > > match previous version of driver.
> > > >
> > > > Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/adc/ad7949.txt         | 22 ++++++++++++++++++++--
> > > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > > > index c7f5057356b1..14ee9a2cb2a5 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > > > @@ -6,11 +6,29 @@ Required properties:
> > > >       * "adi,ad7682"
> > > >       * "adi,ad7689"
> > > >   - reg: spi chip select number for the device
> > > > - - vref-supply: The regulator supply for ADC reference voltage
> > > >
> > > > -Example:
> > > > +Optional properties:
> > > > + - adi,reference-select: Select the reference voltage source to use
> > > > + when converting the input voltages. Valid values are:
> > > So my immediate thought here is we are mapping one binding to several
> > > different things. Some of which are definitely better described in other
> > > ways.
> > >
> > > So let us break it down:
> > >
> > > Internal vs external.
> > > - External should require a regulator.  If the regulator is there, normal
> > > assumption would be you want to use it.
> > >
> > > Which internal reference?  Hmm. This would be incompatible with the external
> > > regulator and I'd expect the presence of such a regulator to override this.
> > > That does need a new binding.
> > > adi,internal-reference-milivolts = 2500 or 4096.   Much nicer to have
> > > real numbers for someone wondering how it is configured than an enum.
> > >
> > > Temperature sensor enabled: Why is this a devicetree question rather than
> > > a runtime decision?
> > >
> > > Buffer enabled: This needs a custom binding
> > > adi,external-reference-buffer-enable or something like that?
> > >
> > > Makes for a more consistent binding where some elements can be common
> > > across similar devices.  It would be good to see if similar bindings
> > > already exist.  Potentially tings like the reference-buffer enable
> > > may be worth making standard ADC properties rather than device
> > > specific.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > The property name "adi,reference-select" was copied from the
> > adi,ad7124 bindings as a similar hardware register configuration value
> > field. If the property was separated into three independent fields,
> > there would be a lot of explanation and checking required since many
> > of the combinations are invalid (for example, temperature sensor and
> > buffer are always enabled if internal reference is used). I could
> > possibly see removing the temperature sensor configuration from the
> > device tree, but, the current driver (even after these patches) does
> > not provide any support to read the temperature sensor's value. I
> > include that information in the configuration options as a summary of
> > the datasheet.
>
> There would certainly be nothing wrong with ignoring the temperature
> sensor element for now.  It is the sort of thing it's possible no one will
> ever actually add.
>
> The reference select for 7124 was both much simpler than this and is
> per channel.  To use a regulator presence in that case would require
> defining a separate regulator for each channel.  The aim is always
> to have the most readable possible (and generic) bindings, but
> sometimes it really is too hard to do and we fall back on manufacturer
> specific ones.  Here I don't think that is true.
>
> I agree there is a small amount of additional complexity to validating
> the provided settings, but it's not going to be that complex.
>
> First see if there is an external regulator.
> If there is check for buffer enable (and possibly temperature enable).
>
> If no external buffer then check for internal ref.
>
> There is no need to check for invalid combinations. The documentation
> needs to include this but the code doesn't.
>
> Thanks
>
> Jonathan
>
>
After taking a closer look at the datasheet, I have overhauled this part in V3
of the patch series such that it is still an enumeration for
reference-select, but
there are only 4 values solely relating to the voltage reference for the part:
 - Internal 2.5V
 - Internal 4.096V
 - External on pin REF
 - External on pin REFIN
The temp sensor is ignored, and the "buffer" logic is corrected to
refer to which
pin the external reference is supplied by (which side of the internal buffer).

Thanks for the feedback

Adam
>
> >
> > Adam
> > >
> > > > +   0: Internal 2.5V reference; temperature sensor enabled
> > > > +   1: Internal 4.096V reference; temperature sensor enabled
> > > > +   2: External reference, temperature sensor enabled, no buffer
> > > > +   3: External reference, temperature sensor enabled, buffer enabled
> > > > +   6: External reference, temperature sensor disabled, no buffer
> > > > +   7: External reference, temperature sensor disabled, buffer enabled
> > > > + - vref-supply: The regulator supply for ADC reference voltage. Required
> > > > + if external reference selected by 'adi,reference-select'.
> > > > +
> > > > +Examples:
> > > >  adc@0 {
> > > >       compatible = "adi,ad7949";
> > > >       reg = <0>;
> > > > +     adi,reference-select = <2>;
> > > >       vref-supply = <&vdd_supply>;
> > > >  };
> > > > +
> > > > +adc@0 {
> > > > +     compatible = "adi,ad7949";
> > > > +     reg = <0>;
> > > > +     adi,reference-select = <0>;
> > > > +};
> > >
>
