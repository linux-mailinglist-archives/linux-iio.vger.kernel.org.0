Return-Path: <linux-iio+bounces-19607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C48ABA1F2
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 19:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553BE3AFA73
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B1255E2F;
	Fri, 16 May 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsYFQzVi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E81B6D06;
	Fri, 16 May 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417175; cv=none; b=LkmLa/2XjFWJ3Galh93dIK+QoKmVgwATsxfmffB6MsM2K9EeEepAA3HZKdR3o0LCAiyEg/q94tNhERofBvC0S2vid7jfYQjv88oCqeK4+VGQudyO5Nb016oRFK+x6KfuhtukI2g4S7usnDrxsEMkWLiaLwPt+TydaZ6lGF7DCIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417175; c=relaxed/simple;
	bh=hRr0vkqcCBiiuQr2Noi3VLDJRnVEgKy0iWnva5xhDNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFqpWd7jkhFRln5YZGMNoVEx3njGQwvVZgixSvGRhqUSiuNQQo5lHzNbNnrYxHN9iAKEtGC4Lw3JPMlVeAbBiqpAih7G/SMeOnCtTBBnnF3Eb9cCHJKbaeMBNrqq2Y/0noGln5awJtzGyo0Vp7+ylyx+1iQ4LyatrlUZ6VhP1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsYFQzVi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-741b3e37a1eso2690847b3a.1;
        Fri, 16 May 2025 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747417173; x=1748021973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lm907Blt8eZZmibNKx552yPMN0qew1WtA6qDv46jnDA=;
        b=MsYFQzViLBYAnGk9jDMgDAoJZyn9bRNKcENgxhaDaewdcJv2K9tqNrBAHu8NXvUXcs
         hiJGAJdpmavDGsC3wpBzcIuoH/nYUh/P+MH616f7SUBTIBUHsHUtz+oRgSzwy4v43W/u
         n6OJJ8DReENijcYS97rzqsx+NFONreBLz9ggExZTjHn4zhfJVlu36QPSr+rs64pJZOuT
         QXwuKCBNu+wIyIyCt/SpGJXyahsOSs402pqk1vQVvEu91s/u5pzPuR7CLbCkiRrRA/0W
         TjZfmooTREuJd9DsxhNVWwf3Zd5BgQJ6BVbp3f8Z+HPLQOpEmjvHH2KC2F3zz1g2Vf45
         0XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417173; x=1748021973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm907Blt8eZZmibNKx552yPMN0qew1WtA6qDv46jnDA=;
        b=JrFyZ7G7B8Omi7idBj0dBMPabzJa5CkpYvptQEBRX3XPujOf2kO8N9FU6V3/EqbMg8
         aDZhW5ia4MfQ8pYYBQTqndEltIrTs6ZcvNpJHR/8/tRcVTO+9DnQzBL0KHIypfTZ+fOf
         CAip6LFYng4XeYpT8HSRcJNmZ3w64cppNhWhpdKDGlWUDYSWXawjBlVy1Bu/SPSDCgnE
         QobAB0xOp0n2ZHecKnjYlGVi+OD3JoKCgeBGRLreDVGZE3uDYIRBzcvDjzut2tMG6o9+
         NRH573FxuG6sjseFCcOLTgc9Gbcdle1YMfnT7ohgBipF1sCpyQlq4LmBHS63YgcdHyLi
         HuCA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0swuur8trdcqvm3kFCHP83bvjWg12wW7ZfD9ZOH/ruAaLj8S6kyXNCpSxyfShIQgeAs/YKv5@vger.kernel.org, AJvYcCVmN/ClYdBAniHljb9kyDKWe5PnEpod+rF6mg7ebLX6INgRG+9ZasYvu75E6zZiAw8ZHsdej8LVhho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpSqkyjNwJrKL7i+/FokNA7GkWGHNNbPzUxnxf46jcCgfoFH7
	4zOc02y7Jnhk24/Mpc5LzQz7KyUTKZ/DghvGHcJ7MMNIUwZ2BAifZCCX
X-Gm-Gg: ASbGncvhG28C/93UVS9txOIPSSuGY8MRExbnoSAUWJTmrsFomXxepjSNwZOvmByEDpV
	xIp93ry6vRz0qE3F5zdO+fZlq/+ybqEACZs9GGQMTlUFzzTtyF0JojXdVfCBGuP3PdTcD3rehMo
	hAC8KO76dUybQ784lnlDtdB3id8b/0COBYyC07xJQLJDAM0dgX+MnUogHRtgNIca9lR10HWFG3c
	nCB3/ZzEPncTA37beI/Dv9kb/WCv/o4l+RDH1r2e6alHiCwL+lAr/lJS7LxESHD3M9pKqbo2a/a
	P5MNRj7cPBsGM0VNl5vACxZR7K2WAAEkFNRSIcHgZVlAfmFzeArSagTCFbiSHsYL2w==
