Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEA15469
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfEFT2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 15:28:21 -0400
Received: from secvs02.rockwellcollins.com ([205.175.225.241]:55856 "EHLO
        secvs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbfEFT2V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2019 15:28:21 -0400
X-RC-All-From: , 205.175.225.60, No hostname, adam.michaelis@rockwellcollins.com,
 Adam Michaelis <adam.michaelis@rockwellcollins.com>, , 
X-RC-Attachments: , ,
X-RC-RemoteIP: 205.175.225.60
X-RC-RemoteHost: No hostname
X-RC-IP-Hostname: secip02.rockwellcollins.com
X-RC-IP-MID: 254077175
X-RC-IP-Group: GOOGLE_RELAYED
X-RC-IP-Policy: $GOOGLE_RELAYED
X-RC-IP-SBRS: None
Received: from unknown (HELO mail-ot1-f70.google.com) ([205.175.225.60])
  by secvs02.rockwellcollins.com with ESMTP/TLS/AES128-GCM-SHA256; 06 May 2019 14:28:19 -0500
Received: by mail-ot1-f70.google.com with SMTP id g8so8021564otq.6
        for <linux-iio@vger.kernel.org>; Mon, 06 May 2019 12:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3/jhiD/ZbEhEosCJkMtvsmPNvbV1LiPl/2lWhpTi5w=;
        b=fe0MgCj14fq7sZ7gG9G8E2tMClhebNWIdYw16l5jTSHMjHxbaNdH1SNo4+TQ8mcuHd
         8l6h2W+Gc7rjr92lR4Fn0WH1264mv9D8oDJNaFO632ygfQcYhXQIGnLqc7v+LZtVqMgn
         5oK3nzpTzsxud0ZYbnaPPSe5GgiuAaCbMf7pDvuzOrX75rTSADQyY1Sg7w3YXsIIQIGe
         nqfcBHa6PZ/OQ+1ll0BFI89HgnXK4gP827MJUrSzIO7j+Zcm/uzVuM90FAN9lPcNXWmM
         9tIMDHjBVNdarK9obvENW7kc1FpWgcH9iPZEEK7x8FZhh7WTfKG3y6sXcK3qM6oCpgV/
         QjOQ==
X-Gm-Message-State: APjAAAXE6hz8tB9jPxtY6xuW84B1RVB4iAjPSgyIfl15LqDkY9L/gHJJ
        07Zopqqxx/WxKn2Ws907loEgMdu0B1/IZekPyw76JGFWIjt7OQviBci2V/NMjIDJ20Zej629jsO
        LTbDVXwddSfb0FiMXTGwCWFMiZXXSGq5KJEHfUWc2AnZCRBNBU1gKxCY=
X-Received: by 2002:a9d:7850:: with SMTP id c16mr17131335otm.201.1557170898350;
        Mon, 06 May 2019 12:28:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxrQXTXRB8Wwnb7clRJC81hWLLDcaBCV2PI3LOlcyFuKV+BEf5DxOqZNIZkybetlKC4TJEj1pbpM3rzKPXUO0Y=
X-Received: by 2002:a9d:7850:: with SMTP id c16mr17131322otm.201.1557170898091;
 Mon, 06 May 2019 12:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
 <1556745423-11368-2-git-send-email-adam.michaelis@rockwellcollins.com> <20190505132234.313b78e9@archlinux>
In-Reply-To: <20190505132234.313b78e9@archlinux>
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
Date:   Mon, 6 May 2019 14:28:06 -0500
Message-ID: <CALMrGWVOZbnomuSXdg=Z-a+Az=gRKHgj5_gSnDYiGPGJGp71pQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select
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

The property name "adi,reference-select" was copied from the
adi,ad7124 bindings as a similar hardware register configuration value
field. If the property was separated into three independent fields,
there would be a lot of explanation and checking required since many
of the combinations are invalid (for example, temperature sensor and
buffer are always enabled if internal reference is used). I could
possibly see removing the temperature sensor configuration from the
device tree, but, the current driver (even after these patches) does
not provide any support to read the temperature sensor's value. I
include that information in the configuration options as a summary of
the datasheet.

On Sun, May 5, 2019 at 7:22 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  1 May 2019 16:16:59 -0500
> Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:
>
> > Adding optional parameter to AD7949 to specify the source for the
> > reference voltage signal. Default value is maintaned with option '6' to
> > match previous version of driver.
> >
> > Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ad7949.txt         | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > index c7f5057356b1..14ee9a2cb2a5 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> > @@ -6,11 +6,29 @@ Required properties:
> >       * "adi,ad7682"
> >       * "adi,ad7689"
> >   - reg: spi chip select number for the device
> > - - vref-supply: The regulator supply for ADC reference voltage
> >
> > -Example:
> > +Optional properties:
> > + - adi,reference-select: Select the reference voltage source to use
> > + when converting the input voltages. Valid values are:
> So my immediate thought here is we are mapping one binding to several
> different things. Some of which are definitely better described in other
> ways.
>
> So let us break it down:
>
> Internal vs external.
> - External should require a regulator.  If the regulator is there, normal
> assumption would be you want to use it.
>
> Which internal reference?  Hmm. This would be incompatible with the external
> regulator and I'd expect the presence of such a regulator to override this.
> That does need a new binding.
> adi,internal-reference-milivolts = 2500 or 4096.   Much nicer to have
> real numbers for someone wondering how it is configured than an enum.
>
> Temperature sensor enabled: Why is this a devicetree question rather than
> a runtime decision?
>
> Buffer enabled: This needs a custom binding
> adi,external-reference-buffer-enable or something like that?
>
> Makes for a more consistent binding where some elements can be common
> across similar devices.  It would be good to see if similar bindings
> already exist.  Potentially tings like the reference-buffer enable
> may be worth making standard ADC properties rather than device
> specific.
>
> Thanks,
>
> Jonathan
>
>
> > +   0: Internal 2.5V reference; temperature sensor enabled
> > +   1: Internal 4.096V reference; temperature sensor enabled
> > +   2: External reference, temperature sensor enabled, no buffer
> > +   3: External reference, temperature sensor enabled, buffer enabled
> > +   6: External reference, temperature sensor disabled, no buffer
> > +   7: External reference, temperature sensor disabled, buffer enabled
> > + - vref-supply: The regulator supply for ADC reference voltage. Required
> > + if external reference selected by 'adi,reference-select'.
> > +
> > +Examples:
> >  adc@0 {
> >       compatible = "adi,ad7949";
> >       reg = <0>;
> > +     adi,reference-select = <2>;
> >       vref-supply = <&vdd_supply>;
> >  };
> > +
> > +adc@0 {
> > +     compatible = "adi,ad7949";
> > +     reg = <0>;
> > +     adi,reference-select = <0>;
> > +};
>


-- 

Adam Michaelis | Sr Software Engineer | Comm Engineering | Mission Systems

COLLINS AEROSPACE

400 Collins Road, Cedar Rapids, IA 52498 U.S.A.

Tel: +1 319 295 4102

adam.michaelis@collins.com | collinsaerospace.com



CONFIDENTIALITY WARNING: This message may contain proprietary and/or
privileged information of Collins Aerospace and its affiliated
companies. If you are not the intended recipient, please 1) Do not
disclose, copy, distribute or use this message or its contents. 2)
Advise the sender by return email. 3) Delete all copies (including all
attachments) from your computer. Your cooperation is greatly
appreciated.
