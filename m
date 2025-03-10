Return-Path: <linux-iio+bounces-16708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF1EA5A532
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C3B3AE276
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E031E102D;
	Mon, 10 Mar 2025 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2QBWZ2je"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08D1DF972
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639399; cv=none; b=rTY1CcODo2jfFFyhnckUSeH6SiTaZkHEtfIs9oMW6jVSskRO/FwyQC0DMXZq4udggtqzXj4OywzSVwuaG6pFZ8+q8MjBDorubQtr5gDzXF+CdOH1hsiyLCu5hp1rpUglZrygPWgfTXqPqECZRHrHH0B+0BHq/GAAOgFFl1wju7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639399; c=relaxed/simple;
	bh=u5ePsmfcDhDkeOwFNFmtVTRv9Rit4LfnW4jtEHfO+UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhtP6BNifxLCbI+ShOVLVCrq2YqJXRhJW3Vqc7rWWZgYQR3QziUN/MCWLZa3aI2ths8EeULOk9KfvvomLwdDwyM6c0qUwp5FlLlM639H7ipQXXiy7VXWXpkGlWkhwZhxx8UKMns5Xfpo5GUc7a0a48bPLzlwXZwYeMiDVyqSKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2QBWZ2je; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f3f4890596so2532509b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639396; x=1742244196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCuzGiRhkz0CBFkmeuLAdFa7ZCDNUYxNv2hZAmPEZO0=;
        b=2QBWZ2jeRvH+x2Yd4Cnq3fBFXtxl+lCa8ugpxYp0AlArhQ+9lNadxKS/s5m84keVe1
         EqlzsNQknkQTsyq6OVq31gzv0HXvb1z7p4n+r4p33Yr8ZLS6bWDtPEEGlC4eIE2hgk+3
         /XK1POM2Kt9QhYhHIfJ8Qy0/ZU/rWoPbrXcZvHFVKm23qOyXG26pGotVOqyZCXNVei2X
         rskPGKUR3K8uzwYNQpx30afgYf08dabGcvb5WNDqMYuDEpWjwBZ6ST+V0hzwlfSWgLLM
         DCwSNn1sU3PnKxOoA/8sF+CQJr/KuI8q6Wcx6a3egejludKKaWLsvzLTN2bRUhDaiqgF
         7hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639396; x=1742244196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCuzGiRhkz0CBFkmeuLAdFa7ZCDNUYxNv2hZAmPEZO0=;
        b=uhr34ZFI7wis0FesJup9gH8XZV5iWQ68EhaRBxaartJUghwUC3RvFwStRTWFzyJL9p
         5zeNYydSYKv6XL+MH2km+S3HqPr1aXFi2v8dzjXVuk9nDVwkXhljS5U/84hq4idwmama
         0bY7NXL0ti4Mz0nfHDwBjVO6RvIx1CJ8Mv2wGjJYjIj9QAfcYtbIJHjogn2Cr+pgSuHb
         3GKQgS8dwWOdYtBd3JLsHtpkIaw1TlZ/68PHIbPYUfqgI6bMMShspKLXcgpwC+ewFETe
         9o0Ur9xrzYQeu/a6YXRfQNSOLqdeITP5wzRBf0MyEc15oacOVTmpWmbTxzu3nRfMdiVa
         y26w==
X-Gm-Message-State: AOJu0YyF04eyUIDNC9kcioPxTdqWbL2EzL7WTKiJaWLCNSQrgGaPoBc3
	qTx/Hzu0AE87fWNRvSRpKCRE9SH9rsIjpr9rsp87QpzpdygzKuanxLww9LijQcI=
X-Gm-Gg: ASbGncv2P7DV1QWk6lI+oMNY7ckX4goUzsgD7RgTi806vk3a64Sw/vmsBTvlPUw2eEO
	hYcaelhlq1VRG9nLvtPtp7GIj/WEe5F9n5QzPIyOinYxibTpe03zdnUSuWpi8eWnEzz3jSPKTR2
	bYfXs5LfLi1kpJy26qcdF9ZxmrLKrzV3uJYi2OWs7vPLegIZQXPlwM8/IpRhextP11xcr/ralUa
	lZJ3i61WLFrdrWNyCl5/Qrx5JWE095fhyrYEYgWkkwKOau8dQ5pzkfzwLh+0L+w8Vz+mVkYdoCe
	oDzpj2xY6tUkrtzmJkxK+EHImBnworvFy4wOhZBW9ndziURERT15pXetjamYLQ//vBfvVA+t+PQ
	1
X-Google-Smtp-Source: AGHT+IFyOgnLNUP09CaNVpg3/60xdXC/GRP1hdw7pw4FVDHJLFomixKx8H+hEkS0rIe2cI6usE+vUg==
X-Received: by 2002:a05:6808:384a:b0:3f4:1738:f804 with SMTP id 5614622812f47-3f697afe34amr8586223b6e.4.1741639396306;
        Mon, 10 Mar 2025 13:43:16 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Mar 2025 15:43:06 -0500
Subject: [PATCH 3/5] iio: adc: ad4030: move setting mode to
 update_scan_mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-3-589e4ebd9711@baylibre.com>
References: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Move calling ad4030_set_mode() from the buffer preenable callback to
the update_scan_mode callback. This doesn't change any functionality
but is more logical since setting the mode is a function of the scan
mask and doesn't require an "undo" operation when the buffer is
disabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index f24b46164a477f9b6b5c93ffeba0a335f7b3de5a..c2117c7a296f22aeeec6911c8a8c74ed576296a0 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -868,6 +868,12 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
 	return st->avg_log2 ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
 }
 
+static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	return ad4030_set_mode(indio_dev, *scan_mask);
+}
+
 static const struct iio_info ad4030_iio_info = {
 	.read_avail = ad4030_read_avail,
 	.read_raw = ad4030_read_raw,
@@ -875,13 +881,9 @@ static const struct iio_info ad4030_iio_info = {
 	.debugfs_reg_access = ad4030_reg_access,
 	.read_label = ad4030_read_label,
 	.get_current_scan_type = ad4030_get_current_scan_type,
+	.update_scan_mode  = ad4030_update_scan_mode,
 };
 
-static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
-{
-	return ad4030_set_mode(indio_dev, *indio_dev->active_scan_mask);
-}
-
 static bool ad4030_validate_scan_mask(struct iio_dev *indio_dev,
 				      const unsigned long *scan_mask)
 {
@@ -895,7 +897,6 @@ static bool ad4030_validate_scan_mask(struct iio_dev *indio_dev,
 }
 
 static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
-	.preenable = ad4030_buffer_preenable,
 	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 

-- 
2.43.0


