Return-Path: <linux-iio+bounces-21405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4242AFA667
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D117B230
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D21DE2C9;
	Sun,  6 Jul 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERwMa2sw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF944C94;
	Sun,  6 Jul 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818581; cv=none; b=YRu5IrZ/HfTBGzs1GVLSHuFkthOcgG7x/pNWu3EbVvS9vyGe+zuaCKhNHyJZYhSl4dd42uxOcgMygK37YirQDkwtb8Q8Okddt7nWLjUVghM2o2K/IggJgqsL4lgFAU7+PvjnM5QNVVqELrC45FrYXFFb1d64KGXUbI4Lj7L7fvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818581; c=relaxed/simple;
	bh=YQnLfsFpmsbdhyeEsxLxRtAeYjiu5IhztSDt4Oz9r7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvW+Js+5zPOPpXQuYj/fdEa9hRCU9eO0ay+TiIbrGkuVO0TlHS1ZKbHn8G4wun+hUcphd6j0IfZLTqsrMAcCg6vCiEPMNN2Vvoqj7azJMt1dkMh9otJx2KytPETz0dlzx8qlE6dDLA35MjCHOdPqS+m2O5J53XzyaNoLLhS/mzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERwMa2sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E91CC4CEED;
	Sun,  6 Jul 2025 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751818580;
	bh=YQnLfsFpmsbdhyeEsxLxRtAeYjiu5IhztSDt4Oz9r7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERwMa2swTMT2EOx1tvJP2X0675Vj+8BcYnRbTnNokrLVP+y1UAgSCw58EH/w75LY0
	 wjWQ09rdLrCSzcxbgEV2/zjOVn93u+noc8HBm8OCxatUzGfMacx5bxCaBf9+/iVdix
	 bzbwSXAXyutDJVMSWseGJMo4rAviwxbOvYpdojljnFnHscn/8YkQ40j4U83AxpH0FN
	 wHgnu5eKQoep26X6iBtLbY3ep6CVYAnXGFYMdBRSUymNkytPwK72uC2LUip28Lxp0n
	 LM2f7u+9B5S2NLwzPjdWXS7IAluaDH+wxpEiRTejZxTAe++v3XfxVerfnVLlVr7vn+
	 OdmF5jqKypWeA==
Date: Sun, 6 Jul 2025 17:16:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>, eraretuya@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 8/8] docs: iio: describe inactivity and free-fall
 detection on the ADXL345
Message-ID: <20250706171611.7b4ae1a1@jic23-huawei>
In-Reply-To: <20250702230315.19297-9-l.rubusch@gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
	<20250702230315.19297-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  2 Jul 2025 23:03:15 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Describe the inactivity detection additionally using the free-fall
> register. Due to the controversial discussions on the mailing list, this
> section of the documentation will be committed separately to allow for a
> more focused and detailed elaboration of the topic.
>=20
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/iio/adxl345.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
> index 8ee01b8b87f4..c5525267ea12 100644
> --- a/Documentation/iio/adxl345.rst
> +++ b/Documentation/iio/adxl345.rst
> @@ -150,6 +150,31 @@ functions, so that one follows the other. The auto-s=
leep function puts the
>  sensor into sleep mode when inactivity is detected, reducing power consu=
mption
>  to the sub-12.5=E2=80=AFHz rate.
> =20
> +The inactivity time is configurable between 1 and 255 seconds. In additi=
on to
> +inactivity detection, the sensor also supports free-fall detection, whic=
h, from
> +the IIO perspective, is treated as a fall in magnitude across all axes. =
In
> +sensor terms, free-fall is defined using an inactivity period ranging fr=
om 0.000
> +to 1.000 seconds.
> +
> +The driver behaves as follows:
> +* If the configured inactivity period is 1 second or more, the driver us=
es the
> +  sensor's inactivity register. This allows the event to be linked with
> +  activity detection, use auto-sleep, and be either AC- or DC-coupled.
> +
> +* If the inactivity period is less than 1 second, the event is treated a=
s plain
> +  inactivity or free-fall detection. In this case, auto-sleep and coupli=
ng
> +  (AC/DC) are not applied.
> +
> +* If an inactivity time of 0 seconds is configured, the driver selects a
> +  heuristically determined default period (greater than 1 second) to opt=
imize
> +  power consumption. This also uses the inactivity register.
> +
> +Note: It is recommended to use the activity, inactivity, or free-fall re=
gisters
> +when operating with an ODR between 12.5=E2=80=AFHz and 400=E2=80=AFHz.

This seems a tiny bit backwards.   It is recommend that the activity, inact=
ivity or
free-fall registers are only used when operating with an ODR...

As currently written it seems to be recommending that if you want those sam=
pling
frequencies you should also enable one of these detectors.

Reminds me of the classic London underground sign that said "Dogs must be
carried." which raised the question of how people with out dogs were meant =
to travel.

Otherwise this new section looks good to me.  Thanks,

Jonathan


> According to the
> +datasheet, the recommended free-fall threshold is between 300=E2=80=AFmg=
 and 600=E2=80=AFmg
> +(register values 0x05 to 0x09), and the suggested free-fall time ranges =
from
> +100=E2=80=AFms to 350=E2=80=AFms (register values 0x14 to 0x46).
> +
>  In DC-coupled mode, the current acceleration magnitude is directly compa=
red to
>  the values in the THRESH_ACT and THRESH_INACT registers to determine act=
ivity or
>  inactivity. In contrast, AC-coupled activity detection uses the accelera=
tion


