Return-Path: <linux-iio+bounces-6253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D299907B36
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 20:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0872846F9
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 18:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B114C5B0;
	Thu, 13 Jun 2024 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiIxKIHG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167C14B942
	for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302986; cv=none; b=kvNKV7FuxFsKEZUa7JDSjN51TF+WwUk5kEpssZtJXukEEuinqLsvVdj9j2dGiPkSFRc3/1P8kqAY7u39ESI8e0EpycetrsmOSDrLFq/T4mxiGoQTcZxZ6WQcVXRVJpFg0GiVdOppjK5Kc3ULBBSQNAUgahJtyCA4tufvgsGedA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302986; c=relaxed/simple;
	bh=7T/n5LmxO802CJzucJ5CSf0SOPCvLweSNJWmGv911Us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ae29vBG0kILymHyGJtcgEmXzHHdyFaThiH9zsBOPK63HsL1g/2r028IRoL8COrYUMrt5mfnO5rvVvJiDeedL3RX18Jz+9fRrLG5OAXOoImUKofE160BBfBSakLS5uYc0kuP5askg86ZdaxULVDOlEi8lr0MiXIqcyD20j56xNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiIxKIHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9267BC2BBFC;
	Thu, 13 Jun 2024 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718302985;
	bh=7T/n5LmxO802CJzucJ5CSf0SOPCvLweSNJWmGv911Us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiIxKIHG/mokz0aD51biZtvAE6tMwK9Mi6s1amymhzYUUh033YJrcNWKFVT1RbXTu
	 8Zs8CYxxtGUkZeUao8iZMEBLfWxOnPleNDTC8ZEroSIV31on4XG5lC+diccfR2H0bi
	 dsEs94BJlPpRnAaXC5K+3Nv0CKB14ZDPCPubc8lTWrq0scqZgD+aJiRwNJX87M8kiH
	 PV82iBunaAKFpWW+cbCPy0QrxZANrqGjhJYLVCP3tcoLUNAf+n9TOs8oQVhxiKxE1j
	 EI3ioOOKfCx5OwF9OtOrryJl4I6quCUPmSZJvFMcSRQhsNjcqgAxJcAwogTtF7CqNG
	 VONZlCnRTyk8Q==
Date: Thu, 13 Jun 2024 19:22:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: INV Git Commit <INV.git-commit@tdk.com>, "lars@metafoo.de"
 <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] iio: imu: inv_icm42600: add support of accel low
 power
Message-ID: <20240613192257.1c7c2f55@jic23-huawei>
In-Reply-To: <FR3P281MB17573989B841EE3886CD2580CEC02@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240605195949.766677-1-inv.git-commit@tdk.com>
	<20240609110930.2f40d3d3@jic23-huawei>
	<FR3P281MB17573989B841EE3886CD2580CEC02@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 12:28:50 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hi Jonathan,
>=20
> I'm sorry I am not able to find this patch in togreg branch currently.
>=20
> Am I not looking at the correct place or there is a problem somewhere?
As so often happens I was being dozy at end of a reviewing session
and failed to push out.
Done now.

>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> Sent:=C2=A0Sunday, June 9, 2024 12:09
> To:=C2=A0INV Git Commit <INV.git-commit@tdk.com>
> Cc:=C2=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <li=
nux-iio@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@td=
k.com>
> Subject:=C2=A0Re: [PATCH v4 0/2] iio: imu: inv_icm42600: add support of a=
ccel low power
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On Wed,  5 Jun 2024 19:59:47 +0000
> inv.git-commit@tdk.com wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > Add accel low power support, enabling use of lower ODR below 12.5Hz.
> >=20
> > Add new sysfs API for controlling the power mode and enforce power mode=
 used
> > when using an ODR that supports only 1 mode (ODR < 12.5Hz or ODR > 500H=
z). =20
> Applied to the togreg branch of iio.git and pushed out as testing for 0-d=
ay to
> poke at it.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Changelog
> >=20
> > V2:
> > - fix patch missing Signed-off tag
> >=20
> > V3:
> > - make all ODRs available and switch power mode automatically for ODR s=
upporting
> >   only 1 mode.
> > =20
> > V4:
> > - prevent power mode setting when the ODR is not supported
> > - return the actual power mode when sensor is on, otherwise the request=
ed one.
> > - add sysfs ABI documentation
> >=20
> > Jean-Baptiste Maneyrol (1):
> >   iio: imu: inv_icm42600: add support of accel low-power mode
> >=20
> >  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +
> >  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 124 +++++++++++++++++-
> >  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  27 ++++
> >  3 files changed, 151 insertions(+), 4 deletions(-)
> >  =20
>=20


