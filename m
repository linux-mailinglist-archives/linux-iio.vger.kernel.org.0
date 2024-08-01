Return-Path: <linux-iio+bounces-8121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5C3943E5F
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 03:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E7EB2321A
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 01:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8151B1D2F44;
	Thu,  1 Aug 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBVS0VfJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F31194AEE;
	Thu,  1 Aug 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472229; cv=none; b=MKPANsNCmGQqC5Za8SMH+2K+pefE96TXbE+3b6/TaTQ88j+9zm7raXfLq/+IdpCFYuwR1L6H9L0otDwVYXCZTpeVfXLYPVIo6YKmVotrdl59S48jYShqIjec3gFo6uGsv2K6k4GuRYvWwYRztIsycxUEY8BW4p8/Z0dP+MAUiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472229; c=relaxed/simple;
	bh=baovRx1fK0tF22J69TB6TMJpO9uvez7P8Cp70gjGPl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb9x/TdHTzg1OQ0Q9SA3A/HFmD5MF2va6Zk7YDm65vtbQwirpwhPptuYxwtUV2RT0SUqufxvTTSH5haR06o3Gv3gkgHibqLzbVdpxkalk1VmKM5xCIhFLhlqDdoJYogdQGpuToJh8hVpNDnIWtYnRtdCUZ+5Jdlp/skMUI5mR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBVS0VfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BDCC4AF0E;
	Thu,  1 Aug 2024 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472228;
	bh=baovRx1fK0tF22J69TB6TMJpO9uvez7P8Cp70gjGPl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBVS0VfJrOHVMkGRINL1s2znKmDNyJEkl7LaiOx19LOJxfU6zv6jDO4zm9GByFNlC
	 BeDnPgI58A2jX2ClFbF/1uEKSoX/n9zTx2X0S9au7wjYdEKaaO8dV9XfydUp9LldD6
	 L/6hqFletgOjyRfcwTWxPrQlbjfG+Z4dNzDg7sdjFgSKZ4iyGCRmsL1CwB7rIIEBz/
	 fLo92ODWi/fQSDmBDsGzoy5SZNmDlusl6qkIjmS4ElDshRX5VFWicJThlezUI5P5Bf
	 tig7NrQ51+awJ5QpthHDE8HfDP19zgeH7N8hPQ2XPMvQ4QDm+XUpGVsLD83QUgftqQ
	 eZFTSJOwkp52Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julien Stephan <jstephan@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 38/61] driver: iio: add missing checks on iio_info's callback access
Date: Wed, 31 Jul 2024 20:25:56 -0400
Message-ID: <20240801002803.3935985-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Julien Stephan <jstephan@baylibre.com>

[ Upstream commit c4ec8dedca961db056ec85cb7ca8c9f7e2e92252 ]

Some callbacks from iio_info structure are accessed without any check, so
if a driver doesn't implement them trying to access the corresponding
sysfs entries produce a kernel oops such as:

[ 2203.527791] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when execute
[...]
[ 2203.783416] Call trace:
[ 2203.783429]  iio_read_channel_info_avail from dev_attr_show+0x18/0x48
[ 2203.789807]  dev_attr_show from sysfs_kf_seq_show+0x90/0x120
[ 2203.794181]  sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
[ 2203.798555]  seq_read_iter from vfs_read+0x238/0x2a0
[ 2203.802236]  vfs_read from ksys_read+0xa4/0xd4
[ 2203.805385]  ksys_read from ret_fast_syscall+0x0/0x54
[ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
[ 2203.812880] dfa0:                   00000003 b6f10f80 00000003 b6eab000 00020000 00000000
[ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 00000000 00020000 00000000
[ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
[ 2203.830363] Code: bad PC value
[ 2203.832695] ---[ end trace 0000000000000000 ]---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Link: https://lore.kernel.org/r/20240530-iio-core-fix-segfault-v3-1-8b7cd2a03773@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-core.c  |  7 ++++++-
 drivers/iio/industrialio-event.c |  9 +++++++++
 drivers/iio/inkern.c             | 32 ++++++++++++++++++++++----------
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 135a86fc94531..162845543efe0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -767,9 +767,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
 							INDIO_MAX_RAW_ELEMENTS,
 							vals, &val_len,
 							this_attr->address);
-	else
+	else if (indio_dev->info->read_raw)
 		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
 				    &vals[0], &vals[1], this_attr->address);
+	else
+		return -EINVAL;
 
 	if (ret < 0)
 		return ret;
@@ -851,6 +853,9 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 	int length;
 	int type;
 
+	if (!indio_dev->info->read_avail)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_avail(indio_dev, this_attr->c,
 					  &vals, &type, &length,
 					  this_attr->address);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 727e2ef66aa4b..14658b41c9bc6 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -283,6 +283,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (!indio_dev->info->write_event_config)
+		return -EINVAL;
+
 	ret = indio_dev->info->write_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), val);
@@ -298,6 +301,9 @@ static ssize_t iio_ev_state_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val;
 
+	if (!indio_dev->info->read_event_config)
+		return -EINVAL;
+
 	val = indio_dev->info->read_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr));
@@ -316,6 +322,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	int val, val2, val_arr[2];
 	int ret;
 
+	if (!indio_dev->info->read_event_value)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_event_value(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 872fd5c241476..bd854e92c6f8c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -561,6 +561,7 @@ EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 			    enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
 	int unused;
 	int vals[INDIO_MAX_RAW_ELEMENTS];
 	int ret;
@@ -572,15 +573,18 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	if (!iio_channel_has_info(chan->channel, info))
 		return -EINVAL;
 
-	if (chan->indio_dev->info->read_raw_multi) {
-		ret = chan->indio_dev->info->read_raw_multi(chan->indio_dev,
-					chan->channel, INDIO_MAX_RAW_ELEMENTS,
-					vals, &val_len, info);
+	if (iio_info->read_raw_multi) {
+		ret = iio_info->read_raw_multi(chan->indio_dev,
+					       chan->channel,
+					       INDIO_MAX_RAW_ELEMENTS,
+					       vals, &val_len, info);
 		*val = vals[0];
 		*val2 = vals[1];
+	} else if (iio_info->read_raw) {
+		ret = iio_info->read_raw(chan->indio_dev,
+					 chan->channel, val, val2, info);
 	} else {
-		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
-					chan->channel, val, val2, info);
+		return -EINVAL;
 	}
 
 	return ret;
@@ -800,11 +804,15 @@ static int iio_channel_read_avail(struct iio_channel *chan,
 				  const int **vals, int *type, int *length,
 				  enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
+
 	if (!iio_channel_has_available(chan->channel, info))
 		return -EINVAL;
 
-	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
-						 vals, type, length, info);
+	if (iio_info->read_avail)
+		return iio_info->read_avail(chan->indio_dev, chan->channel,
+					    vals, type, length, info);
+	return -EINVAL;
 }
 
 int iio_read_avail_channel_attribute(struct iio_channel *chan,
@@ -935,8 +943,12 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
 static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 			     enum iio_chan_info_enum info)
 {
-	return chan->indio_dev->info->write_raw(chan->indio_dev,
-						chan->channel, val, val2, info);
+	const struct iio_info *iio_info = chan->indio_dev->info;
+
+	if (iio_info->write_raw)
+		return iio_info->write_raw(chan->indio_dev,
+					   chan->channel, val, val2, info);
+	return -EINVAL;
 }
 
 int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
-- 
2.43.0


