Return-Path: <linux-iio+bounces-13071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1609E31E1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 04:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F98E162110
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 03:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F013C9A3;
	Wed,  4 Dec 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjBk146R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23E136658;
	Wed,  4 Dec 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281878; cv=none; b=acl89oaNYkzjWzw+YEBD4WJ2BMlRe7mIVBYZ67ZYgc2H6WwlCPO8d3YnYJtBO4gKyi0EV1feUYsTQJegA9gCl0ImTG8IBPxsjsICnzgzr0Mxx+/el9vr/KeEN5Jj9hQ9o8jDanr4KB6FS93gpRBUmGau90fDIsjKELImNIhMeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281878; c=relaxed/simple;
	bh=FC1IO+5zq7LugENdBj6DrnnJuMser+B89cR1TBzHDug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdwDgS6gNcIUoBdo3g1D8OOsqqxr8gBG+080LiHChcr390fpIk8BsczO54NTiOUFtudkXxJe1Rz1hrjluvX8dx3dCbzTOU4Q+Bd3nu57KQqV1CQUI76ZGf3DVtLfdVmtv7Sl6eNBsIrJ0KxLUu0N/Zm490EIZZknO6RON+fl6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjBk146R; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e8522445dso877123766b.1;
        Tue, 03 Dec 2024 19:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281875; x=1733886675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHq1dAMl45aI7ZS4WgJJtiN3EJIyNkMWjx+eXqTV7sU=;
        b=YjBk146Rpez7vv3nviorXLAw6N8WgKZBzbfici60LH/W1CNuTQbPve3O1C028HAXgC
         L/oDoKBWjulbKBn7Av+4pqfrbHIquMYKCfRNOyVklIqeCRcQy+1GXjThfQoUnrh/MmAL
         SWxPQrhROo72RxKI6hlma326NrXbW6HyO93civWx/OkBxC2YGRKk+CYuUn4zK/8HtOdV
         037PGZQecZaJP1KNBareRI5cxM6f4iKLXbZSezsJk17HZF6xRNqsiWf5/AYc186JXrRo
         3ER73fQbhq5dIYdTImSnLNRQfxOijjj/albe/AUgy/2Cs9FMwEgC+CfDiPoG+q8E+k7B
         9iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281875; x=1733886675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHq1dAMl45aI7ZS4WgJJtiN3EJIyNkMWjx+eXqTV7sU=;
        b=Lt9JG1DlBfATO0zVIU1kUQPojYt2gv+K7+1gQrChYhwk339IZPJ4Iq4G4iJAbFumb7
         NpIhPc7Uaw9kW4SHyvUM1XqbMRrQXpwnfdW7tnYt6cyQGnF1sf1sHeCJ7ve5wO3hrMGz
         I9nsfg7jji7Unnzi+qdWzpmDyRdgCvKimapZ2YY68B7LNAJEJZzgmLtAujOwv9lOAuMG
         doM2UQN+EBcxSzsOM9ti30sE/woUYvAyak6oT7Qufl9b5lTO/sbKL6ju8Jc70MOOWcm6
         0s/O1i+3V6UltaDhraU8C117bjKzeAV2+PvR2D1NiMwKGKMQla2cnhhE4dlW0v2R/eeE
         fiBA==
X-Forwarded-Encrypted: i=1; AJvYcCUHN+0cqAR2cUUn1+Xr0wTJfEp7PiSzSdN7JflQsO59KCG85x4digNAj6WN8OjvsJMVEDIQIoRwq3z8/2Cz@vger.kernel.org, AJvYcCWO/yYmAw77VIN4ilCQlo5AlBbhb+gMBl09Nsj1Sb2gnCu2tFq8tVDww7lXHd/SPDt05o6k1DCajKiA@vger.kernel.org, AJvYcCXt+9y4oJ4PymU9hShRDlJ9xDkSHIfC4Mr38xfnc0Yb5UxQ5CXA1j6buDePQ2f2csVnCT1+7amOjgBr@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJW1wpY0lKub6Lhn+8DQfVBSFr5xnVMNiRX2NEow+48hh2tNJ
	yAQZ3V6QiAlRN+sqT9f2bEbETuCAnnG82sMUJE30q38f15BKH8unMQdt3WlXGy3b9KlQ0f44ziD
	YkNr2v/ytE5inbuJwklQV0c20QGU=
X-Gm-Gg: ASbGncteBaTjrzPHwhXdlseXVbzc9pUVHF9j08oyMohBOgeD3Fk0poje4pTB5CdGw3H
	w976t4qkaGtRUBhz8eFeoUqxyvmARt54=
X-Google-Smtp-Source: AGHT+IHq0xfIi11duE9fpLS8hULXoZ211QH6ftIQfZtPmWl0i10iI9AvhODiMZP73poEwbzDTPOxIXqVpsVjjeTUD1Q=
X-Received: by 2002:a17:906:9c9:b0:aa5:4d72:6dd7 with SMTP id
 a640c23a62f3a-aa5f7da2bcfmr315567566b.29.1733281875078; Tue, 03 Dec 2024
 19:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-2-j2anfernee@gmail.com> <4c5044a0-8286-463c-ace9-78a4245f112e@kernel.org>
In-Reply-To: <4c5044a0-8286-463c-ace9-78a4245f112e@kernel.org>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Wed, 4 Dec 2024 11:10:38 +0800
Message-ID: <CA+4VgcKWAOh=sQ=wUUPD89ORjYqZP0EDqJfqFT7FjNPppf=4Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, andriy.shevchenko@linux.intel.com, 
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, tgamblin@baylibre.com, matteomartelli3@gmail.com, 
	alisadariana@gmail.com, gstols@baylibre.com, thomas.bonnefille@bootlin.com, 
	ramona.nechita@analog.com, mike.looijmans@topic.nl, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Krzysztof Kozlowski,

Thank you for your kind feedback.

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:25=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 03/12/2024 10:15, Eason Yang wrote:
> > This adds a binding specification for the Nuvoton NCT7201/NCT7202
>
>
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/sub=
mitting-patches.rst#L95
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree=
/bindings/submitting-patches.rst#L18
>

I read the submit patch rule and understand how to rewrite it.

> >
> > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > ---
> >  .../bindings/iio/adc/nuvoton,nct720x.yaml     | 40 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,n=
ct720x.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.=
yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > new file mode 100644
> > index 000000000000..2ed1e15b953b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton nct7202 and similar ADCs
> > +
> > +maintainers:
> > +  - Eason Yang <j2anfernee@gmail.com>
> > +
> > +description: |
> > +   Family of ADCs with i2c interface.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,nct7201
> > +      - nuvoton,nct7202
> > +
> > +  reg:
> > +    maxItems: 1
>
>
> No other properties? No resources?
>

The difference is to remove read-vin-data-size property and default
use read word vin data.

> I think you skipped quite a lot from previous review.
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        nct7202@1d {
>
> Nothing improved here.
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
> </form letter>
>

Thanks for your friendly reminder.
It's impolite not to reply to every reviewer's comment.
I would keep discussing with reviewers and apply the changes in the
next version.

>
> Best regards,
> Krzysztof

