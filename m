Return-Path: <linux-iio+bounces-19130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C26AA9981
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1094C18899C1
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F5198833;
	Mon,  5 May 2025 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWHGWs22"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D706E13AF2;
	Mon,  5 May 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463285; cv=none; b=uas3JGrl9FkEPxC31HKzzRR2FNVh7KOnxCjjhHPubPlx6eylmyuZLFOJJPf8xSz3ojf6mDkWccElRCdmLUUjl8cOR6IVUe87GsLcSDTtjB43AjIYcPKW72DzDRtZxNtC5AKJuZfNd4EVox/99sdVBEwQzb51cJcWn72cwskxXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463285; c=relaxed/simple;
	bh=qLxPduiqkGHugggze3QWfRy/fdJg8U5VxiLfr6qyh1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1uHpjscdeFyWTreK5lQHB560OmVBoqmc3oxAJ45oqkA26X01F6ePVtxZV+k/TwRMDOxFbCHbuUtsdr7yeVjYkWVyo6rk8+0IyZZbo+k7WgYEdYBtNO8RcV8lDBPx+7tfoGm7W5Z6/9IJs/Oo1uWgafwMt8kzosYymtfp+Ik734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWHGWs22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B53FC4CEF2;
	Mon,  5 May 2025 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463285;
	bh=qLxPduiqkGHugggze3QWfRy/fdJg8U5VxiLfr6qyh1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dWHGWs22JX8hc1B9VdI7Qt5b0BwcnoNYCo+/PLxbKJvFIWQaIBRE1yVvn70aKMaot
	 wOtXUMtCexI5blruspoU1CsnAAqfgpWLBGpBm2l0daHNQ+e8J3kBsBzwwqEKrlrhK0
	 S9o9+S8RYc7B2cTWIgC88Sg506N3ypARM55hhAytXcBDc4zVq6OMLoi2YojpVUGh4b
	 qW/j+nWN9n4EckOb2Lm1khmBCkth4LRdgx7yRFZSnhFP6Ag3SS6x51K4nzFESLtTjd
	 hyQaj9qaRpiTuBmw1FF8SJj+IED1Wdmm81I1so/Q6WDBXM66InYyLz33Yp1kvYV/F2
	 tdBb4wVbZzY/g==
Date: Mon, 5 May 2025 17:41:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org, Nuno
 Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Markus
 Burri <markus.burri@bbv.ch>
Subject: Re: EXTERNAL - [PATCH v1] iio: backend: fix out-of-bound write
Message-ID: <20250505174118.2b3c1f43@jic23-huawei>
In-Reply-To: <e6e05f18418a6dc30c1130e5979f642f6ec8d412.camel@gmail.com>
References: <20250501063240.25295-1-markus.burri@mt.com>
	<c3a792558b7d35f7342a53c94810861cb0eb0b8e.camel@gmail.com>
	<aBU0-ZChCrMCWWLu@Debian-VM-Markus.debian>
	<e6e05f18418a6dc30c1130e5979f642f6ec8d412.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 04 May 2025 09:27:02 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-05-02 at 23:11 +0200, Markus Burri wrote:
> > On Fri, May 02, 2025 at 04:12:04PM +0100, Nuno S=C3=A1 wrote: =20
> > > On Thu, 2025-05-01 at 08:32 +0200, Markus Burri wrote: =20
> > > > The buffer is set to 80 character. If a caller write more character=
s,
> > > > count is truncated to the max available space in "simple_write_to_b=
uffer".
> > > > But afterwards a string terminator is written to the buffer at offs=
et count
> > > > without boundary check. The zero termination is written OUT-OF-BOUN=
D.
> > > >=20
> > > > Add a check that the given buffer is smaller then the buffer to pre=
vent.
> > > >=20
> > > > Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate sta=
ck buffer")
> > > > Signed-off-by: Markus Burri <markus.burri@mt.com>
> > > > ---
> > > > =C2=A0drivers/iio/industrialio-backend.c | 3 +++
> > > > =C2=A01 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/indus=
trialio-
> > > > backend.c
> > > > index a43c8d1bb3d0..3878bd698c98 100644
> > > > --- a/drivers/iio/industrialio-backend.c
> > > > +++ b/drivers/iio/industrialio-backend.c
> > > > @@ -155,6 +155,9 @@ static ssize_t iio_backend_debugfs_write_reg(st=
ruct file
> > > > *file,
> > > > =C2=A0	ssize_t rc;
> > > > =C2=A0	int ret;
> > > > =C2=A0
> > > > +	if (count >=3D sizeof(buf))
> > > > +		return -ENOSPC;
> > > > + =20
> > >=20
> > > Oh, this can indeed easily lead to an oob access. However, I would li=
kely not
> > > mind in early returning an error. This is to write registers so 80 sh=
ould be
> > > more than enough. Meaning that to trigger this, it has to be intentio=
nal. That
> > > said, of course we should not let that happen but I would still trunc=
ate things
> > > and let it fail afterwards (keep the code slightly simpler with one l=
ess check).
> > >  =20
> > Thanks for your response.
> > I would prefer the upfront error check. The code is cleaner and simpler=
 to read. =20
>=20
> Simpler yes, cleaner arguable :). Anyways, no strong feelings so leave it=
 as-is if
> it's your preference. However, I think the proper way is:
>=20
> if (count >=3D sizeof(buf) - 1)
> 	return -ENOSPC;
>=20
> And since you're doing this, I think my suggestion still makes sense. I m=
ean:
>=20
> buf[rc] =3D '\0';
>=20
> since rc is indeed the number of bytes written and we do want to terminat=
e the buffer
> at the proper place. So the above is the correct form even if there's no =
real issue
> with the current form after this patch. Being this a fix, not sure if Jon=
athan is ok
> with the above in the current patch or as follow up.

Both together would be fine for this as it's related stuff.

I like the combination of the two though agree only the initial check is st=
rictly
necessary (though the - 1 is needed to avoid scrubbing the 80th char and ra=
ther
unexpected results.)

J
>=20
> - Nuno S=C3=A1
>=20
> > As you wrote the buffer should only contain a register and a value and
> > therefore never extend the 80 character.
> > If there are more, it must be intentional or by mistake. In both cases =
I expect
> > to get an error back, instead of try to handle partial/wrong data.
> >  =20
> > > So I would instead do:
> > >=20
> > > buf[rc] =3D '\0';
> > >=20
> > > Thanks for catching this!
> > > - Nuno S=C3=A1
> > >=20
> > >  =20
> > > > =C2=A0	rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, us=
erbuf,
> > > > count);
> > > > =C2=A0	if (rc < 0)
> > > > =C2=A0		return rc;
> > > >=20
> > > > base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e =20
>=20


