Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20ACAEF6FD
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 09:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfKEIMG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 03:12:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41959 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbfKEIMG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 03:12:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so14371916lfb.8;
        Tue, 05 Nov 2019 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I97oI86lnkyHn0k2SlVpiWM20+aIPOoBHQv5XpJrU54=;
        b=b6LXscyMhr/dhGiIH34IvVoc2yhNm5O44wXcBgBZGieMxfSHG08/cobvcdTvdj+df8
         fvWV//48u/UrQYaxyD3sukPRhMeyyjgsj8Uc+baKZOqe44C+TOuGp0SXjlukms/mHjVl
         NzzXhZNUOK55TLwcqqx0zPn/hS+WU8A0XO/H1GFskjG9ManNqaBAEXaqDBnYy0WHW1hm
         Ev77AB0REbCmYFHCfgEnCW1T33GKy5XPXokxwSsYSVVphidWkFa66a7N7Kf1SQqdLMI1
         G1dU905ITEJovgwPmGl02Ek0uPNwAGM9l+AMrAhkay8kXxcsPQQ3Kz0nZLaZrkyPI09P
         SkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I97oI86lnkyHn0k2SlVpiWM20+aIPOoBHQv5XpJrU54=;
        b=l/y9k1BPYTWF2BwfDQjTSKfhUyjoOoWGopbfBMyaWBFbA1DuY59yLmbKYVAQ/0l7Hi
         lQtoOM4GyO7dCMo5BV7fGBJGUvmc1IerH94klZSQ3ni3IBCVxYoGjIFgr9W5JG2ikbEe
         Nmf4sq+cm7a3XNSITuvMvao5QYmBivs787zAeeFyNdhVrItfYFNPQxDyXfMpUAYosaK4
         s/+y4h40HrTh4jTnoscKSASHM//ddM39UOdoi2EhhXDWkJyf5c2ZIKBhijfWj3I2Nm+b
         7DVVAWKB8HxcfFYCkQ3JMvV/GqGdWLWE0daZk/Kq5pdDQCyv9m9Mqdme0Xv5jyo0zQMJ
         cB7w==
X-Gm-Message-State: APjAAAVehM+KSHAk3SaEgYTOm056Ekl5eKrwgaFeBlV0dipL71d9n+/V
        9echaQ62mSC4YyW2hTEj6yU=
X-Google-Smtp-Source: APXvYqwJGyDgq31CoYd7HCgMz84XKy3YL46i9DshXvLeT/SBFby9VSv2+7GkezDP01qi8hjIYbIPqQ==
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr19879208lfn.134.1572941522707;
        Tue, 05 Nov 2019 00:12:02 -0800 (PST)
Received: from gmail.com (c-2ec20990-74736162.cust.telenor.se. [46.194.9.144])
        by smtp.gmail.com with ESMTPSA id 27sm9094503ljv.82.2019.11.05.00.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 00:12:01 -0800 (PST)
Date:   Tue, 5 Nov 2019 09:14:41 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "kent@minoris.se" <kent@minoris.se>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: dac: Migrate LTC1660 documentation to
 yaml
Message-ID: <20191105081441.GA16130@gmail.com>
References: <20191104174036.3535-1-marcus.folkesson@gmail.com>
 <00785b238251ad5b2eb3268693bae357a0a94c1b.camel@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <00785b238251ad5b2eb3268693bae357a0a94c1b.camel@analog.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandru,

See comments below.

On Tue, Nov 05, 2019 at 06:42:06AM +0000, Ardelean, Alexandru wrote:
> On Mon, 2019-11-04 at 18:40 +0100, Marcus Folkesson wrote:
> > [External]
> >=20
> > Rewrite bindings to use json-schema vocabulary.
>=20
> Hey,
>=20
> Overall looks good.
>=20
> A few comments inline.
> Rob may add more.

Thank you for looking into this!
>=20
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  .../bindings/iio/dac/lltc,ltc1660.yaml        | 54 +++++++++++++++++++
> >  .../devicetree/bindings/iio/dac/ltc1660.txt   | 21 --------
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 55 insertions(+), 22 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.t=
xt
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> > b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> > new file mode 100644
> > index 000000000000..1f3136bfffcd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/bindings/iio/dac/lltc,ltc1660.yaml=
#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Linear Technology Micropower octal 8-Bit and 10-Bit DACs
> > +
> > +maintainers:
> > +  - Marcus Folkesson <marcus.folkesson@gmail.com>
> > +
> > +description: |
> > +  Bindings for the Linear Technology Micropower octal 8-Bit and 10-Bit
> > DAC.
> > +  Datasheet can be found here:=20
> > https://www.analog.com/media/en/technical-documentation/data-sheets/166=
560fa.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lltc,ltc1660
> > +      - lltc,ltc1665
> > +
> > +  reg:
> > +    description: SPI chip select number for the device
>=20
> You can remove description.
> It's a standard property.
>=20

