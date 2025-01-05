Return-Path: <linux-iio+bounces-13904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A43A01ADA
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F95F161DB5
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6515CD41;
	Sun,  5 Jan 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPa0+001"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13278F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098000; cv=none; b=Q02tNxwCwsy3SeOQuCcIVFpFhRji7JDfvn+7p6xZ+fRjRC/8GMhl0WBpBmYrj3U2OeUrhpf94gFZg/+ZLH5B7F8Ta5enah4HC6ir/588JpRe5fusJ8GEmGWaBdRNr2GBa1OTkXV8eqITTiyIWmckOegp14jaAtbjIYtmWqaIGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098000; c=relaxed/simple;
	bh=qW+WNsCk0k9TgZH5MNCkGmIc/dJmpaJSC3LUHheT+ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSdT/rMqD9xnJ/bfIcp28A9AItW9DKjTYuY+PJfsNuWcwCVGA29s7mrJPRzB0amP2L5inma27eE3kk7eK1jzULW1IsxrxjS+lr4XmWUUtEOsqJq75wBZS5RqJurw5eaIJ3PCiPwT+SLxYEapBR+2BoHAOMoEdiix/J2iSl2V50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPa0+001; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192EAC4CED0;
	Sun,  5 Jan 2025 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098000;
	bh=qW+WNsCk0k9TgZH5MNCkGmIc/dJmpaJSC3LUHheT+ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPa0+001B6vvuXa49Xwsaq4brW+IV8GTvWqFNsW68sbpQZGTbYbwxpmQECKXpFj3z
	 F528FJ03TuHU4BdpRLFgdlWWtDkriYSf2BC34L7KC5qNJmpu6CTMi8+vc9jPh5/nWs
	 s6GoNzbVzFU2Eiio4d4frHrg6weL1ZkXcB3VFxp/IdOae7sTJSaUwZE5HEc3wyLadn
	 CsWz3kIEgvaBYvSUP+54chcERndr8GHDuAFHsuBVyNrq8OaxfFhnTXeplJbrmdu1Pf
	 lzptEn4iEXe2vgo//FBCSDss1faWl7UzzOffCGn2Gv4DneenFUQf5fZOES6Ed7vEb3
	 W/fNzCdfKwMwQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 05/27] iio: proximity: sx9310: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:50 +0000
Message-ID: <20250105172613.1204781-6-jic23@kernel.org>
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
 drivers/iio/proximity/sx9310.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 0d7f0518d4fb..b60707eba39d 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -337,19 +337,26 @@ static int sx9310_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret;
 
 	if (chan->type != IIO_PROXIMITY)
 		return -EINVAL;
 
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
-			return sx9310_read_gain(data, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = sx9310_read_gain(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9310_read_samp_freq(data, val, val2);
 	default:
-- 
2.47.1


