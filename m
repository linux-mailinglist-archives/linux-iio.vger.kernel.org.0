Return-Path: <linux-iio+bounces-2042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDDF84213F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 11:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32AF1F2326E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF760DDE;
	Tue, 30 Jan 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIJUvRZZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52929D03;
	Tue, 30 Jan 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610528; cv=none; b=ToBQNUrkYNL2G90oc9IRqo0vGoGwXv3MYQhbXWg+XLDA0efup3Nb19GvPNBxKbY9IPvHMqfWTpuH0i2QvdVLguSdEw+uosnV5/PpstPtfjtvtuGi/d8cCxE5K0tNm+sAKg41Z5bsqPGBGmj90/7hGBaTUnDH0EcS5W9G7YWqs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610528; c=relaxed/simple;
	bh=McO9BwgHD5FUykIrTLplgerNK6QmzG4Ww/Ee58WLyN4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZ35rNhwSgS/JWOHRH/D3wXEtpzFN3I26eTShsBfBKPnvEENxih7JeQavFILpFlyPQHEqV0f0HL4jSwLkxbsm0BZzmwF9Wcg8nrtXPOiR7AbS3oAqBXrfI2lIjInSoHkcqYAdQ1LQknwt1/xG85puqS7kfrNXPqPgD/GJ1WzCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIJUvRZZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55efbaca48bso2843453a12.2;
        Tue, 30 Jan 2024 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706610525; x=1707215325; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=McO9BwgHD5FUykIrTLplgerNK6QmzG4Ww/Ee58WLyN4=;
        b=aIJUvRZZpepAc40dQWDZdjMhDlZfS0+xJFNzGV+UYsuyAUV6QmtXmScKQ7jLwZh96z
         YMK53Nyw/JVO4nzXoVZqLokic6lo4ZxPwjC1T38xbp+6/xzY29dawpTmzWr4jiER4T/E
         hbYNtnfh4g9525YvkE7gxXMvST8ZG2kqfVZ2XZ3gy8MB+rhwVIuv+h2Slskhd8sOiMMA
         2eexR2fPLUcoDjuGDPuY9Sb1He28yZc/h4qJGm6+LKTdlcWbKArokClMFbUoYoBnE5CX
         z2aXQcNsh11qfDPEHM4uUMFxeuH7by1jcJ3hA0GqP+FvXU+O+bZVZwVfMuhzuKnOoroo
         HbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610525; x=1707215325;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McO9BwgHD5FUykIrTLplgerNK6QmzG4Ww/Ee58WLyN4=;
        b=YAJvAcEjLSP9Uc6dbuLG6lKJgQ/c2o1EMCgHPenqFBV3xnZYQ1qchC89HoDJtMpjD3
         sykMhnNdMzrKCq8qdNHPLG+8/4IHUcmLWoF4H3bAI0QVekuf1z+RfcDEftr38R5/HYhd
         tLllW3QLoHiWzDc7xDReyBfLk7ntp3k9975eq8d+nlSHzWmRUtVUOBid3Mbk98PlGha+
         3/V5x2SeBsHiO086ARVPnWFadtGK7ox/4GDz+NqJd9TRM5kVTSCrUvbVaARYprqXgJyt
         AVRliQ6G9v6pmPI9ph9kpA+x5Y5zriON6VzHlUHQRI0+tp9PO1/cVXbi6LTNW6Q6k+H1
         9ReA==
X-Gm-Message-State: AOJu0Yw/su2M6wdc9DWTJtXUae1sWgwOr9xDSN8En1LCgAT1wsocl7lW
	sVxcZTv7mDgLjWgZDl6ge57VyIdvuSwy1oDS1gUlZLbpPs2Yr2ru
X-Google-Smtp-Source: AGHT+IFmUOp7Qzy4LE0pAxC40tRuQuhLE8rM6Uc2scPXXHkfH6AJAt5LiQmWD68fvkQOoJepxbTmdg==
X-Received: by 2002:a05:6402:1b07:b0:55c:c49a:1898 with SMTP id by7-20020a0564021b0700b0055cc49a1898mr6238256edb.31.1706610525000;
        Tue, 30 Jan 2024 02:28:45 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id ez16-20020a056402451000b0055c82e27412sm4719737edb.75.2024.01.30.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:28:44 -0800 (PST)
Message-ID: <c15cff6c67a9cbb9dc191175cb550ef28639c252.camel@gmail.com>
Subject: Re: [PATCH v7 1/9] of: property: fix typo in io-channels
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Tue, 30 Jan 2024 11:32:00 +0100
In-Reply-To: <CAGETcx-_FbMuisXb5aw40RxgnMT8xTOaq2FOmTo-twY09EV1sQ@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-1-1bff236b8693@analog.com>
	 <CAGETcx_0wij8j5u7YRNPDgpPDkJoFq4AL7oRy0iFUELYTbc9Bg@mail.gmail.com>
	 <20240127150726.3c9150c7@jic23-huawei>
	 <dbf75dfff3ac2d03d198de918a6c525f7b5266c6.camel@gmail.com>
	 <CAGETcx-_FbMuisXb5aw40RxgnMT8xTOaq2FOmTo-twY09EV1sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 14:33 -0800, Saravana Kannan wrote:
> On Mon, Jan 29, 2024 at 12:15=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> >=20
> > On Sat, 2024-01-27 at 15:07 +0000, Jonathan Cameron wrote:
> > > On Wed, 24 Jan 2024 19:14:35 -0800
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >=20
> > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > >=20
> > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > >=20
> > > > > The property is io-channels and not io-channel. This was effectiv=
ely
> > > > > preventing the devlink creation.
> > >=20
> > > I'm a bit lost on the devlink side of things. Is this something with
> > > effects on existing drivers before this patch set, or is it only caus=
ing
> > > real problems with the changes in here?
> > >=20
> > > i.e. Should we mark it for stable and rush it in as a fix, or can it =
wait
> > > for the rest of the set?
> > >=20
> >=20
> > I guess you already figured this out? Anyways, this is a real fix that =
was
> > affecting any consumer using io-channels (so nothing to do with the cur=
rent
> > series). Since the there was a typo, no fw_links were being created.
> >=20
> > I stated in the cover why I included this. Just to make the addition of=
 io-
> > backends later on easier. But if Rob prefers (or you), I can just send =
this
> > standalone patch to the devicetree list.
>=20
> I think you should send this to Rob directly as a DT fix. I already
> gave you a Reviewed-by too. So it should land quickly.
>=20
> This is a real bug that we want to fix as soon as we can. And your
> series might take a bit longer to land.
>=20
> -Saravana

Alright... will do that

- Nuno S=C3=A1

