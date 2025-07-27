Return-Path: <linux-iio+bounces-22042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE34B12FA2
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8250B7AA6B4
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED5B213E85;
	Sun, 27 Jul 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXaDpZkG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDFF13D8B1;
	Sun, 27 Jul 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753621722; cv=none; b=hysgLQ94JSqPS88utBGB5/3l4i839pM5M3hs6C/8xPrRzxZD2jZjeg3WKLr8mCz9HDGxOsfXSdLVTxnCxZ4iALMGyP7DVrRI6hXHfrr8fteepYF1h9Ww5OMbo9rjQNQRZFu4pQI33ETZJI4zzs9TMCdSnOSQwCAFuM44SAWPoes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753621722; c=relaxed/simple;
	bh=hN9LDjd6CLq5G10VnQYY9Dgif1+I33fW6zwuL/KlJ70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3avQgEqBvPG1RM5LdfA/rbnC0UcUG8gid4ZxppSVRNM1FCUn1yPqShQ46uE3P+oy22RtdDtIZO88F2hVWpeIjgY+UEE1YJQPMHL6/nFvXbeLzqFBgFKG0f3gJ1pWKbG2o6F6UTle0queYuHI0jwhdBgv4lYCZQHNUt1zcksK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXaDpZkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4FBC4CEEB;
	Sun, 27 Jul 2025 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753621722;
	bh=hN9LDjd6CLq5G10VnQYY9Dgif1+I33fW6zwuL/KlJ70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NXaDpZkGOTrdczLzZtFLw5a5TR8K0054fptr52ejiMIh1u4w9pSTseGI5EM4ABgBI
	 KFEGCpfdanCIdw4ssb8+lXrAxDEZH6PMFvAyOo8d63kNZs0+YAnKq9LMdy4RrngvVI
	 BWUiXIe9yz3irGRVtZiy2dzWcTogwYzAz+X3CraVX+FXuWBeMXnK8qtT+9cjkbvs8m
	 sDkT32CjuFhHf4Ftpfk1qvX4vHGSy3R44Y3gmk21n/6zqAIMgygoGGfvZ5sqhlw1+i
	 84Hx8Q54byOG/8Y97zfDS30QwogWcARAyel32hT+Rp/BGSN5r18AzUKP6JuDoDfnPq
	 9cxXOLprtOFfA==
Date: Sun, 27 Jul 2025 14:08:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML
 docs
Message-ID: <20250727140828.4893fc51@jic23-huawei>
In-Reply-To: <8f4358e8-ecd6-4d86-8326-25d21c3a4ea2@gmail.com>
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
	<20250724111247.669d6955@jic23-huawei>
	<8f4358e8-ecd6-4d86-8326-25d21c3a4ea2@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Jul 2025 22:38:14 +0530
Sanjay Suthar <sanjaysuthar661996@gmail.com> wrote:

> On 24/07/25 15:42, Jonathan Cameron wrote:
> > On Tue, 22 Jul 2025 22:35:13 +0530
> > Sanjay Suthar <sanjaysuthar661996@gmail.com> wrote:
> > =20
> >> Fix minor grammatical issues by removing duplicated "is" in two device=
tree
> >> binding documents:
> >>
> >> - net/amlogic,meson-dwmac.yaml
> >> - iio/dac/ti,dac7612.yaml
> >>
> >> Signed-off-by: Sanjay Suthar <sanjaysuthar661996@gmail.com> =20
> > I'd have no problem with the argument that this can go through either
> > tree if there was any interaction between the files or the changes, but
> > here there isn't. This is just causing potential mess if either tree en=
ds
> > up with other changes overlapping this for no benefit.  Please split in=
to
> > two patches, one for each subsystem.  You should be fine to keep the
> > various tags given here for the new patches. =20
>=20
> Thanks for the review. I understand your concern regarding splitting the=
=20
> changes. My intention was that, since the fix is a trivial and identical=
=20
> grammatical correction across both subsystems, it didn=E2=80=99t seem nec=
essary=20
> to separate them.
>=20
> However, I=E2=80=99m open to either approach =E2=80=94 keeping it as a si=
ngle patch or=20
> splitting it if that's preferred. As I=E2=80=99m still new to this proces=
s, I=E2=80=99ll=20
> defer to @krzysztof and the DT maintainers for the final call on how=20
> this should be handled.
>=20
> Please let me know the preferred direction, and I=E2=80=99ll be happy to =
update=20
> accordingly.

DT bindings ultimately go through the subsystem trees (in vast majority of
cases) to avoid churn issues and keep them aligned with driver changes.
So split it.

Thanks

Jonathan

>=20
> Best regards,
>=20
> Sanjay Suthar
>=20


