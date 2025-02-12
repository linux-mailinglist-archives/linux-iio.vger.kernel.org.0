Return-Path: <linux-iio+bounces-15435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0ADA323FA
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC25162F12
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F860209F25;
	Wed, 12 Feb 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B/Nqd+mN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6020896D
	for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357627; cv=none; b=Evut27MaWJvhrMMb5QZEX7R2A/SaJxhH6lssSnS/ibx12+HKVwCOSe0sGnRDCEVJSugSs04VjJEYaGkAnvy5SnS5GwpUUDmqHiJQXUfVPzFw3SttZuqU1eN3vBuqzS6CIOwogS0WerATyCS1syS79dzp8utTcEFYJ2jJK6Zwig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357627; c=relaxed/simple;
	bh=8aGSG1R2/KZiNqMahgYpcUrsHqZlV2GQyxwhFjRne34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z67HrFsSiTUBcHkh13GsZ+24rckjNe7EcwLj3d9l26gsFjvYctiecErXL3hc386T6dCHdw4b3ipZlBGzmgi/Tu6gyXBmIh9F/0K7Q7618/rAR7NYotvwxN+gDp2IzPEXSPO87ZlHImS2GzoIgPb6BpT08D8CH9kl9FPa7tFp7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B/Nqd+mN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43934d6b155so4372285e9.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739357623; x=1739962423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AizAf84+FV40x1qFg8hqPNRrmZc6lShv3yme/L08mEs=;
        b=B/Nqd+mNgwWgY9rehlkzchAy+dX88BXxxKJk03Dq1Qt9CNSImqEUtry3cS6N52jNUE
         vKKHbgHt0PZ78I3zx87GDlgA4Ii3syb4od42W0NnT0gPbiGwX4x3ielFYHs9C595ZqEY
         WEc3Kx8znNTPksHcqq4MLyTzFV4zrWy039i2HV/AxppJEZ+TfkJQoGoYTt+CaE4nfcry
         NkUTBreVAhaGoclEH/2U2P9IYDGSkmxH7GLzNZqkFhYB0sE7CHWqKdR3QbL9j4iwIdwN
         gwxEIVx2hJGRlDBJbQDgeyDdSgbqwgceMX61sTQw2rNChKlOkeZtS8t+Jr7eQLl6sxob
         DE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357623; x=1739962423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AizAf84+FV40x1qFg8hqPNRrmZc6lShv3yme/L08mEs=;
        b=BHtGwFP0a33QwkjzhXlWuUqC54HObMMXVbF7a9o2FyC9luque1W5SL+3jrHYEFZTsv
         rO4r7hwO8GWeQQchYuQNUOK5ccnisNR+BNnZMNHkdYhWXEuHfdgZWKJm3R2eBQ1ocUjZ
         kxe+67u0p9ciW4QuDOejb/B/UZ6zHzPllnwMlXaU+JyFgSbzDVr76EpPPTtEDhT/JsmT
         rApTf4S0GlUn2tHb1ZuTpCRt2dWdrNgLzBIaQmgpwlUccxiNjiRdjkY/lXjcqdji9So7
         uJC0eO0M8CWgMh6wpfyJQN55ce4uxmwLsaoKDXK+xNrDy/2xVQ74oFNhr82m0ceug/Gw
         UzaQ==
X-Gm-Message-State: AOJu0YyiqeQ0b+HKZ+mJtnnvpIusyu10qGzX/ppYI9xYtpNkGZyPi3SD
	dNxH9u52SIuq00AVLPIQ+h+WsC0JzpjjtFk7mpWzF34f5qS7kyrDCkneRLxlb3s=
X-Gm-Gg: ASbGncsUubI7J7Ys9q1xwet3w07Nuyv7iGcez1ltBVNjWx6AZnjQbehjTBBuG8cfcd5
	ZM+8RW3iariLlyMEHzdXh3mPvoov9UIc/X/wv+E8K52RH20d0L9yVanYtfQctVWI0zg9tfBw5X6
	q3bDJ5TkXXJud2VFumfcCbNtucASGVaVE+PibdjnxeNgQVmttzncsJXpIzSxanTebNJUxS4rR1v
	E/TySN9fr51lIlWcJkOV3MQT5xigzTo2EtQvDmHJ7stGB2IXQZAqdR+ORPH/8ndinWrCkM7UP4l
	jHghzlSj4hCwImFhH8GhpglQBm4yBjce/o8IC5kLCOf9ZCcvkrimkEFstMXkTtuSNAGEqWu+h3o
	9Xg==
