Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A68E6A0B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJ0XJx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:09:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33547 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfJ0XJx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:09:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id u23so5398551pgo.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O1ipQiwumySfkNGyRlavhekR6KjriM/Phe3P4L2VMow=;
        b=JCrOmjMsalq//LxyUrAPu95FjjPapJE6UGWfSxrXbX+5h1af6+siQyXTjMUEy/qYac
         Px+S54wG09qnuHywV6oMdSDBmg12/glfMXL9+QR1hBR9W6zyehxVTQz81TTHH3OWilOg
         uy2yjyIFxwNtQWYXegr2zcB4hRWXeVUjEdFV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1ipQiwumySfkNGyRlavhekR6KjriM/Phe3P4L2VMow=;
        b=pIDqt8wfaMi6JqXKdvebRPyZ+llVzWR64CItwIpa3/A0Zigeftx9EjSP/2P+ja57O9
         491CMoUxEYSiaVYdALuRNedE5Ad44PmNvJayCfaTmp7T3GUFf9CsRxU2Lkehg9M+vvg0
         6wUyMvBpmTXoauMiufuOADZ4do9yM/booF0cKzxVUKjBvsxxi989AZnjSrRyBX3FKg2m
         u1hpm+dhPsXDWZesP5EN3sOtirayjPiJJj5KUPmf9VE+JW/UTI68SYHNleI40K9ByNPZ
         hk6bqtdUq/XTNXbPuNGNe2n5JHZLUW7PWIYoKwoxwWnaBf57te7doKCAT9gzaqw+/1Ja
         coDQ==
X-Gm-Message-State: APjAAAUTckKwH4ig4UHswqnziTB6B7wG/YKmHygi/zU0pWXHdpBCScJw
        vNhc7DiP/xVLWT+qp9WbU460Gg==
X-Google-Smtp-Source: APXvYqy+GuiwOrcm27S0lN54gS3FgGV0UBA10c4NURWgTuekpcG0liWBL0nYaGcD2DCYV2A4p5vIbQ==
X-Received: by 2002:a63:3c19:: with SMTP id j25mr18084131pga.12.1572217790697;
        Sun, 27 Oct 2019 16:09:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p3sm8567870pgp.41.2019.10.27.16.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:09:50 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 01/18] platform: chrome: Put docs with the code
Date:   Sun, 27 Oct 2019 16:09:04 -0700
Message-Id: <20191027230921.205251-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To avoid doc rot, put function documentations with code, not header.
Use kernel-doc style comments for exported functions.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v3.
New in v2.

 drivers/platform/chrome/cros_ec.c           |  33 +++++++
 drivers/platform/chrome/cros_ec_proto.c     |  70 +++++++++++++
 include/linux/platform_data/cros_ec_proto.h | 103 --------------------
 3 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index fd77e6fa74c2c..9b2d07422e175 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -104,6 +104,15 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	return ret;
 }
 
+/**
+ * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
+ * @ec_dev: Device to register.
+ *
+ * Before calling this, allocate a pointer to a new device and then fill
+ * in all the fields up to the --private-- marker.
+ *
+ * Return: 0 on success or negative error code.
+ */
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
@@ -198,6 +207,14 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 }
 EXPORT_SYMBOL(cros_ec_register);
 
+/**
+ * cros_ec_unregister() - Remove a ChromeOS EC.
+ * @ec_dev: Device to unregister.
+ *
+ * Call this to deregister a ChromeOS EC, then clean up any private data.
+ *
+ * Return: 0 on success or negative error code.
+ */
 int cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
 	if (ec_dev->pd)
@@ -209,6 +226,14 @@ int cros_ec_unregister(struct cros_ec_device *ec_dev)
 EXPORT_SYMBOL(cros_ec_unregister);
 
 #ifdef CONFIG_PM_SLEEP
+/**
+ * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend event.
+ *
+ * Return: 0 on success or negative error code.
+ */
 int cros_ec_suspend(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
@@ -243,6 +268,14 @@ static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 					     1, ec_dev);
 }
 
