Return-Path: <linux-iio+bounces-25418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7BFC067BD
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 15:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4043B1A7A
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6331B127;
	Fri, 24 Oct 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="w1hseHtv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EA242D79
	for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312245; cv=none; b=p7OfVhCEbNY6yUobJ2+4gBgS21bsmbKoLM53sv7rea0t8D9ThNKLCKM0juhnw00IZ4X5Dh4wmd/kUMvvBrg+daTTY5WpugvRzIApA5HOe6Xye5bMXfbWVDf6/wi8TYqjcHuCFM0NTGAna7YAeZOQwi+ZN9uLyMrySF2waF4wD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312245; c=relaxed/simple;
	bh=z2TRYUSayuHSKHuJf8E9VcLFYR1IPicf2kL8xcDAsXs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8W8Ok94D7qdX7IqWjseyc/BcEvLTl1wai82wZ1ccpJn60LLPKDsKjfZgnKsVSZZAmZDuI8qIc/Y03PN6gt4Yw6iHWbc7s+4hOnNqvUJPildsrREV5h6eaBlKUpRXi4dR30Dec1tkz1lrUnf6IvMJSqCbczZVj9/Np22f+oCBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=w1hseHtv; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1761312237; x=1761571437;
	bh=z2TRYUSayuHSKHuJf8E9VcLFYR1IPicf2kL8xcDAsXs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=w1hseHtv0wJWHzltVx2Ou2UGSd5rOZ7Xdc871gMOqdbxt1Hw5D8uyngHJPiEfQD39
	 QjFPWXlQOQe52vcNSg4EGYqjuzGLm761Qn8ZBrGDmuM+lCnmAgX0SopB6YKa/bHWq9
	 0kSqdyW8a9hv8srDbNd9xA5Hc5tM6dvIYQm/L1RWuGTEf03D0AZiSPgFjIeJcGkIuC
	 e/+Y439CL5oUEvsqjfj7vQ60KDFc6F+5Fw3tezNO2iapD7BUAOm5bk8nLaqVl5jY11
	 ciLYk4qduTO40EJrvA1GyS0N2Us2v9Xs5D9K1Njl6WeyFPkZCkWintbHihtUQQG3DN
	 zCDlJsAbGgZ7Q==
Date: Fri, 24 Oct 2025 13:23:53 +0000
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, Remi.Buisson@tdk.com
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: inv_icm42600: icm42670
Message-ID: <12F503C7-0625-4068-84C8-4F0496960565@geanix.com>
In-Reply-To: <FR3P281MB1757036E338AF80CEF7555ACCEC02@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <7s6uxp3luxdenurhh5kcgsrokiawtrlzn2krqphotoeuir5xol@yqhbztxiv6by> <FR3P281MB1757036E338AF80CEF7555ACCEC02@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: dea95d7783601db0c1873309bae19146d32de5ce
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jean-Baptiste and Remi,

Any news on the driver for icm42670?
We have a customer that soon will start a large scale prod with the icm4267=
0.

If there is still no timeframe, I will have to start working on this :)

Br,
/Sean

> On 12 Jun 2024, at 14.26, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@=
tdk.com> wrote:
>=20
> Hello Sean,
>=20
> despite its naming, icm42670/icm42607 are completely different chips comp=
ared to traditional icm42600 chips.
>=20
> The icm42670 open-source Linux driver is currently work-in-progress in ou=
r side. There is a plan to send it here when it will be ready. I'm sorry th=
ere is no timeframe for the moment. We already have an internal Linux drive=
r for our Android solution, but it is not a standard one.
>=20
> icm42670 is sharing some things from icm42600 like the FIFO, but it's alm=
ost all. We are planning to do a driver with a single iio device and multip=
le buffers, different from what was done for icm42600 (at that time there w=
as no multiple buffers support).
>=20
> Best regards,
> JB
>=20
> ________________________________________
> From: Sean Nyekjaer <sean@geanix.com>
> Sent: Wednesday, June 12, 2024 10:28
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; INV Git Comm=
it <INV.git-commit@tdk.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org <linux=
-iio@vger.kernel.org>
> Subject: inv_icm42600: icm42670
> =20
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
> =20
> Hi all,
>=20
> I got a custom board with the TDK icm42670 fitted. We thought is was a
> simple ID add, but I was somewhat wrong.
> Many registers are on different addresses and so on.
>=20
> I have done some work in the st_lsm6dsx, that includes many different
> imu devices from the same family.
> But the driver is kinda hard to read because of that.
>=20
> So is it better to do a new driver called icm42670 or should we do the
> same style as the st_lsm6dsx?
>=20
> @TDK
> Do you have done some work for the icm42670?
>=20
> /Sean
>=20
>=20




