Return-Path: <linux-iio+bounces-25175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B2EBE7013
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 457DC4EA435
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1D233134;
	Fri, 17 Oct 2025 07:48:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CB1EA65
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687337; cv=none; b=L4NRmQHdz+Ui5J2xUL2iHbR1D4IzDL0tMrHBbcFYL2BMVjB2eW9cgqUgDV6onVUG6A7RILg/38srGg05hgd9jpb69eHMFxpNXJaRDMcDcJMmj6haJDrdfita5gFpKfz4hRpDtM0Ue0Z66rVwLlZKPmLv81uR8m1DKMEsrNm2xDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687337; c=relaxed/simple;
	bh=cLKqVn8Z2TBqSDRqJdQ7TokPZf5KyC181WbIfaA6di8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP/XR0lKPVrEFI5ve3ilq4hXHHHFXK6KZwpyHgazWTvuNEOzJMMJ3k50iXyUQzb+S/ct6jHSa0HiUL5Y6/59PoT/JVkHrHfE6IRrIRW0lOWzYkTC3x4E6Qxp76H7qbbfGT4eAUHozoypKLiJ4jIZNOqKZ30ulCEC6wHu6pl3zKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-91fbba9a8f5so135226839f.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 00:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760687335; x=1761292135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsO/hn7ZxXSEVqf0RwtjiX3Woc/Jh2yXP3yIe9HcSiA=;
        b=CefYKJVaNTklZtM+yT/jl8HfOXz6WA4HODSDCazQIc65O09vHeOoCGdm/X24cR6V5x
         /9Ml3qJhD2M89ZX+aLTTD0IS7y3n9UzqkKOhHcmpYRtDb1AApreQ0aIoSA3XEwfxau8b
         B0U3A9VaPZXXftaPFoP6V4wrps8Nt9X5ZenpenY8tYWyPbuZPca3+c2bphW7iiJhjwvx
         nUMNgIifE8EeXWDalThGSz1UAXypETJIz+WliwtAcFmhOViR2koSpDRtlkzfqoY51+KZ
         cyMIf8jbq2w8fuso1VPpmM5PsVZE4iy32bjNghyYxm/mt/XmSeOYAuBXQtqqAjz4xhYA
         bIrg==
X-Forwarded-Encrypted: i=1; AJvYcCXK4YYM6gEc+31A7DtLGedLrBf+QKjfzOr5makxpjl8BVPkMg4FPj6CES2mwVNuAGYc7+hOBMklFVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1M+fsdeO6CFf2zsLEos5IqDHC7MWew+L7bchOcAclbjblvTie
	7Lk6SDbCXepWJbfKwDTgWXhIFuBirK/PtnSMsjARytt/51+x7egdHqCDM1w34Pcc
X-Gm-Gg: ASbGncv4y9pLum9xuSk8OMoaIhwFkewexsQMf9AgFWPyN0pasDjAYzFEZW0NrRhmG/w
	6CBi5k8oV+PsNHTQ1Rek8y7ur38g/gPAktBOZwxixy1/XAdyDh2uBEMRLiuSnuZ3H9/PS59SIy2
	1HJd98uJBeBBpaXApYri0qWME5gTukctk4ulGoMaBFowcL8Y0a5WtGAD68ahPLO0jmRoRTR9IFm
	vmcB3D+MAsLY5AjgnMH5T7IcPBse0R3M/uJR2g+9FjXmIXjMJWhqpMYwAE2qtNo/0qhn5GLHWKo
	h1LDKjjYcD8+Tm+0C1KORBbVXFNX7bdYj/akPct+9GLMwtKLdCpas45GBz3SCYusEC2r8t4PEyV
	qGYiCFR12mBG5NKKKqzjmeygIgvR+iC9guz9na2fFXzIOvyceE26pj044G5b2AMTdjTdqJyfTc5
	ATxizetUFOzI5K1VYUKO33qpMHtQAnMVafZK0Te9CQ1A==
X-Google-Smtp-Source: AGHT+IErcxrqOBW+NRbs1OmmwWDpIQgE8+NRcScb+Z+E8F4+27FEQ0zIOBIJKHFBKLBFVDN/45PAmQ==
X-Received: by 2002:a05:6602:1414:b0:887:638a:29b5 with SMTP id ca18e2360f4ac-93e763ccee7mr368547639f.9.1760687334534;
        Fri, 17 Oct 2025 00:48:54 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a76f52fe54sm632158173.3.2025.10.17.00.48.53
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 00:48:54 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4248b34fc8eso19567385ab.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 00:48:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1rHYKDUKgpO2hOMFbuIqXCqbzPqIw2cYkQGE25ydlFd6e5SEIqyATWCJL+UdH2/4c/AiEFiR0v9o=@vger.kernel.org
X-Received: by 2002:a05:6102:3a13:b0:523:712d:4499 with SMTP id
 ada2fe7eead31-5d7dd6a442emr1096341137.26.1760686853648; Fri, 17 Oct 2025
 00:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-3-herve.codina@bootlin.com> <aPHiAObA61OVf8mY@ninjato>
 <20251017093649.2d5549e4@bootlin.com>
In-Reply-To: <20251017093649.2d5549e4@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 09:40:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0As4XKG0P0y+pJpTT82Bq8qpq2rHufeX4_q0j-eOPPA@mail.gmail.com>
X-Gm-Features: AS18NWADsUKWogewe8kUaA0j69ci3ZpGRe2zEccgQpiOEHAKGQSGuqQNAabIlZg
Message-ID: <CAMuHMdV0As4XKG0P0y+pJpTT82Bq8qpq2rHufeX4_q0j-eOPPA@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
To: Herve Codina <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 17 Oct 2025 at 09:37, Herve Codina <herve.codina@bootlin.com> wrote=
:
> Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> > On Wed, Oct 15, 2025 at 04:28:14PM +0200, Herve Codina (Schneider Elect=
ric) wrote:
> > > +static void rzn1_adc_vc_setup_conversion(struct rzn1_adc *rzn1_adc, =
u32 ch,
> > > +                                    int adc1_ch, int adc2_ch)
> > > +{
> > > +   u32 vc =3D 0;
> > > +
> > > +   if (adc1_ch !=3D -1)
> > > +           vc |=3D RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNE=
L_SEL(adc1_ch);
> > > +
> > > +   if (adc2_ch !=3D -1)
> > > +           vc |=3D RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNE=
L_SEL(adc2_ch);
> >
> > Are you open to either use an errno (maybe EACCES) or define something
> > custom (maybe RZN1_ADC_NO_CHANNEL) instead of hardcoded -1? I think I
> > like the latter a tad more.
>
> I prefer RZN1_ADC_NO_CHANNEL too instead of an error code and I will use
> that instead of -1 in the next iteration.

Or just -ENODEV or -ENOENT, and change the checks above to
"if (adc1_ch >=3D 0)"?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

