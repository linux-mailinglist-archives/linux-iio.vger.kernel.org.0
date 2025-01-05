Return-Path: <linux-iio+bounces-13908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30042A01ADE
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C786E3A2F34
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9505515ECDF;
	Sun,  5 Jan 2025 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNw8iDae"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560358F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098007; cv=none; b=SCM5YxEhlHSyxXK93SLG6wWgp0eKoV1la+Or6bCJWSBGc071ZXKDAI9v3YH9Nf3ip6H4nBGtX/+UjqOLo9rOXP2XHFl2YeFTNNNgpnLmeIVtF9X3f0f+WsTIrqNlAKlQlpeavZROLOwE1kqvLDIWrZmxoIZGYAp8XzHzXEbdUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098007; c=relaxed/simple;
	bh=v6Q1erGVN5BFergJayj06fy9eiHQobsivWzLHugz1Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J85QtZatxEPtc+v5kWB2bWAIikMmlg1EnlYkjx7gTbtTJPSvDgHRYlcASwrbnw1mvXxPjbhV6c/DCT2xyyWbl9CiLRVPV1+jDWKiHMSfjY+q03LVeQ4K6aRYhAWCqC/vPReXSsxLs5GMvyYT2QjH7LZklX7hOzTzXekI0JDel08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNw8iDae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FD3C4CEDD;
	Sun,  5 Jan 2025 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098006;
	bh=v6Q1erGVN5BFergJayj06fy9eiHQobsivWzLHugz1Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNw8iDaeCXS1+s61asbJqMejS+kLlqNRuAtkH0CCV8VdzVSJ8CKD0B5mKMHgCjK1Z
	 0MtWGAYX77/PFbPyWfDTm3XUcRe+j1dRxc8s3h4++5TSgdzCU6tmQb0gUiftsk76EZ
	 RQTyxjBl4a9KQxXDPtr0iqEI4MyDDMCdmt8mdmIgSQwivKBpE7X6mLwWgSujfrQGKd
	 E0OFq2ZMbZrsd5K6l7i+ItbeKh1Yuoodp7pYaCN5SJW13eGvgwiuWO7rhWbq3l6eyE
	 BIuN11h/di7AYvwNzI8KbOwL160Y33QWQxB1zk+vHvQeWjUHFjwCwBaiY/08fG+uoF
	 nBWhXVyCLrENg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 09/27] iio: adc: ad4000: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:54 +0000
Message-ID: <20250105172613.1204781-10-jic23@kernel.org>
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
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4000.c | 61 +++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 1d556a842a68..ef0acaafbcdb 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -535,12 +535,16 @@ static int ad4000_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long info)
 {
 	struct ad4000_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return ad4000_single_conversion(indio_dev, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ad4000_single_conversion(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->scale_tbl[st->span_comp][0];
 		*val2 = st->scale_tbl[st->span_comp][1];
@@ -585,36 +589,47 @@ static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
-static int ad4000_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan, int val, int val2,
-			    long mask)
+static int __ad4000_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val2)
 {
 	struct ad4000_state *st = iio_priv(indio_dev);
 	unsigned int reg_val;
 	bool span_comp_en;
 	int ret;
 
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			guard(mutex)(&st->lock);
+	guard(mutex)(&st->lock);
 
-			ret = ad4000_read_reg(st, &reg_val);
-			if (ret < 0)
-				return ret;
+	ret = ad4000_read_reg(st, &reg_val);
+	if (ret < 0)
+		return ret;
 
-			span_comp_en = val2 == st->scale_tbl[1][1];
-			reg_val &= ~AD4000_CFG_SPAN_COMP;
-			reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
+	span_comp_en = val2 == st->scale_tbl[1][1];
+	reg_val &= ~AD4000_CFG_SPAN_COMP;
+	reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
 
-			ret = ad4000_write_reg(st, reg_val);
-			if (ret < 0)
-				return ret;
+	ret = ad4000_write_reg(st, reg_val);
+	if (ret < 0)
+		return ret;
 
-			st->span_comp = span_comp_en;
-			return 0;
-		}
-		unreachable();
+	st->span_comp = span_comp_en;
+	return 0;
+}
+
+static int ad4000_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = __ad4000_write_raw(indio_dev, chan, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.47.1


