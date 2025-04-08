Return-Path: <linux-iio+bounces-17827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE934A81164
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 18:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAD4423918
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B9254869;
	Tue,  8 Apr 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q+wZ29vu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147E254853
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127785; cv=none; b=SC8Yl/KJn0czJ82hc3mYqxVUzkbMKefNwSpeyRvx2YYK3df/Iu/nZVBjCfvayvcNaM6tWwtAuPK56i3qslYtcaRcJR+Cj2hZ0TQrv8h5A/L0fe6OX1kM48pdWv6BguPMwg4Gjhq35FcY54lrbst+MI310qhvWPtdlLq2ymDBThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127785; c=relaxed/simple;
	bh=+eXao014CZnAwhC+SM1Hq9YPL6wJDL2oazpBhbkQcaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeRowdaZSewEdR32YYR1CwsIMVgUDcna9aa9NLmxdJUVXh9ZhdcAjM4s5Ig5LsuYQqqhixuTjCCOgqnSjMCBja9iTWFzcYAaGvwqm1Zi4s5EeBpLfozXFnQorBOgljLuzrOTMU9Uj3JuBIAUq9IXKFRDDwGUcaSB2hiC6Ikux+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q+wZ29vu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso5635443b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744127782; x=1744732582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZUpULk8hennxfcny51FPWJJyNUQSuBx+DrAa2UJoac=;
        b=Q+wZ29vupB3saDutYfK+BZvmrh7kZuvPuHbTJ0aoZGCbBH96l4xTLTiKqCWM6JUMsv
         l9JoGy9/Hog2MUir6jN7Lip+mO/cJzfW9YqJqHkmQ/8SG1QOMq/9QkqoKlPaaWx36Q6h
         zg8T/c6/NIHCQJCIWSXohjOMUP/47dE2BdVAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127782; x=1744732582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZUpULk8hennxfcny51FPWJJyNUQSuBx+DrAa2UJoac=;
        b=QMepGJblFpFdHmenXWn60PGDj5++fDSEvv7i05L/NhD2ZT+oVGHBlGhlH5jBdvN+TL
         uVomWHVE4gOdVdR8RHlNnP1OjB1MF2X/BMdoqKso2B6GHhNLx7B3bGtFLIxpgsrZl84G
         7XcSOy1RX9IpbyWcn0aw4QPtzqLQHTWXukEMu48hH2RPTASl+qM2LEYqqxwqXrGmr/s4
         rmp2IRB/uhDkhAZvhO3yIiDJTeJj7f5ugXolU9aeV4XRUR2p3EzOpvvhYAJlB5wA6QsS
         jhzK0Y5BEEzrvzNLe/szQGvINgGnEoo7CWFm492Qb277ZHrW2bCpqyAQqubANOZ0veh3
         YX6Q==
X-Gm-Message-State: AOJu0YwZfvF3UhUbI1oQppSuKq/L8oYa5Q6VJLmnUKc8vtTIp8OufDJk
	YJCXu5MGQv0UdT+RdHaIbRdtEqog6v/mj7YFP+7gF/ROYiUjm5hjilQtMTJweQ==
X-Gm-Gg: ASbGnctgCiviXcxiTpN+h01gqVnJfXRSC15nMP4WCpw2AiINDelK/lkNTq9fw549haW
	tTlhsankcUMnr2wWzMytYkmmCq/SQXLEDuLED5g5R3Mu7LvVHGAsLdhcKYKL0F0U6XU+niEBUcQ
	Y6FqNBuCir6aQED59zC+Gmrr7vrubVk6aGK4GjKBruvuPoTKcqZkKdDBKUxyf/XPtojXePEgsgZ
	E8l4yH6rI3fuwVNxJsQtqdldUKhdKa0wqjm5LodQIPG7rzDpdSQuEn7pCmZU36kEJ1wxhxKv+uE
	AQZDQgdZRFu99QAJQSi1iZaUbmcwcQfwnBaqQg==
X-Google-Smtp-Source: AGHT+IHKOMlwlJBzUBH1cp/XU5mAvhv3qP5Kx5amf6dtB8HfkU2s+spaYD0qsczOSgsFuhNauPNiJg==
X-Received: by 2002:a05:6a00:2351:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-739e4be3c73mr23939938b3a.18.1744127782556;
        Tue, 08 Apr 2025 08:56:22 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:8551:1093:9956:f769])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d97d188dsm10734863b3a.7.2025.04.08.08.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 08:56:22 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: tzungbi@kernel.org,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] iio: cros_ec_sensors: Flush when changing the FIFO timeout
Date: Tue,  8 Apr 2025 08:56:19 -0700
Message-ID: <20250408155619.2169189-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <CAPUE2uuY=BaPFro5cQSmQg4JS1Z5J5aBL7XvqqAo-X=LR4be3Q@mail.gmail.com>
References: <CAPUE2uuY=BaPFro5cQSmQg4JS1Z5J5aBL7XvqqAo-X=LR4be3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

|hwfifo_timeout| is used by the EC firmware only when new samples are
available.
When the timeout changes, espcially when the new timeout is shorter than
the current one, send the samples waiting in the FIFO to the host.
Inline the call to transmit |hwfifo_timeout| value to the firmware.

Now flush when a sensor is suspended (ODR set to 0) as well.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v3:
- Fix error detection when setting the sensor frequency

Changes in v2:
- Fix sysfs attribute in commit message
- Indicated the function to send the content of the attribute is now
  inline.
- Improve error detection when setting the sensor frequency and flusing
  the FIFO.
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 50 ++++++++++++-------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b1abd6e16c4ba..67ffe88df7b23 100644
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
 
@@ -764,6 +766,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
  * @mask:	specifies which values to be requested
  *
  * Return:	the type of value returned by the device
+ *
+ * cmd_lock mutex held.
  */
 int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
@@ -836,6 +840,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
  * @mask:	specifies which values to write
  *
  * Return:	the type of value returned by the device
+ *
+ * cmd_lock mutex held.
  */
 int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
@@ -853,6 +859,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 		st->param.sensor_odr.roundup = 1;
 
 		ret = cros_ec_motion_send_host_cmd(st, 0);
+
+		/* Flush the FIFO in case we are stopping a sensor.
+		 * If the FIFO has just been emptied, pending samples will be
+		 * stuck until new samples are available. It will not happen
+		 * when all the sensors are stopped.
+		 */
+		if (ret == 0 && frequency == 0) {
+			st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
+			ret = cros_ec_motion_send_host_cmd(st, 0);
+		}
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.49.0.504.g3bcea36a83-goog


