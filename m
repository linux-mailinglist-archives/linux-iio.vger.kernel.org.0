Return-Path: <linux-iio+bounces-18870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52075AA1AB6
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 20:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD0D17119C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC95253329;
	Tue, 29 Apr 2025 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuqPN/hW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D02367;
	Tue, 29 Apr 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951635; cv=none; b=XQ74Y7mD1TYUfce61nV/05F4pP21z6uoPi0Dc7Q8oIDNQVkxFXr3yz9rbCTiOTnMLMKn7nfn5AmFjLB1U+rNMoCU6yxDY9ai92DSwTpkKxce6S2dvIWtgpwIXDtM4eSlMZ0CMKt9iKt6yyFibxwJcKkcqBTFS3kui3BUaxlJEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951635; c=relaxed/simple;
	bh=hwNyKrd0IQpsJxBON5UhyjzSYJdTdLmRA5jCqUE9m+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gez4/xQuWgfftd+mLnPiYJLcKrUznXNIQb7jDCGPhVEWkrF9cTAR3FuPpHL4Na9hVvzPNJI9X55xkzb+TeAdFwuD79JaA1Q5FmmKusuiht8V7e/H3mO14euCz1yBszXB6PqpOy0cTxv6egeKLJ/W7kyccR/21aKvuRX8Gv8xxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuqPN/hW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549967c72bcso7112420e87.3;
        Tue, 29 Apr 2025 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745951632; x=1746556432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4ZxlSSn4BOp3IVK5EC/nRaC9IIqCfUJt5sSCZ2g+0s=;
        b=CuqPN/hWaLyrQidrFO+UOob5qRvH3gctY+sA+MgpHkdY3ozSyDQa7nrcX0XMIn5O/x
         jjDUFwGofSLEb6GJNUUPmpR5Tmrt05NrgC/eMDPFVwDlWRp3dhJL7h6FPFxw30EbjxPl
         49lt85+vust1rFDTON/I+/UD8eTApdLJVu5FBRLWDSseT/V/EKQdi4Q0BXro0VAK5G6P
         xUKM8D4ACf3uaFOC40bOaVE/TmnWrPc4G3ddO/9pxPhydgec+b1KxKm4OgLYO6/LcKFr
         hXyRRPjbe9OcXLpHHlH+IC8M3wiP0swtIe9jOx0h95XpiqiFN9JNNQBXK0EuBLF/DWHR
         BKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745951632; x=1746556432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ZxlSSn4BOp3IVK5EC/nRaC9IIqCfUJt5sSCZ2g+0s=;
        b=HnBCFZpzq/UDwNE8WQIAZJOWgJ8dOuARK7X8GaPK3g8zvVBH6R5O14YfR1ogsBYlOE
         VnWlSXE1Xmdix7vIZ52GtRlAgFBYgTsQUDkhd2KgxBYCBgJwz75h7bzzCgTmJDoXVCwk
         CqKKsfB7E4sZaB6rpf8qDU7mFUNIwnD4ncD9y6dqFa1cs9Szukiqg8LRZTxMWg9NkyG3
         NgmyUg+lMvYK75zvt6m3x6J12VEd+/T50DDKrFzOLr01737ly0Jx4iItITf8erFBsC33
         AzJYC7wYU8moyiQXbvP9UlaiDlm9uQ/KAEJ0lP3opDtm1oKCzTkCTAY/CSQ+wtT2R33t
         pSmw==
X-Forwarded-Encrypted: i=1; AJvYcCV22Lq1OB02FCD7ekvko62n+6b1gAzOp9n3owFdzI0DOeZvAJHh2csJMi20AESfByJ8i8rAZRth@vger.kernel.org, AJvYcCXv27kU3+FbEUCYa8nmGIiGC/Cw1WqodGUiwU78p97778VZA6I9WvT8qR3B2/3085URtJeFQQxP4K8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XJmI1cxrZKQqNXG9UIim4K6x2sM6Dseg59P943k8irxAzIZ4
	VmLx+KoJNXw7raITDEu2t8RzQADPPVxaazAvS8JnEytpWM0jP/SFes1VS31x8ES+B0xnH3WhWgh
	nLT4EmiwAI84R6gW1i3L2/LuCZLg=