Ok, I will remove it.

> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    description: |
> > +      Definition as per Documentation/devicetree/bindings/spi/spi-
> > bus.txt.
> > +    maximum: 5000000
> > +    maxItems: 1
>=20
> I think you can probably remove `spi-max-frequency` from here.
> It's documented in the base SPI schema.
>=20

Yes it is, and I was not really sure if I should include that property, but
I wanted to somehow document the maximum frequency that the chip can handle=
 as it could be useful information.

> > +
> > +  vref-supply:
> > +    description: Phandle to the external reference voltage supply.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > + =20
> > +      dac@0 {
> > +        compatible =3D "lltc,ltc1660";
> > +        reg =3D <0>;
> > +        spi-max-frequency =3D <5000000>;
> > +        vref-supply =3D <&vref_reg>;
> > +      };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> > b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> > deleted file mode 100644
> > index c5b5f22d6c64..000000000000
> > --- a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> > +++ /dev/null
> > @@ -1,21 +0,0 @@
> > -* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
> > -
> > -Required properties:
> > - - compatible: Must be one of the following:
> > -		"lltc,ltc1660"
> > -		"lltc,ltc1665"
> > - - reg: SPI chip select number for the device
> > - - vref-supply: Phandle to the voltage reference supply
> > -
> > -Recommended properties:
> > - - spi-max-frequency: Definition as per
> > -	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> > -	 Max frequency for this chip is 5 MHz.
> > -
> > -Example:
> > -dac@0 {
> > -	compatible =3D "lltc,ltc1660";
> > -	reg =3D <0>;
> > -	spi-max-frequency =3D <5000000>;
> > -	vref-supply =3D <&vref_reg>;
> > -};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fbccc9d450ff..23497d713298 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9619,7 +9619,7 @@ LTC1660 DAC DRIVER
> >  M:	Marcus Folkesson <marcus.folkesson@gmail.com>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> > +F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> >  F:	drivers/iio/dac/ltc1660.c
> > =20
> >  LTC4261 HARDWARE MONITOR DRIVER

I guess I wait for Robs review until I post a v2.

Thanks,
Marcus Folkesson


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAl3BL2oACgkQiIBOb1ld
UjJS4Q/+PCrmp2ItraO5ELiTwcQhN4/sfTai01iLTh8OEgq7kwMsMDZlOVbNfITE
Ug4xFQnwQlf7OzSsTVk2VbBDi3QJ1f49Z5N3C0zp0ZwSZSnvWgv8/JMCr+euxpEz
YMZWhwJG21SdY68xYw9g7hk2v2sS93F9g47dE5ONKhW6MB6A2XtYgEI0Bz9hf3iB
dxh6opCAhNamD1XfWlrlocIL5IulKUYBedKoUxw/0hIgJDuyFtwtCXT52y0jLR04
VspjQoTIdIi3bNlUdHaOo2X43xH3+I7cGix3PZMiylhNqg8kqN+bd0g+QHVqo9XG
fgLxEq0QueYXFb8NO/bQ7aAGZrIaU98Qt2j5ZwqgjmPfKrPUjtoSarHaPkVdzxZm
b54Igguy0dc3VKH4vrAWml1noTLAZPGpDFF/Ne0d/5quXArSi7hJF7rvknx/LUYS
P9I8FTkVRA6Mrc57cpADmfd+/Za7YN/ErFR0pf3Nl27FiqI/7ej3y1xe1hwbZ2S+
vFSGnats1C6+qd1WQG65YBKROD7W1BtNtVTJxEI7rp3dMQAKfQmtyIRWS5wo3Fjw
i50r7a5rTtLEM8evy7rPuEXuJoXKaYqEz6C0Z0Zm43/xX4cB/anEt5KPlt61vWQZ
5Q4nLDF2DBWP+9wcBnULQsVcSoVFR8//SysNErYKjGiwu5CK9EU=
=tTdR
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
