Return-Path: <linux-iio+bounces-20400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C675AD4E54
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3730F17E9C7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340723A99D;
	Wed, 11 Jun 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYjK4BOe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500A239E7A;
	Wed, 11 Jun 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630448; cv=none; b=KxDQ78k4h2637fRIUclOrAPxr40EiF2OLMEGFaQFAN/oD1Z51aMexOsOxiuDN67CQY+LPpRY5LSuuJF45ac2a4PgvdIYOsO6xOl84zKPGyraHCXWte+0T6nxBBrT3EuMDQHLaJVQSzZsCF2lqWWxJu1i6F2jJHcDXrjF2yyDdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630448; c=relaxed/simple;
	bh=j2Jd6pz4UCo5nwlMe/J4zOZHtRlifUPHhxblunkwVj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrQwb29uzeA3hhsipMQIMcTgphRI7TxeMxi9TO4exYkEjNYeH2NppzbUjelxOkOHRbr6KNNbw60wEPNhgFF6hOyMG+AvJu2jm9nr66S5KB31BDUno3KhYb7uCMAH3Z6iG0TLFiyPjs5pXUJUeSvLavQAK/MH8Ta2PSyQpwjx/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYjK4BOe; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-703f3830906so201367b3.3;
        Wed, 11 Jun 2025 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749630446; x=1750235246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLgEAZKUbudu2QLr9YbBLLCjR0Sb4Rc2/LW76Du1psw=;
        b=hYjK4BOeoS9KNMVdYFIkrkelU3v+X3ArSBu1/9Zrgoa42RFZFwIZCznYEoP6wVyNbS
         QAf3Spsbr21rVUo8oUyQ9ZCRkC0qHBlIV8pKG8M+yVN/1VeO+cGfjnkEzYRwPhjeTGLr
         ydU/bt3DtsQiznfmAsQrlpt5gzpTiaD40iQ0TDXYGn0+RlcYyPcH36NXpdfrdqZQzxqC
         +aDnW7un4UJ0m0aJrNByye0rdCbXaMYkHVlcbLyUeYvBRYkhhNDO57e2IU8Mn5OgXXMR
         F0YenPGBoqfUwBD4/TEBw6Qvy9inpyD91TMIhdh1zvi/pYMIcnZihBhfBb2Nzgdag/B6
         LGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749630446; x=1750235246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLgEAZKUbudu2QLr9YbBLLCjR0Sb4Rc2/LW76Du1psw=;
        b=XIVspiRj5t/okBz/jy8OkC0BWkxfPcwa86IPAPId5OO075A2DjGW6cCda/JejJSJ6W
         /Xbeypj1+xxen6F9jnG08MJ3v/kD/TXqV/y/Yeaahi6qcl56bA098I/KSedHE2B8U9yA
         Dp2T0FPJeDXlkiNeIQoPeP9nceaUYjWmgNpU/up5KzY4Xfo4oNnLWVWZB04vebA3quAK
         gWkAtUuskV7ldo8aKe8pKB2Y6VTwANOHD6E5iPn7/OSvT0+33I2cnGF0nOSSg2AysOzp
         slW5AvblLcGqboMsNw4DEPih18FnOxs42lj+Ib8w8H8S7Ct7COsxN8aUq7nIjFag8A3k
         EfVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9oActuKnJOrWvFRBPTXgg1pO54/vU5FAQa8DdCZV5tRQVBj6CHFHrI2564FwdBG/tGBEhpnXy5U59@vger.kernel.org, AJvYcCWzWyoCPw8zuUKjT/e3bBWiOxu44RuXHMm5dApSgS/akQBsWJy5p1jlHq/L/wkK2mjkmvRFaV597/0=@vger.kernel.org, AJvYcCX5g5kQH9p2873YZ+G9ibx6pFovoNLMhXOwhq73eV7bCff0nuY5MZD/F1Gj04kc/hHRbuFnT8BuQEaqeLjk@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBSWjtwqeic63w8Rc+mk26PDPR+WPYdywZTnTdbEgErppxXyl
	53jqhM+Zrct5uJ5cm+XMNu22eunsaysYlKjXO3U149946/nsIdvTpfdxSw2zJhCSDEtuhQktcq8
	VVHvu5utLr0nASbI8+sffcU2LvrjlDmg=
X-Gm-Gg: ASbGncsPvd1pGd8n1q4Mwtv/8E6+0r6pU3Smb5tEwpXNy3QOjDkJLr6SL/1Lnu+fHfW
	myLguNVcrSG/uIL03gMLe+E1b4uAtKYhAr0kSQ8eB9D1Owa32wTvn7sZFbMprJlWRQXXBIjLS4K
	b4yBtiSIXqp9D0MkgVYjF2UpfKuS93TY/YZLFjF6qXX/dt/LjtJmRV0A==
