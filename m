Return-Path: <linux-iio+bounces-16957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BAA64D63
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48BF169490
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A5238172;
	Mon, 17 Mar 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XMpdHuPD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80023536A
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212391; cv=none; b=NUsiwBPH/1qwGrvtKgqPu0k9q2MIcwovMIR5VeSJ4AL2v3jwW/+QJua9tweEsov3joJN2AnH79NkbHzUPmdCXsJVrEMS8uXgsuyPzRBLpNxqkq6OFEf/GHeovkm9f0vvKNktEYoLfXkyY2ogQZ2FLnzr0aDuMgQO83BOvvTLQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212391; c=relaxed/simple;
	bh=aDGsSr8z8o6oRQUxUQK/c3BVrSaGA5xI5Ivsc3r8erg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9NsFN5tybGLfV6nr+WIiWPDLjcxWxhBcH0g2+E7uJewd5nY2nTw+a13ksRjr2jdrbzPGO/ikWxBWDi75MsUNgdOUkdnRLUbYfzOfEC8CySE7mcHBA24vBcrSN/6GpKUmJ0eTLEvPyQ6nZpCHu67BdANIDLQoov0qLHC/WtAeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XMpdHuPD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so5588653a12.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742212386; x=1742817186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tomDGaytNyV4rRtxAxXsvffW2OKucbb/oDz/GZl5VdQ=;
        b=XMpdHuPDBBN84/PIqPtQn1Z1EbIQLkWC10En0neDl2ZoZXkJH07PCYDl30D7VNbJV9
         h5dJLcbHlmsuKLZOUMiDs/1iTftcdvIr/LvCpuVS0ednOD+Jb3Gihnz562FRSmu4uYrp
         mkyR+auhYbB0fMr3nTmkw2DwSFAA70XXio2GOHrFv8q9rBKiwwUIGFI7lARYdD2QEanX
         TRFpA8XjpZJey6VZdD3VOy3tzAUzFK3OOtWEqtz1OGYoT5H3Z+WyssW/NPICRF25JFsQ
         vqdzEYbuqnkLPdNvawHP0LOyAv3BOHkVMFdZFPMKZExTPpCR+P29PDv9wkbuXhQH0Qq8
         n0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742212386; x=1742817186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tomDGaytNyV4rRtxAxXsvffW2OKucbb/oDz/GZl5VdQ=;
        b=pW/GGLmpG5AEflLpRWYK7R4zsdoe3iQocsBMZHWCw2Q2WPjFpVUPEBoi1wZzFcMue/
         ssXD0nMZJwb/Mi4BqxUoO+HwYa70XObc6oXMfawdeCJ04JpGce1MSarEVyCmsAAW3ghy
         2OU6rjtwn3QnBJYdznwoD4koGZB+e5R4Rrx0aPju7j3QNyEgw6us+OIanG6b6bF8oCdc
         FW1tsNWpc81/rBQMzsf5uDARtO9B/DoAQ3fshb8bBYS+afEFm/8y57GBkG2o1dex4uAF
         WB4Xgr0N6M+Xmbgsnl9ci2p7nqhc8A20LMsWya9A1sfTv1nyBe+hdLaNoIqAWJshS94n
         U0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHH7YFeT5rXZnjaS0sOnnaDlAtvg8fcAnxFnOXK90ol5OnlnuJHJ8JMq4jUO5BMfs5BVrtd2Umb+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF9rvABCYiuX7XpXn8opce90XGu9lhfcJko38oEf2/tPLuAK1V
	QfjuStp6za/725UMhF2HVCEOGF2WHV/Zk9cNjhBQ2KDTzhvBKbMXkGlT0fQcy8E=
X-Gm-Gg: ASbGnctIw6CaR84gwsikAa+jw6v8JLsjkTJz1CXZrpnGmocarh7WQriYjCp4wvRiTlp
	LnywH2AwLMmY8+srG44Nq8KrX2pDs7ySAtiYqbbYyQszPZD2W856yE3tSVZVREbgKPUv5eXwlqT
	EmaTOaWJVYHO/A/dQaV/AApkwYrgqIUb1B1JnZkmFjSKfG+QNwAsxa4i2j70nHRO8DJ4OfMeUgp
	/2OOyzZdXDE7ouWs8mYX6m7wJlH/h3pgMXaQWu4av4kF+NxQE271xC4y921FQm74yJWFKMCe8yd
	ck3c8ll/ZNM2cmI8vFNBCiyDka+CVdbrjAhvmRPet2NYKveSiSH0lnjtOCiApvvoWTq82nnvC5u
	H6YTpxWmvIdw=
X-Google-Smtp-Source: AGHT+IFus4yMP4oMcF5zTuuSlVz/Tvyby6EQn3imep0Jt/rBM2070QbnsM/Wz2wHompP/MZfIt37Qw==
X-Received: by 2002:a05:6402:254b:b0:5e5:e396:3f9a with SMTP id 4fb4d7f45d1cf-5e8a09fd6ecmr9956405a12.31.1742212386254;
        Mon, 17 Mar 2025 04:53:06 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad38f3sm6022663a12.63.2025.03.17.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:53:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/3] iio: adc: ad7124: Fix 3dB filter frequency reading
Date: Mon, 17 Mar 2025 12:52:47 +0100
Message-ID: <20250317115247.3735016-6-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=aDGsSr8z8o6oRQUxUQK/c3BVrSaGA5xI5Ivsc3r8erg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn2A0Syzbm9ok7QmAMQ7ChQRoUMKEqapyPKIV9v h35n5oYwz2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ9gNEgAKCRCPgPtYfRL+ TpKdCACKDa5t8eiwkv7e5k/0EJcAx9cJoVPHDkSeZ104u+9V47XrxfqnY7TJi3zh8/EDPd6XzuE ZiZ8YE+Ixosork9QkkiUoDMi/7QPrJ+Mb42DlPnxvwdNf8CWxtoYBs3xp3tWm4eU2s8SlDTvlYG S5tPNq4XxfEkaAid+ZK4MQj9HrXatVED6KfSbx8aKjcFQn7h4CtEesZ9pOdXSoN6CkZdvYNzsTI dk9861Ks+b1p/cI81Jt32AgLCwXJHatPuNoYbRhlD9wsh/Rln1ZjugCG8kYrqjZPD8UnwoXWwkZ RhZ9rwCVjdRef/rIq6CYgUZ7RDsQrnt36Jytopqdjcsgzs61
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The sinc4 filter has a factor 0.23 between Output Data Rate and f_{3dB}
and for sinc3 the factor is 0.272 according to the data sheets for
ad7124-4 (Rev. E.) and ad7124-8 (Rev. F).

Fixes: cef2760954cf ("iio: adc: ad7124: add 3db filter")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 3ea81a98e455..7d5d84a07cae 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -301,9 +301,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
 
 	switch (st->channels[channel].cfg.filter_type) {
 	case AD7124_SINC3_FILTER:
-		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
+		return DIV_ROUND_CLOSEST(fadc * 272, 1000);
 	case AD7124_SINC4_FILTER:
-		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
+		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
 	default:
 		return -EINVAL;
 	}
-- 
2.47.1


