Return-Path: <linux-iio+bounces-15564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A8A374D7
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B396C7A30F7
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B166194A53;
	Sun, 16 Feb 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYOxQkYM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07F53A7;
	Sun, 16 Feb 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739717288; cv=none; b=VRvmh29VvoqLneJOzfqtqU7XywAnQ3ohwtb9TvaojT5INxHvmvfsgwS5LY9WfOix0Z6F3MB4T+/oIX0B9vjEQGr3iaXby16ga6ANrmNTmMxlmpnA2gHO2mqMoPwelvZiL2CvbyKyAEOWwWYKu1VGk5j+I84Uc99oFqJwe3rCEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739717288; c=relaxed/simple;
	bh=iqPmq+grczjuFhKtfDZtGHAJ4JiXEObV3BGi0+nbQHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUTAS6uoGIOLwQw4TyKo6mhMHiaIqzqJqeF8DpG388SrsxOC85uThV+2prHhChgzsKr/+xIsEaAU5S+bHvmDRqcr3888zBxK38bfbtBS+S687s8do+KtadCloVZ7+FJuQeWZ1whYjgLw+Egc694ipMTC3JZEAIxjQvfy2Psn1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYOxQkYM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439714a799aso9960685e9.2;
        Sun, 16 Feb 2025 06:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739717284; x=1740322084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlcEElTm0BA8ixUxq1ddQ7UmSnpDP3vAKD/DbHBzLIE=;
        b=JYOxQkYMrG4ychyOfj5Qm02d4UZjjEWI3X3qEYFpaWTLzBeSdhZsjYakWXwlC/3G6L
         nCTdjs0GYYZOLlP233z4qcwlHlskxditM4PQJGPs23XRaupAy4R0qFFyPwMLfDCkIfta
         rbwoupCHrkpLL8oocHcxk2EmjhmxHX8ltpKxJ9LqjoFbwTKHmb1cGiVwsMAIUNBHiKt5
         wnzUSiZABzuoug9R30INLKfrQHD3FaGFeICC+hDRiRuy3smmKXBjKSQt8MM/wCeiQxtK
         eXH8tx61D5fTQuU8ddKY+9ZU75Fwjs+Kw5fzVvjfnmorzZAfhk/DNuRvvy97viInWFFT
         sNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739717284; x=1740322084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlcEElTm0BA8ixUxq1ddQ7UmSnpDP3vAKD/DbHBzLIE=;
        b=BsHupcZm4Hor0P7q3HFq/SgMzlXmU2zgyjOnHgt4tlb4A8RwzElX99WR+gK14o2RaG
         6NITzhAnE9zw/Qv/wih/7G6kjKIdC0QiAkMm5+I2/m9EeiRTPje8fdcq8odQtxjG7cb4
         Uiy890TajMAWZCZfbiMwmEcg7spk/SFEiq+mRKmSTSQWUEkiDHJyU46U1wgnxp3N+eaz
         ToKAx2nR/LSk0PFZkex8/2BoDkD9ocw9ZMlXpfBy1ro5rLAFtRJKJMlpFyojgZCut2Bj
         GB9eDFLO5s7ngAtoRBArMCNFQ4K1h6G2NUU6C+Q5oEwMHiNP6CrChEztzkSk8PMWBjaI
         VkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKGiaUDzmyePjn29U//0Ge1kXD1oFdCIgaWX2kdG+dkpQMR2Gx/Qi3+0p4ev5Qa5xDzxoZmF2kZ/2k@vger.kernel.org, AJvYcCUXJAuZKuylVWmws+BRmE2S8eBb7uAa2oPizCez4BbMMtkygUxw82TeIxwT6CQ+ohBhDWtbkuGTKoes@vger.kernel.org, AJvYcCWsNDVid907DXxJ3nZp5Nl+iyNSCBgM+RXCvGNEwgx6AQtsS3nvz2iym//6s6Wjdv/hzo+1RkrmVC1awKg=@vger.kernel.org, AJvYcCXPvx3eQuRUU1igLip1BGSocn5uqtRXy222QJyfQ+huV3xmZSZCWEhrii6zLe05hvca+3F3A5/yRdWMcwj0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5myWTRnOPywWHANwa818Ag12vsawquGzrJF/QkuNljWUL9l8Y
	Gw9Fomp/T5bBccwymEdQUypxtbgchqje3JhRj0IWEoMNNdYmXwEP1Npo/EGrrvZ/xYA+XZ9JbfW
	WiIqa1D0ljIP+LOKil91UcU+Kvok=
