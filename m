Return-Path: <linux-iio+bounces-7367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0A928D40
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 20:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DF7284C64
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF516D33B;
	Fri,  5 Jul 2024 18:03:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C01F94C;
	Fri,  5 Jul 2024 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202588; cv=none; b=hmHKiZ+vVstyc27uZ6la2uTrtBwlC78DrBs4M1JRuFrxyPpiBwBd6HjwJDM0pTHtn3B96v2pLYy0wdtkL8SoljicTPnR5ZtJl+imypRfLeE1oYJLlOBnUtM10ixp8ul87qlL2tz1tccsro19V1Rf8TUCoCNDbezGUZLFpQtmLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202588; c=relaxed/simple;
	bh=BURoN9X2Ud9lPSuEZEgb2aTH1L2VxUlOK+mrgn+GDFg=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=t+zS9NDaBq5g9JZh2ZadyrsFqzpiBO8Tc2dg62FOPJURXMZZ0VdnO+9ZH16iqMKjhlEwVuUIavPH01Ai62ez7t1JcHvIq3PCdAG1Ces8h4OGq41B3Ky11w1tl7uM32ocxQqkqLlhx7boebwq/uGQW2ilGVuA82i7jvNZefr3oQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 6A31537800DE;
	Fri,  5 Jul 2024 18:03:04 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <13828cf9-4a93-45a5-b3a3-542ee9ec056b@denx.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240705095047.90558-1-marex@denx.de>
 <3b2ca0-6687ce00-3-4dab7280@52083650> <13828cf9-4a93-45a5-b3a3-542ee9ec056b@denx.de>
Date: Fri, 05 Jul 2024 19:03:04 +0100
Cc: linux-iio@vger.kernel.org, "Conor Dooley" <conor+dt@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, devicetree@vger.kernel.org, kernel@collabora.com
To: "Marek Vasut" <marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3dd224-66883580-3-40d7c680@7066446>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?iio=3A?==?utf-8?q?_light=3A?=
 =?utf-8?q?_ltrf216a=3A?= Drop undocumented =?utf-8?q?ltr=2Cltrf216a?= 
 compatible string
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Friday, July 05, 2024 20:22 IST, Marek Vasut <marex@denx.de> wrote:

> On 7/5/24 12:42 PM, Shreeya Patel wrote:
> > On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wro=
te:
> >=20
> >> The "ltr,ltrf216a" compatible string is not documented in DT bindi=
ng
> >> document, remove it.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> ---
> >> Cc: Conor Dooley <conor+dt@kernel.org>
> >> Cc: Jonathan Cameron <jic23@kernel.org>
> >> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> >> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >> Cc: Marek Vasut <marex@denx.de>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> >> Cc: devicetree@vger.kernel.org
> >> Cc: linux-iio@vger.kernel.org
> >> ---
> >>   drivers/iio/light/ltrf216a.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf=
216a.c
> >> index 68dc48420a886..78fc910fcb18c 100644
> >> --- a/drivers/iio/light/ltrf216a.c
> >> +++ b/drivers/iio/light/ltrf216a.c
> >> @@ -528,7 +528,6 @@ MODULE=5FDEVICE=5FTABLE(i2c, ltrf216a=5Fid);
> >>  =20
> >>   static const struct of=5Fdevice=5Fid ltrf216a=5Fof=5Fmatch[] =3D=
 {
> >>   	{ .compatible =3D "liteon,ltrf216a" },
> >> -	{ .compatible =3D "ltr,ltrf216a" },
> >>   	{}
> >=20
> > This compatible string with a different vendor prefix was added for=
 a specific reason.
> > Please see the commit message of the following patch :-
> > https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@c=
ollabora.com/
> >=20
> > We were very well aware that not documenting this was going to gene=
rate a warning so
> > we tried to fix that with a deprecated tag but it was NAKd by Rob. =
What we understood
> > from his last message was that it wasn't necessary to fix the DT wa=
rning.
>=20
>  From what I read in the aforementioned discussion thread, it seems R=
ob=20
> was very much opposed to this compatible string, so this shouldn't ha=
ve=20
> gone in in the first place.
>=20
> But it did ... so the question is, what now ?

There were multiple versions sent for adding LTRF216A light sensor driv=
er
and this compatible string wasn't something that was accepted by mistak=
e.
Most of the versions of the patch series made it very clear that it gen=
erates a warning
which you can check here :-
https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me=
55be502302d70424a85368c2645c89f860b7b40

I would just go with whatever Jonathan decides to do here :)

Thanks,
Shreeya Patel


