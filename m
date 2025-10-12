Return-Path: <linux-iio+bounces-24993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F73BD08C9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 225CF4E296F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC22EDD7C;
	Sun, 12 Oct 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw+Mn5qZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D92EC541
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290930; cv=none; b=erk8v2bCbMzHO3oAYtpSKZIf5xxw/CTmROoBSgh20bQukPwPyTehVxqu5IaOgzyem6b88nkK2r64Kvu+bQS5p9dYtAYc2L7HTZjA/dIS+HumKLrekRu80XlnGb0eMRMfFAhjszeJ8CiVNLyrDVW/D72Y/VlJjDLIvyIXQI+pY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290930; c=relaxed/simple;
	bh=eP9vUD+vnLqburWlbhDBLpx8OtHE5Yk44Bqb+/o3gVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t24CmbNzV5GlSOSD+PYnj7KwrWFRiAEQwEEiisFCfBol1E/cB8VA7vV/K/DLeXParNbx2f6YXNjVcsEwg5bsIj6ZHJHvM1mcbS6DiZOijNK6J1B7h4RHfghw0A6G8+jDCIcjUv8ypQG8lmYy6CEKAkfB0cQJYqIwELGuNMiJ5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw+Mn5qZ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-634b774f135so5670225a12.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760290927; x=1760895727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9Vp913h5vL+QAaTd5YmM73F2Cs5m5TxizRwXZaWP60=;
        b=Hw+Mn5qZUJI+e8Cxa9EV7oM11VEB/z367A0Rlv+hmdGbG6+IdNMjBeeQ3UQ2jteQzk
         8TW/iI3ZvYDHf9S0YcnwtH/eba/FyHF/vzHN+L5AX7OO+x1UHYeBFF9GL4JaEfw5IBta
         idNgUnJnqey3KTB99sEdEKrvceiiD/13kbEpfZV/QszVbAX41Kwir1/tQLLEuivMq/hT
         rf3ruh0EJhXOpGLjqmzCkhWAokDvjoJTOvY1n/ZUqqBdhyYqizPnujDTZpAZ1MgdHQct
         aKW/Y8cvVTK67MNFFxvdLK7jhEyFKM6E8U0nlIzlaKEMNbe+Pz72k0gWsQIv3KeULZ5B
         5QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760290927; x=1760895727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9Vp913h5vL+QAaTd5YmM73F2Cs5m5TxizRwXZaWP60=;
        b=BibWCkNotDZWlbpfpX8ambRxTZ7IZA7n3UwB2jhvsF4Lwh+n8cc24LOcVLLOZMx1lc
         APUwQHvZyqpxWyMs3Piwo+byUouzg5lI367qcz3Y7YSezgo5KIyfYstkw/GBtl5/U2U4
         fQRgz4IYVd2MX9U8VOXHf1/H4kD1j7eCVFvdUwxWwwt1TVyvXIkwknJmkq9C5oczCeYX
         fsUCZ7S3sP1tqsv4hJ3Bxp3jiCIgZZkzO+WrlzaqtWySJaF4btcpeIhsJhMt6whqV9Kj
         LbzOe0MoxpZ3O57QK0O7PIKkNtyhOLSNW1HmuDt0RQ/dTSwHOfHaNYIT7jAAyXj6d5L3
         W3qg==
X-Forwarded-Encrypted: i=1; AJvYcCWyT7U/xdqjvwXHNvfsk8fGMq83r7O+8yX0KsOQjRrKn9YzPb2E3yukfbO9sACylEVCAkYHMdlBNAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmr0EQSn3XVKkFISg6arz2+3Twg+L48KVnRGtV/tqS7N2U+m/a
	TLArXgc+GS4UXE/S2gWV6C/IFwzREfXRP5GN83THwUw46VrJaKDP0mhsW+j/40pTMgm0WFooWrL
	215ubEaObYnXVycz5tUlVbwEtYY6c8LU=
