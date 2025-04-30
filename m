Return-Path: <linux-iio+bounces-18918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EECAA54BA
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 21:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329CB1BA6387
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5151E833F;
	Wed, 30 Apr 2025 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdMpS+hN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F91E1A31;
	Wed, 30 Apr 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746041867; cv=none; b=bWYg2EwvQfXDF9tqm6rAkSeqo7WR4gwYSkGpXGpeGznTncyPqVkrUKqP9JzW/emvcJxBdncmtkw3BLtLc/TUsF/ixgSX1qMBqLNntBxqn0p5Cq9AbfMxgZa2lXXL1MPPTtYzDLzluusFIooLZHESnoa1LCKEJu14TzBbBZ5QL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746041867; c=relaxed/simple;
	bh=m6QJZwhPX/SFE08rRkD0dyQ0XUeRPA2AgAoXxvxOZts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdWof/yCN0Sttv9uQvpitDnigJv2+JAr/VXRKfCRGM9hOMZT8/BeR7Iy6/oeDXjRN6U0FbMbUPtBiZUoq7qccvNge+NxAxhACwRHOuuQIJHZN5cEhXLUiJLt6uLC1Rt52lAuj2pjO7hFqZUohdpW7Ot1m8nhYOP3FoSCgtL163E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdMpS+hN; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso1381371fa.3;
        Wed, 30 Apr 2025 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746041863; x=1746646663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Dnl0uiUfShljj4pg3WKImdvuL66vR1xupMJjdiTDT4=;
        b=kdMpS+hN7AyDNfBiXx2P81XVfju3O5jDF9m2fYtqXln8TNfLVGilrZJwHGI5MtfvFo
         p9q+M7x6Y4xHhe900A7aRevq/Dv6QsHII3QKo4rwloK3MuyuhuVa3QhWCS9cCliW4+Nv
         F+4KrkbZSBEqkNyeMCsk7NX/1KLnh5CSpIIYdjUvU3ctweY7AywfFDCAwvgXIOHP8Z5D
         HZUb8fat8bfVhQawCq7Uawhha6js1iPEjz3/oKUDy1jyiJ6O9D95cHFvEhozluJfXPrw
         cidxP95h6b6MjTYFH4cv6BXpm+owzE8Ne4r1Z4w+irqPiTr7wY9eVuW09FtJoyVNZASe
         ZEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746041863; x=1746646663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Dnl0uiUfShljj4pg3WKImdvuL66vR1xupMJjdiTDT4=;
        b=QoFPKaUM8QlygZUJCap9Q1uS8sIyFLOO0M//9grV2xNhPq9fpnnt2h1yG8r/Qgpjg/
         +wXQ9NTvg/yxNE2j0pgcoLODxipGjpSFdMKW1iRvnYb7VPl/E+h9v6OCjVJ0i3d/g/L7
         8xdWlOEstmX2Cra52Av2oUgnUZcwjqmiVpj30e478kZv1anAV80sFtlcWJsvexxi7fUT
         8vCxiDJKT8BH9eKDWVlSZ6CMUvUwSqAFki5rsNOf5DqnNfvY5mRfS1TL11d6R4xiXJTU
         LRxcEMxTlKrw0w1C8bO1TucHVpeiPbW2uhw8ijqOf5XtE+/YGKBYYLANmk0VHqj5l7+p
         HBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9cmR133tjPUcdKJJPTjHe2keYPuCQMwcg05+TqK5LDagu36aB4hqQ/rfXWM1XPVH68q9jmyuz@vger.kernel.org, AJvYcCXfXwewMDh7cTjy2rHTdcJj12NFfCJzTBrnKb108Hg+ZOfN3GHVlTsSCvqSVgC8wLjlMk260OFeelQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMzYi78H1QpUq12GuRvMTq806OluvIh3uc9kcqs+ef0w6nyOnk
	6BPh4lSUl0N+jwog9zLedqD+iuCqOkmUbf0mgzqAnz0ucv/1NutTGYcBhPjl5eBs1UeMFQGPVa4
	Eunr75oz6sPX72+yU+LYCEQzkuak=
X-Gm-Gg: ASbGncv6l72IWEMQY7cEkUjryNkoiY/fI/e9gcn3vYFVx5p+MXZRpdlFsmQc38b/9tl
	gne+cSox2J1VVaFLbs49UkIo3IcWG2PQgcuKt/yN6Rqgk/oA+L2anCdAeRzIdNPYNPMEoytpDBI
	ABWATR/wTK+UfHLVPHCB259ve9j62RmBB8qjU7xk21bRW1R7c8QqrvTw==
