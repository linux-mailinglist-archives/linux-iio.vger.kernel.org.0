Return-Path: <linux-iio+bounces-19872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25058AC344E
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D7A175D04
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C11F2388;
	Sun, 25 May 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRarqGzX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9C1DF26B;
	Sun, 25 May 2025 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748174162; cv=none; b=Y9Q5CHMhilgnhsOZ5VY6L6j3Nj8VMWWyD9+U95uFRPKIaT5VdJbPzraSIzkmG9zYCO8E7re64y/zb0oeaQX6lojdKMkmq6E7JwuzWP7ntN/EuBDZgEQhlsO9SOc8k+4PyWeECzYjqxZkVccBJQ7fxz3A3stefLOZYu9/+qlP0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748174162; c=relaxed/simple;
	bh=rzj4RSMgTitDgsfiG8R9TrQopONaWE0UqE+vmKQYo5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CxlzjxdP0cr2nw9lPh0m5eehPJm9+XxK7yFsKBZbgDbXJue6gVFkvY9+PQhKLQAvMf1lC+4WG32hPCzum5jvRQ255QNGE/CNx2XJsi9K8lSeC2n+IQhdWc+WOmPZrH4CketF3LQms7E2npqqnFmVcG+fHArvmc4xkYHfmenC6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRarqGzX; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87de33ccdb4so418258241.2;
        Sun, 25 May 2025 04:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748174159; x=1748778959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6Iyvae425oa5vml4Qw6ME2a3u8XHgSU+g4q8Mbi88M=;
        b=PRarqGzX9soK82coR62u79TatiGrIbZP6TURTnOVeS3XBxPcb44xlBbq0EuiFpbYbu
         t301q29qnCSMed62WTbFFzlMoO3SwM9t17lnGaus1nsPK6HNqSo82so2FX0GbVPy9OG2
         GzFYRGzisrfX7HDDXPwEWSpLPSJ8h7VtcR/iQGLtOMK8hFr3fS6xeR5DVp+h3beYFsbP
         60qdw9SYTJcP897KdmyVv7OrmuZn5QVLDddqzl95988d5mGc8Dm2R6bUW1nyB8kAay9B
         t5l/GJ4xQa00/n3KOh9Rh/Pr45nn14MRXDskZXjpjd6bOO760nP++9+8Uy2uwc3UinFG
         LTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748174159; x=1748778959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6Iyvae425oa5vml4Qw6ME2a3u8XHgSU+g4q8Mbi88M=;
        b=uXmkMHPB1im8Y6NZrOy3MmedKQjwBV1UyAmN5L6GC1xwT/Jr0CyzaT95DLKcihhXiy
         qNUGTr1bJqFMxNnXGbFVwSM73wotUEA7vq7HXAaNBd2Q4K8KQQotsad0wGQLt2zWPiXu
         vRRi8pYH7zem8GDh9Jxy0pOL9Nay/lLOGD0o37N34XuIP2q7xtaKpB4m9QW9ep/QsOZ6
         U2FnQXanktM+ihlFBA2OOa8HHBu1KAWKqw8YyX9t4nuMzP8bRX7xmEs7zIqI+PXCZNxL
         nQry81HkBxHEwkDd6sHfM4CDwYF/lcnJtnzVwJabpv1gZuAUZ7PBlChbO8Pqu9gbo86y
         psnA==
X-Forwarded-Encrypted: i=1; AJvYcCWaRm5S/7aexZW7EPQjczSF3WSyE8sO8YoWOv6FcM8HJLISjgeWTFbJokfXZx04pC+dGn4yLRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDW9a8L6Um0Ap432tG7d30/5MPJZgh/CPsacVqaB7aFYtoQOnO
	qMmjREtDykjdFksnqrD46/xAG2ms3SUywJWIb1fSgCci/cquaG4ScJjZ
X-Gm-Gg: ASbGncsuMRf63U3sU6DpFKF72mmGwr+kGG7lAgSrVZc0CdI8CipdBTgSQm+sI7SmpuF
	HyMT+uf/ubHPJ1DUWtMBGU+NrJda4WvdO4s9/PurVB62KUtPc1XLt5or60qdjF5mi2YOR7UxE/O
	51secaMHSxW7c9LV1zkDqp9egpnzmP32IPO6BFS6/TRGN0Ppel6f0ho3gl5KuaCKJUjnYulnkRg
	OunRQJ04K+NAlfBDq+wlXbfmJRNg3903aRmCcFZSi1SAI7z3LlWn4Ixu62VEHydd33lBQ/VSkjt
	ta/0MNFKk6HXk6ZOB0bs6jsLcdKg7/Vht+7QeHc01PM43+/guL10a4EVDSvMu7tD5g==
X-Google-Smtp-Source: AGHT+IFre9C/rkzIeD/KNw8KjQpBWme/UdL/dOajuTuX9Z/EB5mL1xvwxMDh5y464YIkN8uw/WlgOw==
X-Received: by 2002:a05:6102:5f0c:b0:4de:3d34:8bcc with SMTP id ada2fe7eead31-4e42417674bmr4663403137.19.1748174159033;
        Sun, 25 May 2025 04:55:59 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fe1b:24a1:48d2:8bd2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87dede7d81fsm2185872241.23.2025.05.25.04.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 04:55:58 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	mazziesaccount@gmail.com,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
Date: Sun, 25 May 2025 08:55:45 -0300
Message-Id: <20250525115546.2368007-1-festevam@gmail.com>
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

Cc: <stable@vger.kernel.org> #6.12
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Removed incorrect Fixes: tag (Matti)

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


