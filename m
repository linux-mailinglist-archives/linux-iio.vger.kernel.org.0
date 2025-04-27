Return-Path: <linux-iio+bounces-18735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5914AA9E503
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AF8172BE9
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3FF200110;
	Sun, 27 Apr 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIB+o+oW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452112B73
	for <linux-iio@vger.kernel.org>; Sun, 27 Apr 2025 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745792571; cv=none; b=Qrg1Fm9Ong3hNN7ALm+/WowoTEGFRY9PV2o0O8ogjBVVETEUGRBqDuLJ18GLogcvDQWGkSqT3lMgRySvebrcqfsL83VmH8lZVvPqZF7EUBNVHhq27lxHgCZ7g0E0vLKAnR2DOVmMjMhDJZ3RLWI8cgkAPiK9yqYjVX+8r7lWGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745792571; c=relaxed/simple;
	bh=5RmU8CEJJI9W0qQ4DW8t5xzQaJgWvMkGLqHLbSmODb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfFFo+ez5C6eWqoTWl6VBmIpuK5ZXUDMhMdkyXmsfrs+082UlgPXXxsZw3S2v1TIE2AYmi3hyou2YsDjdAYxve3S8ftfFPfjnhmViXYjIg/9IakKiXiniFHfYSJOrWCwVgEvlIY6stOdtOCgVm0WsjAYxjgYjwrZZxdhOUSk9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIB+o+oW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c3407a87aso61708605ad.3
        for <linux-iio@vger.kernel.org>; Sun, 27 Apr 2025 15:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745792569; x=1746397369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8owcUOlrgop1sr2+9fce/JSbAixSg1S+2jK0R+SwX9U=;
        b=nIB+o+oWzExtRJXrhr1kbpyKKzcp2HMeBgr8rEhZ1qGobwmKO7kwm0IEzsgyydJCE+
         OK4GWoM+nI6rO1m4kuMZEOMp7fYuQSsfjJeugcL1oQGF1pxQ75ga4xwWUACqmdWrpWMo
         zZgFJGPxKMssNRuGeqo9WtHEZ24fM7aOUtbIuHschdLGMJA9wZINzEUpGCOoE8NlwNSC
         Qd8DgCqGscV1k5+vuszJMBHvEgyag2XYfijiabbomGu4WgPznJOUAWxf7Ms/QWzmrzFL
         89+ab9c+YFIw3ieC3UtWI55fY0Y6SXgg7wusZqNSz13gRGdRKSBNxtGENqKDGyFSk3+f
         Hg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745792569; x=1746397369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8owcUOlrgop1sr2+9fce/JSbAixSg1S+2jK0R+SwX9U=;
        b=PwVd7iRe/MV26UpNZ0+ngfFfTl6HLx4TzFkA9s+LygxyWXF+sliFkZea6bKYvfX6JE
         IPn7oZEZUF5OLGkU5CI50XHD4XAWrKSoH9XAXPv3u5PCOZkWF0LvRFjd86ZTT2sQa3qk
         RT3SPUou10pYFbn4iglD9W88OYDECP+6YC999zU4snptkHUhcbEZ1DAlHUOhfcNytunD
         hMI3ci2XZe08hpDYH/956V2ATsp0n01r5zFdUcwO583zeRU6lraIuzFxXVoh0j0KVhZm
         VEWFlFLEAYcjWWwUxWZdlYK8OAnB4hNiNfQ/3iyPzjUAerjCp8bxG++zal5zNmg2na/d
         Spiw==
X-Gm-Message-State: AOJu0Ywq12UQYU40Mzr8H5wmkh+rQa53PnY5ISzfTGy4k2jg3axiu5YV
	+9LRugudPmoP3VEP1FTMLkK44Hh7f1E3N8ziTDOi667MKWzlsOyL
X-Gm-Gg: ASbGncvkEBEIXZj3V/sbkpDdNmXwOX3BV/uKDVz9BkdZAAXDQtqG2lGOskD6IgQsw5H
	nO4lGisRn3P0lfk9oQ5fU9MzUdEA+3vNsvip3MbC9/eymOt9EPuo5UdT5vOUmHjCOZMAFNQWZhp
	m+t3gz5Gu5m6v6ysyeJuJA/GJJfgn45UsgsysMc9a6oTzC+Af+nN89AxOQihjgyu2wSmM4l1fnN
	KLbtXuDqfbWv6ecwYOICKJyWcum7leIdLtoeAy9Gk5MWxJ/UN5AYxKUsKGhp6+3Yy+de84DchAY
	dq24ftyd6Ul/hzjymrwiCTNOKakZ152BriVi7f/II/ugRkKz/DAhK/mv5E9Z
