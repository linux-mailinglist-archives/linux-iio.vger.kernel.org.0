Return-Path: <linux-iio+bounces-13132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B055A9E5EFD
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 20:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65742286406
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87622D4EC;
	Thu,  5 Dec 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMF4xidF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDE82C60;
	Thu,  5 Dec 2024 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427750; cv=none; b=s3AppJkSwJudfj2QFfwewu8piqiAqD/JZ/eT2ZWmtuSAPSBPwINbZlSbMm0IFwH5VMfJATSmfQzfDFisKeGO8SOD2v42mhYAugpWeiJHtcrEVLKy/34rb2tI8iIzt1vpRhlnTtv/BN5V6VuE/EDYUHjWzA34CQoWdnNiruLl8uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427750; c=relaxed/simple;
	bh=Iq79tceZuWFixqEfWujHAQwjjQciQUkOhDD/6JMxsrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiGBOkL8s7d2z0Hr1VpKEMA9FBNPmwmuH4SNgLY+d3xOyd/w8DlYJza3cGXVQ6E9QUe6XdLV1LFYd+cM5p7CO9szjHNHj06/UVmTS5O5UtPhNrm6Si5f94XEbCZcPZTLS+6lR4hfeyWgcvuUTnzuMDPm3N66b5QLNer9bK6cTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMF4xidF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef9cdecc60so503297b3.1;
        Thu, 05 Dec 2024 11:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733427748; x=1734032548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5mr+Z5wYbYPVcy3T79ju0VJ6Gh5JdWMDmB52o43NMA=;
        b=FMF4xidFgskxzo8vhQck3qOrUVESUaHAz3UW+ucGUaK2RDcHTmHeHM9HJ9GmDQjHqB
         DtRIrvox+K43HhgyAnoIGSTY+I/a9taL0RWi2biy2ObLQitIs4FTfolu3qI95aMCh17S
         uMMu5ZXJZ6idsSRfaB8EzDve4b4s9jk6EluSwR0WDBgjxHZ8Y7yrfIRFjWJCDbUD5clf
         xp494HkXGqH3xyUTK6fTubqZirUAJXOuwjosPMAd314I2sVfr6jvoETSgCGW3LUc37Ck
         1TO2gE02T+edhUWCcScKUGVzq2RXLMBT+rJglCcIn/7O8Ti7sF1QIiwb1T5CAvDyObKl
         hi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733427748; x=1734032548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5mr+Z5wYbYPVcy3T79ju0VJ6Gh5JdWMDmB52o43NMA=;
        b=kn6ey5iVWvDFoh7NUul+uh1SEzr8rzoG6qTYQu4mjXY4sEMVtOiLTIBJ12PO5nMnkD
         jsoOPLCzM+meUHzK31UsmMIVUgV1xlvgIyFGjhKQx8c+QssQ6ZCTA9K2s3c5ZAh+mCv4
         z2vh2iQ6JswDMw2AiHILJNFfKxRMR2NfAYWEZDe8DZHjSIFOv7rQ/c+UG+y55grjyb9s
         fzeguxVSX14SL4JT/nMKgMtoU8g7BwqL25jnTAF+eRoQx4b0SWELq0uSCLX+NXybOa5p
         7PXl/Vl5pGDeE+We69ChowDfNzqkko0zaQXUbA6CLSD0T10Ygl0OLYP91gHjD0D00ukv
         w3VA==
X-Forwarded-Encrypted: i=1; AJvYcCV5poLql3kB7rdOU/IBsZRwXXdumKNGFopgcLcmVSCD8nIz/zNBI61hBWqOpE5jfP/o7hM7UEu/oQV6gDlb@vger.kernel.org, AJvYcCVAaeYkaimhdpxY73Y1m+Rzhcu7epnelCJ7giT6uBwryqHe9TjK8ibTK9PKI5PahuCX5cNzgbLInyz6@vger.kernel.org, AJvYcCXdYqktWQsZ7ruYwN+A8R/0LR7iR6CHdGhrUiyo6Gq4SM8cddF9t7CeAFzHsGMNn1B2L9qeuvmG43DZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9m79dEeUnrb+87BIXNAMMFxs6CJ7wmEAQFRJi1eDJr7tos09
	cgj259r26OTMHyijJ7F84FBQr+/4UykOoNC2WSca/0YMc1LnHdk+DZV0m9XdlERymFHCVl3iIFR
	FUL1Xn2xXIYLp4K2rclETBy2E8bc=
X-Gm-Gg: ASbGncuqkx/lHV/xNzCLUa63HdKT5ndHdaF9NmXCM9rtq/ewLAUt35q0hZYrI9L9wvt
	jb2DKgOVsvV3SIsG9Nerij2Oscf5Up+0=
X-Google-Smtp-Source: AGHT+IGP8nU1DKaxke5LsUGXWlKb0DpEtbRZKxKTUnEuekrY3xZ0bIgO4dRDorP9Ds9GZ8FN9GJwv8IFBrLBYjjiT3U=
X-Received: by 2002:a05:690c:2f10:b0:6ef:57f9:a5c with SMTP id
 00721157ae682-6efe3c8ea2bmr1754097b3.10.1733427748167; Thu, 05 Dec 2024
 11:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205171343.308963-1-l.rubusch@gmail.com> <20241205171343.308963-7-l.rubusch@gmail.com>
 <20241205-fraying-overfull-4fe3eb6c5376@spud>
In-Reply-To: <20241205-fraying-overfull-4fe3eb6c5376@spud>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 5 Dec 2024 20:41:52 +0100
Message-ID: <CAFXKEHbGcTGBNH8Hrg3i90_-xR1KYyw_97X1pPMFB6E4ztL5Aw@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] dt-bindings: iio: accel: add interrupt-names
To: Conor Dooley <conor@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:54=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Thu, Dec 05, 2024 at 05:13:39PM +0000, Lothar Rubusch wrote:
> > Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> > sensor. Only one line will be connected for incoming events. The driver
> > needs to be configured accordingly. If no interrupt line is set up, the
> > sensor will still measure, but no events are possible.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.ya=
ml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > index 280ed479ef5..67e2c029a6c 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > @@ -37,6 +37,11 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  interrupt-names:
> > +    description: Use either INT1 or INT2 for events, or ignore events.
> > +    items:
> > +      - enum: [INT1, INT2]
>
> The description for this ", or ignore events" does not make sense. Just
> drop it, it's clear what happens if you don't provide interrupts.
>
> However, interrupts is a required property but interrupt-names is not.
> Seems rather pointless not making interrupt-names a required property
> (in the binding!) since if you only add interrupts and not
> interrupt-names you can't even use the interrupt as you do not know
> whether or not it is INT1 or INT2?

What I meant is, yes, the sensor needs an interrupt line.
Interrupt-names is optional. The sensor always can measure. When
interrupt-names is specified, though, the sensor will setup a FIFO and
can use events, such as data ready, watermark, single tap, freefall,
etc. Without the interrupt-names, the sensor goes into a "FIFO bypass
mode" without its specific events.

Hence, I better drop the description entirely, since it rather seems
to be confusing.

Best,
L

> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -61,6 +66,7 @@ examples:
> >              reg =3D <0x2a>;
> >              interrupt-parent =3D <&gpio0>;
> >              interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "INT1";
> >          };
> >      };
> >    - |
> > @@ -79,5 +85,6 @@ examples:
> >              spi-cpha;
> >              interrupt-parent =3D <&gpio0>;
> >              interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "INT2";
> >          };
> >      };
> > --
> > 2.39.2
> >

