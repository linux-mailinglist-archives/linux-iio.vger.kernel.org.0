Return-Path: <linux-iio+bounces-17484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24414A76C31
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EC016B1D1
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C579A215076;
	Mon, 31 Mar 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HeKuP6fe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF886337
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439721; cv=none; b=A9s6lhyTndpQgyZg1PZ+poyPDmOpfKvnPZ+J7nPxkvR33kNK1oLV9tsLRoJc3iWF9QOg9hX2VU4Aa04DPmRFjvt1k7fkhU/44UVZBQS6s/nXjM31/K+lNw/UBvlGI7m9HPcmkA+rtapTe5fQhHTpgl6q4XxvzHzyqQOyhBL5IV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439721; c=relaxed/simple;
	bh=/Ml7N2eC8DLx+ini9moz/rIqFI6r/eoVnw1iyxVjvKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S13STfiM9V7IPU0T+7cNoaIF7j6kIzeo5Vb78eIf+CrgRNzTT0y3r/8lXhWUuMjnciGu8ufMAOp9n8Bcxlu1KVdTfS2e5uxTnox5vs67t/k4xbTXAII19/JP+a7rvz7H0msSWKLY06FqpiHR5UjftwraCTWYARS157D2+8svoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HeKuP6fe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22438c356c8so91814325ad.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743439719; x=1744044519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt+KFlGVqPv32OaHgTtc6K8wA3HBhqq+sb6w5Nh3F8A=;
        b=HeKuP6feKSnhtyaLQ01GXETultNWDNnBd+TqgTIdaENmmigbecRdMGJML9Rtva5eEW
         GaaCRxp5siCOVPAD3oJS3VM3cTLgteKnDeqi6/WqrS8rEo6+yh6jLE9ZYJ95luvnXiGD
         lRD6XUBCS1lMDTbTWR5Iz0kAPbNteHBn135NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743439719; x=1744044519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt+KFlGVqPv32OaHgTtc6K8wA3HBhqq+sb6w5Nh3F8A=;
        b=VS4VRwfsYrA7ETLf4o4clE9a1Q4d7ZhK4vIgplKeff4/CptzZvc2avdESoPpyxALQJ
         4QYHfbcwIrhRtpZZLJT0pLCFGKA2MrsTCE2PQAEPsp7xchAvcYNkNtiG5lKsNGLj7kPC
         KzAQxRwdscZTzDPEOzS9MY38ISBy7S7aJyNe+ZruFee0YkZG0FYbktPwjFBcZ7GZcq+W
         9AVRIIUeHxrOYP9vOmDZ/D7VDtLKB74te49loFyl1L3R9rla2eh/FTg5w96es4xHxoJg
         6H5By0eiAltXgOplQPuNsewTRewBZew1xthXS6nXrO2SbHKVi7PCUPFms8C9Bl9FBwkM
         bazw==
X-Gm-Message-State: AOJu0YzJ3cIZagCZkhc4Q5ZoRVjv/5bIbIRvEQZAYJp7t3pyvB031KsB
	leU5OudN43Q9KcVm1N3TVni+XSsHtfqhaZHFwA1j3WI916bsPXqVmMSS09xMlQ==
X-Gm-Gg: ASbGncsHabaxo2p5+yTs+375ITNJyih+aLHExuLmG694qSnj8s7QPgT2+jlsZRIQrfH
	+rHGOi4jdaJWOcdaZdGIUEzlu9+/1zzPLzSZL06Q8sou4/RrW/EYzji71MYkuTxLDD90BzYtQ13
	w5EyW6T3SZcbBCa3RaHoI5BxInR0uqtUpd8Ed8xdXacgmEZWqhMiVHvtOtV2Yr/NeRj1TFBsp8R
	s/vhk7sysG64dHow9Br46e4hiQJqGNhtJNSZcFrjDXgym8+4NlDSA9o3DbGvprch1zUAN5ttudw
	nPpHkeV8SEpn1jHnyw2FOVRuATqFKmNOfPXEmA==
X-Google-Smtp-Source: AGHT+IET2IGY1bkBg5zL2SVho439a24OFmrzQ2RadOLGAwXRbRNSq7QM+dEU7zPM2lLyYAYrxvzCJQ==
X-Received: by 2002:a17:902:c943:b0:224:1005:7280 with SMTP id d9443c01a7336-2292f9ee0c0mr128471695ad.38.1743439719375;
        Mon, 31 Mar 2025 09:48:39 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9a21:5ba5:99d6:3daa])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec693esm71337745ad.31.2025.03.31.09.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 09:48:38 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] drivers: iio: cros_ec_sensors: Flush changing the FIFO timeout
Date: Mon, 31 Mar 2025 09:48:32 -0700
Message-ID: <20250331164832.4039379-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fifo_timeout is used by the EC firmware only when a new sample is
available.
When the timeout changes, espcially when the new timeout is shorter than
the current one, we need to send the samples waiting in the FIFO to the
host.
We also need to flush when a sensor is suspended (ODR set to 0).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 51 ++++++++++++-------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b1abd6e16c4ba..4486c7e1e5b42 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -103,22 +103,6 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 	}
 }
 
-static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
-				      int rate)
-{
-	int ret;
-
-	if (rate > U16_MAX)
-		rate = U16_MAX;
-
-	mutex_lock(&st->cmd_lock);
-	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-	st->param.ec_rate.data = rate;
-	ret = cros_ec_motion_send_host_cmd(st, 0);
-	mutex_unlock(&st->cmd_lock);
-	return ret;
-}
-
 static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 						 struct device_attribute *attr,
 						 const char *buf, size_t len)
@@ -134,7 +118,25 @@ static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 
 	/* EC rate is in ms. */
 	latency = integer * 1000 + fract / 1000;
-	ret = cros_ec_sensor_set_ec_rate(st, latency);
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
+	st->param.ec_rate.data = min(U16_MAX, latency);
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	mutex_unlock(&st->cmd_lock);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Flush samples currently in the FIFO, especially when the new latency
+	 * is shorter than the old one: new timeout value is only considered when
+	 * there is a new sample available. It can take a while for a slow
+	 * sensor.
+	 */
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	mutex_unlock(&st->cmd_lock);
 	if (ret < 0)
 		return ret;
 
@@ -152,7 +154,6 @@ static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
 	mutex_lock(&st->cmd_lock);
 	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
 	st->param.ec_rate.data = EC_MOTION_SENSE_NO_VALUE;
-
 	ret = cros_ec_motion_send_host_cmd(st, 0);
 	latency = st->resp->ec_rate.ret;
 	mutex_unlock(&st->cmd_lock);
@@ -764,6 +765,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
  * @mask:	specifies which values to be requested
  *
  * Return:	the type of value returned by the device
+ *
+ * cmd_lock mutex held.
  */
 int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
@@ -836,6 +839,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
  * @mask:	specifies which values to write
  *
  * Return:	the type of value returned by the device
+ *
+ * cmd_lock mutex held.
  */
 int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
@@ -853,6 +858,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 		st->param.sensor_odr.roundup = 1;
 
 		ret = cros_ec_motion_send_host_cmd(st, 0);
+
+		/* Flush the FIFO in case we are stopping a sensor.
+		 * If the FIFO has just been emptied, pending samples will be
+		 * stuck until new samples are available. It will not happen
+		 * when all the sensors are stopped.
+		 */
+		if (frequency == 0) {
+			st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
+			cros_ec_motion_send_host_cmd(st, 0);
+		}
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.49.0.472.ge94155a9ec-goog


