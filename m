Return-Path: <linux-iio+bounces-18909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E54AA5296
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C83F3B1BD9
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC7E2609CA;
	Wed, 30 Apr 2025 17:25:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A929D0B;
	Wed, 30 Apr 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033945; cv=none; b=LfYoXi4EMxxvXF7pwFKft4G6mla33Kbny7k7urjNBpuZq5sVOOFzxNrqWNFkwiKbcz7gCkCjMzlAMJPy0PAnix985p9sszXYw+aGvjg2e4O+Dr/P+lx3KOffIdryshFefJFBtVqUEU+DJVO6wBfb+s8RfsHRqyyHo5CqhsRFjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033945; c=relaxed/simple;
	bh=MHw2nyvu/92HEkVu/sEOjU8AoIq06UF+djrCQVrhmeo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxaowdVQfiRKR+j37SLl1jf8Xlv5tqgZ5PjsAFmaIr/EFMgZy/2M9PjnktizG3PBUVdJuNRC0VxlcbkouRNuSJCSsmII2b6JGbpVTNALflWhuX71pMXOb8f4AeZdQ2olu8xY8rM1C5erf4LrXTlX9txPbCVnm+tM2QUsUiYA/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZnkVk6pjvz6M4dG;
	Thu,  1 May 2025 01:21:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 44F6714027A;
	Thu,  1 May 2025 01:25:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Apr
 2025 19:25:38 +0200
Date: Wed, 30 Apr 2025 18:25:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <mazziesaccount@gmail.com>,
	<linux-iio@vger.kernel.org>, Fabio Estevam <festevam@denx.de>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
Message-ID: <20250430182537.00007eab@huawei.com>
In-Reply-To: <CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
	<20250429183301.326eaacf@jic23-huawei>
	<CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
	<CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
	<20250430141112.00004bb8@huawei.com>
	<CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
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

