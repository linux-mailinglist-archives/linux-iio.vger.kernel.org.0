Return-Path: <linux-iio+bounces-8119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E650943BE6
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 02:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9401F222E8
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 00:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF31A2C14;
	Thu,  1 Aug 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFeOk97A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DF1A2C03;
	Thu,  1 Aug 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471322; cv=none; b=nYABnMnwH2AuqQ4ZwEzPiO8WdBwPRhTUAE4qIHTrR2k+QnctlWqHybuuaZwAK1EXMEudU1/zbVf1fZkzqhbthIOs8w+9gFwcpTCSNBOeZXc0I3aj0gtAiShXEkayTAoTGZU+AGm2sFsTEmCgsYsWgkGFZpL/n2f2sqlLIYZuO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471322; c=relaxed/simple;
	bh=v7SxaHk712SJkQcxYXR/E/V6XPOirmkRolJHxkrNSJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2M3hztofw3sWZGcOdDl/MKWu8g9mIX8cmYSGtv1KuoQTxnf2Jt58AOQPfNO4em0gW0vLLh0x0Vra1++gLBuSoMR/mIKMNTa1wABM082wYVsOOjp1L3bcKNnb2+VhrhM57BrWlLcHtHSmiwP4DSeU40R0WdZ+OssSFxgLibwbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFeOk97A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1B5C4AF0C;
	Thu,  1 Aug 2024 00:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471322;
	bh=v7SxaHk712SJkQcxYXR/E/V6XPOirmkRolJHxkrNSJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFeOk97AO/XcM+8bpnfmNGRVUpwEI+iFtTDrlD9WrOGXNcSGjSHKXgZcr4rRBkoEJ
	 vfMPSdltcUAzwZnlzdhmtS07BC79gmceA83SoUEUwORR05SH7VV1zbEvXS5Jo/1/4C
	 B5h7hDLDa9iBgoZORy6cMTVSHqLb0ui5xUJ5MC5sKov7CYdCodAVOB/BxB4wL0h9Wu
	 3aMfqCktHSW8Wf474+YqmIyBtAdd0miH6IenIvFO73J/Tcr4XVDaqhEWbq+zqGxMC8
	 vSeWYLvIzLXQE+b+O60bKCIzEFSOBC/eo8oy7pno8ZTx1AKzdpzKhkWtWmwQ4bqd4z
	 NHXqQfwFO4lYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julien Stephan <jstephan@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 073/121] driver: iio: add missing checks on iio_info's callback access
Date: Wed, 31 Jul 2024 20:00:11 -0400
Message-ID: <20240801000834.3930818-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index fa7cc051b4c49..2f185b3869495 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -758,9 +758,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
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
@@ -842,6 +844,9 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 	int length;
 	int type;
 
+	if (!indio_dev->info->read_avail)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_avail(indio_dev, this_attr->c,
 					  &vals, &type, &length,
 					  this_attr->address);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 910c1f14abd55..a64f8fbac597e 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -285,6 +285,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (!indio_dev->info->write_event_config)
+		return -EINVAL;
+
 	ret = indio_dev->info->write_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), val);
@@ -300,6 +303,9 @@ static ssize_t iio_ev_state_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val;
 
+	if (!indio_dev->info->read_event_config)
+		return -EINVAL;
+
 	val = indio_dev->info->read_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr));
@@ -318,6 +324,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	int val, val2, val_arr[2];
 	int ret;
 
+	if (!indio_dev->info->read_event_value)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_event_value(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 485e6fc44a04c..39cf26d69d17a 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -543,6 +543,7 @@ EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 			    enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
 	int unused;
 	int vals[INDIO_MAX_RAW_ELEMENTS];
 	int ret;
@@ -554,15 +555,18 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
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
@@ -750,11 +754,15 @@ static int iio_channel_read_avail(struct iio_channel *chan,
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
@@ -917,8 +925,12 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
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


