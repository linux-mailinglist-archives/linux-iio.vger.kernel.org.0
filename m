Return-Path: <linux-iio+bounces-13035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B685A9E2D0A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152FAB2AC0A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FE41FDE26;
	Tue,  3 Dec 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiwXQEmi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065DE1362;
	Tue,  3 Dec 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252073; cv=none; b=HB20BflUna70rYV1T8un2ckfeyi/OQchwNDZRJjEyScbZH11kGO508RfBec3QSBgheIHK2fjfp/hEBtIrIldmYoFsAzsHtUP2+9DiIY4d+ayGUpbCPcpegOHihxrb5l2t3O3xaejuLHsWXdzeRrJYlnAayO+k8xIH8AWSEqTdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252073; c=relaxed/simple;
	bh=60yk3Un3mOUOU5fBr7J6kvdiEa38IlN7DapF4V0egX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGRCoPriddw+aNLtJP4x4F0AlxmhQGyFSj1Y7GIET7R4B8cG2aln7qNnIbq4BLYihmg5aTIHWN1ym6WjbWRDbMnutFSzLnIy5JpOBxrrNtyDpAMiF2L/Yh1Le8cqVWcbtxQqZ2fSHA4r7JLx9pclU1GQo1c2Rd8FeT52HJbyPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiwXQEmi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso994054666b.1;
        Tue, 03 Dec 2024 10:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733252070; x=1733856870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FviEcMHkuex0XRkvCZB3GMVGniNscSHmKW1gWw04XDc=;
        b=HiwXQEmijSTLF9BPZFDru/zH5gsJU3QpjZs3uRbBZ0Dm7Fnk4Kqufwtn7MVjzSVBtg
         MXi988ieTvYcM0S6u/GknqL6mMKePpsr3TWSMfyoxIbejj4FniKuackb5HveWXtSNQd3
         8VNL4q/PJ/Bstz6NghlEFUPnPrYEwm+iLjaZzj4Lbcy+BsT9bZ3RjzNMndMA5xIPT1/S
         BbhKmbAaGzH/QXN8lLlx/fKeBDXfSc3XjuXsVt9giia/no3HMdayeJCnoJ2LKGNMnrMx
         YoVPl9qd+pHlt4u9uTr0XIR+ZAcNgk1VVi6LDQ2UdDhxMJUCA0nHDZzz+XH1Fas9TfA/
         zctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733252070; x=1733856870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FviEcMHkuex0XRkvCZB3GMVGniNscSHmKW1gWw04XDc=;
        b=RxvSavsPmbqXyiRgZauVoQaUaU9YA4PbSNSHe02+3b4/f1bzaVJycbUNgNjSgjB4qa
         wVx0eA4c7VB2dfUesMvxYjMLcstzipoZrKP++EGr/HQkWUU14UE7oAx2KTJcPXm4zo54
         9Ze+Kz59uEHlBNwSnxIpFwJqz3Fz8i6kCA4cLctWDgDpZ0Q5H5hXmqlyKJtAFfrrA2Hr
         zRZvrx+gqqktYeSBvoqfCB8PMVg/UdQReILY+FrIV9nNS8g//z57E2aD5QKqSO2JqPb4
         vjT4qFu6isr6lhfdbOvLz+9EEEPfjNqkOSZ5G5IPvTZWDto4yEO3xTzRnMtjK9U42UOf
         crlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg8y6PCWDzLQBaJd/BkKoOHNtsIHfTD4PGVOh54tFnTSA71Lsou6OET+aueqeBVGjjAxk1qevQZ/Kf@vger.kernel.org, AJvYcCXMH73btKXBn7D2ZY7r/RhXlCsXfIG5Ci2sEreKR3LlFGj+gXj7aD4Tr9Qz4EdzcBTyLghRMnmH9ZFv@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzGJ5ld1GOZFEco7qsAo/KqMC2XGcl7wFCBrXJNmpKyHh0G53
	OIt08M6INGhU9HdYJpNEKkcjOQ9BRQPBUSr1et01Vi+pclTlwwlk9frq5fLhSyFEKd9raEi5LTX
	tQir8xiqJnWbP4WVFz5lsEeheMjxEq7px
X-Gm-Gg: ASbGncvFqBuY8ejCu3iRj10m/KtF6BQg4dwg0usUmrW5E3aHcv36jrUgGfroSxNuKIW
	/T8U8Kton5JwJeWfwiID8nE27Pw1l9B0=
