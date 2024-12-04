Return-Path: <linux-iio+bounces-13072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A7A9E3204
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 04:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA9A161C3E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 03:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDC813C9A3;
	Wed,  4 Dec 2024 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihbdj/p3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6617BA1;
	Wed,  4 Dec 2024 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282460; cv=none; b=BMJJlLjrvXMHVjn0zDe1C+PB9DcUtdaaoiFXrpt83bNHf3fiLSPlOTM6uoaZmU9r9GL6iQmnz2oCbwB1s2gPXiUhg+e6gjeOdrITZr7j4jSNChg3b+71IUcw2nc+ZgiDVzW/WPktFDNOI0U+jYMt8Se1tYxDqaM+ImOmNOdooDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282460; c=relaxed/simple;
	bh=xFiJD3eDhYrPQHtnKlD8TkcwxwRmE2OmsefHI750AS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhFkJmzMZzbG9t5oK8FQndxCuXff76l/f3msF3j2qWdRuY7bw6gT8hJvQLljnzCXiFle4XCEebBEUfuNttLVDN0+PdwVIpUL1WM236wgYIpJchO+t/FOyoczwT++J6qUZHyvBDKmu46FlSZEJ7PkIUU8LCET8+2ZXa2sLe7RWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ihbdj/p3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ec267b879so1038482566b.2;
        Tue, 03 Dec 2024 19:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733282457; x=1733887257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y04cA3TO1YirE/koG9dsISeizBY/CnfgH65djkwX2Bk=;
        b=Ihbdj/p37YTVFZ6A8ZMvwRBI4LhuFzSMu55Z/6MWvBNtfxbSydNk92luFdg9QxgZpj
         g4Fe2wPRgAxZcFugiSjaLa6BTqlSzIH6GwY/31IZTyRN9kzy/cFnlrKeE6nQfj6exOGX
         2sATQXgO2fzrAiywelfaxR4UnVgkJ+tc1N77AyyqBWh4CoJuu3eqLxUULCJolsJjqO93
         4j5XM3/8SOTEeRLQgsR6zEilgqzRtMK5XU/wq8SLUm4tY1agkJcdUvrqX1ZrAz+sZ+z4
         jI5nbCqlbyHJ9Pgr0jXpn2pjWhlhOmzbHMzJpAt2l7vhRhpXf3wcWTDBEtmwhBujcuCd
         DbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733282457; x=1733887257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y04cA3TO1YirE/koG9dsISeizBY/CnfgH65djkwX2Bk=;
        b=JWLQ19ZxrDR8EDegXYv2V0plr4zApAd2yWHXemzd8TewDAVT2tTrurn/Mkk1m1ru8E
         XQSdYAaTdunuR+qRp1uPSNIxdy2X6/ODArrc1Gs+VonkrrVuEkNk7htnIZgC3gvNZzu2
         HnC51r5UaPeLazqZAKarcKEUELO5+W1+5sjEr7Xy3lMo9ZtLOE+C5rDwkrcFev9dHMzC
         KtY9YaVbEuxb5ETAUDekd6G5cyMnQ5GHeDzfGc+sB7qI8CN6wJEg9D+zLzXC0UoxBX2X
         BSgZ2sdYKXX0nFof+77o/CNJdOcHt4TNZnINPp6holCFFw4GzXO6ZG9Uqo7djGiEOM4F
         +JMw==
X-Forwarded-Encrypted: i=1; AJvYcCU0h0jzvgEbeUbeg9HgTNtSh7FgS5Hnn2P+rux9xbuWqlhXySykmCgVCFKwZgIpllNsZQrMWr+rAbq/R7Sk@vger.kernel.org, AJvYcCUfPZmsC8ctwYjjfC9ORqVLRqE/gvK7rmtBcX5796LXscHeoAxO2v4tLEgsSuXWCHJOxjlR6lSeFY1e@vger.kernel.org, AJvYcCXAJKPwwqeT9Aw5rAZgQTA6xVj2rPibRjWDJfiKMJ2CVX8KLPG0LCTSn8M9ykXu1UTJjpyC+E8LLzIa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SvMabUnIb4KcO1+SkNyjqO42QV92Hu+Z4+FU1x4y1wLVSnpc
	ZpFy9ldOTJDm/E4P+3RxDDucvJH1pKbBvfweM6Hdxy7bG2a8ivezwbpI+2GhYMHbDKrRAaisY3E
	TPpTwZERPTMFAbEh1LdPXTx8chVg=
X-Gm-Gg: ASbGncuyrKk2MqoTFBBPh5jJKADWu5b46p9n+g1DR9sDstZ5LMiBDb1Wlg2L9Juycg4
	GOByT0TZiYjvAtFpdft3Q4jh035PMX8o=
X-Google-Smtp-Source: AGHT+IGwe/oix06krX2fuoZe1ERy+q9naY8xqOUcm7s53LomcongR2PQFcGeSdVl85Uok60HVU/VrIr7KREYgLQOuhE=
X-Received: by 2002:a17:906:32ce:b0:aa5:1d68:1ec8 with SMTP id
 a640c23a62f3a-aa5f7cce55cmr446672366b.7.1733282457090; Tue, 03 Dec 2024
 19:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com> <Z08MkR40fjfW3MXZ@smile.fi.intel.com>
In-Reply-To: <Z08MkR40fjfW3MXZ@smile.fi.intel.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Wed, 4 Dec 2024 11:20:20 +0800
Message-ID: <CA+4VgcJW=9rtuqr3VZbfA8QxgYAR+KvfAHdf_0xv4XLQtVVQJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com, 
	thomas.bonnefille@bootlin.com, ramona.nechita@analog.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Andy Shevchenko,

Thank you for your comment.

Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E6=96=BC 2024=E5=B9=B4=
12=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:50=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Tue, Dec 03, 2024 at 05:15:40PM +0800, Eason Yang wrote:
> > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> >
> > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up =
to
> > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins fo=
r
> > independent alarm signals, and the all threshold values could be set fo=
r
> > system protection without any timing delay. It also supports reset inpu=
t
> > RSTIN# to recover system from a fault condition.
> >
> > Currently, only single-edge mode conversion and threshold events suppor=
t.
>
> Please, get rid of explicit castings where the are not needed or implied,=
 like
>
>         u16 foo;
>         ...
>         foo =3D (u16)bar;
>
> you have a lot of this in the code.
>

We would  get rid of explicit castings in all codes.

> Second, why do you need two regmaps? How debugfs is supposed to work on t=
he
> registers that are 16-bit if you access them via 8-bit regmap and vice ve=
rsa?
>
> Can't you simply use bulk reads/writes when it makes sense and drop 16-bi=
t
> regmap completely?
>
>

Read VIN info can use word read or byte read, and other registers
should use byte read.

For a reviewer's comment,
If the i2c controller allows word read
then the right thing is to always use it.


> --
> With Best Regards,
> Andy Shevchenko
>
>

