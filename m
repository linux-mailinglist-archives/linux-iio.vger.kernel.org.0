Return-Path: <linux-iio+bounces-7777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B29389A2
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 09:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D59F1C20E7A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB71BC3F;
	Mon, 22 Jul 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQiPduTx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAB1BC3C
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632122; cv=none; b=mjoLJ489oe384rod0DA/3m39Vca2B/FUl+qCjBoJleE7ehg5xvHnLtppgDPP0my/AX0ll8eNbmpJpf0wP3u1ai1ySKCyiQuCv5MBH3yum3ceem98oF/A2bLkUV8uVZR+njQOsmlsEynVvxM3LvSuFiPW/naaEHkn7WUk3LJr4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632122; c=relaxed/simple;
	bh=9ykHrbxTN5qHzRq35AKNPk+S4OILqbeDYiq9UF0Huiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZ6XESgt5Hh5C8pe1ev4x8iTdvjGfCe/8DqnHuS3XsyZMdu9KHZwBrIgdNAdamex9AXU/XIgJFpr1Ej5VbvrBrf3cXzijR6a8Q/50UE4SrvuEl/cT40EDKdsur2bqD5fjiZ3vmPxw22wr8kMVMgJU7l6arlOYjDEeyPYn5vMyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQiPduTx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e7420697so441604666b.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721632119; x=1722236919; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oBUR++UY2rPJoRaCksyFBU1M6Sc5em0Zhwl6nLAXkz0=;
        b=AQiPduTxK014aNX22pQOEUv/9Xaa+/hBbD7pdnqgRM6gV01p1jhdnxH6hpiUVNXLB4
         RDWflwM/mYrZkx5OPp/1EIPpsf2aUMYFjsEiP1eDP+VnMGU62FUXVVIvTkzMcyv3o6Ly
         tPtj63cvlcIr77IIYSrGuTqI8rxlUx6PNnrsxJRNRTkVTgQ1K9OAc3DgfWTIDNZ9PudR
         9mKkQhb0TeirDWisMMlLpDrvJ/Ot8o3XrLCaJh++McZZRex6WwBjOlxnG3NwoZI/ST9u
         ww1jJXrSpStSwyLgp3ORn/HrvT7uFCerDc8fPg+NxmZoOpY8Z+5xDKWvj/5evZbYNIAz
         kP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721632119; x=1722236919;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBUR++UY2rPJoRaCksyFBU1M6Sc5em0Zhwl6nLAXkz0=;
        b=FhuoDJEuZwDV7EEcNFz5P3+D1V96mC0FTUDp+0MxQTCpiICS2o/bxEv6zZGSXX2/4Q
         mix/wLFq+2au+3Yx08zonXw3BHI2xk7z2ZwAHkO6Y8mHMOEV+Vga7WfYkokTsWBehjxr
         XBazhMNXk3A/Bpi3k9kr+AJkOsrmgdGrOTmLof56C1Ce9J2mnOBd39TR8UtICqV426tK
         OI1RhIe9+hg9WrINsWkXE8m/aT7VZCcsrcqR4Fx0rem38933lZWKDAu0CGBTz47LnC/B
         +Ke5I841O7FEAWK2iP/iXd/luPFynjFBB8fCpjerCsRLl7IgrL9fdYwim/hxH81VKfr2
         c+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTiLPssS86d0OtlJWxwQbMuVsRYnYMjtGJAQIrJwPVgUaZCKyirC9jAua/Y1RAd8XUgQl7XNqKeYhjtgF4K9I8HDJMd6tHrMRe
X-Gm-Message-State: AOJu0Ywh+md7BXFWa1CtYAPT7uRK5zM3CnaQtXHluOIsMYKJzWBp1pxE
	S0EWJZW9pttB/eb4pcnd088Wr/B3CcF7sfwqYjQ3KapcqHAbTTiA
X-Google-Smtp-Source: AGHT+IEExeqQtThLyTgXlPnyJETk1Jl9a3w5BtvjJLfRj9B+oullTSrT9PZEwjRIalDxHD4pedyAPA==
X-Received: by 2002:a17:907:9727:b0:a79:8290:ab with SMTP id a640c23a62f3a-a7a4bfa1630mr324847566b.15.1721632118780;
        Mon, 22 Jul 2024 00:08:38 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8bf2d0sm381077266b.105.2024.07.22.00.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:08:38 -0700 (PDT)
