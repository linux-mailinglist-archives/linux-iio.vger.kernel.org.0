Return-Path: <linux-iio+bounces-13338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A116F9ED4CD
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA10283D68
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B991209F57;
	Wed, 11 Dec 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gluDOk+p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED820969A;
	Wed, 11 Dec 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942557; cv=none; b=VsYe21ffiAIJGNeQ22FkW9m4wx+y8iWwnR3pvKck2Iy15dpE7DLfDvv2muu3JBK8Rrqdgh+ETyyOefiBt5TbKaYJx1b9CeBcoxnzqtF78PU+q//eCeRDjBldFImB3ZXAUzyWFzh4OIVFH3cWdoWHqdZlbl31VPza+mB/vj5509A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942557; c=relaxed/simple;
	bh=pd0k148YzYabUSvUzhzX4borTCtPgUpXrUsJus+zF6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN+nOj9PRMrLyrPGmOpJb3LoZbJ4JC6B6J0LPc4z0KhM1yd+TTG1Gi4W807WSCCplkYm0wVcDtS0n9PXyx5Siu5tVLbulJRuRBCVsP0ooNJ2+o/nuuSoZZcCivz2uGNMR0SRq4HJLo+8vUEeNBtvwjDAH+ApdpB+kCy4vp3tQkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gluDOk+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9FCC4CED2;
	Wed, 11 Dec 2024 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733942556;
	bh=pd0k148YzYabUSvUzhzX4borTCtPgUpXrUsJus+zF6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gluDOk+pxor4QJOt4k9310Tpn/HGCD5SpHotQCPqXcgajyz2dPmFzSWQExT7inOSm
	 vtMoeCaNMLoVLvaNif5P2KFtGLSwGEsqm8aBxgWldPsNd9YcL7RiNDswwvmyuj5iK4
	 Fbi7P5dcdVVqxwIuYFH2TScjgEfbf56H7LWAZ61ZOEQPOCHmJIIFREspQKZCUiXzA7
	 UD/LkRzVrz5A+Rjk7LjeqFoVbwzJOjT6wBLlCnLY3AUyTGKsX4jabE8yhKPjHwecAw
	 URJo7FXI3ePh5O4Z9ZLS0iZ+q5AnfT6FgaMGdM4QVBiGsfsmisWXm5cp1nwmuYP4db
	 9/i6UH67p31rQ==
Date: Wed, 11 Dec 2024 18:42:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 02/10] iio: accel: adxl345: rename variable data to
 st
Message-ID: <20241211184227.7a843ac0@jic23-huawei>
In-Reply-To: <CAFXKEHZu7SFx9DS3-cy-=JXSRL6CD0L-WG_BACNa=0w9f_yOEQ@mail.gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-3-l.rubusch@gmail.com>
	<20241208132750.24ff93b8@jic23-huawei>
	<CAFXKEHZu7SFx9DS3-cy-=JXSRL6CD0L-WG_BACNa=0w9f_yOEQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 18:31:57 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi,
>=20
> On Sun, Dec 8, 2024 at 2:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Thu,  5 Dec 2024 17:13:35 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Rename the locally used variable data to st. The st refers to "state",
> > > representing the internal state of the driver object. Further it
> > > prepares the usage of an internal data pointer needed for the
> > > implementation of the sensor features.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Applied to the togreg branch of iio.git. Initially pushed out as testing
> > to let the bots take a look. =20
>=20
> Should I actually drop the "applied" patches in a v6? Or, may I keep them?

Rebase on top of my testing branch or just drop them. Either works.

>=20
> I see that Dan Carpenters smatch now comes up with some issues. So, do
> the fixes go into v6 here, or better separate?
If for things I've picked up, then separate fixup at the beginning of
your v6.  I might squash them into original patches if I haven't pushed
out as togreg yet or they are particularly bad and I think worth potentially
work giving others a messy rebase.

Jonathan


>=20
> Best,
> L


