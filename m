Return-Path: <linux-iio+bounces-22206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967DFB18F73
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A40AA1BC0
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C324888A;
	Sat,  2 Aug 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRWTI39v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1B235047
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153147; cv=none; b=uI/hEkO9EYZgoK34mUs2CG6bUqhoXpt0926e6nJP8NohGRFxs8V/DExf705eRPWnWU5sCGXX4NfgLLnIhqpkiZFAJkmNMcvW1WT4+LjIsBX3i3T7frTJHTjBGOX69DjQDeh57jZwa4GgY6k1WZL1NowLprEPA9zJp7xIj34dqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153147; c=relaxed/simple;
	bh=JCWRSn1njYW7+7qgPea5gmUJ5Ak6qBCk3Qm6xzogczo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjcn8jl8FspBNXOGSQCWmmyBJMETfQAGqLakMPYSNg4XPgYHfuDkmGHbZq84oCZ+EebyeB8YbB6sXsTxkyDiQ+9aa/ZpNjkhRbQJAZ57P0rIMROe03DpKmFjjyuyLxh+o7/wXQvKppUB7UKpGS3I4Jh4gz7iLPavGSlFeHrJ1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRWTI39v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B828C4CEEF;
	Sat,  2 Aug 2025 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153147;
	bh=JCWRSn1njYW7+7qgPea5gmUJ5Ak6qBCk3Qm6xzogczo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRWTI39v/dk72dgFyo2nqPHnzKcWsoTsk4N3uYGoFn7OQRwRddzTqf2sUEBlaVEKZ
	 WxNuRlf/uykgYGJA1crwe+avtpIcl8mENBgyj+mi6vn3y2YKf3g7d7iiKPelaPiKEM
	 FaF5beA/Y63xPI1c3uTGfapm/j1M9BcF2005dF2dhMPZzaYHLbJIsc3phH4LkZFCXP
	 /9rH5ymzN84RszlETdF5XGy2FvxDcG3WYQQ8FCVyzS4npJHdueRW4+sWfuoD9+x4RS
	 0p1VBofRmrulpW/5VZdzhKTleo4Ddm74AeFcha5Wr0FvKS+TwxGxITmyRVfQDe8SLQ
	 Y30Y4Wew/rZZg==
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
Subject: [PATCH 08/16] iio: light: adjd_s311: Use iio_push_to_buffers_with_ts() to allow source size runtime check
Date: Sat,  2 Aug 2025 17:44:28 +0100
Message-ID: <20250802164436.515988-9-jic23@kernel.org>
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
 drivers/iio/light/adjd_s311.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index cf96e3dd8bc6..edb3d9dc8bed 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -54,10 +54,6 @@
 
 struct adjd_s311_data {
 	struct i2c_client *client;
-	struct {
-		s16 chans[4];
-		aligned_s64 ts;
-	} scan;
 };
 
 enum adjd_s311_channel_idx {
@@ -120,6 +116,10 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
 	struct adjd_s311_data *data = iio_priv(indio_dev);
 	s64 time_ns = iio_get_time_ns(indio_dev);
 	int i, j = 0;
+	struct {
+		s16 chans[4];
+		aligned_s64 ts;
+	} scan = { };
 
 	int ret = adjd_s311_req_data(indio_dev);
 	if (ret < 0)
@@ -131,10 +131,10 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			goto done;
 
-		data->scan.chans[j++] = ret & ADJD_S311_DATA_MASK;
+		scan.chans[j++] = ret & ADJD_S311_DATA_MASK;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), time_ns);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.50.1


