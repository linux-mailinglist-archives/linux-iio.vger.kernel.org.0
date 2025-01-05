Return-Path: <linux-iio+bounces-13905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C2A01ADB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046623A2F00
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64F166F32;
	Sun,  5 Jan 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVmU+VGe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787EF8F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098002; cv=none; b=rk+HBkrGhkPDhSpPWLk5cH672+J1y5U6MPyyKp84OosNU18bdrCD/AUAUbAGIgEy+mwfyuH9LoelP+MBpEImIYEiJRAJ8nWf4bqcn/kjqCp5btOYJxcmPolGZVH44L4Af+YEp2ACb5SGy6oUMm0v+2DCnlyclOkWsjeAnawrF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098002; c=relaxed/simple;
	bh=bMTpZJQO8uXn3yP0hbnGzyBggb+IDRFNYYEyj20fiZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo6SLSIc2DFXQhip50KSfGcs8fL2cE1iF84MC0pLbRHatpAOMZqVmHwCDUYO/3JAgAmdSyj5YsmvjrDBYnnmuYhCpHQMAsmG9miKDJl3mbbd6zOH6OyTpww9ywRJuqNg4Hz/1JhEam3Yp+MYiuV4z81Q3n0oJvjzc/LbRMNrGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVmU+VGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B850C4CEDD;
	Sun,  5 Jan 2025 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098002;
	bh=bMTpZJQO8uXn3yP0hbnGzyBggb+IDRFNYYEyj20fiZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVmU+VGeXzWqbfgDWO8Rhcj20x9hkCqKhxls/Fi304/FikbHBVTTNHV4Jb55uezpN
	 eMbVVXVvdiQgR2ZqUqIBcqlb3ZKcVYX0Kk1o5bUDuDDgnb9FaLeMRFqDNlqydy1ZFY
	 fNaq0wfy2oitpJ1IcfF5wy7CWqWxk+hwONCoU+2XZsC05o9oL6vHWrEEDw+copvSZR
	 9mN6oF7MiBi7s8XoE1MEbBT1w1iNPIzEPW4BKPfF8rKoRRwyvReEnk883RE2TJXYzt
	 uCe4PIn8XFaw3Hws199A/rVGVSRkyxax2TzzHLtu9kxzTtEJCNydUGSNqELt5gNjhM
	 WBD7or4kZROQA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 06/27] iio: proximity: sx9324: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:51 +0000
Message-ID: <20250105172613.1204781-7-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/sx9324.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index f7819dd2775c..73d972416c01 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -429,16 +429,23 @@ static int sx9324_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return sx_common_read_proximity(data, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = sx_common_read_proximity(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return sx9324_read_gain(data, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = sx9324_read_gain(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9324_read_samp_freq(data, val, val2);
 	default:
-- 
2.47.1