X-Google-Smtp-Source: AGHT+IFY2PBg/N2tgavOhlNFfmKZV1hRQuMpvC1Z1jV/0vhdMctBszo7gNoz8AcoAklFhX2dFZZUDdHIzUE7sIP61gY=
X-Received: by 2002:a05:651c:146d:b0:30d:62c1:3c0a with SMTP id
 38308e7fff4ca-31e6b2c3340mr19064111fa.25.1746041862440; Wed, 30 Apr 2025
 12:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429150213.2953747-1-festevam@gmail.com> <20250429183301.326eaacf@jic23-huawei>
 <CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
 <CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
 <20250430141112.00004bb8@huawei.com> <CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
 <20250430182537.00007eab@huawei.com>
In-Reply-To: <20250430182537.00007eab@huawei.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Apr 2025 16:37:30 -0300
X-Gm-Features: ATxdqUHD9oSwaZ0zrqJQ-_-1LVGK0OIdV3EvET0tpXnhaEiXEYiKscREFKzNDT0
Message-ID: <CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Wed, Apr 30, 2025 at 2:25=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:

> Should be:
> #define MAX1363_4X_CHANS(bits, ev_spec, num_ev_spec) {                  \
>         MAX1363_CHAN_U(0, _s0, 0, bits, ev_spec, num_ev_spec),          \
>         MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),          \
>         MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),          \
>         MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),          \
>         MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),     \
>         MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),     \
>         MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),     \
>         MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),     \
>         IIO_CHAN_SOFT_TIMESTAMP(8)                                      \
>         }

I have applied your suggestion.

Please take a look and let me know your thoughts.

--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -504,10 +504,10 @@ static const struct iio_event_spec max1363_events[] =
=3D {
        MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),          \
        MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),          \
        MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),          \
-       MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),      \
+       MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),     \
        IIO_CHAN_SOFT_TIMESTAMP(8)                                      \
        }

@@ -577,8 +577,8 @@ static const struct iio_chan_spec
max1238_channels[] =3D MAX1363_12X_CHANS(12);

 static const enum max1363_modes max11607_mode_list[] =3D {
        _s0, _s1, _s2, _s3,
-       s0to1, s0to2, s0to3,
-       s2to3,
+       s0to1, s0to2, s2to3,
+       s0to3,
        d0m1, d2m3, d1m0, d3m2,
        d0m1to2m3, d1m0to3m2,
 };
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-cor=
e.c
index 6a6568d4a2cb..8c9330a9f615 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1947,15 +1947,21 @@ static void
iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
         * available masks in the order of preference (presumably the least
         * costy to access masks first).
         */
