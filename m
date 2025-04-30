Return-Path: <linux-iio+bounces-18895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD5DAA4D17
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BDB17D63F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C1231847;
	Wed, 30 Apr 2025 13:11:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1FE1D88D0;
	Wed, 30 Apr 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018686; cv=none; b=PzcvYM2zUHF8akogdvsQrOV+lhgg8l6AEkHiKgmU8r5p1YNuDfaC4rqq3AQcRoiDwuP7EXGE2rARtrsvkA1zG4X0G/rP0fxKm/qBVNqkx1V3X9U6DP0GPYVW/BqgNtZCqPjjb+ON3FQ2WWF5FwvUyTON7p44+UJWEbkYyn3yr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018686; c=relaxed/simple;
	bh=C9/FUQFz+i+GJv9TTRnTkJtbPSiu6fzsLHQ2/g5FeaE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3aB3hL6rIoRRxwxN8jrxGzpqXShP579YK7OyyZksFcqYA8NrSky8gwW4n9u2fmTUiYV2qwbJlFGlmzPDX16NlA+BqpMvqranUaR0+d2zxf2BfdkjTx9zIgvKtFFv2pWXSCm92Lflh7TjvAOUUVEtVQibvZ80wrl/n4bp+Zn2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZncrY4WWXz6K901;
	Wed, 30 Apr 2025 21:06:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 59A01140604;
	Wed, 30 Apr 2025 21:11:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Apr
 2025 15:11:14 +0200
Date: Wed, 30 Apr 2025 14:11:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <mazziesaccount@gmail.com>,
	<linux-iio@vger.kernel.org>, Fabio Estevam <festevam@denx.de>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
Message-ID: <20250430141112.00004bb8@huawei.com>
In-Reply-To: <CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
	<20250429183301.326eaacf@jic23-huawei>
	<CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
	<CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Apr 2025 16:05:55 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Tue, Apr 29, 2025 at 3:33=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
