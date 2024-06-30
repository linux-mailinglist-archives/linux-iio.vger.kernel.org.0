Return-Path: <linux-iio+bounces-7085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0791D171
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 13:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4773B20DF1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E663C13AD20;
	Sun, 30 Jun 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIJq9jA2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099A13C3D5;
	Sun, 30 Jun 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719746994; cv=none; b=SCtYZl1tEnMjjM7kw+aRbKFbLl+tUR7gUt5X30maMroH0phN5APiSU7lKnN+i38oAfOjfHFAOT4yKG4MUMcyIJ6O56NPA/VO0ErR4mxm1FTj02Fuw7gb2jPpWw0dnoH32zQYgZ7Ux8dprITb6sNPAIDcA5LPY+JYaDai+PQsprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719746994; c=relaxed/simple;
	bh=X9PIonGbJhQLIpEQEmnTtYCiDN8DjBnLQv/yyICT2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOyeV/a15LKikJjV0ATjwObpnODAT16S+skzOWQUkScriK6xIoCHyGxZYv0Pbc1UWPhdlW/5h58e9zlI7gFtyOs0pNqWo1U6EWd8McCM2P2zispxDSQu+m7FFvlwjhW4q2K7pZP3LVQ01Cma2e6bvI8xJPFtZA8WKWQnwonpYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIJq9jA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7882C2BD10;
	Sun, 30 Jun 2024 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719746994;
	bh=X9PIonGbJhQLIpEQEmnTtYCiDN8DjBnLQv/yyICT2Hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DIJq9jA26nzGGruYHXNNJ593+iID8EB1V9CJRBQ4FYDDBLwC0QC6YoPj35R2Pagx9
	 WKtGJcXa0nRUs1RfDWbT4TAbq5fBaQHHyOjNCacGP4DsXPsCPfxM5Q5l9lSWh0CsQm
	 aGJrX9F2zTEZNlcUpJYJfzNKCVoJLg4Z8O1Kwnblchjs4S2Zz+AllZCDnx4uW/UWzY
	 HCTOioZmWNjxY/p57uaauyOvOqNI8jqcBYIONcqOtxCR7AHcryjcPKRtZdCYSzhzel
	 vj5U9CxkOJnG60Kf6OMEWBSzIN2cXvyOuj6GkB8s+yu0Ht5BIvr5D0LDb3LujHm05W
	 GTReFmPbrrrJg==
Date: Sun, 30 Jun 2024 12:29:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jyoti Bhayana <jbhayana@google.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Chris Down <chris@chrisdown.name>,
 John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andi Shyti <andi.shyti@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, Mark
 Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/4] dev_printk: add new dev_err_probe() helpers
Message-ID: <20240630122946.308e3a54@jic23-huawei>
In-Reply-To: <0bebcdd4f1eb94c6fc34b18846ee12cc3c23be0d.camel@gmail.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	<20240606-dev-add_dev_errp_probe-v3-1-51bb229edd79@analog.com>
	<20240608190748.2577b8a5@jic23-huawei>
	<20240617204153.7e36b157@jic23-huawei>
	<0bebcdd4f1eb94c6fc34b18846ee12cc3c23be0d.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jun 2024 17:01:03 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-06-17 at 20:41 +0100, Jonathan Cameron wrote:
> > On Sat, 8 Jun 2024 19:07:48 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> > > On Thu, 6 Jun 2024 09:22:37 +0200
> > > Nuno Sa <nuno.sa@analog.com> wrote:
> > >  =20
> > > > This is similar to dev_err_probe() but for cases where an ERR_PTR()=
 or
> > > > ERR_CAST() is to be returned simplifying patterns like:
> > > >=20
> > > > 	dev_err_probe(dev, ret, ...);
> > > > 	return ERR_PTR(ret)
> > > > or
> > > > 	dev_err_probe(dev, PTR_ERR(ptr), ...);
> > > > 	return ERR_CAST(ptr)
> > > >=20
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>=C2=A0  =20
> > >=20
> > > I'm convinced this is worth doing but would like inputs from others
> > > before I pick this series up. =20
> >=20
> > Andi and Andy,
> >=20
> > You both commented on earlier versions.=C2=A0 Do you think this is a go=
od
> > change set?
> >=20
> > I've +CC a few more based on a quick look at the original
> > dev_err_probe() series. Whilst this isn't adding a bunch of new stuff
> > around deferred probing (like that series did), maybe some of those
> > reviewers will give opinions here?
> >  =20
>=20
> Hi,
>=20
> I there something else needed from my side? Would be nice to have some
> feedback...
I guess no one has strong opinions they haven't expressed already.

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.  Still time for last minute feedback of course.

Basically I decided that even if people decide later they don't like this
for now it has few users and we can rip it out again if needed.
Hopefully that won't happen.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
>=20