On Wed, 30 Apr 2025 10:26:12 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Wed, Apr 30, 2025 at 10:11=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>=20
> > As below. Should be mask1[0] as we've already indexed the array with
> > the above calculation. =20
>=20
> Thanks for catching that bug.
>=20
> Now I get:
>=20
> [    1.556734] iio-core: ******** masklength is 9
> [    1.559663] iio-core: ******** longs_per_mask is 1
> [    1.564119] iio-core: ******** mask1[0] is 0x1
> [    1.573367] iio-core: ******** mask2[0] is 0x2
> [    1.577822] iio-core: ******** mask2[0] is 0x4
> [    1.582279] iio-core: ******** mask2[0] is 0x8
> [    1.586738] iio-core: ******** mask2[0] is 0x3
> [    1.591198] iio-core: ******** mask2[0] is 0x7
> [    1.595654] iio-core: ******** mask2[0] is 0xf
> [    1.600110] iio-core: ******** mask2[0] is 0xc
> [    1.604560] iio-core: ******** mask2[0] is 0x1000
> [    1.609278] max1363 1-0064: available_scan_mask 8 subset of 0. Never u=
sed
> [    1.616084] iio-core: ******** mask2[0] is 0x2000
> [    1.620799] max1363 1-0064: available_scan_mask 9 subset of 0. Never u=
sed
> [    1.627602] iio-core: ******** mask2[0] is 0x40000
> [    1.632408] max1363 1-0064: available_scan_mask 10 subset of 0. Never =
used
> [    1.639303] iio-core: ******** mask2[0] is 0x80000
> [    1.644105] max1363 1-0064: available_scan_mask 11 subset of 0. Never =
used
> [    1.650995] iio-core: ******** mask2[0] is 0x3000
> [    1.655713] max1363 1-0064: available_scan_mask 12 subset of 0. Never =
used
> [    1.662606] iio-core: ******** mask2[0] is 0xc0000
> [    1.667412] max1363 1-0064: available_scan_mask 13 subset of 0. Never =
used
> [    1.674309] iio-core: ******** mask1[1] is 0x2
> [    1.678761] iio-core: ******** mask2[1] is 0x4
> [    1.683212] iio-core: ******** mask2[1] is 0x8
> [    1.687666] iio-core: ******** mask2[1] is 0x3
> [    1.692118] iio-core: ******** mask2[1] is 0x7
> [    1.696576] iio-core: ******** mask2[1] is 0xf
> [    1.701029] iio-core: ******** mask2[1] is 0xc
> [    1.705483] iio-core: ******** mask2[1] is 0x1000
> [    1.710199] max1363 1-0064: available_scan_mask 8 subset of 1. Never u=
sed
> [    1.716996] iio-core: ******** mask2[1] is 0x2000
> [    1.721711] max1363 1-0064: available_scan_mask 9 subset of 1. Never u=
sed
> [    1.728510] iio-core: ******** mask2[1] is 0x40000
> [    1.733317] max1363 1-0064: available_scan_mask 10 subset of 1. Never =
used
> [    1.740212] iio-core: ******** mask2[1] is 0x80000
> [    1.745013] max1363 1-0064: available_scan_mask 11 subset of 1. Never =
used
> [    1.751899] iio-core: ******** mask2[1] is 0x3000
> [    1.756612] max1363 1-0064: available_scan_mask 12 subset of 1. Never =
used
> [    1.763503] iio-core: ******** mask2[1] is 0xc0000
> [    1.768306] max1363 1-0064: available_scan_mask 13 subset of 1. Never =
used
> [    1.775193] iio-core: ******** mask1[2] is 0x4
> [    1.779650] iio-core: ******** mask2[2] is 0x8
> [    1.784117] iio-core: ******** mask2[2] is 0x3
> [    1.788570] iio-core: ******** mask2[2] is 0x7
> [    1.793023] iio-core: ******** mask2[2] is 0xf
> [    1.797476] iio-core: ******** mask2[2] is 0xc
> [    1.801934] iio-core: ******** mask2[2] is 0x1000
> [    1.806650] max1363 1-0064: available_scan_mask 8 subset of 2. Never u=
sed
> [    1.813447] iio-core: ******** mask2[2] is 0x2000
> [    1.818162] max1363 1-0064: available_scan_mask 9 subset of 2. Never u=
sed
> [    1.824961] iio-core: ******** mask2[2] is 0x40000
> [    1.829764] max1363 1-0064: available_scan_mask 10 subset of 2. Never =
used
> [    1.836649] iio-core: ******** mask2[2] is 0x80000
> [    1.841450] max1363 1-0064: available_scan_mask 11 subset of 2. Never =
used
> [    1.848336] iio-core: ******** mask2[2] is 0x3000
> [    1.853049] max1363 1-0064: available_scan_mask 12 subset of 2. Never =
used
> [    1.859934] iio-core: ******** mask2[2] is 0xc0000
> [    1.864740] max1363 1-0064: available_scan_mask 13 subset of 2. Never =
used
> [    1.871626] iio-core: ******** mask1[3] is 0x8
> [    1.876079] iio-core: ******** mask2[3] is 0x3
> [    1.880533] iio-core: ******** mask2[3] is 0x7
> [    1.884985] iio-core: ******** mask2[3] is 0xf
> [    1.889439] iio-core: ******** mask2[3] is 0xc
> [    1.893891] iio-core: ******** mask2[3] is 0x1000
> [    1.898605] max1363 1-0064: available_scan_mask 8 subset of 3. Never u=
sed
> [    1.905403] iio-core: ******** mask2[3] is 0x2000
> [    1.910122] max1363 1-0064: available_scan_mask 9 subset of 3. Never u=
sed
> [    1.916921] iio-core: ******** mask2[3] is 0x40000
> [    1.921724] max1363 1-0064: available_scan_mask 10 subset of 3. Never =
used
> [    1.928610] iio-core: ******** mask2[3] is 0x80000
> [    1.933413] max1363 1-0064: available_scan_mask 11 subset of 3. Never =
used
> [    1.940297] iio-core: ******** mask2[3] is 0x3000
> [    1.945012] max1363 1-0064: available_scan_mask 12 subset of 3. Never =
used
> [    1.951897] iio-core: ******** mask2[3] is 0xc0000
> [    1.956698] max1363 1-0064: available_scan_mask 13 subset of 3. Never =
used
> [    1.963584] iio-core: ******** mask1[4] is 0x3
> [    1.968037] iio-core: ******** mask2[4] is 0x7
> [    1.972489] iio-core: ******** mask2[4] is 0xf
> [    1.976942] iio-core: ******** mask2[4] is 0xc
> [    1.981394] iio-core: ******** mask2[4] is 0x1000
> [    1.986113] max1363 1-0064: available_scan_mask 8 subset of 4. Never u=
sed
> [    1.992915] iio-core: ******** mask2[4] is 0x2000
> [    1.997626] max1363 1-0064: available_scan_mask 9 subset of 4. Never u=
sed
> [    2.004429] iio-core: ******** mask2[4] is 0x40000
> [    2.009230] max1363 1-0064: available_scan_mask 10 subset of 4. Never =
used
> [    2.016120] iio-core: ******** mask2[4] is 0x80000
> [    2.020922] max1363 1-0064: available_scan_mask 11 subset of 4. Never =
used
> [    2.027807] iio-core: ******** mask2[4] is 0x3000
> [    2.032522] max1363 1-0064: available_scan_mask 12 subset of 4. Never =
used
> [    2.039408] iio-core: ******** mask2[4] is 0xc0000
> [    2.044210] max1363 1-0064: available_scan_mask 13 subset of 4. Never =
used
> [    2.051095] iio-core: ******** mask1[5] is 0x7
> [    2.055548] iio-core: ******** mask2[5] is 0xf
> [    2.060000] iio-core: ******** mask2[5] is 0xc
> [    2.064453] iio-core: ******** mask2[5] is 0x1000
> [    2.069167] max1363 1-0064: available_scan_mask 8 subset of 5. Never u=
sed
> [    2.075966] iio-core: ******** mask2[5] is 0x2000
> [    2.080680] max1363 1-0064: available_scan_mask 9 subset of 5. Never u=
sed
> [    2.087478] iio-core: ******** mask2[5] is 0x40000
> [    2.092280] max1363 1-0064: available_scan_mask 10 subset of 5. Never =
used
> [    2.099166] iio-core: ******** mask2[5] is 0x80000
> [    2.103967] max1363 1-0064: available_scan_mask 11 subset of 5. Never =
used
> [    2.110858] iio-core: ******** mask2[5] is 0x3000
> [    2.115573] max1363 1-0064: available_scan_mask 12 subset of 5. Never =
used
> [    2.122463] iio-core: ******** mask2[5] is 0xc0000
> [    2.127265] max1363 1-0064: available_scan_mask 13 subset of 5. Never =
used
> [    2.134150] iio-core: ******** mask1[6] is 0xf
> [    2.138602] iio-core: ******** mask2[6] is 0xc
> [    2.143056] max1363 1-0064: available_scan_mask 7 subset of 6. Never u=
sed
> [    2.149862] iio-core: ******** mask2[6] is 0x1000
> [    2.154578] max1363 1-0064: available_scan_mask 8 subset of 6. Never u=
sed
> [    2.161374] iio-core: ******** mask2[6] is 0x2000
> [    2.166089] max1363 1-0064: available_scan_mask 9 subset of 6. Never u=
sed
> [    2.172886] iio-core: ******** mask2[6] is 0x40000
> [    2.177687] max1363 1-0064: available_scan_mask 10 subset of 6. Never =
used
> [    2.184573] iio-core: ******** mask2[6] is 0x80000
> [    2.189372] max1363 1-0064: available_scan_mask 11 subset of 6. Never =
used
> [    2.196257] iio-core: ******** mask2[6] is 0x3000
> [    2.200973] max1363 1-0064: available_scan_mask 12 subset of 6. Never =
used
> [    2.207858] iio-core: ******** mask2[6] is 0xc0000
> [    2.212659] max1363 1-0064: available_scan_mask 13 subset of 6. Never =
used
> [    2.219544] iio-core: ******** mask1[7] is 0xc
> [    2.223996] iio-core: ******** mask2[7] is 0x1000
> [    2.228715] max1363 1-0064: available_scan_mask 8 subset of 7. Never u=
sed
> [    2.235518] iio-core: ******** mask2[7] is 0x2000
> [    2.240234] max1363 1-0064: available_scan_mask 9 subset of 7. Never u=
sed
> [    2.247030] iio-core: ******** mask2[7] is 0x40000
> [    2.251832] max1363 1-0064: available_scan_mask 10 subset of 7. Never =
used
> [    2.258717] iio-core: ******** mask2[7] is 0x80000
> [    2.263518] max1363 1-0064: available_scan_mask 11 subset of 7. Never =
used
> [    2.270403] iio-core: ******** mask2[7] is 0x3000
> [    2.275117] max1363 1-0064: available_scan_mask 12 subset of 7. Never =
used
> [    2.282002] iio-core: ******** mask2[7] is 0xc0000
> [    2.286803] max1363 1-0064: available_scan_mask 13 subset of 7. Never =
used
> [    2.293688] iio-core: ******** mask1[8] is 0x1000
> [    2.298401] iio-core: ******** mask2[8] is 0x2000
> [    2.303116] max1363 1-0064: available_scan_mask 9 subset of 8. Never u=
sed
> [    2.309914] iio-core: ******** mask2[8] is 0x40000
> [    2.314715] max1363 1-0064: available_scan_mask 10 subset of 8. Never =
used
> [    2.321600] iio-core: ******** mask2[8] is 0x80000
> [    2.326401] max1363 1-0064: available_scan_mask 11 subset of 8. Never =
used
> [    2.333289] iio-core: ******** mask2[8] is 0x3000
> [    2.338004] max1363 1-0064: available_scan_mask 12 subset of 8. Never =
used
> [    2.344889] iio-core: ******** mask2[8] is 0xc0000
> [    2.349691] max1363 1-0064: available_scan_mask 13 subset of 8. Never =
used
> [    2.356577] iio-core: ******** mask1[9] is 0x2000
> [    2.361294] iio-core: ******** mask2[9] is 0x40000
> [    2.366094] max1363 1-0064: available_scan_mask 10 subset of 9. Never =
used
> [    2.372977] iio-core: ******** mask2[9] is 0x80000
> [    2.377778] max1363 1-0064: available_scan_mask 11 subset of 9. Never =
used
> [    2.384663] iio-core: ******** mask2[9] is 0x3000
> [    2.389377] max1363 1-0064: available_scan_mask 12 subset of 9. Never =
used
> [    2.396262] iio-core: ******** mask2[9] is 0xc0000
> [    2.401063] max1363 1-0064: available_scan_mask 13 subset of 9. Never =
used
> [    2.407948] iio-core: ******** mask1[10] is 0x40000
> [    2.412835] iio-core: ******** mask2[10] is 0x80000
> [    2.417723] max1363 1-0064: available_scan_mask 11 subset of 10. Never=
 used