X-Gm-Gg: ASbGncvIik+VmdU1C4pWuqxID/5fIDLtM9+C2NaHFlqHo6BU//jsXf+0bGo8j/9yQiA
	hp2Dl7sis8nVPELbUYVVnKL7r9FrAt+Y5Njqm7tzdzE0cffHFFN9NevtfF0U8u87dMT8bTu8H/y
	OItyJkjKZH9JDVkAF7CqP5S+IEZlW5TwlYpWyEGcOl2MT0k7ylkLa1tw==
X-Google-Smtp-Source: AGHT+IH5vtuumTNGaaO3ZvqNkla0WJ6wGonrjxeawbK2sQaRZecJ5S6+V05C6taRQ+a2MjRgu2UeXDQqCeMWbyICdng=
X-Received: by 2002:a05:6512:3e0a:b0:549:8fc0:bc2b with SMTP id
 2adb3069b0e04-54ea33ab66bmr45594e87.39.1745951631158; Tue, 29 Apr 2025
 11:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429150213.2953747-1-festevam@gmail.com> <20250429183301.326eaacf@jic23-huawei>
In-Reply-To: <20250429183301.326eaacf@jic23-huawei>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Apr 2025 15:33:39 -0300
X-Gm-Features: ATxdqUHpNOezKYzASWhUsZc3_TAUmvb27X3kof2w0chSXD3Gv-vCtK2WAIDe6g4
Message-ID: <CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
To: Jonathan Cameron <jic23@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Tue, Apr 29, 2025 at 2:33=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> Why move away from the bitmap_subset() call?

