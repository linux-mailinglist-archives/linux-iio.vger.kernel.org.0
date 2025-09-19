Return-Path: <linux-iio+bounces-24305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F79B8B4C5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 23:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F005A171482
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8C2D027F;
	Fri, 19 Sep 2025 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcK/X7nf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289F2773C6
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316285; cv=none; b=q5+jz7Qp+9GzZ50JF7IUR204rDBZC+2i+O4+2SywQZ+yOFtn6lcHGBuIGLoRM3waagJbH7GzPcMklgd2jXfXJREBoM9bi3hFRuZupHcvfzP4KdLe6eTgdqpgDlQEhck5jTZaFuE4317w5n3VlnKd692MTDby37/nxSrh6wChUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316285; c=relaxed/simple;
	bh=G5ZTT0/2dA6G2tttpKgcyUVjFhq8OBnLoSkHTTYjaCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD+hDzaNfI1EBOAR/cDEeJW5rKzM+5ijhvs9XM24DMG7qRKQ1GuTmR1n2f9rQaChkCTez+Ze8z+9rp7MFi8+Ccv7oQ27jbEZwiJ4wJq+Qb1iAr8pNgLfK8Bqlk553C+F2Zv3dMBJChIbLy5XUhqSvzGV0k35tkvucVQrHMSTfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcK/X7nf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77b2e3169dcso3548062b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758316283; x=1758921083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFD2PiGcX7JoCeN4pUYUathAXqzYxKQBC02xv/EkTPU=;
        b=bcK/X7nfY8Xd4ZED9wwZgphkp8AxTLwPqYqkTiDciDH8g6T2EMRCzwHaxmv2/ySE+U
         tck9XxMyPZu5WmtwFWeVIppt2j5bDmma0cfwSitExWQTbo6QXa0CNN6Y1BS4nb8a53Tu
         ZlXyLSSAI3mqDOqs7B3HbgZAc0gqC9Cr1v+TlQKlX58Sim7iLMSNsVBye8aqS96BuDRQ
         ZZmGP7SMViHZ1vXCfK/cwNj2Jc8WNMBnLi96aG28ikbeN/DOJhLRqW7dm4CByxmDS8jK
         vSbnd37clSNy/MyI1n1C3Gu057gizkT58S3KnqahHKH+rskIlANIF+gz0nqRdapNo8Zx
         qSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758316283; x=1758921083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFD2PiGcX7JoCeN4pUYUathAXqzYxKQBC02xv/EkTPU=;
        b=QwqD9IcPl4+Ul0eiUG65ICp7+mZuub5viHNE+VWEK6rYumFJp6reMuVGU9SOW/PwJH
         Ns289GWfO+ZrDrZpgmFCUHO+Dnmd/izbhrKdxHnKlfew465ONvFF9+b6sqjtjlcPw2kK
         3eB46VsRD+TbiOFtQt99CrA5aFPzS45eA0j6bMbcceGubGX0cwgHmfOZvF2bBMKu5wLM
         iUetr+tOCwNurWeku7vJSG3gzc+Bit4b3fJcD19+k/vLnFBLCiEe+wgcTAIafPAHgbxj
         GASBRCA3s8RhomrTOwVyG7evqqvQLtk+kkYAhEEfOclMEC0hdaXf37pMP6M6MdgyEghO
         o0tw==
X-Forwarded-Encrypted: i=1; AJvYcCWKm9Lhc93+1yblgDwb8aXcG8waDyIMSg49jsI8yxiX9PMOPVn92f4KLZPVZfFkaGFfGE8PATlN6W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQjgA7vewSTgPGBfkifhoju3pTcxrR/KeO/t7tA74xBJLryIS
	JSMv3XYC+TR8m0Eln59thdTumY3EXHt8LbVNp2qeKJTkmpWY8XzgfT4n
X-Gm-Gg: ASbGnctHAVn4SgX/OZ8qen0MPa8kmEOmH+PW8e+SBAJ4TmtuWA9QDeiC7szCzkNKK5o
	QBBr+G2Otfcgo1fax0KOSxDwLThLuisNu8KIMoHExmpz83kx14aypRhbTJF8MjtmNKzOXWjO03p
	LirbN16cx5oqruZm9owh7vhpGdTLcBAh/XUtYv3p8skGM9i6Hkf7lFCT473GGBFSKs1ZINr/QRc
	C8AT8mPS4nuHt2U9+5GqZBWAaLw4B6OqkKxKsmYKFuAfjH6lib80zbxzemUChClNfnslJNdl2SK
	ja+Iuz9dkJ24tJU7tr1W+YfD5uMu24SUuE97cbU1MbwfZYkCfrodNO68+NzWCb5l/oFo5sJVP2w
	haujdeCFM1DRuumq9z6EPlG1FQcIQsmU=
