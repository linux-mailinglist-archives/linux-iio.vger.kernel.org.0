Return-Path: <linux-iio+bounces-8533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3569557CE
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8F9283080
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC314A62A;
	Sat, 17 Aug 2024 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Tl1Zy8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FC335D3;
	Sat, 17 Aug 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723897936; cv=none; b=HnScZLczRGUTRBaQrFVL1hze4e5vsJx2stiGl7Q0XqyQAGIgGNZ63he+8fhD2ggKKKmmmKT9s+NU5fSA04IZXRtMEiuJ8DK4qaAfjVCvIw5Kl5e9JvEA/rzQOoVRvUCXjnQ6LNWYcdNTU4pR62K1SCM64IB4mS8V0H3qoKebeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723897936; c=relaxed/simple;
	bh=xTN2wrxSIweCYAg7tK0FmpUWkzt7Wz14+AV35EGYxbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGLL7A5/DWbBPVKNxWUbGZe8RMmIxw2Fmqn88Ll0DSQ+4lqufNHxRCwphlWsZ4PLRnAagOT2lT4rh5eEkTktxNE1el/gbplm4WGk+IRRczDt+bUTvEZCLn9GWIo/XzmOsT2YJMPFSah7KdyTDQlQWbjRIF631lUxx9n7Betuk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Tl1Zy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA36DC116B1;
	Sat, 17 Aug 2024 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723897935;
	bh=xTN2wrxSIweCYAg7tK0FmpUWkzt7Wz14+AV35EGYxbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s0Tl1Zy8k5l5zWAzQVWcthqd+YyyHM9UAbgtU0+LXeM+CuuHd20v2WcoU6L4bo79+
	 Qu2Z1QY+7yV1tXp72PKJSm1mqYZc31slyYntODvnTjAyASRgkj0D2BCQTq95B7ihNP
	 bw3cpr9Boz3ntRzkoDZg6kBJvUoNKpM7zB0wjQb+HP1+sz0mc/NU5QHzf7rbJ1gbOY
	 q+ORHprkCwLhnhZ8OJ1Vamkb7JxeusaIaqy3DD3eLCk97umlKk1Tgn8Skou1TuBSdY
	 MuJtH3y7AN/pGwFXEvfwq0ZDhI8cYNyg/KOljFM0uTxUBFqdPn9psaspI1sJT0wtNW
	 kMXalACysKS6A==
Date: Sat, 17 Aug 2024 13:32:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: barnabas.czeman@mainlining.org, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Albrieux
 <jonathan.albrieux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux@mainlining.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: imu: magnetometer: Add ak09118
Message-ID: <20240817133207.3585371b@jic23-huawei>
In-Reply-To: <8e4a2774-ed58-49cb-b970-b3c05c9c1daa@kernel.org>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
	<20240809-ak09918-v3-3-6b036db4d5ec@mainlining.org>
	<1568980c-fc35-4445-a10c-8bb7fede2763@kernel.org>
	<45dc7e6de63f5b55f6a3488a82ad5b0d@mainlining.org>
	<8e4a2774-ed58-49cb-b970-b3c05c9c1daa@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Aug 2024 08:17:52 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 11/08/2024 20:28, barnabas.czeman@mainlining.org wrote:
> > On 2024-08-10 14:15, Krzysztof Kozlowski wrote: =20
> >> On 09/08/2024 22:25, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wrote: =20
> >>> From: Danila Tikhonov <danila@jiaxyga.com>
> >>>
> >>> Document asahi-kasei,ak09918 compatible. =20
> >>
> >> Not much improved here. =20
> > I have removed Reviewed-by because fallback compatible is a different=20
> > approach
> > and I would not mind second look. =20
>=20
> You received specific comments. You ignored them, so I replied that you
> ignored them. And your excuse is that you ask for review? This does not
> work like this.  Read CAREFULLY form letter below.
>=20
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It seems my or other reviewer's previous comments were not fully
> >> addressed. Maybe the feedback got lost between the quotes, maybe you
> >> just forgot to apply it. Please go back to the previous discussion and
> >> either implement all requested changes or keep discussing them.
> >>
> >> Thank you.
> >> </form letter>
> >> =20
> >>>
> >>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> >>> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainli=
ning.org>
> >>> ---
> >>>  .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml    =
 =20
> >>>  | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git=20
> >>> a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml=20
> >>> b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> >>> index 9790f75fc669..ff93a935363f 100644
> >>> ---=20
> >>> a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> >>> +++=20
> >>> b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> >>> @@ -18,6 +18,9 @@ properties:
> >>>            - asahi-kasei,ak09911
> >>>            - asahi-kasei,ak09912
> >>>            - asahi-kasei,ak09916
> >>> +      - items:
> >>> +          - const: asahi-kasei,ak09918
> >>> +          - const: asahi-kasei,ak09912 =20
> >>
> >> Why? Your driver suggests it might not be compatible... Can device bind
> >> using ak09912 and operate up to ak09912 extend? =20
> > It is register compatible and it can bind on 09112, as I understand=20
> > fallback compatible =20
>=20
> ok
>=20
> > was a request from Connor and Jonathan in the previous round. =20
>=20
> Not entirely, you should read comments more carefully.
Given the device specific data is only different in terms of the ID
register value, a fallback seems fine, but you should add to this
patch description something to say that this device is register
compatible etc.

>=20
> Best regards,
> Krzysztof
>=20


