Return-Path: <linux-iio+bounces-27666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F3D1845E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 12:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 247693023A2D
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A431387350;
	Tue, 13 Jan 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXpgZpr8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB259325702
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301518; cv=none; b=MTH0PJHQatAbtOUNOGkio2D2eVl/HB2PGSHLIbcZG913FFw1NXcdeiA0ob94popY9VgyvBCw8CdLLtflZnsvpiI3NX/7bndsB2txWNdHEI2w00X4nhL0PL/DhMkG9O0hIPD4TZzZwnukil2ooZ+uhLV3DOKBilCwCFLfMxaDCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301518; c=relaxed/simple;
	bh=wngbeCWJ78AgQdVs8Y4OTon8UJX5Zt1LgSTkbzRSAwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fyv/GdzhZk3HUGE9hSwP867nhJH6hvaEiFSg2nZJ7V1e3wgl2tV+FIwgThLz+a/x/CogLyE7Rx+BAx3ieEXbKesn36Y9SEgCTA2JtaCaCFmyIfRrmJNjdwFJtV/5cR/iNjbi6U6dk41E0JVoHAHlU0SJtu2w7iw8ZQp/WyZP2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXpgZpr8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so74599075e9.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 02:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768301515; x=1768906315; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wynvHKPpqBYNwHxzvvXe3nHnYg6avn76hgMgeTYQIVA=;
        b=PXpgZpr8wcjXOAWALCVHmJw1Hws4lruBkIfSlJDaphTcXbXvpMVfh/WArrepnnk0o+
         C+IeSNhm8zvVlMOO2EuJ4gYoCavC8mULLZxcWkiQ9lJL/7s+blQP+v5kkobt67+3vA5M
         Ox3f4+8deeXjedH6suMUGCWWV+LXDJy1drM/tJO1+ds1BuN28xd/bUOw8szsoKvvxAVH
         1NS1AEFDi4G+equCcKSjUVE9SjFdi0xx204ys5Cw63SfH1hkzV++gJ6e+KPxZIfRQRT7
         kmtczGkgwqaXrIGU9cXF/X0TLUQuHBlcSi2DUax4llejUkEcLr9UG4H9Za07jiflFwkx
         86IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301515; x=1768906315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wynvHKPpqBYNwHxzvvXe3nHnYg6avn76hgMgeTYQIVA=;
        b=wkV148mmXDVd0rI7WvHXKHNvbkE0ED0MspxwJYmKQzOfyYhpPVbPx9o/nPStF/tDj8
         YpwjpJULH0Kgir/9BXYuT8O0I+Z99pHTDNoNztNaiLKKyNAaXsMt37I+fJ+6s1XZgjpS
         +sZxUtOGnHD1ncZ39ytGNe4p9jXGgFo/jt7BpI904Ue8VJgM9crRhvaLKHLtfJLwUkC9
         0MsUfBql4quHKIXx7Y1DMsJDJOQ8x3HgYdJwUPtok4fvL1ee2pLOrSB5cFAmxy7rFSyB
         eiUs7r1Q25K8p7qQo0ArcKOs2051Cu6jcP6TVFltPipYo0nezeabn2+HY44uv8ufhjEB
         i8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTFGBvbeKMdE4TWEslHCjhaA78epTIM1z7JDX0KoNfwSlF7IxQdaTIixCZlRC39AbYhn0olZ/YA3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsiY1sXZkLkZVselHMbIt3MdW5NLrNhNi5MzvHuLrLtdswORM
	oeM6l3cEdVLizkgZVTf/PDX2jVm4a8d6hV7VfVCvN6vn0otss3DVHirt
X-Gm-Gg: AY/fxX6q8T6BucItBiUDNAgqRahJbyDcEgE/nuEun/dbnXcZoiiOW2CbYN8WxrEMLh3
	3/vwt2C2zeuRivvCU6Ketf4dVdVmINmcCLDc/y3lJL1oSeJrgtDLJ9XvHBfzKPMg9lYmknT7JT8
	klSnes7QADypnP9Q//FdjOu1yCP5bKE+3LM8oc4/3Sh8rBwTYAnbwxbIVnYRHDLSDcM4gSSFYvA
	YoGtU3TAoMrgrtA3ngeGWF4Q2Iyke+qtIPz4H/6MSn7/TFIs1LQzhCF32H1vNnMxxsz9zypHMhS
	NI8NljQflEZuFuLDkgTwFQRw7/Dsfqs9s0Yu+KiDhnfgQSLttjrIKkANDS7ZvBkchDGb+kW3V69
	2gFOfxVJgDb8IKBW8g7giF2uAZ3oxWMsMMwhvqKu4mRCFHi9RcKwVZoLTElHvIZiN7ihFjhmJk+
	IUcsWB1oM2Nyi0KIwJtVU=
X-Google-Smtp-Source: AGHT+IGMA+7T9erPHocCgSnFpUv/3TN84QugGnjX7iRNwN55w6o7MZeCKJyui0VotySzOLBaIOL7HQ==
X-Received: by 2002:a5d:64c8:0:b0:431:32f:3140 with SMTP id ffacd0b85a97d-432c376107dmr25271814f8f.12.1768301514847;
        Tue, 13 Jan 2026 02:51:54 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16d2sm44998383f8f.13.2026.01.13.02.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:51:54 -0800 (PST)