X-Google-Smtp-Source: AGHT+IFIbsKmcWZz+y+kYlL0bxCohZJQJKjbcWIUx5kzQah2pbNSyVkIBMNqG6C8hrQNGe5N/QQIoQ==
X-Received: by 2002:a05:600d:e:b0:439:3e90:c54b with SMTP id 5b1f17b1804b1-4394ce622dcmr58532325e9.0.1739357623024;
        Wed, 12 Feb 2025 02:53:43 -0800 (PST)
Received: from localhost (p200300f65f083b04d1ced5eed56c82e8.dip0.t-ipconnect.de. [2003:f6:5f08:3b04:d1ce:d5ee:d56c:82e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f217sm15964605e9.1.2025.02.12.02.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:53:42 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v1 1/3] iio: adc: ad7124: Fix comparison of channel configs
Date: Wed, 12 Feb 2025 11:53:22 +0100
Message-ID: <20250212105322.10243-6-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
References: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2807; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=8aGSG1R2/KZiNqMahgYpcUrsHqZlV2GQyxwhFjRne34=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnrH2lTmdjBcVT1t0qY4QVi1tYu/xXLx/wE/sId +nLY3s1MXyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6x9pQAKCRCPgPtYfRL+ Tm5iCACyrUPO18oOSHV8TMsSeSzDqcWOUPCOV4tT7sPXvOq1RbieDyIORyLFZLZTZw/HE8aGsAF 9HL7IAZIuAipkri13U4CXiRGVWF0Q5VAJ4oPYXL+rRopfR8kEbR03tgMbyBeARdouDzRF6mq4oE CR77QmRVDvtKdZCXFzuWr2b2+ey+vSBHtGgu9BaQGi91X0sY+Mxg311Nf58889P8FYWJ8mbVcy6 NRGc7X55AaD+jDvtadXW1T734x+arIXzgHq+c5g0bwCNsCb6hev0nD4RKGMubu1HaiY+2TvoxXI 5Nto/IQxlzPK6azDY2Zb0AGqsGw/9U2dRW9BGgmiP4vJqV7y
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Checking the binary representation of two structs (of the same type)
for equality doesn't have the same semantic as comparing all members for
equality. The former might find a difference where the latter doesn't in
the presence of padding or when ambiguous types like float or bool are
involved. (Floats typically have different representations for single
values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
true, but memcmp finds a difference.)

When searching for a channel that already has the configuration we need,
the comparison by member is the one that is needed.

Convert the comparison accordingly to compare the members one after
another. Also add a BUILD_BUG guard to (somewhat) ensure that when
struct ad7124_channel_config::config_props is expanded, the comparison
is adapted, too.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 6bc418d38820..a664179918fc 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -338,15 +338,38 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 								  struct ad7124_channel_config *cfg)
 {
 	struct ad7124_channel_config *cfg_aux;
-	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = sizeof_field(struct ad7124_channel_config, config_props);
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad7124_channel_config was changed.
+	 */
+	BUILD_BUG_ON(sizeof_field(struct ad7124_channel_config, config_props) !=
+		     sizeof(struct {
+			    enum ad7124_ref_sel refsel;
+			    bool bipolar;
+			    bool buf_positive;
+			    bool buf_negative;
+			    unsigned int vref_mv;
+			    unsigned int pga_bits;
+			    unsigned int odr;
+			    unsigned int odr_sel_bits;
+			    unsigned int filter_type;
+		     }));
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
 		if (cfg_aux->live &&
-		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+		    cfg->refsel == cfg_aux->refsel &&
+		    cfg->bipolar == cfg_aux->bipolar &&
+		    cfg->buf_positive == cfg_aux->buf_positive &&
+		    cfg->buf_negative == cfg_aux->buf_negative &&
+		    cfg->vref_mv == cfg_aux->vref_mv &&
+		    cfg->pga_bits == cfg_aux->pga_bits &&
+		    cfg->odr == cfg_aux->odr &&
+		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
+		    cfg->filter_type == cfg_aux->filter_type)
 			return cfg_aux;
 	}
 
-- 
2.47.1