Message-ID: <856445909ebc2e34fbdb3b53a0c9406c9e8e0c1c.camel@gmail.com>
Subject: Re: [PATCH 3/9] iio: backend: add debugFs interface
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 22 Jul 2024 09:12:35 +0200
In-Reply-To: <20240720104315.52dcc2ec@jic23-huawei>
References: 
	<20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
	 <20240709-dev-iio-backend-add-debugfs-v1-3-fb4b8f2373c7@analog.com>
	 <20240716191443.397c1278@jic23-huawei>
	 <5a26783c2167310237936d80affe61b43ea84022.camel@gmail.com>
	 <20240720104315.52dcc2ec@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-07-20 at 10:43 +0100, Jonathan Cameron wrote:
> On Thu, 18 Jul 2024 16:32:33 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2024-07-16 at 19:14 +0100, Jonathan Cameron wrote:
> > > On Tue, 9 Jul 2024 13:14:30 +0200
> > > Nuno Sa <nuno.sa@analog.com> wrote:
> > > =C2=A0=20
> > > > This adds a basic debugfs interface for backends. Two new ops are b=
eing
> > > > added:
> > > >=20
> > > > =C2=A0* debugfs_reg_access: Analogous to the core IIO one but for b=
ackend
> > > > =C2=A0=C2=A0 devices.
> > > > =C2=A0* debugfs_print_chan_status: One useful usecase for this one =
is for
> > > > =C2=A0=C2=A0 testing test tones in a digital interface and "ask" th=
e backend to
> > > > =C2=A0=C2=A0 dump more details on why a test tone might have errors=
.
> > > >=20
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>=C2=A0=20
> > > Debugfs deserved docs as well as sysfs.
> > > Same place in Documentation/ABI/
> > >=20
> > > Obviously we've neglected this in the past, but nice to do it right
> > > nor new stuff.
> > > =C2=A0=20
> >=20
> > I see. So you mean adding debugfs-iio?
>=20
> Probably debugfs-iio-backend for this stuff, though we should have
> a more general doc as well.
>=20
> >=20
> > There's one thing I'm not sure though... I'm contemplating the case whe=
re
> > one device
> > may have multiple backends in which case I'm doing:
> >=20
> > back->name =3D name;
> >=20
> > where name comes from FW (DT usually). That obviously means the interfa=
ce
> > won't be
> > always consistent which I guess it's not a real problem for debugfs?
> >=20
> > How would the interface look in the file? Something like?
> >=20
> > /sys/kernel/debug/iio/iio:deviceX/<backend_name>_direct_reg_access
>=20
> That's fine - fairly common sort of thing to see in debugfs.
>=20
> >=20
> > Or should we think in a more reliable naming? One option that came to m=
ind
> > is
> >=20
> > /sys/kernel/debug/iio/iio:deviceX/backendY_direct_reg_access
> If you were doing this it might be better as a directory.
> e.g. backendY/direct_reg_access
> >=20
> > where Y would be the corresponding index in io-backend-names.
> >=20
> > One thing not optimal with the above would be identifying the actual ba=
ckend
> > device.
> > It would then maybe make sense having a 'backend_name' interface which =
I
> > think is
> > likely too much just for this?
> It kind of depends on your expected usecase.=C2=A0 These are in debugfs s=
o there
> is an assumption they aren't a 'normal operation' thing.=C2=A0 So if they
> are going to typically be poked by a user, then complex file names are fi=
ne.
> If it's going to be scripted, then stable names something like
> backendY/name
> backendY/direct_reg_access etc
> would be easier to use.
>=20

Yeah, I think the main usage (the one I do at least) is for the user to dir=
ectly
play and poke with this. However I don't think that the scripting usecase  =
to be
that crazy (or unlikely) and I do like stable things :). Also liked your
suggestion about grouping the interfaces in a backendY directory. We'll lik=
ely
need an iio_backend_info struct interface for backends to pass in when
registering. Maybe too much for a debug interface but this kind of 'info'
structure may very well be something we'll need in the future. Anyways, I t=
hink
I'll give this a try for v2 so we can see how it looks like in practise.

> I'm not bothered as much about consistency of this debug interface as I w=
ould
> be about sysfs, so up to you (or other reviewers) for which you prefer.
>=20

Yeah, I was kind of expecting that (no one should blindly rely on debugFS) =
:)

- Nuno S=C3=A1=20