X-Google-Smtp-Source: AGHT+IFF4zn1I7bui9V0BRnykOTY+aa6zcx1lsvanAEYAX+TL2Qt9qt0vuMbXxL6JtYR3Ao7FhNflDGt3bT7MRxVfZI=
X-Received: by 2002:a17:906:23ea:b0:a99:f887:ec1d with SMTP id
 a640c23a62f3a-aa5f7f53a6emr318507066b.49.1733252069993; Tue, 03 Dec 2024
 10:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
 <20241203110019.1520071-20-u.kleine-koenig@baylibre.com> <CAHp75VfuTRDAjOD73re8tCWWJsAFUq_P6hPiPd4j_mOFM8oKGw@mail.gmail.com>
 <wfcqlw3xqs2farpvkn3jjlot2bhmsgfa7lfpyzrjwuwuininsn@ni5rcnm3zdxs>
 <CAHp75VdYagk3Rk=ZwhrONHmJBQ=oxQuJc0-RHZwj7E_wGim-OA@mail.gmail.com> <ysobvgq5vxvoe6cr3aryxwfaaqg7ckdyxr72mo7k3r4z2n7bnj@hgfh4ec2sopp>
In-Reply-To: <ysobvgq5vxvoe6cr3aryxwfaaqg7ckdyxr72mo7k3r4z2n7bnj@hgfh4ec2sopp>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Dec 2024 20:53:53 +0200
Message-ID: <CAHp75VeZNX1zzts3yCsbdsk7ZyXQS8MFoL67aLXvdkP8AqSn1w@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Renato Lui Geh <renatogeh@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, devicetree@vger.kernel.org, 
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 8:47=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Tue, Dec 03, 2024 at 07:47:53PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 3, 2024 at 6:16=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > > On Tue, Dec 03, 2024 at 03:10:30PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Dec 3, 2024 at 1:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > >
> > > > > It can happen if a previous conversion was aborted the ADC pulls =
down
> > > > > the =CC=85R=CC=85D=CC=85Y line but the event wasn't handled befor=
e. In that case enabling
> > > >
> > > > Interesting use of Unicode, but I suggest to avoid it when it can b=
e
> > > > avoided, i.e.
> > > > using the notation of #RDY_N might be appropriate as that is how
> > > > usually the HW people refer to the active low signals.
> > >
> > > Usage of =CC=85R=CC=85D=CC=85Y has the advantage to match the referen=
ce manual and data
> > > sheet. So I tend to keep it.
> >
> > Not sure it's strictly the same. The above has two dashes on top
> > (actually misaligned a bit) of two letters out of three, this is quite
> > confusing (as to me to an electrical engineer) and I hardly believe
> > it's the same in the datasheet (however nowadays everything is
> > possible with (ab)use of Unicode).
>
> I think this is "only" a misrepresentation on your end.

I think it depends on all possible compositions of the fonts, glyphs
and unicode libraries, now since I looked at the lore.kernel.org (via
the same browser!) I see a different appearance of this, i.e. it now
has one dash on top of both R and D and one (still misaligned) on top
of R on top of the first dash, the thickness of them is also different
there.

> Sometimes it
> happens for me, too. A forced redraw helps then. I think that's a bug in
> the unicode render engine. In gitk it looks completely wrong.
> Syntactically it's correct however, the sequence is:
> \xcc\x85R\xcc\x85D\xcc\x85Y, where "\xcc\x85" is the UTF-8
> representation of the "combining overline" code point (0x305).

With all this said, please, change it to a less confusing (dependent
to external libraries/tools) way.

> That makes me remember the times when having a non-ASCII char in your
> name was a problem:

Your name in UTF-8 looks nice to me, the below is different character
set mis-conversions, but it's not the same as we are talking here
about.

> $ git log v6.13-rc1 | grep -P -o 'Kleine-K.*?nig' | sort | uniq -c
>       8 Kleine-K=C3=83=C2=B6nig
>       1 Kleine-K=3DC3=3DB6nig
>       1 Kleine-K=3DF6nig
>       1 Kleine-K?nig
>      10 Kleine-Knig
>     156 Kleine-Koenig
>       8 Kleine-Konig
>   12862 Kleine-K=C3=B6nig
>       1 Kleine-K <u.kleine-koenig
>
> If we don't start using these, it will never be repaired ...

Sometimes it's better not to start at all... :-)

--=20
With Best Regards,
Andy Shevchenko