X-Google-Smtp-Source: AGHT+IFuIiW4juUqRqMj5seaAf5fiJdyitd63hqZHOD9nE/8E7rUafQl57TENToxffffGCpntb7bcw==
X-Received: by 2002:a05:6a00:17a6:b0:776:20e7:d6f6 with SMTP id d2e1a72fcca58-77e4eac2ac7mr5701354b3a.22.1758316282737;
        Fri, 19 Sep 2025 14:11:22 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77cfec3f379sm6089705b3a.74.2025.09.19.14.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 14:11:22 -0700 (PDT)
Date: Fri, 19 Sep 2025 18:12:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aM3HJY0GWJmP8-do@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <2d6bca62056e1254f91b45f70f4ba4614e659c1c.1758214628.git.marcelo.schmitt@analog.com>
 <20250919-unsure-mounted-0fc49ce72216@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-unsure-mounted-0fc49ce72216@spud>

On 09/19, Conor Dooley wrote:
> On Thu, Sep 18, 2025 at 02:39:29PM -0300, Marcelo Schmitt wrote:
> > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> > PGA (programmable gain amplifier) that scales the input signal prior to it
> > reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> > and A1) that set one of four possible signal gain configurations.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v1 -> v2
> > - Use pattern to specify devices that require gain related properties.
> > - Disallow gain related properties for devices that don't come with embedded PGA.
> > - Documented VDDH and VDD_FDA supplies for ADAQ4216 and ADAQ4224.
> > - Updated PGA gain constants.
> > 
> >  .../bindings/iio/adc/adi,ad4030.yaml          | 65 +++++++++++++++++--
> >  1 file changed, 60 insertions(+), 5 deletions(-)
> > 
...
> >  
> > +  pga-gpios:
> > +    description:
> > +      A0 and A1 pins for gain selection. For devices that have PGA configuration
> > +      input pins, pga-gpios should be defined if adi,gain-milli is absent.
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  adi,pga-value:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> How come this is "value" rather than "gain"?

Because, for this one, I drew inspiration from ad7191 bindings [1] in the hopes
of avoiding creating new properties or using discontinued/deprecated
nomenclature [2].

The thing is, we now have ADC chips coming with PGA circuitry in front of ADC
inputs. Those PGAs are usually set/configured through hardware connections
(e.g. dedicated GPIOs or pin-strapped) and have been described in dt-bindings.
Though, since these added PGAs don't follow a pattern with respect to the
provided gain, different properties began to appear. ad7380 and ad4000 use
adi,gain-milli to describe PGA gain [3, 4], ad7191 uses adi,pga-value and,
more recently, adaq7768-1 has been proposed with adi,aaf-gain-bp [5].
adaq7768-1 is arguably a slightly different case since the signal gain stems
from an anti-aliasing filter, but it nevertheless results in signal attenuation
much like some PGAs.

I personally like the -milli (or even -permille) nomenclature because 4 digits
have been more than enough to describe the gains (at least so far). Though, I
acknowledge the base points suffix (-bp) which is documented in
property-units.yaml [6]. The only thing I don't like much about -bp for
describing PGA gain is that PGA gains are often described in terms of unitless
scale factors, while bp implies the value to be described as a percent.

Anyways, whatever property name is chosen, it will probably be better settle to
something rather than arguing about property names each time a new ADC comes
with an integrated PGA.


[1] Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
[2] https://lore.kernel.org/linux-iio/510f6efb-ada3-4848-ac8e-16fa5d1b5284@kernel.org/
[3] Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
[4] Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
[5] https://lore.kernel.org/linux-iio/46842d4cf2c1149bd64188f94c60ce5e4f3b2beb.1757001160.git.Jonathan.Santos@analog.com/
[6] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> 
> > +    description: |
> > +      Should be present if PGA control inputs are pin-strapped. The values
> > +      specify the gain per mille. For example, 333 means the input signal is
> > +      scaled by a 0.333 factor (i.e. attenuated to one third of it's original
> > +      magnitude). Possible values:
> > +      Gain 333 (A1=0, A0=0)
> > +      Gain 555 (A1=0, A0=1)
> > +      Gain 2222 (A1=1, A0=0)
> > +      Gain 6666 (A1=1, A0=1)
> > +      If defined, pga-gpios must be absent.
> > +    enum: [333, 555, 2222, 6666]
> > +

Thanks,
Marcelo

