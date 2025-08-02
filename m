Return-Path: <linux-iio+bounces-22211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42A7B18F78
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26300169073
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839924A06E;
	Sat,  2 Aug 2025 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo1xOMTB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC882264D6
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153179; cv=none; b=b2b2J3OTJgsSlqmLDkCTG1GXX4vqwbHoRiBimiEavdPMzVgP8OyD2MBkvzk2FXKa6sj9tPR7yBOUIdjLGyp6btT1Nv6BrpPzraY2HquAbO5ni+2JHKhaT1WKaqw5Cazxs2LRgiAGhJ2Hexs6Yg7xuQz1MqSZxyoyEdlN5k+2Q4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153179; c=relaxed/simple;
	bh=iJp+pWgmbuTD/+m8MqFnMnndXtCdWMTbLvtAn2R/Pco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAX3l6TWyI8pb5ufPStroazNUC7ccK6xdM+nCeQpoVjZp1jbcPdK3RGNwKWM0RmRP8lbzZDm3iuENXQR0OVBJ20LKGzoGMwziIqKFe7XxhO1jdjxLrRlSMMP+T90qZ/b5Tr4xI39Q35UGYd6FMqIb5pQO9jxCwxQdv1IsOR72JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo1xOMTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C26C4CEEF;
	Sat,  2 Aug 2025 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153178;
	bh=iJp+pWgmbuTD/+m8MqFnMnndXtCdWMTbLvtAn2R/Pco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jo1xOMTBI/+8few2lu1ZeOxMP8HQnEfD7wS3/jXgq5nfh2XsP80WpKRpYF/9p3T/u
	 8f587dpVFKSBNZatHB+LB4M16DwI8YJCpaTF6hF/FnrIGv4j5wrivpMcUCZ6Rfz5Fy
	 5wb14bF5IrI+jjPrDs/w3LUn149IhiLZbk6cpnf2k4itOZ17yEhzdOjAXxoyz3IJfZ
	 /ZmjsoUQPIhpPr9Q6hVe6ftrzVOBZrdAlvYyF/Q1HDitI9ewvUHefpzfBO71QUOAxx
	 NdZy1bod0FUq3rBZLZAXShi6fgyPhf8s6hdOLxPZLuHms6W61CvZ/Zdw8xCt2xoASk
	 iyNeMx2uba4Sw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/16] iio: light: tcs3472: Use iio_push_to_buffers_with_ts() to allow source size runtime check
Date: Sat,  2 Aug 2025 17:44:33 +0100
Message-ID: <20250802164436.515988-14-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also move the structure used as the source to the stack as it is only 16
bytes and not the target of an DMA or similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/tcs3472.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 0f8bf8503edd..12429a3261b3 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -64,11 +64,6 @@ struct tcs3472_data {
 	u8 control;
 	u8 atime;
 	u8 apers;
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		u16 chans[4];
-		aligned_s64 timestamp;
-	} scan;
 };
 
 static const struct iio_event_spec tcs3472_events[] = {
@@ -377,6 +372,11 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct tcs3472_data *data = iio_priv(indio_dev);
 	int i, j = 0;
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u16 chans[4];
+		aligned_s64 timestamp;
+	} scan = { };
 
 	int ret = tcs3472_req_data(data);
 	if (ret < 0)
@@ -388,10 +388,10 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			goto done;
 
-		data->scan.chans[j++] = ret;
+		scan.chans[j++] = ret;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 		iio_get_time_ns(indio_dev));
 
 done:
-- 
2.50.1