X-Gm-Gg: ASbGncspVwyZilPoqy8zv5RrMpG6cyIr1WQpQUOG1Pm3CE+0wcgD8GePMcK2UXOw/JJ
	xRIzbBtMkRXkjI+fpBOWRnRJUXAgDVxDXRKDgZGFyjvagm6v9IQvRb6/b4ISTTn+tbNdGK2eJ+F
	7G90XNcADjs0dmIIVy0RVfJWS58Ej4SGjVKgZecWuUM5G89Fwyz2+35JbrNyQW6Ir0muGmeBP5Z
	ChbuETQpZjU/9fEsyWdizx5Yw==
X-Google-Smtp-Source: AGHT+IHK/YEDMsxfyxXe6QHnu1EkcbH1GIUSupmeK3Uje3bcpIQzzt6PFoeNHm7/h6JTMXG/uNGnvGRHvfar18LgOMI=
X-Received: by 2002:a17:906:dc90:b0:aff:fe6:78f0 with SMTP id
 a640c23a62f3a-b50ac8e5533mr2061063566b.54.1760290927009; Sun, 12 Oct 2025
 10:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com> <fce1c905-1c64-47b5-91b1-0017809ec12c@baylibre.com>
In-Reply-To: <fce1c905-1c64-47b5-91b1-0017809ec12c@baylibre.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sun, 12 Oct 2025 23:11:55 +0530
X-Gm-Features: AS18NWAjXit-R0YqUEVlsFKx0AtG-hL4GXHhWfTkLW4-ZmK0phkm6xICo2h97SE
Message-ID: <CAHc1_P7W0sU_5dU8Ei9MgGOFA+N7Q=fotk91vdcGUuUGLWLuqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:19=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 10/7/25 10:17 PM, Shrikant Raskar wrote:
> > The appropriate LED pulse width for the MAX30100 depends on
> > board-specific optical and mechanical design (lens, enclosure,
> > LED-to-sensor distance) and the trade-off between measurement
> > resolution and power consumption. Encoding it in Device Tree
> > documents these platform choices and ensures consistent behavior.
> >
> > Tested on: Raspberry Pi 3B + MAX30100 breakout board.
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> >
> > Changes since v1:
> > Add unit suffix.
> > Drop redundant description.
> >
> > Link to v1:
> > https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.=
com/
> > ---
> >  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max3010=
0.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > index 967778fb0ce8..5c651a0151cc 100644
> > --- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > @@ -27,6 +27,11 @@ properties:
> >        LED current whilst the engine is running. First indexed value is
> >        the configuration for the RED LED, and second value is for the I=
R LED.
> >
> > +  maxim,pulse-width-us:
> > +    maxItems: 1
> > +    description: Pulse width in microseconds
>
> Would be nice to add to the description which pulse width this is referri=
ng to.
Thanks for your review comment, I have updated the description and
shared v3 patch for your review.
> > +    enum: [200, 400, 800, 1600]
>
> Properties with standard unit suffixes are u32 arrays, so I think this
> would fix the error and also make maxItems not necessary.
>
>        items:
>          - enum: [200, 400, 800, 1600]
>
Thanks for sharing the fix. I have tried it but 'dt_binding_check'
complains as below: 'items' is not one of ['description', 'deprecated',
'const', 'enum','minimum', 'maximum', 'multipleOf', 'default', '$ref', 'one=
Of'].
Schema expects it to be defined as a single u32, not an array. I have
updated the patch accordingly.
> And we want to know what the default is if this property is omitted.
>
>         default: 1600
>
Thanks for your feedback, I have added the default value and shared v3
patch for your review.

Thanks and Regards,
Shrikant
> > +
> >  additionalProperties: false
> >
> >  required:
> > @@ -44,6 +49,7 @@ examples:
> >              compatible =3D "maxim,max30100";
> >              reg =3D <0x57>;
> >              maxim,led-current-microamp =3D <24000 50000>;
> > +            maxim,pulse-width-us =3D <1600>;
> >              interrupt-parent =3D <&gpio1>;
> >              interrupts =3D <16 2>;
> >          };
>