>=20
> > +                       pr_err("******** mask2[%d] is 0x%lx\n", j, mask=
2[i]); =20
>=20
> Sorry, this line is wrong.
>=20
> The correct debug patch is this one:
>=20
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1947,15 +1947,23 @@ static void
> iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
>          * available masks in the order of preference (presumably the lea=
st
>          * costy to access masks first).
>          */
> +
> +       pr_err("******** masklength is %d", masklength);
> +       pr_err("******** longs_per_mask is %d", longs_per_mask);
> +
>         for (i =3D 0; i < num_masks - 1; i++) {
>                 const unsigned long *mask1;
>                 int j;
>=20
>                 mask1 =3D av_masks + i * longs_per_mask;
> +
> +               pr_err("******** mask1[%d] is 0x%lx\n", i, mask1[i]);

As below. Should be mask1[0] as we've already indexed the array with
the above calculation.


> +
>                 for (j =3D i + 1; j < num_masks; j++) {
>                         const unsigned long *mask2;
>=20
>                         mask2 =3D av_masks + j * longs_per_mask;
> +                       pr_err("******** mask2[%d] is 0x%lx\n", j, mask2[=
j]);

Should print mask2[0] as the calculation already found the offset into the =
array.

Jonathan


>                         if (bitmap_subset(mask2, mask1, masklength))
>                                 dev_warn(indio_dev->dev.parent,
>                                          "available_scan_mask %d
> subset of %d. Never used\n",
> The original mask array is:
>=20
> 0x1,
> 0x2,
> 0x4,
> 0x8,
> 0x3,
> 0x7,
> 0xf,
> 0xc,
> 0x1000,
> 0x2000,
> 0x40000,
> 0x80000,
> 0x3000,
> 0xc0000,
>=20
> So mask2 is jumping by two indexes, instead of one.

I think this is a false positive due to the bug in the debug
prints above.

>=20
> mask1 and mask2 arrays are accessing uninitialized data:
>=20
> [    1.561626] iio-core: ******** masklength is 9
> [    1.561639] iio-core: ******** longs_per_mask is 1
> [    1.566130] iio-core: ******** mask1[0] is 0x1
> [    1.570945] iio-core: ******** mask2[1] is 0x4
> [    1.584554] iio-core: ******** mask2[2] is 0x3
> [    1.589012] iio-core: ******** mask2[3] is 0xf
> [    1.593465] iio-core: ******** mask2[4] is 0x1000
> [    1.598183] iio-core: ******** mask2[5] is 0x40000
> [    1.602981] iio-core: ******** mask2[6] is 0x3000
> [    1.607702] iio-core: ******** mask2[7] is 0x0
> [    1.612157] iio-core: ******** mask2[8] is 0xffff0000000e2720
> [    1.617925] max1363 1-0064: available_scan_mask 8 subset of 0. Never u=
sed
> [    1.624723] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    1.630493] max1363 1-0064: available_scan_mask 9 subset of 0. Never u=
sed
> [    1.637297] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    1.643141] max1363 1-0064: available_scan_mask 10 subset of 0. Never =
used
> [    1.650032] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    1.655876] max1363 1-0064: available_scan_mask 11 subset of 0. Never =
used
> [    1.662772] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    1.668614] max1363 1-0064: available_scan_mask 12 subset of 0. Never =
used
> [    1.675506] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    1.681361] max1363 1-0064: available_scan_mask 13 subset of 0. Never =
used
> [    1.688257] iio-core: ******** mask1[1] is 0x4
> [    1.692725] iio-core: ******** mask2[2] is 0x3
> [    1.697185] iio-core: ******** mask2[3] is 0xf
> [    1.701642] iio-core: ******** mask2[4] is 0x1000
> [    1.706361] iio-core: ******** mask2[5] is 0x40000
> [    1.711163] iio-core: ******** mask2[6] is 0x3000
> [    1.715880] iio-core: ******** mask2[7] is 0x0
> [    1.720335] iio-core: ******** mask2[8] is 0xffff0000000e2720
> [    1.726097] max1363 1-0064: available_scan_mask 8 subset of 1. Never u=
sed
> [    1.732899] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    1.738659] max1363 1-0064: available_scan_mask 9 subset of 1. Never u=
sed
> [    1.745463] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    1.751307] max1363 1-0064: available_scan_mask 10 subset of 1. Never =
used
> [    1.758197] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    1.764044] max1363 1-0064: available_scan_mask 11 subset of 1. Never =
used
> [    1.770933] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    1.776776] max1363 1-0064: available_scan_mask 12 subset of 1. Never =
used
> [    1.783671] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    1.789521] max1363 1-0064: available_scan_mask 13 subset of 1. Never =
used
> [    1.796407] iio-core: ******** mask1[2] is 0x3
> [    1.800864] iio-core: ******** mask2[3] is 0xf
> [    1.805319] iio-core: ******** mask2[4] is 0x1000
> [    1.810046] iio-core: ******** mask2[5] is 0x40000
> [    1.814848] iio-core: ******** mask2[6] is 0x3000
> [    1.819563] iio-core: ******** mask2[7] is 0x0
> [    1.824014] iio-core: ******** mask2[8] is 0xffff0000000e2720
> [    1.829769] max1363 1-0064: available_scan_mask 8 subset of 2. Never u=
sed
> [    1.836566] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    1.842322] max1363 1-0064: available_scan_mask 9 subset of 2. Never u=
sed
> [    1.849149] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    1.854994] max1363 1-0064: available_scan_mask 10 subset of 2. Never =
used
> [    1.861880] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    1.867723] max1363 1-0064: available_scan_mask 11 subset of 2. Never =
used
> [    1.874608] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    1.880452] max1363 1-0064: available_scan_mask 12 subset of 2. Never =
used
> [    1.887339] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    1.893182] max1363 1-0064: available_scan_mask 13 subset of 2. Never =
used
> [    1.900068] iio-core: ******** mask1[3] is 0xf
> [    1.904520] iio-core: ******** mask2[4] is 0x1000
> [    1.909232] iio-core: ******** mask2[5] is 0x40000
> [    1.914033] iio-core: ******** mask2[6] is 0x3000
> [    1.918746] iio-core: ******** mask2[7] is 0x0
> [    1.923200] iio-core: ******** mask2[8] is 0xffff0000000e2720
> [    1.928956] max1363 1-0064: available_scan_mask 8 subset of 3. Never u=
sed
> [    1.935759] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    1.941517] max1363 1-0064: available_scan_mask 9 subset of 3. Never u=
sed
> [    1.948315] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    1.954156] max1363 1-0064: available_scan_mask 10 subset of 3. Never =
used
> [    1.961042] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    1.966885] max1363 1-0064: available_scan_mask 11 subset of 3. Never =
used
> [    1.973771] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    1.979614] max1363 1-0064: available_scan_mask 12 subset of 3. Never =
used
> [    1.986499] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    1.992343] max1363 1-0064: available_scan_mask 13 subset of 3. Never =
used
> [    1.999226] iio-core: ******** mask1[4] is 0x1000
> [    2.003943] iio-core: ******** mask2[5] is 0x40000
> [    2.008743] iio-core: ******** mask2[6] is 0x3000
> [    2.013457] iio-core: ******** mask2[7] is 0x0
> [    2.017910] iio-core: ******** mask2[8] is 0xffff0000000e2720
> [    2.023666] max1363 1-0064: available_scan_mask 8 subset of 4. Never u=
sed
> [    2.030464] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    2.036220] max1363 1-0064: available_scan_mask 9 subset of 4. Never u=
sed
> [    2.043019] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    2.048863] max1363 1-0064: available_scan_mask 10 subset of 4. Never =
used
> [    2.055748] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    2.061596] max1363 1-0064: available_scan_mask 11 subset of 4. Never =
used
> [    2.068482] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    2.074326] max1363 1-0064: available_scan_mask 12 subset of 4. Never =
used
> [    2.081212] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.087055] max1363 1-0064: available_scan_mask 13 subset of 4. Never =
used
> [    2.093938] iio-core: ******** mask1[5] is 0x40000
> [    2.098739] iio-core: ******** mask2[6] is 0x3000
> [    2.103452] iio-core: ******** mask2[7] is 0x0
> [    2.107905] iio-core: ******** mask2[8] is 0xffff0000000e2720
> [    2.113661] max1363 1-0064: available_scan_mask 8 subset of 5. Never u=
sed
> [    2.120459] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    2.126215] max1363 1-0064: available_scan_mask 9 subset of 5. Never u=
sed
> [    2.133013] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    2.138857] max1363 1-0064: available_scan_mask 10 subset of 5. Never =
used
> [    2.145750] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    2.151595] max1363 1-0064: available_scan_mask 11 subset of 5. Never =
used
> [    2.158480] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    2.164323] max1363 1-0064: available_scan_mask 12 subset of 5. Never =
used
> [    2.171208] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.177051] max1363 1-0064: available_scan_mask 13 subset of 5. Never =
used
> [    2.183936] iio-core: ******** mask1[6] is 0x3000
> [    2.188654] iio-core: ******** mask2[7] is 0x0
> [    2.193106] max1363 1-0064: available_scan_mask 7 subset of 6. Never u=
sed
> [    2.199904] iio-core: ******** mask2[8] is 0xffff0000000e2720
> [    2.205660] max1363 1-0064: available_scan_mask 8 subset of 6. Never u=
sed
> [    2.212458] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    2.218215] max1363 1-0064: available_scan_mask 9 subset of 6. Never u=
sed
> [    2.225012] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    2.230855] max1363 1-0064: available_scan_mask 10 subset of 6. Never =
used
> [    2.237740] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    2.243583] max1363 1-0064: available_scan_mask 11 subset of 6. Never =
used
> [    2.250470] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    2.256313] max1363 1-0064: available_scan_mask 12 subset of 6. Never =
used
> [    2.263198] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.269041] max1363 1-0064: available_scan_mask 13 subset of 6. Never =
used
> [    2.275926] iio-core: ******** mask1[7] is 0x0
> [    2.280379] iio-core: ******** mask2[8] is 0xffff0000000e2720
> [    2.286135] max1363 1-0064: available_scan_mask 8 subset of 7. Never u=
sed
> [    2.292934] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    2.298689] max1363 1-0064: available_scan_mask 9 subset of 7. Never u=
sed
> [    2.305488] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    2.311336] max1363 1-0064: available_scan_mask 10 subset of 7. Never =
used
> [    2.318221] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    2.324065] max1363 1-0064: available_scan_mask 11 subset of 7. Never =
used
> [    2.330949] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    2.336792] max1363 1-0064: available_scan_mask 12 subset of 7. Never =
used
> [    2.343677] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.349520] max1363 1-0064: available_scan_mask 13 subset of 7. Never =
used
> [    2.356406] iio-core: ******** mask1[8] is 0xffff0000000e2720
> [    2.362162] iio-core: ******** mask2[9] is 0xffff0000000e2660
> [    2.367918] max1363 1-0064: available_scan_mask 9 subset of 8. Never u=
sed
> [    2.374716] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    2.380559] max1363 1-0064: available_scan_mask 10 subset of 8. Never =
used
> [    2.387444] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    2.393287] max1363 1-0064: available_scan_mask 11 subset of 8. Never =
used
> [    2.400172] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    2.406015] max1363 1-0064: available_scan_mask 12 subset of 8. Never =
used
> [    2.412901] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.418744] max1363 1-0064: available_scan_mask 13 subset of 8. Never =
used
> [    2.425629] iio-core: ******** mask1[9] is 0xffff0000000e2660
> [    2.431384] iio-core: ******** mask2[10] is 0xffff0000000e25a0
> [    2.437231] max1363 1-0064: available_scan_mask 10 subset of 9. Never =
used
> [    2.444117] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    2.449961] max1363 1-0064: available_scan_mask 11 subset of 9. Never =
used
> [    2.456846] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    2.462689] max1363 1-0064: available_scan_mask 12 subset of 9. Never =
used
> [    2.469575] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.475417] max1363 1-0064: available_scan_mask 13 subset of 9. Never =
used
> [    2.482303] iio-core: ******** mask1[10] is 0xffff0000000e25a0
> [    2.488145] iio-core: ******** mask2[11] is 0xffff0000000e24e0
> [    2.493988] max1363 1-0064: available_scan_mask 11 subset of 10. Never=
 used
> [    2.500957] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    2.506800] max1363 1-0064: available_scan_mask 12 subset of 10. Never=
 used
> [    2.513772] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.519615] max1363 1-0064: available_scan_mask 13 subset of 10. Never=
 used
> [    2.526587] iio-core: ******** mask1[11] is 0xffff0000000e24e0
> [    2.532429] iio-core: ******** mask2[12] is 0xffff0000000e2420
> [    2.538272] max1363 1-0064: available_scan_mask 12 subset of 11. Never=
 used
> [    2.545244] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.551087] max1363 1-0064: available_scan_mask 13 subset of 11. Never=
 used
> [    2.558060] iio-core: ******** mask1[12] is 0xffff0000000e2420
> [    2.563906] iio-core: ******** mask2[13] is 0xffff0000000e2360
> [    2.569747] max1363 1-0064: available_scan_mask 13 subset of 12. Never=
 used
>=20


