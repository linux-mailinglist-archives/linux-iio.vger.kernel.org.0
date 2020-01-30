Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74D014E40D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2020 21:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgA3Ueq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jan 2020 15:34:46 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51161 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgA3Ueq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jan 2020 15:34:46 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so1848039pjb.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2020 12:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNvy6xwMxMabKrq0MY/fy2p6dAUXxsNgojqhZXniMoQ=;
        b=JkyEhE+s5+Wpe9JqeSPNRzRf/NSIQQ56u17SUmBOAa7egf0+ZaDkuoAvRhnnAG12ds
         bEdtqtp1BK2D3cPBgOqkNhVR6QHyoUi1YP6tLF8B7FVnhbU0Ov24O7JESM0XfWqcSGsG
         SDvrf0ATbPRbMVN7jDm8tF3mLtiRZTIaeNx4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wNvy6xwMxMabKrq0MY/fy2p6dAUXxsNgojqhZXniMoQ=;
        b=PdFK6dzmClypRCeORcYgyS613wEMktyFmIqNQIYVCXm87fiEhzbyWM6j1DyCL6Vgo0
         JtvdehWaQyI154PGkLFg6ivppuijnw+dtmHVVaFH2AVI6HBYjsHmgqBWAzkNa7plKiOH
         qC+LFyxewei5CH3LmCLLuF0whGD7cCaJms9LUL1WIjqZXTdMNF0puowpfykTbBz2s+H1
         jGK1RoClzuzbxl/EHyB0mlQhH4ur8ZQVxyfXwTSfTF/U82aTCArOAXvpdukMXTbpkoer
         5OddvNLv75lUPnhm0kB1mL6OYyYM+mpUobDYrj2RhedeiQYwNtHVDUTcqcADQIWEaU1j
         ca2A==
X-Gm-Message-State: APjAAAXU9Yt/Umrse+j2iUf81zECCXEuJF09eAx1rxMJv7WtjhNqov17
        ScajeY7JelFI/ltRjNa8EfA7RQ==
X-Google-Smtp-Source: APXvYqwiXDNqu57rhE6CnJCrN58jJFirKHsZJl4ezmSLzTkhqKVwa9mGJxyZ9RclnPgN5RlRhnwY7A==
X-Received: by 2002:a17:90a:c20d:: with SMTP id e13mr8010288pjt.95.1580416485444;
        Thu, 30 Jan 2020 12:34:45 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:34:45 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH 10/17] iio: cros_ec: Use cros_ec_send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:30:54 -0800
Message-Id: <20200130203106.201894-11-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace cros_ec_cmd_xfer_status() with cros_ec_send_cmd_msg()
which does the message buffer setup and cleanup.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 43 +++++++++----------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 81a7f692de2f37..f92032e97a84d7 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -31,24 +31,16 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 					     u16 cmd_offset, u16 cmd, u32 *mask)
 {
 	int ret;
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_params_get_cmd_versions params;
-			struct ec_response_get_cmd_versions resp;
-		};
-	} __packed buf = {
-		.msg = {
-			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
-			.insize = sizeof(struct ec_response_get_cmd_versions),
-			.outsize = sizeof(struct ec_params_get_cmd_versions)
-			},
-		.params = {.cmd = cmd}
-	};
-
-	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
+	struct ec_params_get_cmd_versions params = {0};
+	struct ec_response_get_cmd_versions resp = {0};
+
+	params.cmd = cmd;
+	ret = cros_ec_send_cmd_msg(ec_dev, 0,
+				   EC_CMD_GET_CMD_VERSIONS + cmd_offset,
+				   &params, sizeof(params),
+				   &resp, sizeof(resp));
 	if (ret >= 0)
-		*mask = buf.resp.version_mask;
+		*mask = resp.version_mask;
 	return ret;
 }
 
@@ -164,15 +156,22 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 				 u16 opt_length)
 {
 	int ret;
+	struct cros_ec_command *msg = state->msg;
 
 	if (opt_length)
-		state->msg->insize = min(opt_length, state->ec->max_response);
+		msg->insize = min(opt_length, state->ec->max_response);
 	else
-		state->msg->insize = state->ec->max_response;
+		msg->insize = state->ec->max_response;
 
-	memcpy(state->msg->data, &state->param, sizeof(state->param));
-
-	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
+	/*
+	 * In order to not disrupt the usage of struct cros_ec_command *msg,
+	 * which is defined higher up in the call stack, we pass in its
+	 * members to cros_ec_send_cmd_msg, instead of removing it at all
+	 * calling locations.
+	 */
+	ret = cros_ec_send_cmd_msg(state->ec, msg->version, msg->command,
+				   &state->param, sizeof(state->param),
+				   msg->data, msg->insize);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.0.341.g760bfbb309-goog

