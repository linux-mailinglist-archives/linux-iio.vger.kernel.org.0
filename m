Return-Path: <linux-iio+bounces-13445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F69F1E5B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD634167C90
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012EE18F2DA;
	Sat, 14 Dec 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbkDmBVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB527170A13;
	Sat, 14 Dec 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734176961; cv=none; b=o+bSfQlRIPT1jvlvRpB86REIJMDHCNgQWQTN6QZn0aBeyzKYJkVs0QFH2mELBBQPITfpV+1r+cQNuq/wAkHQ4fy8w3LquwICiMHdUXXPTmosiWUa12q0FadZBArWko/Nye3H5LUfgl3K5jo8MWzBaf3Iq63xHE9hdPR1pSLTiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734176961; c=relaxed/simple;
	bh=xJSS30hg2FmUw1g1FBZO8Pu4Z0GIfgxqCh5NDr3y3MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLBBEtOwT/Mm6Roz+ogf/4vu03S8vMX8/CRg0V6zdBY0nlkf0vtaYh8oqdinsoy1xrH6DmDhx3A2YNEm8wDQIBNTXTmeJgRL2Nk6pJMq0UuvwYoDdmQYpAkGJsDOVd3f3IGzceETH6TKEEWSSbi8uNVednfa/9lpV5jk+sG8rno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbkDmBVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7174DC4CED1;
	Sat, 14 Dec 2024 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734176961;
	bh=xJSS30hg2FmUw1g1FBZO8Pu4Z0GIfgxqCh5NDr3y3MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WbkDmBVJ13bAnrkUhSfL+sb1j3d4AQ2LnSWZCZA8BEmn2PgIubP5j4/28LxUYoMs9
	 ZsZyCNMJq8m6KGu+AfMwbU4jgHkZb5VNar9eHOLHht2YV185EJY0/Id/kZYO0o0hpb
	 MpuXAMn/j8+GRcOV6qCXI4YuPtIJmA7BwGYDfiTKeY//7m+zHGmvOQZ1kH3LVTQYyJ
	 ycoPRGT44Kn4DpVITZSCeT6Xj+INedT3O+BPwJRnovU2x7ZgBGiHLNUKg8/JFprxdO
	 TtncqN6gpIaZPelgL/iAUTM6sKHnCYOmPWeAJVHB37VjnMo09tG5DRvyHIEqznuxhE
	 +IHiMQADIAHLg==
Date: Sat, 14 Dec 2024 11:49:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v6 2/7] iio: accel: adxl345: complete the list of
 defines
Message-ID: <20241214114914.02a280dd@jic23-huawei>
In-Reply-To: <CAFXKEHZr2MT6Ard2pTpQtU9BVrr8FHes0wFO0PU=rM7iFX6H8A@mail.gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
	<20241211230648.205806-3-l.rubusch@gmail.com>
	<ldsvh5heh6gkdljxvgovwl6ni55cudvqw2mihbrliw7dqanrnk@lwlg6irtvg4x>
	<CAFXKEHZr2MT6Ard2pTpQtU9BVrr8FHes0wFO0PU=rM7iFX6H8A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Dec 2024 10:37:55 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi  Krzysztof,
> Thank you so much for reviewing.
>=20
> On Thu, Dec 12, 2024 at 9:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On Wed, Dec 11, 2024 at 11:06:43PM +0000, Lothar Rubusch wrote: =20
> > > Extend the list of constants. Keep them the header file for readabili=
ty.
> > > The defines allow the implementation of events like watermark, single
> > > tap, double tap, freefall, etc. =20
> >
> > We don't store constants just to store constants, so this commit does
> > not have reason to be separate. We store constants/defines only to
> > implement the driver. Merge these with the users... unless you want to
> > say there are no users of this at all, but then make it clear: move the
> > patch to the end.
> > =20
>=20
> I see your point.
>=20
> The defines are needed for the current introduction of the FIFO usage,
> connected with the watermark feature. Some of it is related to
> upcoming features, such as mentioned in the comment (tap events,
> freefall, powersafe, selftest, etc).
>=20
> This patch series now on FIFO/watermark are just the first step to get
> a solid reviewed common base. Further features are upcoming. I did not
> split up the constants. All the specified registers will be needed to
> allow for their configuration and setup. I understand it's no organig
> growth by immediate need, as I understand, but giving IMHO a bit
> flexibility then in implementing what is the next feature, since all
> registers are already defined.
>=20
> Pls, let me know, if you prefer me to only introduce immediately
> needed constants for a current specific feature?

That would be the normal way to do it in a series that is adding those
features.

There are cases where we do blanket includes of all registers etc in=20
one patch but they tend to be autogenerated from another source (so
annoying to split up) rather than introduced alongside features.

Also tends to be more common for first posting of a driver rather than
adding new features when the author of the driver decided to do a subset
(so follow the local style).

Jonathan

> Best,
> L
>=20
> > Best regards,
> > Krzysztof
> > =20


