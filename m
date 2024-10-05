Return-Path: <linux-iio+bounces-10188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F79918AF
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B881F22097
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797F15886C;
	Sat,  5 Oct 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDSGmKrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC501B960;
	Sat,  5 Oct 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728148086; cv=none; b=biBCm2hNoIL+ZqGv72xzHan/YLXXyK2fyYmcKLWDxoh0LMyv4EHZ4EmzTVrgB6pdcxL5Xt03ci0O6u/hkUqTEnAuzkL5yhGi01ZGU1/lcNyZL3eWSTCZmGEoBnbibUIfMfjUNITsPgZQnHCTkT9kVnW7qkOm2ZoCRZ1QAsPdvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728148086; c=relaxed/simple;
	bh=B3uljJHiMAf1cRHBuRo4QAouDvsIUiHWsHV7MJsQq2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5HviQH5Ie5QffVa5lHKo2NMTPB3tHOwtsWfjpTNX1k78SZ0EWQOLWfyMz3tQjuVVHpRYfH1j7ClARkxkzDaQcnnX3FyMGQQiwfDJ8054otzf8wysq3oVux35el8RoOsPRs4/A8R6FeQsXqW/gbx6Ne3C5abju7P2aEPhaGWdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDSGmKrT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so474378a12.3;
        Sat, 05 Oct 2024 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728148084; x=1728752884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5IBhB30RYMAj/6Fpesral+q+EcptBpi8jLdv7vKqayQ=;
        b=HDSGmKrTvgPFuvBKmKjBMtjH7kTFJDKf5rFsku/UkuUqI2FN6s/yRMS9MahhRDJoeL
         SEmLztqrzQBv7Qctrkz9uR6xXvz1oIp8LvfJC9loJXi0iWt2tZ4L/f/GUYaZgrcQp37B
         Fkz2zsYdqTsLkY6xLu5lgYraQiNg9rPaNl1HT2b6Y3lNinRj6q1RgKDUWW9XvU9hPwMa
         4Hdtx5mPQtgTdliVDseu1Z/WjRB1iiE4SkFNcie0M5zZSywEH83yl5sDOdMaKvoo5tCn
         E5tTS9cko+OPBQjRVQ/mpqqXbvShowQZz0fWz0+rJCKelWs7ezRTal1aZUH0MZnlb7FP
         0qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728148084; x=1728752884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IBhB30RYMAj/6Fpesral+q+EcptBpi8jLdv7vKqayQ=;
        b=p1TaykDu/AurhXvK0jO8woUnQkH8rfYnUp2PlXz8TV038TayD13wK6lHIyVabAJjEH
         U1VfYiTNIPvV4u138KSpZ3fxBIxXtWSbWNY61lBMr28fgAQn/hKe5WLEcjZOq++bERtU
         5k2cf+71CkrZQ0DveKKI3qpddq3Hr1L2jYRKy6pYTuWgmDPfGs7f1r2V3VTJ5qvIaWdT
         nOTmmBNBKMaBUaSlAPH+8BF+CIXUh3KQmTNZ0wn1xfeGbR+ZxjODzsXhWWsm3HDJBg5O
         FVXKL+1KLjptsn6tLRKguA8hbn37x9d1cErbvP8FtKXoHEqSE6fARNjZb2Xg0IKnBCwj
         H+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXMLYQSsNQXkzq2JV0IBALj1TSxB2MoRcllmhmInulbQftbSRv0bthfkUIVvnhrDGavZYbq2UocPlIQhoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuquv08erYHN3OPbzsP/+1E5/B2fQmZ/HFIPaAoYbtyMd6nM5B
	opki0kzmrLlAY3UEhjMaPGnkZy4uy+Q3oeTKueI8DUtaYTPFu8LjOWD4yKI4
X-Google-Smtp-Source: AGHT+IHDAlfm86KK/syFJzjhmXRBAzAPJYAmjt3MIcm86/2ZImAvixw0ZPiTvFSk+cCKNx30H+QQaQ==
X-Received: by 2002:a17:902:ec90:b0:207:192f:fb9 with SMTP id d9443c01a7336-20bff1ea9d1mr88909525ad.60.1728148083774;
        Sat, 05 Oct 2024 10:08:03 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c1396890esm15182625ad.197.2024.10.05.10.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 10:08:03 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH v2] iioc: dac: ltc2664: Fix span variable usage in ltc2664_channel_config function
Date: Sat,  5 Oct 2024 22:37:22 +0530
Message-ID: <20241005170722.19542-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation of the ltc2664_channel_config function,
a variable named span is declared and initialized to 0, intended to
capture the return value of the ltc2664_set_span function. However,
the output of ltc2664_set_span is directly assigned to chan->span,
leaving span unchanged. As a result, when the function later checks
if (span < 0), this condition will never trigger an error since
span remains 0, this flaw leads to ineffective error handling. The
current patch resolves this issue by using the ret variable for 
getting the return value, later assigning if successful and also 
effectively removing span variable.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
Fixes: 4cc2fc445d2e4e63ed6bd5d310752d88d365f8e4
---
v2:
- Using the ret variable to store the result from ltc2664_set_span
---
 drivers/iio/dac/ltc2664.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
index 5be5345ac5c8..7dafcba7ece7 100644
--- a/drivers/iio/dac/ltc2664.c
+++ b/drivers/iio/dac/ltc2664.c
@@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 	const struct ltc2664_chip_info *chip_info = st->chip_info;
 	struct device *dev = &st->spi->dev;
 	u32 reg, tmp[2], mspan;
-	int ret, span = 0;
+	int ret;
 
 	mspan = LTC2664_MSPAN_SOFTSPAN;
 	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
@@ -579,20 +579,24 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 		ret = fwnode_property_read_u32_array(child, "output-range-microvolt",
 						     tmp, ARRAY_SIZE(tmp));
 		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
-			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
+			ret = ltc2664_set_span(st, tmp[0] / 1000,
 						      tmp[1] / 1000, reg);
-			if (span < 0)
-				return dev_err_probe(dev, span,
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
 						     "Failed to set span\n");
+			else
+				chan->span = ret;
 		}
 
 		ret = fwnode_property_read_u32_array(child, "output-range-microamp",
 						     tmp, ARRAY_SIZE(tmp));
 		if (!ret) {
-			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
-			if (span < 0)
-				return dev_err_probe(dev, span,
+			ret = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
 						     "Failed to set span\n");
+			else
+				chan->span = ret;
 		}
 	}
 
-- 
2.46.0


