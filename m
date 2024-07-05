Return-Path: <linux-iio+bounces-7348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E69286FF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252DF2831CE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF6B1487EF;
	Fri,  5 Jul 2024 10:42:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2F13C8F9;
	Fri,  5 Jul 2024 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176164; cv=none; b=jxTpjG3X9M8ekQ3NW5puzWPSgjiRSPwggZ9NxqEsfg8GwyJafDxRG7LPj1Yk5pbojd6KlwaamJVDkllDmPVx2X2cEHnKqCcB8+3Er5lJauVo61JTP7aF63CMDjKHDhgKQkT03sOF2WPoNEe2VvR6k0mhg+MFQk42wv4RJ76+z/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176164; c=relaxed/simple;
	bh=zXMAkggHhhAA+aDOLGdaygaaSvxs4nR0CWBBjK/lV3Y=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=CxtTNZBVgKv65f30X9KH8m6X/YM2fS2rOUjIcs8htsJOEJPZ185embJjW6/X/o7c7uqwUK8ArKhp+KuWW2LmtpQAJOEaIFyK87ooFwH6/HdGVXd5kdAYtfra8CSkuPxfWhWvhrN1j5KdegxZ91b5lZLdHQRzISmLuDBm8itqV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 7E7DB378219E;
	Fri,  5 Jul 2024 10:42:35 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240705095047.90558-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240705095047.90558-1-marex@denx.de>
Date: Fri, 05 Jul 2024 11:42:35 +0100
Cc: linux-iio@vger.kernel.org, "Conor Dooley" <conor+dt@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, devicetree@vger.kernel.org, kernel@collabora.com
To: "Marek Vasut" <marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3b2ca0-6687ce00-3-4dab7280@52083650>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?iio=3A?==?utf-8?q?_light=3A?=
 =?utf-8?q?_ltrf216a=3A?= Drop undocumented =?utf-8?q?ltr=2Cltrf216a?= 
 compatible string
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:

> The "ltr,ltrf216a" compatible string is not documented in DT binding
> document, remove it.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/light/ltrf216a.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216=
a.c
> index 68dc48420a886..78fc910fcb18c 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -528,7 +528,6 @@ MODULE=5FDEVICE=5FTABLE(i2c, ltrf216a=5Fid);
> =20
>  static const struct of=5Fdevice=5Fid ltrf216a=5Fof=5Fmatch[] =3D {
>  	{ .compatible =3D "liteon,ltrf216a" },
> -	{ .compatible =3D "ltr,ltrf216a" },
>  	{}

This compatible string with a different vendor prefix was added for a s=
pecific reason.
Please see the commit message of the following patch :-
https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@colla=
bora.com/

We were very well aware that not documenting this was going to generate=
 a warning so
we tried to fix that with a deprecated tag but it was NAKd by Rob. What=
 we understood
from his last message was that it wasn't necessary to fix the DT warnin=
g.

Thanks,
Shreeya Patel

>  };
>  MODULE=5FDEVICE=5FTABLE(of, ltrf216a=5Fof=5Fmatch);
> --=20
> 2.43.0
>