X-Google-Smtp-Source: AGHT+IFWbAOPu15nQigiBQFVQ+o69gmR47TuWoXEjHfKIISO5x4ZBK3QKVvYm+v97UT823hXNJ3uYw==
X-Received: by 2002:a17:903:8c5:b0:227:e74a:a05a with SMTP id d9443c01a7336-22dbf740429mr166516185ad.44.1745792568787;
        Sun, 27 Apr 2025 15:22:48 -0700 (PDT)
Received: from homelab.localdomain ([2804:1b3:ae41:a039:6e39:a76b:403b:6b8c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7fb7e54sm6022638a12.30.2025.04.27.15.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 15:22:48 -0700 (PDT)
From: Lucas Sobrinho <lucasmsobrinho@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	filipetressmann@usp.br,
	davidbtadokoro@usp.br,
	paulormm@ime.usp.br,
	Lucas Sobrinho <lucasmsobrinho@gmail.com>
Subject: [PATCH] iio: adc: ti-ads124s08: Add direct mode protection and refactor read channel logic
Date: Sun, 27 Apr 2025 19:22:34 -0300
Message-ID: <20250427222234.126285-1-lucasmsobrinho@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a call to iio_device_claim_direct() in the ads124s_read_raw() function
to ensure exclusive access to the device during direct mode reads.

Also refactor the channel read logic into a separate function.

Signed-off-by: Lucas Sobrinho <lucasmsobrinho@gmail.com>
Co-developed-by: Filipe Tressmann Velozo <filipetressmann@usp.br>
Signed-off-by: Filipe Tressmann Velozo <filipetressmann@usp.br>
---
 drivers/iio/adc/ti-ads124s08.c | 85 ++++++++++++++++------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 8ea1269f7..e1efe8865 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -219,6 +219,40 @@ static int ads124s_read(struct iio_dev *indio_dev)
 	return get_unaligned_be24(&priv->data[2]);
 }
 
+static int  ads124s_read_channel(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val)
+{
+	int ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX, chan);
+
+	if (ret) {
+		dev_err(&priv->spi->dev, "Set ADC CH failed\n");
+		return ret;
+	}
+
+	ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
+	if (ret) {
+		dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
+		return ret;
+	}
+
+	ret = ads124s_read(indio_dev);
+	if (ret < 0) {
+		dev_err(&priv->spi->dev, "Read ADC failed\n");
+		return ret;
+	}
+
+	*val = ret;
+
+	ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
+	if (ret) {
+		dev_err(&priv->spi->dev, "Stop conversions failed\n");
+		return ret;
+	}
+
+	return IIO_VAL_INT;
+}
+
 static int ads124s_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long m)
@@ -226,44 +260,18 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
 	struct ads124s_private *priv = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&priv->lock);
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX,
-					chan->channel);
-		if (ret) {
-			dev_err(&priv->spi->dev, "Set ADC CH failed\n");
-			goto out;
-		}
-
-		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
-		if (ret) {
-			dev_err(&priv->spi->dev, "Start conversions failed\n");
-			goto out;
-		}
-
-		ret = ads124s_read(indio_dev);
-		if (ret < 0) {
-			dev_err(&priv->spi->dev, "Read ADC failed\n");
-			goto out;
-		}
-
-		*val = ret;
-
-		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
-		if (ret) {
-			dev_err(&priv->spi->dev, "Stop conversions failed\n");
-			goto out;
-		}
-
-		ret = IIO_VAL_INT;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ads124s_read_channel(indio_dev, chan->channel, val);
+		iio_device_release_direct(indio_dev);
 		break;
 	default:
 		ret = -EINVAL;
 		break;
 	}
-out:
-	mutex_unlock(&priv->lock);
 	return ret;
 }
 
@@ -280,20 +288,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 	int ret;
 
 	iio_for_each_active_channel(indio_dev, scan_index) {
-		ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX,
-					scan_index);
-		if (ret)
-			dev_err(&priv->spi->dev, "Set ADC CH failed\n");
-
-		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
-		if (ret)
-			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
-
-		priv->buffer[j] = ads124s_read(indio_dev);
-		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
-		if (ret)
-			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
-
+		ads124s_read_channel(indio_dev, chan->channel, &(priv->buffer[j]));
 		j++;
 	}
 
-- 
2.49.0