X-Google-Smtp-Source: AGHT+IGzDm5ELGYKbrto9JX2k7KVpQvS03eqoI+l+JWalw5Lv+1ObhU1SDLFUgt0NJcxYXNg7nESbetrn1DLvHDorE0=
X-Received: by 2002:a05:690c:3685:b0:70e:4cdc:6e7a with SMTP id
 00721157ae682-71140ae3679mr14479907b3.6.1749630446042; Wed, 11 Jun 2025
 01:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-6-l.rubusch@gmail.com>
 <CAHp75VdCMSzQt9bY0y84yndPWUmFXD+KJeu4YxvQxk9pnfgWCA@mail.gmail.com>
In-Reply-To: <CAHp75VdCMSzQt9bY0y84yndPWUmFXD+KJeu4YxvQxk9pnfgWCA@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 10:26:50 +0200
X-Gm-Features: AX0GCFsoHusUEV42d7rTNXbyl140ks3C0P07moo2x4MFrLAu3usZv0yimg1AMwQ
Message-ID: <CAFXKEHb7aADU7cy89HYp9T0acjDt3VzeHXV32m4L4J0mFpGPGg@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] iio: accel: adxl313: prepare interrupt handling
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sun, Jun 1, 2025 at 9:21=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jun 1, 2025 at 8:21=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> >
> > Evaluate the devicetree property for an optional interrupt line, and
> > configure the interrupt mapping accordingly. When no interrupt line
> > is defined in the devicetree, keep the FIFO in bypass mode as before.
>
> ...
>
> >         struct adxl313_data *data;
> >         struct iio_dev *indio_dev;
> > -       int ret;
> > +       u8 int_line;
> > +       u8 int_map_msk;
> > +       int irq, ret;
>
> Why do you need a specific irq variable?
>
> ...
>
> > +       int_line =3D ADXL313_INT1;
>
> Assign this when we are sure that the INT1 is defined. Current
> approach is not robust.
>
> > +       irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> > +       if (irq < 0) {
> > +               int_line =3D ADXL313_INT2;
> > +               irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> > +               if (irq < 0)
> > +                       int_line =3D ADXL313_INT_NONE;
> > +       }
>
> So, the below code does not use the returned vIRQ, moreover, the above
> code actually does the IRQ mapping. Why do you need that if the code
> doesn't use it?
>
> > +       if (int_line !=3D ADXL313_INT_NONE) {
>
> Why not positive conditional? But see below...
>
> > +               /* FIFO_STREAM mode */
> > +               int_map_msk =3D ADXL313_INT_DREADY | ADXL313_INT_ACTIVI=
TY |
> > +                       ADXL313_INT_INACTIVITY | ADXL313_INT_WATERMARK =
|
> > +                       ADXL313_INT_OVERRUN;
> > +               ret =3D regmap_assign_bits(data->regmap, ADXL313_REG_IN=
T_MAP,
> > +                                        int_map_msk, int_line =3D=3D A=
DXL313_INT2);
>
> This is fragile. It heavily relies on the existence of exactly three
> IRQ variants. Instead of defining special case (NONE) simply use
> whatever is undefined as the default case
>
>   switch (IRQ type) {
>   case 'INT1':
>     ...
>     break;
>   case 'INT2':
>     ...
>     break;
>   default:
>     // FIFO bypass mode
>     ...
>     break;
>   }

The idea here is actually to conditionally try to read if optional
interrupt lines are configured in the DT. First I check if INT1 is
configured. If not, I try INT2. Else, no interrupt line was setup. The
interrupt lines just need to be configured in the mapping register.
So, there is actually nothing more to a case INT1 or case INT2.

With this explanation and from how I also interprete your and
Jonathans commit, I'll go to merge some of the patches for a next
version. I won't change to switch/case here. IMHO it is not the
approach for the above idea (might be wrong).

I appreciate your feedback and have taken note of it. Thank you.

>
> But still, the main question and confusion here is the absence of the
> users of 'irq'.
>
> > +               if (ret)
> > +                       return ret;
> > +       } else {
> > +               /*
> > +                * FIFO_BYPASSED mode
> > +                *
> > +                * When no interrupt lines are specified, the driver fa=
lls back
> > +                * to use the sensor in FIFO_BYPASS mode. This means tu=
rning off
> > +                * internal FIFO and interrupt generation (since there =
is no
> > +                * line specified). Unmaskable interrupts such as overr=
un or
> > +                * data ready won't interfere. Even that a FIFO_STREAM =
mode w/o
> > +                * connected interrupt line might allow for obtaining r=
aw
> > +                * measurements, a fallback to disable interrupts when =
no
> > +                * interrupt lines are connected seems to be the cleane=
r
> > +                * solution.
> > +                */
> > +               ret =3D regmap_write(data->regmap, ADXL313_REG_FIFO_CTL=
,
> > +                                  FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE=
_MSK,
> > +                                             ADXL313_FIFO_BYPASS));
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         return devm_iio_device_register(dev, indio_dev);
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko

