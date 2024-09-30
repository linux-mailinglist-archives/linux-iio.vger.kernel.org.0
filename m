Return-Path: <linux-iio+bounces-9921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8921D989D98
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4180F1F225C7
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433621865FA;
	Mon, 30 Sep 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+KAq66z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E6185B76;
	Mon, 30 Sep 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687021; cv=none; b=aFYrN+Jj5L1DmEauj0O6NtCfhZU86UQZnTzPknyEMi6xkTYcRMwSWuE6j1r5jBguWduZ3X8L0hMGymKFNGKvfAEJAPMdgzdjTkoskuJWrGHRwn4sPsAszgViK8Sd6Bg7XrDjaQ3P5WvlAqio3ArlOY6v6YGWmfCT6orFKRiQHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687021; c=relaxed/simple;
	bh=ZCHTDQA9ITJT0R1IodVB40XzGFekSP2PUOcE8t3dJKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+xuLwUJoX/NyriyO78KqfQy6MrUBAvZG+WY4dJbmp8aFOepzAL9BYVjNvnumXN9YobGAV0Ppf2+hE7BxMRb5Nmu/KKEZ6b+zArDXdzpYI9igfnZ4sPvQPx3n+tpjCHrHCtWTKs2Wa20BBkV17lzc9WGpKZ+U0beyBNbxCvrVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+KAq66z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E2CC4CEC7;
	Mon, 30 Sep 2024 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727687020;
	bh=ZCHTDQA9ITJT0R1IodVB40XzGFekSP2PUOcE8t3dJKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S+KAq66z0yhhH/GabLL0htOAX9XID5l2bN6ifnTeSQAaqQNQ8vZ5vv90fYp9AGVMb
	 HD2507qoNmsFP90DhBFagW0K+YfUtbhSxTfHATVfFkrjvKG4mILFKYaqXqlhhYtUuo
	 qzgnHv3OYfdp4y1+U4j6pZ4QhIXF19v1GiXZ+qkYoOuO5P3O4t6vY0p4N/QJWCh2ev
	 YD0lI0SlA1pLF4n9Ul1Stz0neuETPN29uojqpObMf8Rm3smnYC9W1/+cFv+GTPEw3e
	 e7fIUF7XeEp2iGGLlh88Jnm4rURqK+NYxCPbo21T4WKU3nMvRuBnw+/JYpOZUlyHJ5
	 jntgsIiYzLvQQ==
Date: Mon, 30 Sep 2024 10:03:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Add
 iam20680ht/hp bindings to mpu6050
Message-ID: <20240930100331.1e7573e0@jic23-huawei>
In-Reply-To: <FR3P281MB17575FC03AF60D690B67452CCE762@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
	<20240923-inv-mpu6050-add-iam20680-ht-hp-v2-1-48290e0b9931@tdk.com>
	<685c0c28-9439-45da-8bc1-19c2c56b2053@kernel.org>
	<20240928174550.47cec40f@jic23-huawei>
	<FR3P281MB17575FC03AF60D690B67452CCE762@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sep 2024 08:46:05 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan
>=20
> for the explanation, the chip variants at reset have a FIFO restricted to=
 512 bytes like the original one. You have to write specific bits in a regi=
ster to unlock the FIFO to its full size.
>=20
> The driver is writing these bits only when you configure the variant. Oth=
erwise, it will behave really like the original one.
>=20
> That's why I call them fully compatible.
Even then I'd go with 'backwards compatible'.

A driver that assumed the new device and tried to use that wouldn't work
with the IAM-20680 so it is one way compatibility.

The binding is fine, just the patch description may imply more than intende=
d.

Jonathan

>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> Sent:=C2=A0Saturday, September 28, 2024 18:45
> To:=C2=A0Krzysztof Kozlowski <krzk@kernel.org>
> Cc:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Pe=
ter Clausen <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Koz=
lowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Jean-Bapti=
ste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; linux-iio@vger.kernel.org <l=
inux-iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kern=
el.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject:=C2=A0Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Add iam2=
0680ht/hp bindings to mpu6050
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On Mon, 23 Sep 2024 17:38:44 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> > On 23/09/2024 16:53, Jean-Baptiste Maneyrol via B4 Relay wrote: =20
> > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > >=20
> > > IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.
> > > They just have better specs, temperature range and a bigger FIFO.
> > >=20
> > > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > > ---   =20
> >=20
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =20
> Ah. I missed v2 as checked by email address.
>=20
> As per v1 review I've tweaked this patch description to say they are
> backwards compatible rather than fully (as the fifo size is not
> discoverable)
>=20
> Jonathan
>=20
> >=20
> > Best regards,
> > Krzysztof
> >  =20
>=20