+/**
+ * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume event.
+ *
+ * Return: 0 on success or negative error code.
+ */
 int cros_ec_resume(struct cros_ec_device *ec_dev)
 {
 	int ret;
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index f659f96bda128..7db58771ec77c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -117,6 +117,17 @@ static int send_command(struct cros_ec_device *ec_dev,
 	return ret;
 }
 
+/**
+ * cros_ec_prepare_tx() - Prepare an outgoing message in the output buffer.
+ * @ec_dev: Device to register.
+ * @msg: Message to write.
+ *
+ * This is intended to be used by all ChromeOS EC drivers, but at present
+ * only SPI uses it. Once LPC uses the same protocol it can start using it.
+ * I2C could use it now, with a refactor of the existing code.
+ *
+ * Return: 0 on success or negative error code.
+ */
 int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 		       struct cros_ec_command *msg)
 {
@@ -141,6 +152,16 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_prepare_tx);
 
+/**
+ * cros_ec_check_result() - Check ec_msg->result.
+ * @ec_dev: EC device.
+ * @msg: Message to check.
+ *
+ * This is used by ChromeOS EC drivers to check the ec_msg->result for
+ * errors and to warn about them.
+ *
+ * Return: 0 on success or negative error code.
+ */
 int cros_ec_check_result(struct cros_ec_device *ec_dev,
 			 struct cros_ec_command *msg)
 {
@@ -326,6 +347,13 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
 	return ret;
 }
 
+/**
+ * cros_ec_query_all() -  Query the protocol version supported by the
+ *         ChromeOS EC.
+ * @ec_dev: Device to register.
+ *
+ * Return: 0 on success or negative error code.
+ */
 int cros_ec_query_all(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
@@ -453,6 +481,16 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 }
 EXPORT_SYMBOL(cros_ec_query_all);
 
+/**
+ * cros_ec_cmd_xfer() - Send a command to the ChromeOS EC.
+ * @ec_dev: EC device.
+ * @msg: Message to write.
+ *
+ * Call this to send a command to the ChromeOS EC.  This should be used
+ * instead of calling the EC's cmd_xfer() callback directly.
+ *
+ * Return: 0 on success or negative error code.
+ */
 int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 		     struct cros_ec_command *msg)
 {
@@ -500,6 +538,18 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
+/**
+ * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
+ * @ec_dev: EC device.
+ * @msg: Message to write.
+ *
+ * This function is identical to cros_ec_cmd_xfer, except it returns success
+ * status only if both the command was transmitted successfully and the EC
+ * replied with success status. It's not necessary to check msg->result when
+ * using this function.
+ *
+ * Return: The number of bytes transferred on success or negative error code.
+ */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
 {
@@ -584,6 +634,16 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
 	return ec_dev->event_size;
 }
 
+/**
+ * cros_ec_get_next_event() - Fetch next event from the ChromeOS EC.
+ * @ec_dev: Device to fetch event from.
+ * @wake_event: Pointer to a bool set to true upon return if the event might be
+ *              treated as a wake event. Ignored if null.
+ *
+ * Return: negative error code on errors; 0 for no data; or else number of
+ * bytes received (i.e., an event was retrieved successfully). Event types are
+ * written out to @ec_dev->event_data.event_type on success.
+ */
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 {
 	u8 event_type;
@@ -628,6 +688,16 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 }
 EXPORT_SYMBOL(cros_ec_get_next_event);
 
+/**
+ * cros_ec_get_host_event() - Return a mask of event set by the ChromeOS EC.
+ * @ec_dev: Device to fetch event from.
+ *
+ * When MKBP is supported, when the EC raises an interrupt, we collect the
+ * events raised and call the functions in the ec notifier. This function
+ * is a helper to know which events are raised.
+ *
+ * Return: 0 on error or non-zero bitmask of one or more EC_HOST_EVENT_*.
+ */
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 {
 	u32 host_event;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index eab7036cda090..0d4e4aaed37af 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -187,133 +187,30 @@ struct cros_ec_platform {
 	u16 cmd_offset;
 };
 
-/**
- * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
- * @ec_dev: Device to suspend.
- *
- * This can be called by drivers to handle a suspend event.
- *
- * Return: 0 on success or negative error code.
- */
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
 
-/**
- * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
- * @ec_dev: Device to resume.
- *
- * This can be called by drivers to handle a resume event.
- *
- * Return: 0 on success or negative error code.
- */
 int cros_ec_resume(struct cros_ec_device *ec_dev);
 
-/**
- * cros_ec_prepare_tx() - Prepare an outgoing message in the output buffer.
- * @ec_dev: Device to register.
- * @msg: Message to write.
- *
- * This is intended to be used by all ChromeOS EC drivers, but at present
- * only SPI uses it. Once LPC uses the same protocol it can start using it.
- * I2C could use it now, with a refactor of the existing code.
- *
- * Return: 0 on success or negative error code.
- */
 int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 		       struct cros_ec_command *msg);
 
-/**
- * cros_ec_check_result() - Check ec_msg->result.
- * @ec_dev: EC device.
- * @msg: Message to check.
- *
- * This is used by ChromeOS EC drivers to check the ec_msg->result for
- * errors and to warn about them.
- *
- * Return: 0 on success or negative error code.
- */
 int cros_ec_check_result(struct cros_ec_device *ec_dev,
 			 struct cros_ec_command *msg);
 
-/**
- * cros_ec_cmd_xfer() - Send a command to the ChromeOS EC.
- * @ec_dev: EC device.
- * @msg: Message to write.
- *
- * Call this to send a command to the ChromeOS EC.  This should be used
- * instead of calling the EC's cmd_xfer() callback directly.
- *
- * Return: 0 on success or negative error code.
- */
 int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 		     struct cros_ec_command *msg);
 