Message-ID: <f4cd3b85c47b2829cc54c514dffd254433f796e4.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
	 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Jan 2026 10:52:36 +0000
In-Reply-To: <51085acb-91c9-43ad-8f7e-94f1e9c995ed@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	 <20251221200014.29af7df8@jic23-huawei>
	 <356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
	 <997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
	 <20260111114109.28b01266@jic23-huawei>
	 <d36d38b2ae691371c653927fcba310bc525e0aac.camel@gmail.com>
	 <51085acb-91c9-43ad-8f7e-94f1e9c995ed@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 09:47 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 12/01/2026 15:21, Nuno S=C3=A1 wrote:
> > On Sun, 2026-01-11 at 11:41 +0000, Jonathan Cameron wrote:
> > > On Mon, 05 Jan 2026 14:57:02 +0000
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > >=20
> > > > On Mon, 2026-01-05 at 13:06 +0200, Tomas Melin wrote:
> > > > > Hi,
> > > > >=20
> > > > > On 21/12/2025 22:00, Jonathan Cameron wrote:=C2=A0=20
> > > > > > On Tue, 16 Dec 2025 11:40:06 +0000
> > > > > > Tomas Melin <tomas.melin@vaisala.com> wrote:
> > > > > > =C2=A0=20
> > > > > > > Not all users can or want to use the device with an iio-backe=
nd.
> > > > > > > For these users, let the driver work in standalone mode, not =
coupled
> > > > > > > to the backend or the services it provides.
> > > > > > >=20
> > > > > > > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>=C2=A0=
=20
> > > > > > Hi Tomas,
> > > > > > =C2=A0=20
> > > > > > > =C2=A0static int ad9467_probe(struct spi_device *spi)
> > > > > > > @@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_de=
vice *spi)
> > > > > > > =C2=A0	indio_dev->channels =3D st->info->channels;
> > > > > > > =C2=A0	indio_dev->num_channels =3D st->info->num_channels;
> > > > > > > =C2=A0
> > > > > > > +	/* Using a backend is optional */=C2=A0=20
> > > > > >=20
> > > > > > I'll largely defer to Nuno on the backend aspects but I would l=
ike a
> > > > > > lot more than a statement that it is optional in this comment.
> > > > > > At least something about where the data goes and what a real sy=
stem
> > > > > > that didn't provide a backend would look like etc.=C2=A0=20
> > > > >=20
> > > > > Having the backend as optional is about flexibility to incorporat=
e these
> > > > > devices as fits best with the system. The current backend approac=
h is
> > > > > pretty much dictated with how the ADI default backend is implemen=
ted.
> > > > > These devices are fully configurable via SPI interface so the bac=
kend
> > > > > doesn't necessarily need to be anything fancy or even configurabl=
e.
> > > > >=20
> > > > > So there is atleast two use cases that promote the optional iio-b=
ackend
> > > > > approach
> > > > > =C2=A0- simple backend that is not configurable, no need for a de=
dicated
> > > > > driver. The backend (FPGA) sits and waits for data and handles it=
 when
> > > > > it arrives=C2=A0=20
> > > >=20
> > > > Agree on the above. Ideally we could have some dummy backend for th=
e above but
> > > > it is not really easy/maintainable to have it.
> > >=20
> > > When we say the backend needs no driver, where does the data end up?
> > > Is the idea that it goes into some processing pipeline and sent to
> > > some external path that we have no visibility of? i.e. We configure t=
he
> > > data capture in Linux but never see the data?
> >=20
> > Yes, that's also my assumption about Tomas's usecase.
>=20
> The data becomes available to user space but there is currently no
> immediate need or natural place to create a separate instance to
> function as a backend device.

So do you have some completely different data path bypassing IIO (just curi=
ous)?

>=20
> But that being said, I'm leaning towards thinking that perhaps a
> minimalistic backend should always be registered after all. That would
> keep the idea of the backend always existing intact.
> But since the backend can be missing a lot of the features defined for
> the current ADI backend, capability handling would need to be added to
> the backend framework to make it functional.
>=20
> Looking into how this could be achieved with reasonable impact, I have
> tried to identify capabilities that we could add for starters, and then
> have the frontend behave differently depending on what features are prese=
nt.
>=20
> Something like this (added to backend_info),
> .caps =3D IIO_BACKEND_CAP_TEST_PATTERNS |=C2=A0 --> backend patterns are =
avail.
> 	IIO_BACKEND_CAP_BUFFERING |=C2=A0 --> backend has buffering cap.
> 	IIO_BACKEND_CAP_CALIBRATION, --> backend supports calibration
>=20

Looks reasonable but I'm still a bit afraid to open this can of worms. But =
as Jonathan
pointed out multiple times on the backend code, this is mostly inkernel int=
erfaces so
it is easier to deal with bad choices :).
=20

We would still need to "combine" these capabilities feature with a dummy ba=
ckend that
would dummy implement the more common/expected like (chan)enable/disable an=
d so on.

We can then decide on a usecase by usecase basis on what should be a capabi=
lity or what
should be dummy implemented.

Bottom line, I'm leaning on "I'm ok with the above" since I expect usecases=
 like this to
be fairly rare (famous last words :)). And It would be nice to have more fe=
edback
on this one.

- Nuno S=C3=A1


