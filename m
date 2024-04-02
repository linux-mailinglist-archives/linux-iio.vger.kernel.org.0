Return-Path: <linux-iio+bounces-4004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3868955FD
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD281C224FF
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8A85283;
	Tue,  2 Apr 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RpaHx4tC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3568405D
	for <linux-iio@vger.kernel.org>; Tue,  2 Apr 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066425; cv=none; b=k/JibgC1Oib+VJDy3+YQvJ7xO2U1Ak9Tkv+swg7+/dzD4lN6NgCPJH9x0DsTy5eP7diMWce7Y6ztk5B/96pzqnwB/jyNeIf4GqWEGpNEa8WkG68+OQaziatffouaqaxLmyQLVeRXyn/JFy5cQaIewXF2BWPVMfX8lpxDkZONDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066425; c=relaxed/simple;
	bh=zQsUVohe62XDCv8RPmVhbR0HOvcb2ANjyDfd2BTRSTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQMGQ3rle+rRgw9JmYXuOu45s7b+oQIWroB/3rUIqLFGJS4P7u+IlxzqIdR98WdQztEjaDy0eSmGpC4DtzuoNQjIQdbBPNFe4pqLjRtE/O+HwrYqdSFw0PTH+dBbetlpU443gqUje1mKJOEBOo5cPXwLXGlon4BLHazomUUQxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RpaHx4tC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d700beb60bso88455891fa.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Apr 2024 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712066421; x=1712671221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rDbZVm/05+TD8i00zno4F1FPbK9cGt0EA7D+/0NFvM=;
        b=RpaHx4tCJ3BDi1LLkthbtY6JG/Zklfc19v14leIe4bGroL1Y29/a9k9R3ZdmD7pZ0n
         U6Nnp5IqS6lJ6H93XpfLsjwovzdOG1INNTRZu5tXeyg7oRqAeDQxOqrqzXDrDFZMGXBy
         bZsytrh2FxMjzozGNVEgEUQskkDZ94Mj4oH01DybFJVEk1eSJe8GOwSTFN7JpL9UoI0d
         ZviYNMcovL0sRChW5cDxNzEsEgwTCAmIXqpDYldWUC/OkDYNEPcmZID9V62HLvAKHmVR
         X6V7S0brqQS+Q9gDrsR6MCSxuO37S0fbquuAsNnfw39Jgpu+okcAt8VQwdK6VmFEHfr9
         h27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066421; x=1712671221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rDbZVm/05+TD8i00zno4F1FPbK9cGt0EA7D+/0NFvM=;
        b=tm/P29yD8EddRGFgjNR8ND0MUpZGSjTgXYGncnGc/JMER7SmWyllaIpRHi7HN7rcyH
         DIvjh9QExAwz6kPJfGJ4jmc6Ga+N5ZiHi/ph2Cx9LT27JnboLdicz5VQcMSPTKaJIX5X
         N1Bfa897u1icXOW+kpdNf9natKAUBv3Fm8vx5/j6f/mKV+5Usu3sEOwdzdFoi/VVrGop
         j3EqdajNrOVaUJFIrtw9XW4IKUdliZIvYUGeklTLHf4/5rOEePzhhouyq+DSqeO4Ku/g
         4gEu/dU3SgJxqDiqGD+OwB1cBy21izFEqk90ZFcjo4MebN4ZeSuGFG1hgdNZRBJoz1jo
         XHdg==
X-Forwarded-Encrypted: i=1; AJvYcCVvKR7lFean0M0GtCognWqtT8VEPJw7Pm2y7AGMCKt41fMlhvwyOZnbKon+kNtMJoE95h3CWcCuWkIBXyOD69YRBZzujjXUKLkY
X-Gm-Message-State: AOJu0Yx8g7yiZntxZIfnua1DmNOfjR3XUPqVshW1okoN9cUmrUjwAOcw
	V9ecsZNiAmerqe2sAp1/00Nhc5/g9lWcASX5464aMpsACkrqJ0vkB974w8/pFEtbvtBL4VZqj+D
	vli7T8kJyz5Wdp2Tn5+N3Aj3uQNEcI1ClN5RdHQ==
X-Google-Smtp-Source: AGHT+IHCFlw3ou3Ij39/rVMdq0w422umliw3LKcflbCanJZ8AoG55GlMVztIqNJgFjjdkFnQ5BoSu74kXlmLHaTCgpw=
X-Received: by 2002:a2e:8049:0:b0:2d6:8868:f1a6 with SMTP id
 p9-20020a2e8049000000b002d68868f1a6mr1601468ljg.43.1712066421456; Tue, 02 Apr
 2024 07:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-6-34618a9cc502@analog.com>
 <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
In-Reply-To: <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 2 Apr 2024 09:00:10 -0500
Message-ID: <CAMknhBHf_9kFfLySJmRyoUS6UFfTeLW3bfEi1-3ApEDHyyVhCw@mail.gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:45=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >
> > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >
> > Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
> >

...

> > @@ -1028,15 +1204,22 @@ static int ad7173_fw_parse_channel_config(struc=
t iio_dev *indio_dev)
> >                 *chan =3D ad7173_channel_template;
> >                 chan->address =3D chan_index;
> >                 chan->scan_index =3D chan_index;
> > -               chan->channel =3D ain[0];
> > -               chan->channel2 =3D ain[1];
> > -               chan->differential =3D true;
> >
> > -               chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0], ain[1])=
;
> > +               if (reg >=3D AD4111_CURRENT_CHAN_CUTOFF) {
> > +                       chan->type =3D IIO_CURRENT;
> > +                       chan->channel =3D ain[0];
> > +                       chan_st_priv->ain =3D ad4111_current_channel_co=
nfig[ain[0]];
> > +               } else {
> > +                       chan->channel =3D ain[0];
> > +                       chan->channel2 =3D ain[1];
> > +                       chan->differential =3D true;
>
> Expecting chan->differential =3D false when ADCIN15 is configured for
> pseudo-differential inputs.
>
> Also, perhaps missed in previous reviews, I would expect
> chan->differential =3D false when channels are used as single-ended.
>

After sleeping on it, I came to the concision that these parts are
probably too complex to try to worry about differential vs.
pseudo-differential/single-ended (what the datasheet calls
single-ended is really pseudo-differential).

So I take back my comments about expecting differential =3D false in those =
cases.