I added the following debug patch on top of the original code:

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
+                       pr_err("******** mask2[%d] is 0x%lx\n", j, mask2[i]=
);
                        if (bitmap_subset(mask2, mask1, masklength))
                                dev_warn(indio_dev->dev.parent,
                                         "available_scan_mask %d
subset of %d. Never used\n",

and saw that the current logic for determining when an element is a
subset of a previous one is not working correctly:

[    1.562321] iio-core: ******** masklength is 9
[    1.562334] iio-core: ******** longs_per_mask is 1
[    1.566855] iio-core: ******** mask1[0] is 0x1
[    1.576121] iio-core: ******** mask2[1] is 0x2
[    1.580577] iio-core: ******** mask2[2] is 0x4
[    1.585029] iio-core: ******** mask2[3] is 0x8
[    1.589482] iio-core: ******** mask2[4] is 0x3
[    1.593936] iio-core: ******** mask2[5] is 0x7
[    1.598389] iio-core: ******** mask2[6] is 0xf
[    1.602840] iio-core: ******** mask2[7] is 0xc
[    1.607294] iio-core: ******** mask2[8] is 0x1000
[    1.612013] max1363 1-0064: available_scan_mask 8 subset of 0. Never use=
d
[    1.618814] iio-core: ******** mask2[9] is 0x2000
[    1.623530] max1363 1-0064: available_scan_mask 9 subset of 0. Never use=
d
[    1.630328] iio-core: ******** mask2[10] is 0x40000
[    1.635224] max1363 1-0064: available_scan_mask 10 subset of 0. Never us=
ed
[    1.642112] iio-core: ******** mask2[11] is 0x80000
[    1.647001] max1363 1-0064: available_scan_mask 11 subset of 0. Never us=
ed
[    1.653886] iio-core: ******** mask2[12] is 0x3000
[    1.658687] max1363 1-0064: available_scan_mask 12 subset of 0. Never us=
ed
[    1.665571] iio-core: ******** mask2[13] is 0xc0000
[    1.670461] max1363 1-0064: available_scan_mask 13 subset of 0. Never us=
ed
[    1.677350] iio-core: ******** mask1[1] is 0x4
[    1.681811] iio-core: ******** mask2[2] is 0x8
[    1.686272] iio-core: ******** mask2[3] is 0x3
[    1.690724] iio-core: ******** mask2[4] is 0x7
[    1.695175] iio-core: ******** mask2[5] is 0xf
[    1.699626] iio-core: ******** mask2[6] is 0xc
[    1.704078] iio-core: ******** mask2[7] is 0x1000
[    1.708791] iio-core: ******** mask2[8] is 0x2000
[    1.713506] max1363 1-0064: available_scan_mask 8 subset of 1. Never use=
d
[    1.720305] iio-core: ******** mask2[9] is 0x40000
[    1.725106] max1363 1-0064: available_scan_mask 9 subset of 1. Never use=
d
[    1.731903] iio-core: ******** mask2[10] is 0x80000
[    1.736793] max1363 1-0064: available_scan_mask 10 subset of 1. Never us=
ed
[    1.743676] iio-core: ******** mask2[11] is 0x3000
[    1.748478] max1363 1-0064: available_scan_mask 11 subset of 1. Never us=
ed
[    1.755363] iio-core: ******** mask2[12] is 0xc0000
[    1.760251] max1363 1-0064: available_scan_mask 12 subset of 1. Never us=
ed
[    1.767136] iio-core: ******** mask2[13] is 0x0
[    1.771677] max1363 1-0064: available_scan_mask 13 subset of 1. Never us=
ed
[    1.778562] iio-core: ******** mask1[2] is 0x3
[    1.783015] iio-core: ******** mask2[3] is 0x7
[    1.787470] iio-core: ******** mask2[4] is 0xf
[    1.791922] iio-core: ******** mask2[5] is 0xc
[    1.796403] iio-core: ******** mask2[6] is 0x1000
[    1.801116] iio-core: ******** mask2[7] is 0x2000
[    1.805830] iio-core: ******** mask2[8] is 0x40000
[    1.810636] max1363 1-0064: available_scan_mask 8 subset of 2. Never use=
d
[    1.817433] iio-core: ******** mask2[9] is 0x80000
[    1.822235] max1363 1-0064: available_scan_mask 9 subset of 2. Never use=
d
[    1.829033] iio-core: ******** mask2[10] is 0x3000
[    1.833832] max1363 1-0064: available_scan_mask 10 subset of 2. Never us=
ed
[    1.840719] iio-core: ******** mask2[11] is 0xc0000
[    1.845607] max1363 1-0064: available_scan_mask 11 subset of 2. Never us=
ed
[    1.852491] iio-core: ******** mask2[12] is 0x0
[    1.857029] max1363 1-0064: available_scan_mask 12 subset of 2. Never us=
ed
[    1.863915] iio-core: ******** mask2[13] is 0x0
[    1.868456] max1363 1-0064: available_scan_mask 13 subset of 2. Never us=
ed
[    1.875341] iio-core: ******** mask1[3] is 0xf
[    1.879794] iio-core: ******** mask2[4] is 0xc
[    1.884246] iio-core: ******** mask2[5] is 0x1000
[    1.888960] iio-core: ******** mask2[6] is 0x2000
[    1.893674] iio-core: ******** mask2[7] is 0x40000
[    1.898475] iio-core: ******** mask2[8] is 0x80000
[    1.903276] max1363 1-0064: available_scan_mask 8 subset of 3. Never use=
d
[    1.910074] iio-core: ******** mask2[9] is 0x3000
[    1.914788] max1363 1-0064: available_scan_mask 9 subset of 3. Never use=
d
[    1.921586] iio-core: ******** mask2[10] is 0xc0000
[    1.926474] max1363 1-0064: available_scan_mask 10 subset of 3. Never us=
ed
[    1.933360] iio-core: ******** mask2[11] is 0x0
[    1.937906] max1363 1-0064: available_scan_mask 11 subset of 3. Never us=
ed
[    1.944794] iio-core: ******** mask2[12] is 0x0
[    1.949334] max1363 1-0064: available_scan_mask 12 subset of 3. Never us=
ed
[    1.956219] iio-core: ******** mask2[13] is 0xffff0000012b5480
[    1.962063] max1363 1-0064: available_scan_mask 13 subset of 3. Never us=
ed
[    1.968948] iio-core: ******** mask1[4] is 0x1000
[    1.973659] iio-core: ******** mask2[5] is 0x2000
[    1.978372] iio-core: ******** mask2[6] is 0x40000
[    1.983172] iio-core: ******** mask2[7] is 0x80000
[    1.987972] iio-core: ******** mask2[8] is 0x3000
[    1.992686] max1363 1-0064: available_scan_mask 8 subset of 4. Never use=
d
[    1.999484] iio-core: ******** mask2[9] is 0xc0000
[    2.004289] max1363 1-0064: available_scan_mask 9 subset of 4. Never use=
d
[    2.011087] iio-core: ******** mask2[10] is 0x0
[    2.015629] max1363 1-0064: available_scan_mask 10 subset of 4. Never us=
ed
[    2.022514] iio-core: ******** mask2[11] is 0x0
[    2.027054] max1363 1-0064: available_scan_mask 11 subset of 4. Never us=
ed
[    2.033939] iio-core: ******** mask2[12] is 0xffff0000012b5480
[    2.039783] max1363 1-0064: available_scan_mask 12 subset of 4. Never us=
ed
[    2.046668] iio-core: ******** mask2[13] is 0xffff0000012b5420
[    2.052513] max1363 1-0064: available_scan_mask 13 subset of 4. Never us=
ed
[    2.059404] iio-core: ******** mask1[5] is 0x40000
[    2.064203] iio-core: ******** mask2[6] is 0x80000
[    2.069003] iio-core: ******** mask2[7] is 0x3000
[    2.073716] iio-core: ******** mask2[8] is 0xc0000
[    2.078518] max1363 1-0064: available_scan_mask 8 subset of 5. Never use=
d
[    2.085316] iio-core: ******** mask2[9] is 0x0
[    2.089769] max1363 1-0064: available_scan_mask 9 subset of 5. Never use=
d
[    2.096567] iio-core: ******** mask2[10] is 0x0
[    2.101107] max1363 1-0064: available_scan_mask 10 subset of 5. Never us=
ed
[    2.107993] iio-core: ******** mask2[11] is 0xffff0000012b5480
[    2.113836] max1363 1-0064: available_scan_mask 11 subset of 5. Never us=
ed
[    2.120721] iio-core: ******** mask2[12] is 0xffff0000012b5420
[    2.126564] max1363 1-0064: available_scan_mask 12 subset of 5. Never us=
ed
[    2.133449] iio-core: ******** mask2[13] is 0xffff0000012b53c0
[    2.139292] max1363 1-0064: available_scan_mask 13 subset of 5. Never us=
ed
[    2.146182] iio-core: ******** mask1[6] is 0x3000
[    2.150898] iio-core: ******** mask2[7] is 0xc0000
[    2.155699] max1363 1-0064: available_scan_mask 7 subset of 6. Never use=
d
[    2.162499] iio-core: ******** mask2[8] is 0x0
[    2.166952] max1363 1-0064: available_scan_mask 8 subset of 6. Never use=
d
[    2.173750] iio-core: ******** mask2[9] is 0x0
[    2.178204] max1363 1-0064: available_scan_mask 9 subset of 6. Never use=
d
[    2.185006] iio-core: ******** mask2[10] is 0xffff0000012b5480
[    2.190850] max1363 1-0064: available_scan_mask 10 subset of 6. Never us=
ed
[    2.197735] iio-core: ******** mask2[11] is 0xffff0000012b5420
[    2.203578] max1363 1-0064: available_scan_mask 11 subset of 6. Never us=
ed
[    2.210463] iio-core: ******** mask2[12] is 0xffff0000012b53c0
[    2.216307] max1363 1-0064: available_scan_mask 12 subset of 6. Never us=
ed
[    2.223194] iio-core: ******** mask2[13] is 0xffff0000012b5360
[    2.229041] max1363 1-0064: available_scan_mask 13 subset of 6. Never us=
ed
[    2.235926] iio-core: ******** mask1[7] is 0x0
[    2.240378] iio-core: ******** mask2[8] is 0x0
[    2.244831] max1363 1-0064: available_scan_mask 8 subset of 7. Never use=
d
[    2.251629] iio-core: ******** mask2[9] is 0xffff0000012b5480
[    2.257385] max1363 1-0064: available_scan_mask 9 subset of 7. Never use=
d
[    2.264183] iio-core: ******** mask2[10] is 0xffff0000012b5420
[    2.270032] max1363 1-0064: available_scan_mask 10 subset of 7. Never us=
ed
[    2.276914] iio-core: ******** mask2[11] is 0xffff0000012b53c0
[    2.282757] max1363 1-0064: available_scan_mask 11 subset of 7. Never us=
ed
[    2.289640] iio-core: ******** mask2[12] is 0xffff0000012b5360
[    2.295483] max1363 1-0064: available_scan_mask 12 subset of 7. Never us=
ed
[    2.302367] iio-core: ******** mask2[13] is 0xffff0000012b5300
[    2.308215] max1363 1-0064: available_scan_mask 13 subset of 7. Never us=
ed
[    2.315101] iio-core: ******** mask1[8] is 0xffff0000012b5480
[    2.320857] iio-core: ******** mask2[9] is 0xffff0000012b5420
[    2.326613] max1363 1-0064: available_scan_mask 9 subset of 8. Never use=
d
[    2.333411] iio-core: ******** mask2[10] is 0xffff0000012b53c0
[    2.339254] max1363 1-0064: available_scan_mask 10 subset of 8. Never us=
ed
[    2.346138] iio-core: ******** mask2[11] is 0xffff0000012b5360
[    2.351981] max1363 1-0064: available_scan_mask 11 subset of 8. Never us=
ed
[    2.358867] iio-core: ******** mask2[12] is 0xffff0000012b5300
[    2.364710] max1363 1-0064: available_scan_mask 12 subset of 8. Never us=
ed
[    2.371594] iio-core: ******** mask2[13] is 0xffff0000012b52a0
[    2.377437] max1363 1-0064: available_scan_mask 13 subset of 8. Never us=
ed
[    2.384322] iio-core: ******** mask1[9] is 0xffff0000012b53c0
[    2.390077] iio-core: ******** mask2[10] is 0xffff0000012b5360
[    2.395921] max1363 1-0064: available_scan_mask 10 subset of 9. Never us=
ed
[    2.402805] iio-core: ******** mask2[11] is 0xffff0000012b5300
[    2.408648] max1363 1-0064: available_scan_mask 11 subset of 9. Never us=
ed
[    2.415533] iio-core: ******** mask2[12] is 0xffff0000012b52a0
[    2.421376] max1363 1-0064: available_scan_mask 12 subset of 9. Never us=
ed
[    2.428262] iio-core: ******** mask2[13] is 0xffff0000012b5240
[    2.434108] max1363 1-0064: available_scan_mask 13 subset of 9. Never us=
ed
[    2.440993] iio-core: ******** mask1[10] is 0xffff0000012b5300
[    2.446836] iio-core: ******** mask2[11] is 0xffff0000012b52a0
[    2.452679] max1363 1-0064: available_scan_mask 11 subset of 10. Never u=
sed
[    2.459651] iio-core: ******** mask2[12] is 0xffff0000012b5240
[    2.465494] max1363 1-0064: available_scan_mask 12 subset of 10. Never u=
sed
[    2.472466] iio-core: ******** mask2[13] is 0xffff0000012b51e0
[    2.478309] max1363 1-0064: available_scan_mask 13 subset of 10. Never u=
sed
[    2.485281] iio-core: ******** mask1[11] is 0xffff0000012b5240
[    2.491123] iio-core: ******** mask2[12] is 0xffff0000012b51e0
[    2.496966] max1363 1-0064: available_scan_mask 12 subset of 11. Never u=
sed
[    2.503939] iio-core: ******** mask2[13] is 0xffff0000012b5180
[    2.509780] max1363 1-0064: available_scan_mask 13 subset of 11. Never u=
sed
[    2.516752] iio-core: ******** mask1[12] is 0xffff0000012b5180
[    2.522594] iio-core: ******** mask2[13] is 0xffff0000012b5120
[    2.528436] max1363 1-0064: available_scan_mask 13 subset of 12. Never u=
sed

That's why I decided to implement a new one that I have validated on a PC.

I am open to suggestions.

Thanks

