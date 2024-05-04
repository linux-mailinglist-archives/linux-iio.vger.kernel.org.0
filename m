Return-Path: <linux-iio+bounces-4798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E78BBAF8
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0931F21A21
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC720335;
	Sat,  4 May 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3pnMKNr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9DF513;
	Sat,  4 May 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823573; cv=none; b=J+ejavVsSopsTIYW/pPE2eZzDus8PMTl6d0xaw/Ac11fweE/louDCbztv/MOlAZXMoDmHstagzRsgcInZg7+ZUH5VLSrmtjn5nI9GDgmLpsUqxXo/TIJtrIFW96vmh+zIdGA8ihXqa+On+fN1eK3KvHjRArq6bN4jG4G4MYRChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823573; c=relaxed/simple;
	bh=M1Eow/Hwn2Mnc9f11s+ZrLorbo3+uGhlKvf5J52KRuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkCj46Nrxv9ewjpCzmgcyIMg8TOyxYHjyuPaT9QnhlYykrbhkdEyp/jz83AO3nT2DiSmpCB8bHJFyvW9fu2+LXDk5em6Wmx5UNb3fhCeZW0YFKwxlLkCQQOFQQlBItYw3XWJCmiOLpE7E0Y1kF1lKNy14O7g3b1Q0hjuiinjfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3pnMKNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6F0C072AA;
	Sat,  4 May 2024 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714823572;
	bh=M1Eow/Hwn2Mnc9f11s+ZrLorbo3+uGhlKvf5J52KRuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V3pnMKNroRAVKjC2Pb5zLdRO9M1XNICYEEWQWaL0ghTjpZ7pMv86dttUMajypOqsb
	 xjfspe45LQGPwJ1svW66arOZpg1W2001VOSaYdzcODwDpW5KeETME6fWPtwQls1ZdG
	 FzMPYYWckLa0jDHTzRSWBwQiI/iM+U1DoXoj+RrjMUg8VMlO9QVlzfs0oTv6HU7g9f
	 QlWYZXvXMpUrMdwR24x7W6PtTBB0jHzUPHsmG6/3sgpxY83fI0l0EmfjG8216MNjip
	 uPO+Re4CswXTSRCjQkAn9LyJ0zUmJCawUe3BZVkIO/S32s49MPWzUsD8aaRGRcaE1q
	 jZjEwWJQeMhqg==
Date: Sat, 4 May 2024 12:52:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Danila Tikhonov
 <danila@jiaxyga.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: bmi160: add bmi120
Message-ID: <20240504125228.0efe24bf@jic23-huawei>
In-Reply-To: <20240504-bmi120-v1-2-478470a85058@gmail.com>
References: <20240504-bmi120-v1-0-478470a85058@gmail.com>
	<20240504-bmi120-v1-2-478470a85058@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 04 May 2024 01:45:25 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com> wrote:

> From: Danila Tikhonov <danila@jiaxyga.com>
>=20
> Document bosch,bmi120 compatible.
>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Barnb=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml =
b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> index 47cfba939ca6..9ca874aea837 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> @@ -16,7 +16,9 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: bosch,bmi160
> +    enum:
> +      - bosch,bmi120
> +      - bosch,bmi160

Please use a fallback compatible for the bmi120 similar to handling
done for st,asm330lhhx in st,lsm6dsx.yaml

Whilst the driver would currently reject the chip ID, the binding should
assume the driver does fallback handling correctly.

Jonathan

> =20
>    reg:
>      maxItems: 1
>=20