> [    2.424696] iio-core: ******** mask2[10] is 0x3000
> [    2.429497] max1363 1-0064: available_scan_mask 12 subset of 10. Never=
 used
> [    2.436471] iio-core: ******** mask2[10] is 0xc0000
> [    2.441359] max1363 1-0064: available_scan_mask 13 subset of 10. Never=
 used
> [    2.448331] iio-core: ******** mask1[11] is 0x80000
> [    2.453218] iio-core: ******** mask2[11] is 0x3000
> [    2.458020] max1363 1-0064: available_scan_mask 12 subset of 11. Never=
 used
> [    2.464991] iio-core: ******** mask2[11] is 0xc0000
> [    2.469879] max1363 1-0064: available_scan_mask 13 subset of 11. Never=
 used
> [    2.476860] iio-core: ******** mask1[12] is 0x3000
> [    2.481659] iio-core: ******** mask2[12] is 0xc0000
> [    2.486551] max1363 1-0064: available_scan_mask 13 subset of 12. Never=
 used
>=20
> Who sets masklength =3D 9? Is this correct?

It should be set to the maximum scan index seen for any channels (+1 for so=
me reason
I can't remember) and hence the maximum bitmap bit that should ever be set.=
=20
That's something like 19 in this case not 9...=20

Hmm. These masks seem to be garbage because the driver is packing the scan =
indexes
not using the same ones for all channel combinations as those masks assume.

So wherever MAX1363_CHAN_U is called should assume the single channels=20
start at index 0 and the differential channels at 12.  For instance:

#define MAX1363_4X_CHANS(bits, ev_spec, num_ev_spec) {			\
	MAX1363_CHAN_U(0, _s0, 0, bits, ev_spec, num_ev_spec),		\
	MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),		\
	MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),		\
	MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),		\
	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),	\
	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),	\
	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),	\
	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),	\
	IIO_CHAN_SOFT_TIMESTAMP(8)					\
	}