X-Google-Smtp-Source: AGHT+IHD0migFvT1aM+B0g561TwoSRuL4bAJjayYRLgG0iSW65e9n+KdHWvJpvQyxc+LytP54UTZ8g==
X-Received: by 2002:a05:6a20:12ca:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-21621875ab8mr6490718637.4.1747417172739;
        Fri, 16 May 2025 10:39:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:93a1:94a9:517a:f69c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c85dsm1842201b3a.61.2025.05.16.10.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:39:32 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
Date: Fri, 16 May 2025 14:38:59 -0300
Message-Id: <20250516173900.677821-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Since commit 2718f15403fb ("iio: sanity check available_scan_masks array"),
booting a board populated with a MAX11601 results in a flood of warnings:

max1363 1-0064: available_scan_mask 8 subset of 0. Never used
max1363 1-0064: available_scan_mask 9 subset of 0. Never used
max1363 1-0064: available_scan_mask 10 subset of 0. Never used
max1363 1-0064: available_scan_mask 11 subset of 0. Never used
max1363 1-0064: available_scan_mask 12 subset of 0. Never used
max1363 1-0064: available_scan_mask 13 subset of 0. Never used
...

These warnings are caused by incorrect offsets used for differential
channels in the MAX1363_4X_CHANS() and MAX1363_8X_CHANS() macros.

The max1363_mode_table[] defines the differential channel mappings as
follows:

MAX1363_MODE_DIFF_SINGLE(0, 1, 1 << 12),
MAX1363_MODE_DIFF_SINGLE(2, 3, 1 << 13),
MAX1363_MODE_DIFF_SINGLE(4, 5, 1 << 14),
MAX1363_MODE_DIFF_SINGLE(6, 7, 1 << 15),
MAX1363_MODE_DIFF_SINGLE(8, 9, 1 << 16),
MAX1363_MODE_DIFF_SINGLE(10, 11, 1 << 17),
MAX1363_MODE_DIFF_SINGLE(1, 0, 1 << 18),
MAX1363_MODE_DIFF_SINGLE(3, 2, 1 << 19),
MAX1363_MODE_DIFF_SINGLE(5, 4, 1 << 20),
MAX1363_MODE_DIFF_SINGLE(7, 6, 1 << 21),
MAX1363_MODE_DIFF_SINGLE(9, 8, 1 << 22),
MAX1363_MODE_DIFF_SINGLE(11, 10, 1 << 23),

Update the macros to follow this same pattern, ensuring that the scan masks
are valid and preventing the warnings.

Cc: stable@vger.kernel.org
Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Fix the problem by changing the MAX1363_4X_CHANS() and MAX1363_8X_CHANS()
macros. (Jonathan)

 drivers/iio/adc/max1363.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index a7e9912fb44a..bc44b4604ef4 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -511,10 +511,10 @@ static const struct iio_event_spec max1363_events[] = {
 	MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, ev_spec, num_ev_spec),	\
 	IIO_CHAN_SOFT_TIMESTAMP(8)					\
 	}
 
@@ -609,14 +609,14 @@ static const enum max1363_modes max11608_mode_list[] = {
 	MAX1363_CHAN_U(5, _s5, 5, bits, NULL, 0),	\
 	MAX1363_CHAN_U(6, _s6, 6, bits, NULL, 0),	\
 	MAX1363_CHAN_U(7, _s7, 7, bits, NULL, 0),	\
-	MAX1363_CHAN_B(0, 1, d0m1, 8, bits, NULL, 0),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 9, bits, NULL, 0),	\
-	MAX1363_CHAN_B(4, 5, d4m5, 10, bits, NULL, 0),	\
-	MAX1363_CHAN_B(6, 7, d6m7, 11, bits, NULL, 0),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 12, bits, NULL, 0),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, NULL, 0),	\
-	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, NULL, 0),	\
-	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, NULL, 0),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, NULL, 0),	\
+	MAX1363_CHAN_B(4, 5, d4m5, 14, bits, NULL, 0),	\
+	MAX1363_CHAN_B(6, 7, d6m7, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, NULL, 0),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, NULL, 0),	\
+	MAX1363_CHAN_B(5, 4, d5m4, 20, bits, NULL, 0),	\
+	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, NULL, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(16)			\
 }
 static const struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);
-- 
2.34.1


