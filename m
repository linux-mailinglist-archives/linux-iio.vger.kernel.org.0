Return-Path: <linux-iio+bounces-6650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3410F911428
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 23:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FE51C20DE8
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73923A1CD;
	Thu, 20 Jun 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXF2LTuG"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECF80C03
	for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2024 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918004; cv=none; b=ZgF9qbv/elztqgL7Ec922Afu5MAKmEBjCcGqDVcp7R7rVZrpGHh3PmapDKKAiDmkv6D8TFo7vDBrRnojgnEiEmWHfgBrqXk2EQ2HbUm8h5FDh16pN9u3gVuKmhOL7Ngt+MFZSbLuv2/tJMZL5V6UEFUgAt8Qr7mlp1RxE47m6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918004; c=relaxed/simple;
	bh=QyX6hFu5aH/3FUAeokgMlgJR6loneZVeGcpYw3d3hjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MjCutLphG8zQghxzz5el1PNMZycopNpZPbi/xrP8QKSoGI916HhKCJ8tIDIAHPT2CTsmPs/f1USc62Vv1LHFbgvgdrCmy5Oc0QrbY2Kgyx9RM/R0vo5i9thU++M1CEV8VBCYGgFDfKGS9ovTX7PxYgEtHeYEajZaGj/GgpeW4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qXF2LTuG; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jic23@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718917999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJIcJeul+qmKBv5T/OXvSe+kfJGIu3x5ZFUMxqYCCzU=;
	b=qXF2LTuGLu/At/rZdw/vJeZTGYTcaWqOxnclGreYhJvC23ZRu4yGMb17xFnRgKx3mXMUEn
	jlAAaVFZZ4bbURagj8JEuICJIQy04qJ/9aqPW82PCkBTcBGC+JZyCMajcMlm94+kAk1Uo1
	X/Yp5vs2QqkcRLQu/wvu7oED388MT5k=
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux@roeck-us.net
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/2] hwmon: iio: Add labels from IIO channels
Date: Thu, 20 Jun 2024 17:13:09 -0400
Message-Id: <20240620211310.820579-3-sean.anderson@linux.dev>
In-Reply-To: <20240620211310.820579-1-sean.anderson@linux.dev>
References: <20240620211310.820579-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add labels from IIO channels to our channels. This allows userspace to
display more meaningful names instead of "in0" or "temp5".

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/hwmon/iio_hwmon.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 4c8a80847891..588b64c18e63 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -33,6 +33,17 @@ struct iio_hwmon_state {
 	struct attribute **attrs;
 };
 
+static ssize_t iio_hwmon_read_label(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	struct iio_hwmon_state *state = dev_get_drvdata(dev);
+	struct iio_channel *chan = &state->channels[sattr->index];
+
+	return iio_read_channel_label(chan, buf);
+}
+
 /*
  * Assumes that IIO and hwmon operate in the same base units.
  * This is supposed to be true, but needs verification for
@@ -90,12 +101,12 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 
 	st->channels = channels;
 
-	/* count how many attributes we have */
+	/* count how many channels we have */
 	while (st->channels[st->num_channels].indio_dev)
 		st->num_channels++;
 
 	st->attrs = devm_kcalloc(dev,
-				 st->num_channels + 1, sizeof(*st->attrs),
+				 2 * st->num_channels + 1, sizeof(*st->attrs),
 				 GFP_KERNEL);
 	if (st->attrs == NULL)
 		return -ENOMEM;
@@ -147,7 +158,23 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		a->dev_attr.show = iio_hwmon_read_val;
 		a->dev_attr.attr.mode = 0444;
 		a->index = i;
-		st->attrs[i] = &a->dev_attr.attr;
+		st->attrs[2 * i] = &a->dev_attr.attr;
+
+		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
+		if (a == NULL)
+			return -ENOMEM;
+
+		sysfs_attr_init(&a->dev_attr.attr);
+		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
+						       "%s%d_label",
+						       prefix, n);
+		if (!a->dev_attr.attr.name)
+			return -ENOMEM;
+
+		a->dev_attr.show = iio_hwmon_read_label;
+		a->dev_attr.attr.mode = 0444;
+		a->index = i;
+		st->attrs[2 * i + 1] = &a->dev_attr.attr;
 	}
 
 	st->attr_group.attrs = st->attrs;
-- 
2.35.1.1320.gc452695387.dirty


