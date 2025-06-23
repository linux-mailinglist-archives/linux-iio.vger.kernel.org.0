Return-Path: <linux-iio+bounces-20919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1383AE4D1C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 20:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607FA188AFD0
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155552DA774;
	Mon, 23 Jun 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MB7VKAGB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF882DA778
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704509; cv=none; b=L6w6qG5gT+nQuyRZC3xw+91h6w2QeORSv09YenBHGXF/rf6weYempV33UaOP0/kZMc/DDXaR9n7Jsh7lsHx3HISrZjez73+fwdQ5wN0sMDu2yA6c901fipjM87Jdl+CdBQKQ6M5dt0Wh4AXBMnDZ23hJjefyUFmBAqaPT0a4gPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704509; c=relaxed/simple;
	bh=LLwRt3RaRane+6N3CHDP0Q9kH2XKVAh9bRyCZmE9jCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNW3U0bktT3Ah+zsw3h3Wto3BCuIGfTOhYhq1H6Ge/TbXnFMMrRrztVbfSDfPUwKNpIU0eP6tReGu69VtwlEoHtx8Q/3OJZHavLeAFqjNZ6mm3Q26cFrPbgdytnH6m7SoWlMfyDYvj9NlvII5wy3KrwhrfLKZ5J3TP4+gm9AOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MB7VKAGB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3620567b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750704507; x=1751309307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+bqk1+26/9FCspe37TDRAgsJwv18cHjS1QszjhZbVU=;
        b=MB7VKAGB/hoHllUoPm/lmKqEYyFpy+U3RBtEGZCy2YGsDFuVHdyrqXqcKjwMQ/YE0g
         cgRwGELEyn0pE7vi3KbKWH70eSEgSmIyVDX8AjoRuVpPdtb/OFY7nA6YtZ+RO05dA06A
         URelyyOw8esQRXLNLtvZI0jhu2PmtcPutfMWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704507; x=1751309307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+bqk1+26/9FCspe37TDRAgsJwv18cHjS1QszjhZbVU=;
        b=CrA9JIgG9tg0phikiFbbGtta/mVxoWmFmaOWv3aL4cIyG+QyyzgOPym4/HDbluCL5c
         5/MhN9/OWU91Uc/OJyOwxfMZMaqUOIRJoKUSox4XuIF3aCCJdBLAu2ySMx0Z1u4zl50L
         qxcpX0p5o+sgHqMVYFiinuoi6oZ8eQDzofWFC2AfBzW2Llepxe6LRE9nZoVwM6NNt5kK
         NlycV00z8hCceIr2ekt8ijhLLe4kIvwdttC/gicNvB7KTekHG+SBP9KjuHiS8An5zQst
         HgxeJdJsljw2GOOaEhcqdKMBhygQ8TqVEpDNOX5MVkAw6wai5fkNNkeMe2Cb+ygB5B3R
         Gwcw==
X-Forwarded-Encrypted: i=1; AJvYcCV188lWZkLY31B3aMqwmsBLNDTDySpYsi9rM3+XalqIWYUFGyBFG9CTmlIomD+B/7R9lzLHw85uhw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTF+chn6G+1VQF/DHCheQ9iH++yIlIUzAA4G5x6UOsg8owjxdU
	/Uv8nKfjVPH7JBe8fUxN15+4kPvqbnqxB3isOS1t1PaUFOgUOXaxU3Zw0k8m1bSu7g==
X-Gm-Gg: ASbGncsZlMOkpc707Cs0FryWtZAQjTzJsY/dQRbAVY04rJPP2RrsEZFP0ndQqAziT13
	LLsGH9z9NKvxtNjY6qhJwamk/hmdph/QbFp5dxJJOufusPXv9RylEdznoOvPSq/yoOf3tSeWUst
	u3+AeT4SDu01j3xazxjXwdHNN/rNaN7mzq9Gdx5YCFMxyVb44c8lOlWAl99ZrE77TyZ+MwwSBJ3
	zwTeKi8H0GeFgjJdE2sYQuiftWJnXFQxKfNlqm6v+2IGOUlBLXSnfX2i8TXYcsUG9be7vKQAgCs
	PFaolYAorjcPJrLSS9/7Eh8XUByB/FvvmGWCYsNYrajsMNKqRCMqEok=
X-Google-Smtp-Source: AGHT+IEBW8vhbGRA0B/WYZz/fI1RO+gEzOmya7yuE3RqOdoNmQmjVm4YPCITJeXY/ybPnWz1wZtOnw==
X-Received: by 2002:a05:6a00:85aa:b0:742:ccf9:317a with SMTP id d2e1a72fcca58-74955dee5b4mr758603b3a.12.1750704507564;
        Mon, 23 Jun 2025 11:48:27 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:eabe:52f4:36e6:5c0d])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74933e6d117sm4625425b3a.53.2025.06.23.11.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 11:48:26 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
X-Google-Original-From: Gwendal Grignou <gwendal@google.com>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] drivers: iio: cros_ec_sensors: Flush changing the FIFO timeout
Date: Mon, 23 Jun 2025 11:48:17 -0700
Message-ID: <20250623184817.220409-1-gwendal@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gwendal Grignou <gwendal@chromium.org>

fifo_timeout is used by the EC firmware only when a new sample is
available.
When the timeout changes, espcially when the new timeout is shorter than
the current one, we need to send the samples waiting in the FIFO.

Change-Id: Iec40367472bd301123c22e38d0ad8aca4ed41379
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 51 ++++++++++++-------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index bd8483866d046..339faee6ab44b 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -105,22 +105,6 @@ static void get_default_min_max_freq(enum motionsensor_type type,
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
@@ -136,7 +120,25 @@ static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 
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
+	 * Flush samples currently in the FIFO, expecially when the new latency
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
 
@@ -154,7 +156,6 @@ static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
 	mutex_lock(&st->cmd_lock);
 	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
 	st->param.ec_rate.data = EC_MOTION_SENSE_NO_VALUE;
-
 	ret = cros_ec_motion_send_host_cmd(st, 0);
 	latency = st->resp->ec_rate.ret;
 	mutex_unlock(&st->cmd_lock);
@@ -769,6 +770,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
  * @mask:	specifies which values to be requested
  *
  * Return:	the type of value returned by the device
+ *
+ * cmd_lock mutex held.
  */
 int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
@@ -841,6 +844,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
  * @mask:	specifies which values to write
  *
  * Return:	the type of value returned by the device
+ *
+ * cmd_lock mutex held.
  */
 int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
@@ -858,6 +863,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
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


