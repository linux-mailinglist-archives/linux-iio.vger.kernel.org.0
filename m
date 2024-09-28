Return-Path: <linux-iio+bounces-9833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B51C989026
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C39F1C21351
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B3C36B11;
	Sat, 28 Sep 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+Md+vDj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E119470;
	Sat, 28 Sep 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727538623; cv=none; b=QuhRwIVS/w5Oj+SYrLvxav5k2m3NVPpX5IcPiLH/yaHqGnmzy78ocTJLeJzDpePLuDJtipJ+YMQ8r1zGgQg3LGGIHLzEza/KvKpnwJs3oEBcuiat391MRzKQYit4zBaAFKQqW0vXcHQv57f3h185KLIW6gGnp8hlS8SQMRsJ+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727538623; c=relaxed/simple;
	bh=mRta/wbu5/MssN1857WJD7KYGrXXB98douJKixzLznM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvRWq5ituw4NQ58123G7LlidmXYd1AjrTLJ/zNfc6lFuMa2cqxN0pmoUYuZdZRlyPIzubLzo2BCRJS8aLXIRDgTbIUtbU1Pb6CcusQeEh0/hU/zkBaiRLyK2IkZ7hKaxwdTO0BaAlx+K3BZGNHfgoKo6IZgbjWBAUcPVVbsHUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+Md+vDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1B0C4CEC3;
	Sat, 28 Sep 2024 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727538623;
	bh=mRta/wbu5/MssN1857WJD7KYGrXXB98douJKixzLznM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O+Md+vDjwy+y7J6snfS5yWW7qYMXsfmqi4OJCF8tH007mWngupn8RAz02RYTYQlIO
	 epV6bFtG8h+KT0O3QjOCgEz/C7q6vEUrEZ8jl4BZtjIybCBO8g3jysAQfcRwBhHiNt
	 FrXpw/Hrd/Igj3bRh/J6ODbuu7eJnxSQatwWlNttU1xAsxx92RNTe2oyGBiZYxarxR
	 a9GkYFfFCWrYqjndb+Q9ysXAwXpcM1UumsKTvEwCio60znBcsiBujnvLvMre0q6dZ2
	 oesYKXyxPnXgCYMyQlvc/R102sstmlwTLlKx+IMQl6Fxn/x3QNJD1Nm3aojyBfBKrB
	 kTSuoqkGrpJwA==
Date: Sat, 28 Sep 2024 16:50:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, INV Git Commit
 <INV.git-commit@tdk.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Message-ID: <20240928165015.419fb5d0@jic23-huawei>
In-Reply-To: <FR3P281MB1757A18AD6B116CF34E9B811CE6C2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240920133615.167726-1-inv.git-commit@tdk.com>
	<20240920133615.167726-2-inv.git-commit@tdk.com>
	<43982b29-e456-4e7b-9cda-322ff876a276@kernel.org>
	<FR3P281MB1757A18AD6B116CF34E9B811CE6C2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Sep 2024 14:39:14 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> sorry about that, since there are no modifications at all in the patches =
and just sent them with the added email lists, I wasn't thinking there was =
a need to update the version.
>=20
> I will resend with an updated version number to the right lists then, eve=
n if the patches are strictly the same.

[RESEND PATCH...] and say  in the cover letter why the resend and then don'=
t change the revision.

Jonathan

>=20
> Sorry about that.
>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Krzysztof Kozlowski <krzk@kernel.org>
> Sent:=C2=A0Friday, September 20, 2024 15:39
> To:=C2=A0INV Git Commit <INV.git-commit@tdk.com>; jic23@kernel.org <jic23=
@kernel.org>; robh@kernel.org <robh@kernel.org>; krzk+dt@kernel.org <krzk+d=
t@kernel.org>; conor+dt@kernel.org <conor+dt@kernel.org>
> Cc:=C2=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <li=
nux-iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kerne=
l.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject:=C2=A0Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam2068=
0ht/hp bindings to mpu6050
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On 20/09/2024 15:36, inv.git-commit@tdk.com wrote:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.
> > They just have better specs, temperature range and a bigger FIFO.
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com> =
=20
>=20
> You just sent it... please do not send the same over and over again. See
> submitting patches. Your contributions should be versioned and provide
> changelog in cover letter or within patch's changelog (---).
>=20
> Sending the same over and over will get the same answer: nope.
>=20
> Best regards,
> Krzysztof
>=20


