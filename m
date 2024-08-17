Return-Path: <linux-iio+bounces-8534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA99557E3
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F2282F4A
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC21E892;
	Sat, 17 Aug 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW8u7gSR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E9804;
	Sat, 17 Aug 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898780; cv=none; b=RMftynlRuN7pNqfvj0fLL2eqbUs4TH9UX5sNAvFTlEzWLkY7aX4UzqSQD7219vQfeUJnY3vCvmS3xKm7L87XUQ1sNWSWchgc97KK4okWTmOYqvmZCyb43SWO17cUVvcQEr3oJK68PmVqhPksT74OEhg8ecB6Riy0zWjxfdysNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898780; c=relaxed/simple;
	bh=dLg/As2EpM7QD4+4pHujiUhGDPuFrfSM1Whs4P290tY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2eti5DxoRgfpVng5I8jiVLggWyNAjX/Gd/HIKw/qWFtTBFaGSBLhhT3cqodsxfTz0QkJq6w4MEYCXkfZQ5ztd10MvTWAg+W2rMQT4YAv7sSSfYH2A397A65mkHqRwgV4l0jOioWy3LvA78iW7GVmc96FtyFb1DjzQ0kh0zk/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW8u7gSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EE8C116B1;
	Sat, 17 Aug 2024 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723898779;
	bh=dLg/As2EpM7QD4+4pHujiUhGDPuFrfSM1Whs4P290tY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qW8u7gSRLqNGwEmDmYhyHJP1aYZv1sDAi85+RXr6Qr8WKOXCyTB8HCy/HbywAYiZS
	 V2Ps67sWtH2PkXmqJep3oECcxEztjIR8uHpYdLwEauLqmULv6oJK/+RMTlJABisl4k
	 GgUrCYmGD36heHMrtjgsi6PE1+nTCmbU2xEseuuHyrPRZtpdxrEcXVSrwVwwLDXbyi
	 ghZzUZ7CSRPmCGcX5pGu9ilubDbGE+AG59Y0enecQlzvj5iYFbZs/xO5gtlRF9+dPU
	 i/FyEzhhkYIAo+6B03S9qjXcY3GeN7stK4SdzzyQcNqNc+sFx/yit5Rz/kVytRPjm0
	 cl8VJ7ZQ+Bosg==
Date: Sat, 17 Aug 2024 13:46:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org, Danila Tikhonov
 <danila@jiaxyga.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: imu: magnetometer: Add ak09118
Message-ID: <20240817134612.5fac3917@jic23-huawei>
In-Reply-To: <20240809-ak09918-v3-3-6b036db4d5ec@mainlining.org>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
	<20240809-ak09918-v3-3-6b036db4d5ec@mainlining.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Aug 2024 22:25:41 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote:

> From: Danila Tikhonov <danila@jiaxyga.com>
>=20
> Document asahi-kasei,ak09918 compatible.
>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
Patch title should not contain imu as this isn't one.

> ---
>  .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml       |=
 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kas=
ei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-k=
asei,ak8975.yaml
> index 9790f75fc669..ff93a935363f 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> @@ -18,6 +18,9 @@ properties:
>            - asahi-kasei,ak09911
>            - asahi-kasei,ak09912
>            - asahi-kasei,ak09916
> +      - items:
> +          - const: asahi-kasei,ak09918
> +          - const: asahi-kasei,ak09912
>        - enum:
>            - ak8975
>            - ak8963
>=20