-/**
- * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
- * @ec_dev: EC device.
- * @msg: Message to write.
- *
- * This function is identical to cros_ec_cmd_xfer, except it returns success
- * status only if both the command was transmitted successfully and the EC
- * replied with success status. It's not necessary to check msg->result when
- * using this function.
- *
- * Return: The number of bytes transferred on success or negative error code.
- */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg);
 
-/**
- * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
- * @ec_dev: Device to register.
- *
- * Before calling this, allocate a pointer to a new device and then fill
- * in all the fields up to the --private-- marker.
- *
- * Return: 0 on success or negative error code.
- */
 int cros_ec_register(struct cros_ec_device *ec_dev);
 
-/**
- * cros_ec_unregister() - Remove a ChromeOS EC.
- * @ec_dev: Device to unregister.
- *
- * Call this to deregister a ChromeOS EC, then clean up any private data.
- *
- * Return: 0 on success or negative error code.
- */
 int cros_ec_unregister(struct cros_ec_device *ec_dev);
 
-/**
- * cros_ec_query_all() -  Query the protocol version supported by the
- *         ChromeOS EC.
- * @ec_dev: Device to register.
- *
- * Return: 0 on success or negative error code.
- */
 int cros_ec_query_all(struct cros_ec_device *ec_dev);
 
-/**
- * cros_ec_get_next_event() - Fetch next event from the ChromeOS EC.
- * @ec_dev: Device to fetch event from.
- * @wake_event: Pointer to a bool set to true upon return if the event might be
- *              treated as a wake event. Ignored if null.
- *
- * Return: negative error code on errors; 0 for no data; or else number of
- * bytes received (i.e., an event was retrieved successfully). Event types are
- * written out to @ec_dev->event_data.event_type on success.
- */
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
 
-/**
- * cros_ec_get_host_event() - Return a mask of event set by the ChromeOS EC.
- * @ec_dev: Device to fetch event from.
- *
- * When MKBP is supported, when the EC raises an interrupt, we collect the
- * events raised and call the functions in the ec notifier. This function
- * is a helper to know which events are raised.
- *
- * Return: 0 on error or non-zero bitmask of one or more EC_HOST_EVENT_*.
- */
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
 #endif /* __LINUX_CROS_EC_PROTO_H */
-- 
2.23.0.866.gb869b98d4c-goog

