Return-Path: <linux-iio+bounces-11888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200189BB0DB
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 11:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CC4281572
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0191B0F18;
	Mon,  4 Nov 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="moyF9DbF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F719309A
	for <linux-iio@vger.kernel.org>; Mon,  4 Nov 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715567; cv=none; b=PyIs9+tXg4Fr0kNWRUEIlu5NALsPcJUlsoyF2e2qJ12R6wvcv9SEA34MJJolyM2vYpNgiFiiH0DwxkdJ1KGZt+7SGEJ92o2eoWn2SOtGePGbH/+hst2qhBjpchZAPlf3wocVPdMI6Oz6SqbiC4zxBjttSXDSgZoWQMC3JzG1mHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715567; c=relaxed/simple;
	bh=p02u5ugaKpWhKVqfxEAznxhLGO4mT4uCMsWfpBLALds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SKIvbn+Er2bjBk4ydK5yfGfIopxY7Yy6HXTd3h0uUKwEI2JcQp6NREDAyf7EVYW0s9SaMz5mR3FEfzc+UG/YJOs4iWIg/PqLReEE6Qg6NlDuXvg7AG7OmdBDeM4bfKq7oTi9+T6i0Zs31DKX/PL9xUW4VGrPc0yYsd59w9eAPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=moyF9DbF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314b316495so34024975e9.2
        for <linux-iio@vger.kernel.org>; Mon, 04 Nov 2024 02:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730715562; x=1731320362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISWAroPoW2Cp/mKeny0CkcawM1MmOld3TK+B1w8Xgd4=;
        b=moyF9DbFW0KZ2QxpaCTUaY3aTqXQpt1GdP1Qcu8jZUI+kwn/o+zrC8rvbZGwz7dJ41
         AxXxVzjoOCye0ZZo4f9ac7Ie+zbWUDgGjLXltbnQ3bfQh+i3sO7tYB+KpnmwQdMx6PG4
         ozYRdeVmtY5OR0YSufayJSJLmUHopu/3SZPoNoQMbdfSt3NYNLMFHdonnk4LRHyjksbm
         Wzuk6gq76S5kFC93WlLB0ivXOu0bLROV820CY2ZU3XWqHnZNcnITy4Forl3kSz6xCvRf
         3cpl9ivfFBCm+wsdtW0ouHE2UX+NlFpq04ym3Do6ge0TlxVWikTCHhw/6rJyZ3VuHE1g
         1xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715562; x=1731320362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISWAroPoW2Cp/mKeny0CkcawM1MmOld3TK+B1w8Xgd4=;
        b=J5HvFto/+6enXhS1MWku89+hxTuOb+njcekIuCQRGI27LjW9Z7wUwNqxUO9+rvynRd
         qSEZVWLalFQIhUzMlWvt9K4wQnIizhb3tnRUt3UM1V0w9gDgwJhcy2f1cRJE78XGchsj
         Fhb38nmK43hGmhwNvPA9qmvN1F4A+mPCQYkHmeB+UizIpmzqN1oXrqDxN8tEJVBX431x
         Xj2hFjwtIG1kLeOLRU1Dt2cej5rUUDdAz4JxDTTruPjLIenEC6S6Y4Ejc6/c6jghwIyq
         hOFlXpKhSIkKG0h/N1UC68yHD7NSd7Pk5qK5+AttaURQLL0GyidSCKtA/eqtCF41Hs24
         pbZA==
X-Forwarded-Encrypted: i=1; AJvYcCUGD7hav3K1TjCN0/QMiuxKhHUV+n4I8wx2Q+/eSXDJqDLJf8aKOpIVN07NmBQyHQZiuMlXTf62YxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECxi4YKBLeaO84Er2k2A1t0kmplTp3oF5Jc8I4whJocH4jAMV
	0qvEsILDavlNiLK0pdlRMshwZ6TMybvaHXrYJo4yaMJDhdDjMrFNSlF6DMzLboU=
X-Google-Smtp-Source: AGHT+IGHBx2Wfh4vX522CnWiby+5Vc1dK4lFkw+tq96nrFTY32QtNrkmHCTwETHp0Q7Y5pJBnfMIXw==
X-Received: by 2002:a05:600c:548d:b0:431:60ac:9b0c with SMTP id 5b1f17b1804b1-4327b6fd376mr124782995e9.20.1730715561767;
        Mon, 04 Nov 2024 02:19:21 -0800 (PST)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e8915sm148643405e9.27.2024.11.04.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:19:20 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7124: Disable all channels at probe time
Date: Mon,  4 Nov 2024 11:19:04 +0100
Message-ID: <20241104101905.845737-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=p02u5ugaKpWhKVqfxEAznxhLGO4mT4uCMsWfpBLALds=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnKJ+Zur8byYe7r6sBCec7CjSYmSuaMA0BkMcL7 8U72Z2JZQiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZyifmQAKCRCPgPtYfRL+ Tph2B/0Q0OQGXvioezD7/2j1hrcpeyLTWoQpl3jeMqbAHoTixhKqjkGqYFX2hfyKQl/aklir2+4 YOnMiGarQRVtQFY30FVdtTCdktbT/qb2Wub3y+/oe4hTvjnWIx9o+8Kd1BqYhQ0FIkwunaFYi52 QaCWInxtFQ2U/BEh920lUnaMFqLjCIqgF5PMsO67YkuY9cElbZAqNEDuq0DVBopTj24kFG2s9GK eDXXgKfh7KrZIAtWIona9NWS+a0Cd6PaBv5slOwiqeIQySHwTYnXg8SxkibA5PviXVZlb8yrm1z JX0Ww4IbUZd8mW6cIEBs0miHDPDsz689Y46otMzTZDw9i1Uo
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When during a measurement two channels are enabled, two measurements are
done that are reported sequencially in the DATA register. As the code
triggered by reading one of the sysfs properties expects that only one
channel is enabled it only reads the first data set which might or might
not belong to the intended channel.

To prevent this situation disable all channels during probe. This fixes
a problem in practise because the reset default for channel 0 is
enabled. So all measurements before the first measurement on channel 0
(which disables channel 0 at the end) might report wrong values.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this patch was part of a series before. The remaining patches are still
under discussion. As this is a fix orthogonal to the other patches of
the series (apart from the other relevant change there also being
necessary to make the ad7124 work for me) it IMHO makes sense to apply
this one already now. There are machines that don't suffer from the
other issue (i.e. the device irq becoming pending by spi traffic), so
this fix is also valuable stand alone. It's IMHO good enough to go in
before v6.12.

The previous submission is available at
https://lore.kernel.org/linux-iio/20241028160748.489596-10-u.kleine-koenig@baylibre.com/

b4 ignored Nuno's Reviewed-by tag with

	NOTE: some trailers ignored due to from/email mismatches:
	    ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
	     Msg From: Nuno Sá <noname.nuno@gmail.com>

I wonder if other maintainers use b4 apply's -S by default, because I
often run into this issue but don't see others mentioning that.
I added the tag here anyhow.

 drivers/iio/adc/ad7124.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index a5d91933f505..749304d38415 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -917,6 +917,9 @@ static int ad7124_setup(struct ad7124_state *st)
 		 * set all channels to this default value.
 		 */
 		ad7124_set_channel_odr(st, i, 10);
+
+		/* Disable all channels to prevent unintended conversions. */
+		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0);
 	}
 
 	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.45.2


