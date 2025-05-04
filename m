Return-Path: <linux-iio+bounces-19024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D398AA857D
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 11:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C23416AFE8
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 09:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1190E18A6AD;
	Sun,  4 May 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzXR4q+9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C918DB37;
	Sun,  4 May 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746350802; cv=none; b=nnVbuQ7yKK7E4+kgeS9F1Q4AhSw1ql+d3ruBT5InGmyW8BZco8zRU2ekZFU+e9EsA0oqNF2FSvfemgxAs79HfmvoCuUPcRK1NwS/sHOCe2vYhd8LQvjQUCZMXGIztUljoI1PBn/RAjX03DEZB7TO0Ee9m4P2YzJs6dYeIG1bkQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746350802; c=relaxed/simple;
	bh=GgE3fUePBwhCFgyR0mBctmDXGX2r6ZS1hfSP17x1TBk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nat8QGVoRi+3yIUIj5tIHS8DbARf9yI9bqs9VAveUu59dFBabM80dA+lrlXMUuKq9HRjYwYMWZDqb0az/le6hvTaG38OBpI6e4YPFMqB48DIYVm7B6b1mKbOW0KADymzmzbDzy26Ed4THPOdLRFF0NQilTxskSAfKMfgbn97uA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzXR4q+9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so27397775e9.3;
        Sun, 04 May 2025 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746350799; x=1746955599; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vqZJZgAzdDTF79oqF94DA/Bbc6jcWSbG8amRxWSzjaU=;
        b=VzXR4q+9wuOadm7UNi5x5B2Za0n9GOzRjI9yELprMCAt42cZhRLJqH3IhNC2Vin2/w
         unRKusUxjnqPlp7fqc15Y8L/rZ3N+AKcJvJyjQFeC5IU3SYo9NLgDBp1k+vwvv/3Ric/
         JURPvKKWDkhXSDj7Q6UIY/RvsxFE/KMY3Z1oMlsHNN497ZddSn0Yr4yl2pumpnV+q8jX
         2vHCIBKQLwSBw0Uo3kXPMt0OO7YGuzDDIDQeR7DqcZi9TNe2weW4s67+3ZEHf8F6Jrh4
         AjoOxZ683PU98b0bbJ/fLLd1V3I4eVhY0xWiqLkUCJNnEVXOLUM6VAUp4D58IDgiL4ON
         8lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746350799; x=1746955599;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqZJZgAzdDTF79oqF94DA/Bbc6jcWSbG8amRxWSzjaU=;
        b=hrkeCi+UxuBDjHnNAZIW7K3Bs6DNqZk1EjXUa/J7SgQ9zxHIkryOfUGlbOjZTWBhOm
         gW/2/MWDCWZj78/r8ef6wQagQnliroYMvaZGj+0RWmkKwEjZhpJfSa8zjm+AvVGs79Cn
         /R1w7pMqBvSNTVOgvLjL6nZNTTc5mTPJPJwUnaUeUM10M34rkuGLBl207IohcrlbpqFm
         IncSNSGeeO9wFTHUOFM3tZKafem2yKvPlFd6VPH44XZdvgmhaPEa8qXbBSMcsbEnx380
         lXJc2rxAbk0l+fjVaUDxIlMW+EiVQkoGn3CZd8W/Zy1XAz+T/4h4o2i9LGucp3zT49T+
         C6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4k8eLF/1RhzDtHOp91jerVNcil5gOGeCW1+VWHUYSCVe46xMegCWDSp8xRm0rGXmiDA1irOjTNVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehHOzLM8pCbRAAaCVmP+nJMlhJ8RPJYKofZcpRWtiGpcUX9qH
	l1/7c68P8bzpv60FxDgT1kh1rAq584/+Ls6x+dusjb+QI8ChMaLi
X-Gm-Gg: ASbGncslWO1FBfSMwe0H4BGyo0DGpL0FNeGuqhG1n6Cg/5KoXm1vzTbO2irKA/h9+Zu
	ll3U3k+ninPlrGSr0nk3EHX0malVXntUgGJdRCbnBvv6CIIjXVrxdo4RPs4RjAWRChnhvwM2Q9l
	0/mcjb4ubWhk+mJ1cLiYLAW5WLDe9S0RFvUfAw6PmTdUFMDcgs1a+JTfHbPtB8j3JXCeGO1mylM
	pdq+TRx9u0YTpoG1pBTSoVKkAqFcLM7mGdA+PVqZJ7+2wd6qHoOAvC5FHkgiLEaiwXQFUI5c9GP
	mIKL9Xq+IL46ncmB4nHv4Eu5bCGpopVTe7uRf1rG3pR4fWniJmWsjksVQjBQYZAaddtpM+vZUwn
	VLPh1wCwmjYBuOowJRZCHF2JE9A==