Should be:
#define MAX1363_4X_CHANS(bits, ev_spec, num_ev_spec) {			\
	MAX1363_CHAN_U(0, _s0, 0, bits, ev_spec, num_ev_spec),		\
	MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),		\
	MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),		\
	MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),		\
	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),	\
	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),	\
	MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),	\
	MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),	\
	IIO_CHAN_SOFT_TIMESTAMP(8)					\
	}

https://elixir.bootlin.com/linux/v6.14.4/source/drivers/iio/industrialio-bu=
ffer.c#L2272

The reason userspace never notices this is that the channel indices are tre=
ated
as monotonic so the mismatch between 4 and 12 is irrelevant because there
are no channels on scan index 5,6,7,8,9,10,11 in this example.

Took me a while to figure out why basic tests wouldn't fail!

So the full fix is reorder the scan indices to fix the basic problem + fix
the scan index values in all those channel arrays to use the right mask bit=
s.

Thanks for chasing this down!

Jonathan

>=20
> If I use BITS_PER_LONG instead of masklength inside bitmap_subset():
>=20
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1947,16 +1947,22 @@ static void
> iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
>          * available masks in the order of preference (presumably the lea=
st
>          * costy to access masks first).
>          */
> +       pr_err("******** masklength is %d", masklength);
> +       pr_err("******** longs_per_mask is %d", longs_per_mask);
> +
> +
>         for (i =3D 0; i < num_masks - 1; i++) {
>                 const unsigned long *mask1;
>                 int j;
>=20
>                 mask1 =3D av_masks + i * longs_per_mask;
> +               pr_err("******** mask1[%d] is 0x%lx\n", i, mask1[0]);
>                 for (j =3D i + 1; j < num_masks; j++) {
>                         const unsigned long *mask2;
>=20
>                         mask2 =3D av_masks + j * longs_per_mask;
> -                       if (bitmap_subset(mask2, mask1, masklength))
> +                       pr_err("******** mask2[%d] is 0x%lx\n", i, mask2[=
0]);
> +                       if (bitmap_subset(mask2, mask1, BITS_PER_LONG))
>                                 dev_warn(indio_dev->dev.parent,
>                                          "available_scan_mask %d
> subset of %d. Never used\n",
>                                          j, i);
>=20
> Then the correct subset information is printed:
>=20
> [    1.560392] iio-core: ******** masklength is 9
> [    1.560406] iio-core: ******** longs_per_mask is 1
> [    1.564890] iio-core: ******** mask1[0] is 0x1
> [    1.574185] iio-core: ******** mask2[0] is 0x2
> [    1.578644] iio-core: ******** mask2[0] is 0x4
> [    1.583108] iio-core: ******** mask2[0] is 0x8
> [    1.587564] iio-core: ******** mask2[0] is 0x3
> [    1.592024] iio-core: ******** mask2[0] is 0x7
> [    1.596486] iio-core: ******** mask2[0] is 0xf
> [    1.600948] iio-core: ******** mask2[0] is 0xc
> [    1.605407] iio-core: ******** mask2[0] is 0x1000
> [    1.610130] iio-core: ******** mask2[0] is 0x2000
> [    1.614856] iio-core: ******** mask2[0] is 0x40000
> [    1.619670] iio-core: ******** mask2[0] is 0x80000
> [    1.624475] iio-core: ******** mask2[0] is 0x3000
> [    1.629199] iio-core: ******** mask2[0] is 0xc0000
> [    1.634017] iio-core: ******** mask1[1] is 0x2
> [    1.638475] iio-core: ******** mask2[1] is 0x4
> [    1.642941] iio-core: ******** mask2[1] is 0x8
> [    1.647401] iio-core: ******** mask2[1] is 0x3
> [    1.651865] iio-core: ******** mask2[1] is 0x7
> [    1.656321] iio-core: ******** mask2[1] is 0xf
> [    1.660786] iio-core: ******** mask2[1] is 0xc
> [    1.665245] iio-core: ******** mask2[1] is 0x1000
> [    1.669968] iio-core: ******** mask2[1] is 0x2000
> [    1.674691] iio-core: ******** mask2[1] is 0x40000
> [    1.679505] iio-core: ******** mask2[1] is 0x80000
> [    1.684345] iio-core: ******** mask2[1] is 0x3000
> [    1.689069] iio-core: ******** mask2[1] is 0xc0000
> [    1.693872] iio-core: ******** mask1[2] is 0x4
> [    1.698331] iio-core: ******** mask2[2] is 0x8
> [    1.702788] iio-core: ******** mask2[2] is 0x3
> [    1.707246] iio-core: ******** mask2[2] is 0x7
> [    1.711702] iio-core: ******** mask2[2] is 0xf
> [    1.716156] iio-core: ******** mask2[2] is 0xc
> [    1.720614] iio-core: ******** mask2[2] is 0x1000
> [    1.725333] iio-core: ******** mask2[2] is 0x2000
> [    1.730046] iio-core: ******** mask2[2] is 0x40000
> [    1.734850] iio-core: ******** mask2[2] is 0x80000
> [    1.739665] iio-core: ******** mask2[2] is 0x3000
> [    1.744385] iio-core: ******** mask2[2] is 0xc0000
> [    1.749192] iio-core: ******** mask1[3] is 0x8
> [    1.753654] iio-core: ******** mask2[3] is 0x3
> [    1.758112] iio-core: ******** mask2[3] is 0x7
> [    1.762570] iio-core: ******** mask2[3] is 0xf
> [    1.767027] iio-core: ******** mask2[3] is 0xc
> [    1.771484] iio-core: ******** mask2[3] is 0x1000
> [    1.776203] iio-core: ******** mask2[3] is 0x2000
> [    1.780921] iio-core: ******** mask2[3] is 0x40000
> [    1.785727] iio-core: ******** mask2[3] is 0x80000
> [    1.790531] iio-core: ******** mask2[3] is 0x3000
> [    1.795253] iio-core: ******** mask2[3] is 0xc0000
> [    1.800059] iio-core: ******** mask1[4] is 0x3
> [    1.804515] iio-core: ******** mask2[4] is 0x7
> [    1.808970] iio-core: ******** mask2[4] is 0xf
> [    1.813427] iio-core: ******** mask2[4] is 0xc
> [    1.817891] iio-core: ******** mask2[4] is 0x1000
> [    1.822608] iio-core: ******** mask2[4] is 0x2000
> [    1.827336] iio-core: ******** mask2[4] is 0x40000
> [    1.832164] iio-core: ******** mask2[4] is 0x80000
> [    1.836970] iio-core: ******** mask2[4] is 0x3000
> [    1.841690] iio-core: ******** mask2[4] is 0xc0000
> [    1.846495] iio-core: ******** mask1[5] is 0x7
> [    1.850953] iio-core: ******** mask2[5] is 0xf
> [    1.855409] iio-core: ******** mask2[5] is 0xc
> [    1.859867] iio-core: ******** mask2[5] is 0x1000
> [    1.864590] iio-core: ******** mask2[5] is 0x2000
> [    1.869310] iio-core: ******** mask2[5] is 0x40000
> [    1.874116] iio-core: ******** mask2[5] is 0x80000
> [    1.878918] iio-core: ******** mask2[5] is 0x3000
> [    1.883636] iio-core: ******** mask2[5] is 0xc0000
> [    1.888442] iio-core: ******** mask1[6] is 0xf
> [    1.892900] iio-core: ******** mask2[6] is 0xc
> [    1.897364] max1363 1-0064: available_scan_mask 7 subset of 6. Never u=
sed
> [    1.904169] iio-core: ******** mask2[6] is 0x1000
> [    1.908887] iio-core: ******** mask2[6] is 0x2000
> [    1.913603] iio-core: ******** mask2[6] is 0x40000
> [    1.918409] iio-core: ******** mask2[6] is 0x80000
> [    1.923212] iio-core: ******** mask2[6] is 0x3000
> [    1.927930] iio-core: ******** mask2[6] is 0xc0000
> [    1.932733] iio-core: ******** mask1[7] is 0xc
> [    1.937190] iio-core: ******** mask2[7] is 0x1000
> [    1.941902] iio-core: ******** mask2[7] is 0x2000
> [    1.941907] iio-core: ******** mask2[7] is 0x40000
> [    1.941911] iio-core: ******** mask2[7] is 0x80000
> [    1.941917] iio-core: ******** mask2[7] is 0x3000
> [    1.965640] iio-core: ******** mask2[7] is 0xc0000
> [    1.970447] iio-core: ******** mask1[8] is 0x1000
> [    1.975163] iio-core: ******** mask2[8] is 0x2000
> [    1.979881] iio-core: ******** mask2[8] is 0x40000
> [    1.984683] iio-core: ******** mask2[8] is 0x80000
> [    1.989491] iio-core: ******** mask2[8] is 0x3000
> [    1.994209] iio-core: ******** mask2[8] is 0xc0000
> [    1.999010] iio-core: ******** mask1[9] is 0x2000
> [    2.003732] iio-core: ******** mask2[9] is 0x40000
> [    2.008533] iio-core: ******** mask2[9] is 0x80000
> [    2.013339] iio-core: ******** mask2[9] is 0x3000
> [    2.018065] iio-core: ******** mask2[9] is 0xc0000
> [    2.022866] iio-core: ******** mask1[10] is 0x40000
> [    2.027760] iio-core: ******** mask2[10] is 0x80000
> [    2.032647] iio-core: ******** mask2[10] is 0x3000
> [    2.037453] iio-core: ******** mask2[10] is 0xc0000
> [    2.042346] iio-core: ******** mask1[11] is 0x80000
> [    2.047234] iio-core: ******** mask2[11] is 0x3000
> [    2.052041] iio-core: ******** mask2[11] is 0xc0000
> [    2.056928] iio-core: ******** mask1[12] is 0x3000
> [    2.061736] iio-core: ******** mask2[12] is 0xc0000