X-Gm-Gg: ASbGnctpxfjaCohen7guRxPnaamCyB5KJyIAeJNtPdxm/E5lBn1Ndh7KqiPI6HzV6SV
	eEHXN32V5nHbxjt5Tso3wN7C6I5qb0v/3m/LZDajMTD1+zNmn+8eL8eH8up0FlseTm8W5iEPQLg
	==
X-Google-Smtp-Source: AGHT+IGBc44t8YpXSqBkWRNQ9WaLrZFjt9nEjnsyHg8J10A70LfxmZJR1Pm4XPzJnAcNRVE6L2/HMV22awZUgkFKMDU=
X-Received: by 2002:a05:6000:d08:b0:38f:27e9:7918 with SMTP id
 ffacd0b85a97d-38f33f2d6aemr4252482f8f.26.1739717283701; Sun, 16 Feb 2025
 06:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215103159.106343-1-clamor95@gmail.com> <20250215103159.106343-3-clamor95@gmail.com>
 <1597453a-31fc-49eb-8b69-efeb8805c67a@ixit.cz> <CAPVz0n1T_jXXDhm6gF7gDDqZ=b6abR1Tqk=5kLo=Ws4FF2EVJw@mail.gmail.com>
 <20250216144436.70ff78c3@jic23-huawei>
In-Reply-To: <20250216144436.70ff78c3@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 16 Feb 2025 16:47:52 +0200
X-Gm-Features: AWEUYZkxAKkJS_vNno2lnsPcvY9aiOMMSk4zgIRn8C3NNn0OU5g6pKC5qb7nuns
Message-ID: <CAPVz0n2s1mxuheAadhFMHnmm6DtdMYzLHaBQDB_TEF--tWktrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Heidelberg <david@ixit.cz>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 16 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:44 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
> > > > +
> > > > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > > > +                         struct iio_chan_spec const *chan, int *va=
l,
> > > > +                         int *val2, long mask)
> > > > +{
> > > > +     struct al3000a_data *data =3D iio_priv(indio_dev);
> > > > +     int ret, gain;
> > > > +
> > > > +     switch (mask) {
> > > > +     case IIO_CHAN_INFO_RAW:
> > > > +             ret =3D regmap_read(data->regmap, AL3000A_REG_DATA, &=
gain);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +
> > > > +             *val =3D lux_table[gain & AL3000A_GAIN_MASK];
> > >
> > > Why did you chosen to do post-processing in the RAW channel instead
> > > doing it in INFO_SCALE (same as al3010 does)?
> > >
> >
> > From my observation INFO_SCALE will just perform multiplication of RAW
> > to SCALE. In this case values which are read are not actual raw values
> > of illumination. Next is my assumption (since there is no datasheet),
> > but values obtained from register are similar to values from adc
> > thermal sensors, they need be converted via reference table to get
> > actual data.
>
> Please add a comment somewhere here to say that we don't know the
> relationship of these values to illuminance hence providing
> _RAW and _SCALE would not be helpful.
>

We do know relationship of these values to illuminance thanks to
conversion table provided.

> >
> > > Except this, LGTM.
> > >
> > > Documentation and DT patch:
> > >
> > > Reviewed-by: David Heidelberg <david@ixit.cz>
> > > > +
> > > > +             return IIO_VAL_INT;
> > > > +     case IIO_CHAN_INFO_SCALE:
> > > > +             *val =3D 1;
> > > > +
>
> Don't do this.  The above lack of known relationship has to be
> expressed by not providing the _scale attribute.
>
> > > > +             return IIO_VAL_INT;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +}
> > > > +
> > > > +static const struct iio_info al3000a_info =3D {
> > > > +     .read_raw       =3D al3000a_read_raw,
> > > > +};
>
>