X-Google-Smtp-Source: AGHT+IGbUJX6NTICvb23QJT7MaAWEUFhHfJ9ihgVnn7Zxv9DMPj37lRyOTGh4JnJWNfKpPzV7HUCbw==
X-Received: by 2002:a05:600c:1e2a:b0:43d:1f1:8cd with SMTP id 5b1f17b1804b1-441c491fb16mr27013515e9.24.1746350799134;
        Sun, 04 May 2025 02:26:39 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad7688sm144143805e9.3.2025.05.04.02.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 02:26:38 -0700 (PDT)
Message-ID: <e6e05f18418a6dc30c1130e5979f642f6ec8d412.camel@gmail.com>
Subject: Re: EXTERNAL - [PATCH v1] iio: backend: fix out-of-bound write
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Markus
 Burri <markus.burri@bbv.ch>
Date: Sun, 04 May 2025 09:27:02 +0100
In-Reply-To: <aBU0-ZChCrMCWWLu@Debian-VM-Markus.debian>
References: <20250501063240.25295-1-markus.burri@mt.com>
	 <c3a792558b7d35f7342a53c94810861cb0eb0b8e.camel@gmail.com>
	 <aBU0-ZChCrMCWWLu@Debian-VM-Markus.debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 23:11 +0200, Markus Burri wrote:
> On Fri, May 02, 2025 at 04:12:04PM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2025-05-01 at 08:32 +0200, Markus Burri wrote:
> > > The buffer is set to 80 character. If a caller write more characters,
> > > count is truncated to the max available space in "simple_write_to_buf=
fer".
> > > But afterwards a string terminator is written to the buffer at offset=
 count
> > > without boundary check. The zero termination is written OUT-OF-BOUND.
> > >=20
> > > Add a check that the given buffer is smaller then the buffer to preve=
nt.
> > >=20
> > > Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack=
 buffer")
> > > Signed-off-by: Markus Burri <markus.burri@mt.com>
> > > ---
> > > =C2=A0drivers/iio/industrialio-backend.c | 3 +++
> > > =C2=A01 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industr=
ialio-
> > > backend.c
> > > index a43c8d1bb3d0..3878bd698c98 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -155,6 +155,9 @@ static ssize_t iio_backend_debugfs_write_reg(stru=
ct file
> > > *file,
> > > =C2=A0	ssize_t rc;
> > > =C2=A0	int ret;
> > > =C2=A0
> > > +	if (count >=3D sizeof(buf))
> > > +		return -ENOSPC;
> > > +
> >=20
> > Oh, this can indeed easily lead to an oob access. However, I would like=
ly not
> > mind in early returning an error. This is to write registers so 80 shou=
ld be
> > more than enough. Meaning that to trigger this, it has to be intentiona=
l. That
> > said, of course we should not let that happen but I would still truncat=
e things
> > and let it fail afterwards (keep the code slightly simpler with one les=
s check).
> >=20
> Thanks for your response.
> I would prefer the upfront error check. The code is cleaner and simpler t=
o read.

Simpler yes, cleaner arguable :). Anyways, no strong feelings so leave it a=
s-is if
it's your preference. However, I think the proper way is:

if (count >=3D sizeof(buf) - 1)
	return -ENOSPC;

And since you're doing this, I think my suggestion still makes sense. I mea=
n:

buf[rc] =3D '\0';

since rc is indeed the number of bytes written and we do want to terminate =
the buffer
at the proper place. So the above is the correct form even if there's no re=
al issue
with the current form after this patch. Being this a fix, not sure if Jonat=
han is ok
with the above in the current patch or as follow up.

- Nuno S=C3=A1

> As you wrote the buffer should only contain a register and a value and
> therefore never extend the 80 character.
> If there are more, it must be intentional or by mistake. In both cases I =
expect
> to get an error back, instead of try to handle partial/wrong data.
>=20
> > So I would instead do:
> >=20
> > buf[rc] =3D '\0';
> >=20
> > Thanks for catching this!
> > - Nuno S=C3=A1
> >=20
> >=20
> > > =C2=A0	rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user=
buf,
> > > count);
> > > =C2=A0	if (rc < 0)
> > > =C2=A0		return rc;
> > >=20
> > > base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e