+       pr_err("******** masklength is %d", masklength);
+       pr_err("******** longs_per_mask is %d", longs_per_mask);
+
+
        for (i =3D 0; i < num_masks - 1; i++) {
                const unsigned long *mask1;
                int j;

                mask1 =3D av_masks + i * longs_per_mask;
+               pr_err("******** mask1[%d] is 0x%lx\n", i, mask1[0]);
                for (j =3D i + 1; j < num_masks; j++) {
                        const unsigned long *mask2;

                        mask2 =3D av_masks + j * longs_per_mask;
+                       pr_err("******** mask2[%d] is 0x%lx\n", i, mask2[0]=
);
                        if (bitmap_subset(mask2, mask1, masklength))
                                dev_warn(indio_dev->dev.parent,
                                         "available_scan_mask %d
subset of %d. Never used\n",

[    1.569250] iio-core: ******** masklength is 16
[    1.569261] iio-core: ******** longs_per_mask is 1
[    1.573834] iio-core: ******** mask1[0] is 0x1
[    1.583173] iio-core: ******** mask2[0] is 0x2
[    1.587629] iio-core: ******** mask2[0] is 0x4
[    1.592091] iio-core: ******** mask2[0] is 0x8
[    1.596569] iio-core: ******** mask2[0] is 0x3
[    1.601027] iio-core: ******** mask2[0] is 0x7
[    1.605482] iio-core: ******** mask2[0] is 0xc
[    1.609942] iio-core: ******** mask2[0] is 0xf
[    1.614400] iio-core: ******** mask2[0] is 0x1000
[    1.619118] iio-core: ******** mask2[0] is 0x2000
[    1.623832] iio-core: ******** mask2[0] is 0x40000
[    1.628642] max1363 1-0064: available_scan_mask 10 subset of 0. Never us=
ed
[    1.635543] iio-core: ******** mask2[0] is 0x80000
[    1.640343] max1363 1-0064: available_scan_mask 11 subset of 0. Never us=
ed
[    1.647229] iio-core: ******** mask2[0] is 0x3000
[    1.651943] iio-core: ******** mask2[0] is 0xc0000
[    1.656745] max1363 1-0064: available_scan_mask 13 subset of 0. Never us=
ed
[    1.663631] iio-core: ******** mask1[1] is 0x2
[    1.668088] iio-core: ******** mask2[1] is 0x4
[    1.672544] iio-core: ******** mask2[1] is 0x8
[    1.676997] iio-core: ******** mask2[1] is 0x3
[    1.681452] iio-core: ******** mask2[1] is 0x7
[    1.685905] iio-core: ******** mask2[1] is 0xc
[    1.690365] iio-core: ******** mask2[1] is 0xf
[    1.694820] iio-core: ******** mask2[1] is 0x1000
[    1.699535] iio-core: ******** mask2[1] is 0x2000
[    1.704251] iio-core: ******** mask2[1] is 0x40000
[    1.709059] max1363 1-0064: available_scan_mask 10 subset of 1. Never us=
ed
[    1.715945] iio-core: ******** mask2[1] is 0x80000
[    1.720747] max1363 1-0064: available_scan_mask 11 subset of 1. Never us=
ed
[    1.727632] iio-core: ******** mask2[1] is 0x3000
[    1.732349] iio-core: ******** mask2[1] is 0xc0000
[    1.737150] max1363 1-0064: available_scan_mask 13 subset of 1. Never us=
ed
[    1.744038] iio-core: ******** mask1[2] is 0x4
[    1.748488] iio-core: ******** mask2[2] is 0x8
[    1.752941] iio-core: ******** mask2[2] is 0x3
[    1.757393] iio-core: ******** mask2[2] is 0x7
[    1.761846] iio-core: ******** mask2[2] is 0xc
[    1.766300] iio-core: ******** mask2[2] is 0xf
[    1.770756] iio-core: ******** mask2[2] is 0x1000
[    1.775469] iio-core: ******** mask2[2] is 0x2000
[    1.780184] iio-core: ******** mask2[2] is 0x40000
[    1.784986] max1363 1-0064: available_scan_mask 10 subset of 2. Never us=
ed
[    1.791871] iio-core: ******** mask2[2] is 0x80000
[    1.796673] max1363 1-0064: available_scan_mask 11 subset of 2. Never us=
ed
[    1.803558] iio-core: ******** mask2[2] is 0x3000
[    1.808271] iio-core: ******** mask2[2] is 0xc0000
[    1.813072] max1363 1-0064: available_scan_mask 13 subset of 2. Never us=
ed
[    1.819961] iio-core: ******** mask1[3] is 0x8
[    1.824415] iio-core: ******** mask2[3] is 0x3
[    1.828865] iio-core: ******** mask2[3] is 0x7
[    1.833317] iio-core: ******** mask2[3] is 0xc
[    1.837771] iio-core: ******** mask2[3] is 0xf
[    1.842224] iio-core: ******** mask2[3] is 0x1000
[    1.846937] iio-core: ******** mask2[3] is 0x2000
[    1.851649] iio-core: ******** mask2[3] is 0x40000
[    1.856448] max1363 1-0064: available_scan_mask 10 subset of 3. Never us=
ed
[    1.863334] iio-core: ******** mask2[3] is 0x80000
[    1.868135] max1363 1-0064: available_scan_mask 11 subset of 3. Never us=
ed
[    1.875026] iio-core: ******** mask2[3] is 0x3000
[    1.879739] iio-core: ******** mask2[3] is 0xc0000
[    1.884540] max1363 1-0064: available_scan_mask 13 subset of 3. Never us=
ed
[    1.891427] iio-core: ******** mask1[4] is 0x3
[    1.895882] iio-core: ******** mask2[4] is 0x7
[    1.900334] iio-core: ******** mask2[4] is 0xc
[    1.904787] iio-core: ******** mask2[4] is 0xf
[    1.909239] iio-core: ******** mask2[4] is 0x1000
[    1.913952] iio-core: ******** mask2[4] is 0x2000
[    1.918666] iio-core: ******** mask2[4] is 0x40000
[    1.923467] max1363 1-0064: available_scan_mask 10 subset of 4. Never us=
ed
[    1.930353] iio-core: ******** mask2[4] is 0x80000
[    1.935154] max1363 1-0064: available_scan_mask 11 subset of 4. Never us=
ed
[    1.942045] iio-core: ******** mask2[4] is 0x3000
[    1.946759] iio-core: ******** mask2[4] is 0xc0000
[    1.951560] max1363 1-0064: available_scan_mask 13 subset of 4. Never us=
ed
[    1.958445] iio-core: ******** mask1[5] is 0x7
[    1.962898] iio-core: ******** mask2[5] is 0xc
[    1.967351] iio-core: ******** mask2[5] is 0xf
[    1.971804] iio-core: ******** mask2[5] is 0x1000
[    1.976515] iio-core: ******** mask2[5] is 0x2000
[    1.981233] iio-core: ******** mask2[5] is 0x40000
[    1.986034] max1363 1-0064: available_scan_mask 10 subset of 5. Never us=
ed
[    1.992920] iio-core: ******** mask2[5] is 0x80000
[    1.997722] max1363 1-0064: available_scan_mask 11 subset of 5. Never us=
ed
[    2.004612] iio-core: ******** mask2[5] is 0x3000
[    2.009327] iio-core: ******** mask2[5] is 0xc0000
[    2.014125] max1363 1-0064: available_scan_mask 13 subset of 5. Never us=
ed
[    2.021011] iio-core: ******** mask1[6] is 0xc
[    2.025463] iio-core: ******** mask2[6] is 0xf
[    2.029916] iio-core: ******** mask2[6] is 0x1000
[    2.034629] iio-core: ******** mask2[6] is 0x2000
[    2.039343] iio-core: ******** mask2[6] is 0x40000
[    2.044146] max1363 1-0064: available_scan_mask 10 subset of 6. Never us=
ed
[    2.051031] iio-core: ******** mask2[6] is 0x80000
[    2.055832] max1363 1-0064: available_scan_mask 11 subset of 6. Never us=
ed
[    2.062717] iio-core: ******** mask2[6] is 0x3000
[    2.067435] iio-core: ******** mask2[6] is 0xc0000
[    2.072237] max1363 1-0064: available_scan_mask 13 subset of 6. Never us=
ed
[    2.079123] iio-core: ******** mask1[7] is 0xf
[    2.083579] iio-core: ******** mask2[7] is 0x1000
[    2.088293] iio-core: ******** mask2[7] is 0x2000
[    2.093006] iio-core: ******** mask2[7] is 0x40000
[    2.097808] max1363 1-0064: available_scan_mask 10 subset of 7. Never us=
ed
[    2.104694] iio-core: ******** mask2[7] is 0x80000
[    2.109493] max1363 1-0064: available_scan_mask 11 subset of 7. Never us=
ed
[    2.116378] iio-core: ******** mask2[7] is 0x3000
[    2.121091] iio-core: ******** mask2[7] is 0xc0000
[    2.125892] max1363 1-0064: available_scan_mask 13 subset of 7. Never us=
ed
[    2.132777] iio-core: ******** mask1[8] is 0x1000
[    2.137490] iio-core: ******** mask2[8] is 0x2000
[    2.142203] iio-core: ******** mask2[8] is 0x40000
[    2.147009] max1363 1-0064: available_scan_mask 10 subset of 8. Never us=
ed
[    2.153896] iio-core: ******** mask2[8] is 0x80000
[    2.158698] max1363 1-0064: available_scan_mask 11 subset of 8. Never us=
ed
[    2.165583] iio-core: ******** mask2[8] is 0x3000
[    2.170297] iio-core: ******** mask2[8] is 0xc0000
[    2.175098] max1363 1-0064: available_scan_mask 13 subset of 8. Never us=
ed
[    2.181983] iio-core: ******** mask1[9] is 0x2000
[    2.186698] iio-core: ******** mask2[9] is 0x40000
[    2.191504] max1363 1-0064: available_scan_mask 10 subset of 9. Never us=
ed
[    2.198390] iio-core: ******** mask2[9] is 0x80000
[    2.203191] max1363 1-0064: available_scan_mask 11 subset of 9. Never us=
ed
[    2.210077] iio-core: ******** mask2[9] is 0x3000
[    2.214788] iio-core: ******** mask2[9] is 0xc0000
[    2.219591] max1363 1-0064: available_scan_mask 13 subset of 9. Never us=
ed
[    2.226476] iio-core: ******** mask1[10] is 0x40000
[    2.231363] iio-core: ******** mask2[10] is 0x80000
[    2.236250] max1363 1-0064: available_scan_mask 11 subset of 10. Never u=
sed
[    2.243222] iio-core: ******** mask2[10] is 0x3000
[    2.248022] iio-core: ******** mask2[10] is 0xc0000
[    2.252910] max1363 1-0064: available_scan_mask 13 subset of 10. Never u=
sed
[    2.259882] iio-core: ******** mask1[11] is 0x80000
[    2.264770] iio-core: ******** mask2[11] is 0x3000
[    2.269570] iio-core: ******** mask2[11] is 0xc0000
[    2.274458] max1363 1-0064: available_scan_mask 13 subset of 11. Never u=
sed
[    2.281430] iio-core: ******** mask1[12] is 0x3000
[    2.286229] iio-core: ******** mask2[12] is 0xc0000
[    2.291120] max1363 1-0064: available_scan_mask 13 subset of 12. Never u=
sed

