Return-Path: <linux-iio+bounces-13961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FFAA0429D
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593AB3A0827
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE991F238C;
	Tue,  7 Jan 2025 14:31:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A211EE006
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260269; cv=none; b=bfgWYdRfa/KGtO8DFXBwhJICl5rUjivU54iLHvMPpys7XELArMpB2HWBurVNnq4Nkrl3FCVnqvPeUzIQ0leHhjxIyqzM0wHQYz/VbGfV0zyU6CUTF3wWWtSc7R9ftV7yqCc+mKKEaVbslUgpishiolAKadtWg/QvKeOBNLwRpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260269; c=relaxed/simple;
	bh=KaJstIpWJ4pAK3zg04SYkontKoQ7+7bq4ZMMb4iG7qA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjK2OCJGJ2g4VtMxAW+pefwNk3D8qmDk5Qc7tfRClp9bQMQb+XbmR9wIBQpssP8eWrsAqhXV5c/cLWnv/Fxv6D2pPkNjN2euK5/qwhOOsiL7vjskbbWiqcA8se1hsw+dzg/9il6Nv31vn1dGNPJHE3ZYAYHKV5Lu3qUkp4YEoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YSCzC61Bqz6JBDx;
	Tue,  7 Jan 2025 22:26:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E69B140A90;
	Tue,  7 Jan 2025 22:31:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 7 Jan
 2025 15:31:04 +0100
Date: Tue, 7 Jan 2025 14:31:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	=?UTF-8?Q?=E2=80=9CLuc?= Van =?UTF-8?Q?Oostenryck=E2=80=9D?=
	<luc.vanoostenryck@gmail.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [RFC PATCH 00/27] iio: improve handling of direct mode claim
 and release
Message-ID: <20250107143102.000058bc@huawei.com>
In-Reply-To: <052fb7dd2d227527e1ab97159849606ce6666868.camel@gmail.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
	<052fb7dd2d227527e1ab97159849606ce6666868.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 07 Jan 2025 13:09:44 +0000
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Sun, 2025-01-05 at 17:25 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Note I haven't attempted to CC relevant people for specific drivers.
> > I'll do that for a non RFC version if we move forwards.
> >=20
> > Effectively two linked things in this series:
> >=20
> > 1) Ripping out iio_device_claim_direct_scoped()
> > 2) Enabling use of sparse to check the claim is always released.
> >=20
> > The iio_device_claim_direct_scoped() was an interesting experiment
> > built on conditional scoped guards, but it has been the source of
> > a range of esoteric build warnings and is awkward to use.
> >  =20
>=20
> Curious about one thing... David, wouldn't your work on 'if_not_cond_guar=
d()'
> help with this messy scoped calls? I saw it was not merged yet though... =
Was it
> dropped for some reason?

Link in cover letter. David's work got merged then reverted :(

https://lore.kernel.org/all/CAHk-=3Dwi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+x=
AghYPQ@mail.gmail.com/

Basically it seems to be impossible to contrive a way of doing scoped condi=
tion
cleanup neatly.  I was also hoping we could transition to the if_cond_guard=
()
approach to solve the scoped problems. :(

Jonathan


>=20
> Anyways, I do like this approach specially due to 2) which, likely, it wo=
uld not
> be straightforward with automatic cleanups (if feasible at all).
>=20
> I plan to go over the whole series in the next few days...
>=20
> - Nuno S=E1
>=20
>=20


