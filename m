Return-Path: <linux-iio+bounces-18872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E3DAA1B22
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 21:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206FA4A4798
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB5258CE5;
	Tue, 29 Apr 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9NusSys"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76B1E89C;
	Tue, 29 Apr 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953571; cv=none; b=qDeD+dZgFBMiRpxePwfIo/ESkxY0ZfrvA5h9mEpgBEFneTsP+wjpha3aBBJicr18jsRA1qr5k5PEuk1Rer1fZQQvQI1wgC2sTAfc8vtGxcicD3I687OEkYjyKEiqCZ3Br8YMqrpaq3K5HPv6FVJlxgFvNLKtB2+uHEMRRPNNK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953571; c=relaxed/simple;
	bh=s/u13BLU4y78CXP74OtspEiTdxOvWdtDnn+KIfamJuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lzx2+4eZDk4twaoKEf1lkqNLhW7xzcwzru3RdLK8Hkuukvi3QcAn0qal1JF2S18Ru1NOJ46RE4NoAUfi7yudAq3gaj9QFrTe5Kttco1h5P7xa3zlgD6vRbiZV5lSJ6OjRE6KZeHwCCa7l5oc6m3GlMfn3Fs5re46J0Q8m+R2/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9NusSys; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso60961781fa.3;
        Tue, 29 Apr 2025 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745953567; x=1746558367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tB2i8gaNb3Gu37LmvyH5tcnVrRlscMEALsEIAXsINFg=;
        b=F9NusSysbK6V9bmQJ0prZYoecCbGXWulX1QqgtS3eFBzfslmCu8qGpJ/tzLFtQQKO4
         xWeXZMEOeVoIgR7vCFEz7Az2EbRaNxqktnWKSjChXR4bJAdZmaQc3iLIYTM/xyE4dqTZ
         G5vY5SV1hC5Wo4l7TR98rTBaScgO/1J83TVMduQJEGbbX3f1J4vm+kUGhdGuZN7rSkPt
         gyg+Z7yzL1N0/SCOfkaOV5VA3koufWhQL87aijCnVApfiCf9OHDwB72b6wULZDwJZze+
         FriFNVUj+roOcjK++UJ9YZTlZC6kvkgwOzHA5kvNKq1qr7nBsVn4BDnE2P9f95/W50dh
         lPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745953567; x=1746558367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tB2i8gaNb3Gu37LmvyH5tcnVrRlscMEALsEIAXsINFg=;
        b=Adcvlllm9sbZAaaQT220peauRTaZyeI8VZGMSxAUN0BtOgvtz1i7PISa4HxHecfE6e
         /cW//H6pCGPZg8aoqvz1SSlIUw74h7JwUum5bNxXpOIyHe22YsGGUX9NixhGtd/d+gfu
         F/5hJP5B5jmj9IEC1utUkGUK3vII9R7mFDTxGga3HmYkakz44V8cTUfn6PDKbXTLBD4V
         udLVU6g7Hp97et1bI7YETEjeWv0RR8yBTQ58j1Uw7mM+vSTxm/rLlz2aWewDHjbPofOR
         mW3vVu/SXvSFfqlz6wLy0Osl+mCO1AoiRlq6mSWfitfsSmTZ8FmOWmRtuvQnY7uQBG7b
         rYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSJBXTwGtQlu+gQQc5anOHQqi8olf59BeyQaRCp9WEMTa13BEqo/JIgaStqoYjNTo4uNn8vzIVSzY=@vger.kernel.org, AJvYcCUt2k1+sJfnb3GDO5OqYe+NIG1G6JPXrPYJqSphTAj9s71wQwtu4DqaPK+lNHFpeUut9mlcJRbA@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPALFnnfxpiG5sD4MPjx1Inrdtfw4EYLAT1HPi1q5DIiAYZIH
	fjhV0RaY9FQbwjA0MdxV/+7QpMgQMUXEVcgRDIQwpxwHlgCQspuyKf70aizMP7NsKFLTX2AbiBK
	IEw2RQgiwNhXXEEkixX/Y/1gPMvw=
X-Gm-Gg: ASbGnctJ6xdoRliCAw91EBfrdV689ImJQu5vNbbcgjJvTU9VatjiVCog2vqcYXEBcv8
	yRT+WXtrsA8hGoSC/8wUkPxL/Jp8QueyvPJBZW84IrL1cdPM+wA5eVPwsXvi4Q5+CB2oJTwaojM
	V+wsg+nPCoHVzNfusu14frGTEQ6Syt4/ktO6L0rmCNdheBQqM8LkkxMQ==
