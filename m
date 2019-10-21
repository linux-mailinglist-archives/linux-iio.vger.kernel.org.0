Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDDFDE434
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 07:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfJUFyP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 01:54:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41224 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfJUFyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 01:54:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so7692414pfh.8
        for <linux-iio@vger.kernel.org>; Sun, 20 Oct 2019 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AdBSi2rqFh7Vdpb3I3tVfeX5I0nWB5o7fC6PgNP0NjU=;
        b=Jfgl+xH0G/cVghEax9U0ejV4Qz+iIqyt7gM1hlBK0LFNFDRPnlVHyI4q3tT3DZ3qOL
         R9/5C2fJvS/BVkjKIgmmJEwKwteYO8/vzFminOt8z4RwgWXIxamA3ui+XRvzhewznDop
         M3MqA6XcKdlkewEmo6UhyRbtTr3WkBOWokoto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AdBSi2rqFh7Vdpb3I3tVfeX5I0nWB5o7fC6PgNP0NjU=;
        b=lyJIInfIiCd6kQ1NqNktkkugPyWs1kweyPqq5lhtxJGd6fpqBrkVzQf7zTvCQEuPK4
         L/cVBa6zyFc47gz9aDeLsB7CakLO1ImwoLMCIyt58JbIRxeOGOj+DA0dLfUF5HbcqBUM
         ue006Ql1U/clTEKiHPl0Vf9ec9uhkmDEYPz/tqD9Nzd6t/EY0EsSFWNFN/Y2QEjwpczx
         NKWKP/c0vCil7LngPM8+Nl4TGyRuVp5L32DsqXFTW1LG8fcGQqICDmnA/dx1c8Vu4Gti
         9RqXAxtVDUGUp814z2mr9mJI7O82FbbfhWZMMlvpEEQmNvjJiVpAxqKYytdDhXEm2KCX
         fW2g==
X-Gm-Message-State: APjAAAUKx0Uq4aFpZdFdJk0LlKBienbZu66YLWySyz5muoLLLMNIJ3w9
        CFN9QmaHX4+PeiyGJBOaChdmrg==
X-Google-Smtp-Source: APXvYqwUpQlnenFnhvRw/qIE5AaExdM9R6F2kRHa5O0ipwLqN8BtCpDqTHM0fETGit7+IYggXgyJjg==
X-Received: by 2002:a17:90a:bf8d:: with SMTP id d13mr27307999pjs.89.1571637254353;
        Sun, 20 Oct 2019 22:54:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id s141sm15976909pfs.13.2019.10.20.22.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:13 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 01/18] platform: chrome: Put docs with the code
Date:   Sun, 20 Oct 2019 22:53:46 -0700
Message-Id: <20191021055403.67849-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
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

