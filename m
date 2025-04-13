Return-Path: <linux-iio+bounces-18060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1720A87198
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA91890E7C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5A1A08A0;
	Sun, 13 Apr 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO8G9JX9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8519D880
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540539; cv=none; b=g3QS1WlwFDx1AK7kPpzcAk9EkgXKvxIfe4PRaUWcKsPpvDl2Y5ba7p6XgMQGMgqkExpYMOuwflYtRF4ETFCzW4tFqJpGN8QYshRkOQjl7YkUZPSIGiq/rZU6u2yZQsYOloufT1a9jMUEDtOTKKTSoz5ICCTyd8OjG1jNAnRjAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540539; c=relaxed/simple;
	bh=riZ+Y0aQ6HCCudD/PiQBQji7SaR0mW2OJHVOV0OTV9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQCko8JQaADHF1typuCi/ulcQIh2wza+Z9nMaFIZ0n/vetqAhKic67UQ8umJsI899U4Jvnbo7RLyJXoVVSBYkoSBvb68EUtQmD3Y/OGacFoMzrPTSLDMwqp+bnN/c7Ew7fPt/GV4PPK2Z5j07d08bQgQHyOOEunGnFzUO41YU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO8G9JX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CB9C4CEEC;
	Sun, 13 Apr 2025 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540538;
	bh=riZ+Y0aQ6HCCudD/PiQBQji7SaR0mW2OJHVOV0OTV9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tO8G9JX9TDs9996Ck2LW6ebkXbBAdd6697nthoV2eWxMQvCYtOcat2uAS3yPCY481
	 qd01VZcGsdDY7WeVTkIpq70UxwbUV4xqJBJA0wasYRCugxYBW/q35TPpZEcNS9zg9H
	 1pNErRJjho0aP5/in6AOHK/g3+HpUlMZSyUqwmoGbG8OS9jbERJjegocgrFaIpsJsf
	 jpEsLS9mVi/+mjtaG6N5zPm4qBznkUdD19glJ64VryPVEDlcvtfamNs6mFrXHEUkzo
	 Ts+sS3du+538H48/v4H1TGwoKA76loiwdWTisAPMJC0oNOHnbnn4TtjjXu2CJw0Wgz
	 9rJ2w/G3g8yYw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 16/20] iio: proximity: irsd200: Use a struct for scan and iio_push_to_buffers_with_ts()
Date: Sun, 13 Apr 2025 11:34:39 +0100
Message-ID: <20250413103443.2420727-17-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The driver previously used an array of two s64, then type cast the
pointer to write an s16 to the start. The code is made more readable
using a structure.  At the same time switch to the new
iio_push_to_buffers_with_ts() helper to enable runtime checking of the
size of the source buffer.

Note that this approach uses a structure with holes, so use memset()
to ensure those do not contain old kernel data as this data is passed
to userspace.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/irsd200.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 1b1b6dfdfa78..0d30b91dbcbc 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -760,15 +760,19 @@ static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
 {
 	struct iio_dev *indio_dev = ((struct iio_poll_func *)pollf)->indio_dev;
 	struct irsd200_data *data = iio_priv(indio_dev);
-	s64 buf[2] = {};
+	struct {
+		s16 channel;
+		aligned_s64 ts;
+	} scan;
 	int ret;
 
-	ret = irsd200_read_data(data, (s16 *)buf);
+	memset(&scan, 0, sizeof(scan));
+	ret = irsd200_read_data(data, &scan.channel);
 	if (ret)
 		goto end;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 end:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.49.0