X-Google-Smtp-Source: AGHT+IGdAznEmYGP9D89sQDQthZBc14RDWdFDpFD09FoMka4rumgI8q8kcRjQKeadqVI+79aqi2nWS/pwcczqBRin1c=
X-Received: by 2002:a05:651c:146d:b0:30d:62c1:3c0a with SMTP id
 38308e7fff4ca-31e6b2c3340mr1198671fa.25.1745953566942; Tue, 29 Apr 2025
 12:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429150213.2953747-1-festevam@gmail.com> <20250429183301.326eaacf@jic23-huawei>
 <CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
In-Reply-To: <CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Apr 2025 16:05:55 -0300
X-Gm-Features: ATxdqUHKpz-mYzgl3I-EdrZxiCx0P7rnpolRfFmZeF4pVJ3mBEMRg901gIIrPfY
Message-ID: <CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
To: Jonathan Cameron <jic23@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 3:33=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> +                       pr_err("******** mask2[%d] is 0x%lx\n", j, mask2[=
i]);

Sorry, this line is wrong.

The correct debug patch is this one:

--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1947,15 +1947,23 @@ static void
iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
         * available masks in the order of preference (presumably the least
         * costy to access masks first).
         */
+
+       pr_err("******** masklength is %d", masklength);
+       pr_err("******** longs_per_mask is %d", longs_per_mask);
+
        for (i =3D 0; i < num_masks - 1; i++) {
                const unsigned long *mask1;
                int j;

                mask1 =3D av_masks + i * longs_per_mask;
+
+               pr_err("******** mask1[%d] is 0x%lx\n", i, mask1[i]);
+
                for (j =3D i + 1; j < num_masks; j++) {
                        const unsigned long *mask2;

                        mask2 =3D av_masks + j * longs_per_mask;
+                       pr_err("******** mask2[%d] is 0x%lx\n", j, mask2[j]=
);
                        if (bitmap_subset(mask2, mask1, masklength))
                                dev_warn(indio_dev->dev.parent,
                                         "available_scan_mask %d
subset of %d. Never used\n",
The original mask array is:

0x1,
0x2,
0x4,
0x8,
0x3,
0x7,
0xf,
0xc,
0x1000,
0x2000,
0x40000,
0x80000,
0x3000,
0xc0000,

So mask2 is jumping by two indexes, instead of one.

mask1 and mask2 arrays are accessing uninitialized data:

[    1.561626] iio-core: ******** masklength is 9
[    1.561639] iio-core: ******** longs_per_mask is 1
[    1.566130] iio-core: ******** mask1[0] is 0x1
[    1.570945] iio-core: ******** mask2[1] is 0x4
[    1.584554] iio-core: ******** mask2[2] is 0x3
[    1.589012] iio-core: ******** mask2[3] is 0xf
[    1.593465] iio-core: ******** mask2[4] is 0x1000
[    1.598183] iio-core: ******** mask2[5] is 0x40000
[    1.602981] iio-core: ******** mask2[6] is 0x3000
[    1.607702] iio-core: ******** mask2[7] is 0x0
[    1.612157] iio-core: ******** mask2[8] is 0xffff0000000e2720
[    1.617925] max1363 1-0064: available_scan_mask 8 subset of 0. Never use=
d
[    1.624723] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    1.630493] max1363 1-0064: available_scan_mask 9 subset of 0. Never use=
d
[    1.637297] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    1.643141] max1363 1-0064: available_scan_mask 10 subset of 0. Never us=
ed
[    1.650032] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    1.655876] max1363 1-0064: available_scan_mask 11 subset of 0. Never us=
ed
[    1.662772] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    1.668614] max1363 1-0064: available_scan_mask 12 subset of 0. Never us=
ed
[    1.675506] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    1.681361] max1363 1-0064: available_scan_mask 13 subset of 0. Never us=
ed
[    1.688257] iio-core: ******** mask1[1] is 0x4
[    1.692725] iio-core: ******** mask2[2] is 0x3
[    1.697185] iio-core: ******** mask2[3] is 0xf
[    1.701642] iio-core: ******** mask2[4] is 0x1000
[    1.706361] iio-core: ******** mask2[5] is 0x40000
[    1.711163] iio-core: ******** mask2[6] is 0x3000
[    1.715880] iio-core: ******** mask2[7] is 0x0
[    1.720335] iio-core: ******** mask2[8] is 0xffff0000000e2720
[    1.726097] max1363 1-0064: available_scan_mask 8 subset of 1. Never use=
d
[    1.732899] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    1.738659] max1363 1-0064: available_scan_mask 9 subset of 1. Never use=
d
[    1.745463] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    1.751307] max1363 1-0064: available_scan_mask 10 subset of 1. Never us=
ed
[    1.758197] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    1.764044] max1363 1-0064: available_scan_mask 11 subset of 1. Never us=
ed
[    1.770933] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    1.776776] max1363 1-0064: available_scan_mask 12 subset of 1. Never us=
ed
[    1.783671] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    1.789521] max1363 1-0064: available_scan_mask 13 subset of 1. Never us=
ed
[    1.796407] iio-core: ******** mask1[2] is 0x3
[    1.800864] iio-core: ******** mask2[3] is 0xf
[    1.805319] iio-core: ******** mask2[4] is 0x1000
[    1.810046] iio-core: ******** mask2[5] is 0x40000
[    1.814848] iio-core: ******** mask2[6] is 0x3000
[    1.819563] iio-core: ******** mask2[7] is 0x0
[    1.824014] iio-core: ******** mask2[8] is 0xffff0000000e2720
[    1.829769] max1363 1-0064: available_scan_mask 8 subset of 2. Never use=
d
[    1.836566] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    1.842322] max1363 1-0064: available_scan_mask 9 subset of 2. Never use=
d
[    1.849149] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    1.854994] max1363 1-0064: available_scan_mask 10 subset of 2. Never us=
ed
[    1.861880] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    1.867723] max1363 1-0064: available_scan_mask 11 subset of 2. Never us=
ed
[    1.874608] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    1.880452] max1363 1-0064: available_scan_mask 12 subset of 2. Never us=
ed
[    1.887339] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    1.893182] max1363 1-0064: available_scan_mask 13 subset of 2. Never us=
ed
[    1.900068] iio-core: ******** mask1[3] is 0xf
[    1.904520] iio-core: ******** mask2[4] is 0x1000
[    1.909232] iio-core: ******** mask2[5] is 0x40000
[    1.914033] iio-core: ******** mask2[6] is 0x3000
[    1.918746] iio-core: ******** mask2[7] is 0x0
[    1.923200] iio-core: ******** mask2[8] is 0xffff0000000e2720
[    1.928956] max1363 1-0064: available_scan_mask 8 subset of 3. Never use=
d
[    1.935759] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    1.941517] max1363 1-0064: available_scan_mask 9 subset of 3. Never use=
d
[    1.948315] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    1.954156] max1363 1-0064: available_scan_mask 10 subset of 3. Never us=
ed
[    1.961042] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    1.966885] max1363 1-0064: available_scan_mask 11 subset of 3. Never us=
ed
[    1.973771] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    1.979614] max1363 1-0064: available_scan_mask 12 subset of 3. Never us=
ed
[    1.986499] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    1.992343] max1363 1-0064: available_scan_mask 13 subset of 3. Never us=
ed
[    1.999226] iio-core: ******** mask1[4] is 0x1000
[    2.003943] iio-core: ******** mask2[5] is 0x40000
[    2.008743] iio-core: ******** mask2[6] is 0x3000
[    2.013457] iio-core: ******** mask2[7] is 0x0
[    2.017910] iio-core: ******** mask2[8] is 0xffff0000000e2720
[    2.023666] max1363 1-0064: available_scan_mask 8 subset of 4. Never use=
d
[    2.030464] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    2.036220] max1363 1-0064: available_scan_mask 9 subset of 4. Never use=
d
[    2.043019] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    2.048863] max1363 1-0064: available_scan_mask 10 subset of 4. Never us=
ed
[    2.055748] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    2.061596] max1363 1-0064: available_scan_mask 11 subset of 4. Never us=
ed
[    2.068482] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    2.074326] max1363 1-0064: available_scan_mask 12 subset of 4. Never us=
ed
[    2.081212] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.087055] max1363 1-0064: available_scan_mask 13 subset of 4. Never us=
ed
[    2.093938] iio-core: ******** mask1[5] is 0x40000
[    2.098739] iio-core: ******** mask2[6] is 0x3000
[    2.103452] iio-core: ******** mask2[7] is 0x0
[    2.107905] iio-core: ******** mask2[8] is 0xffff0000000e2720
[    2.113661] max1363 1-0064: available_scan_mask 8 subset of 5. Never use=
d
[    2.120459] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    2.126215] max1363 1-0064: available_scan_mask 9 subset of 5. Never use=
d
[    2.133013] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    2.138857] max1363 1-0064: available_scan_mask 10 subset of 5. Never us=
ed
[    2.145750] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    2.151595] max1363 1-0064: available_scan_mask 11 subset of 5. Never us=
ed
[    2.158480] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    2.164323] max1363 1-0064: available_scan_mask 12 subset of 5. Never us=
ed
[    2.171208] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.177051] max1363 1-0064: available_scan_mask 13 subset of 5. Never us=
ed
[    2.183936] iio-core: ******** mask1[6] is 0x3000
[    2.188654] iio-core: ******** mask2[7] is 0x0
[    2.193106] max1363 1-0064: available_scan_mask 7 subset of 6. Never use=
d
[    2.199904] iio-core: ******** mask2[8] is 0xffff0000000e2720
[    2.205660] max1363 1-0064: available_scan_mask 8 subset of 6. Never use=
d
[    2.212458] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    2.218215] max1363 1-0064: available_scan_mask 9 subset of 6. Never use=
d
[    2.225012] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    2.230855] max1363 1-0064: available_scan_mask 10 subset of 6. Never us=
ed
[    2.237740] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    2.243583] max1363 1-0064: available_scan_mask 11 subset of 6. Never us=
ed
[    2.250470] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    2.256313] max1363 1-0064: available_scan_mask 12 subset of 6. Never us=
ed
[    2.263198] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.269041] max1363 1-0064: available_scan_mask 13 subset of 6. Never us=
ed
[    2.275926] iio-core: ******** mask1[7] is 0x0
[    2.280379] iio-core: ******** mask2[8] is 0xffff0000000e2720
[    2.286135] max1363 1-0064: available_scan_mask 8 subset of 7. Never use=
d
[    2.292934] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    2.298689] max1363 1-0064: available_scan_mask 9 subset of 7. Never use=
d
[    2.305488] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    2.311336] max1363 1-0064: available_scan_mask 10 subset of 7. Never us=
ed
[    2.318221] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    2.324065] max1363 1-0064: available_scan_mask 11 subset of 7. Never us=
ed
[    2.330949] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    2.336792] max1363 1-0064: available_scan_mask 12 subset of 7. Never us=
ed
[    2.343677] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.349520] max1363 1-0064: available_scan_mask 13 subset of 7. Never us=
ed
[    2.356406] iio-core: ******** mask1[8] is 0xffff0000000e2720
[    2.362162] iio-core: ******** mask2[9] is 0xffff0000000e2660
[    2.367918] max1363 1-0064: available_scan_mask 9 subset of 8. Never use=
d
[    2.374716] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    2.380559] max1363 1-0064: available_scan_mask 10 subset of 8. Never us=
ed
[    2.387444] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    2.393287] max1363 1-0064: available_scan_mask 11 subset of 8. Never us=
ed
[    2.400172] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    2.406015] max1363 1-0064: available_scan_mask 12 subset of 8. Never us=
ed
[    2.412901] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.418744] max1363 1-0064: available_scan_mask 13 subset of 8. Never us=
ed
[    2.425629] iio-core: ******** mask1[9] is 0xffff0000000e2660
[    2.431384] iio-core: ******** mask2[10] is 0xffff0000000e25a0
[    2.437231] max1363 1-0064: available_scan_mask 10 subset of 9. Never us=
ed
[    2.444117] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    2.449961] max1363 1-0064: available_scan_mask 11 subset of 9. Never us=
ed
[    2.456846] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    2.462689] max1363 1-0064: available_scan_mask 12 subset of 9. Never us=
ed
[    2.469575] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.475417] max1363 1-0064: available_scan_mask 13 subset of 9. Never us=
ed
[    2.482303] iio-core: ******** mask1[10] is 0xffff0000000e25a0
[    2.488145] iio-core: ******** mask2[11] is 0xffff0000000e24e0
[    2.493988] max1363 1-0064: available_scan_mask 11 subset of 10. Never u=
sed
[    2.500957] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    2.506800] max1363 1-0064: available_scan_mask 12 subset of 10. Never u=
sed
[    2.513772] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.519615] max1363 1-0064: available_scan_mask 13 subset of 10. Never u=
sed
[    2.526587] iio-core: ******** mask1[11] is 0xffff0000000e24e0
[    2.532429] iio-core: ******** mask2[12] is 0xffff0000000e2420
[    2.538272] max1363 1-0064: available_scan_mask 12 subset of 11. Never u=
sed
[    2.545244] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.551087] max1363 1-0064: available_scan_mask 13 subset of 11. Never u=
sed
[    2.558060] iio-core: ******** mask1[12] is 0xffff0000000e2420
[    2.563906] iio-core: ******** mask2[13] is 0xffff0000000e2360
[    2.569747] max1363 1-0064: available_scan_mask 13 subset of 12. Never u=
sed

