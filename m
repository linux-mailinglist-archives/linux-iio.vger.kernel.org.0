Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4D1538CF
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 20:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBETNv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 14:13:51 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50248 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBETNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 14:13:51 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so1391420pjb.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2020 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVfW9ZDni1DlH8qMCX1yHxGbDRXW3ULcuLJHVxLKcnE=;
        b=adQzvvwU+OaHvm/k1t3ljfvwjtqX27BJkfXGeNkH5BOUh0R2RkI+0rZBpjG1cuGDCs
         lv6iltnlnDYBYjHg3PVOneyoPs4ijZRLe8sYytvTzs65IBNF8GhCxQrX7tWPEELe/cmp
         Z7nENynpBqM7UigYEzWqBXNLhVKkrVyXeZlO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVfW9ZDni1DlH8qMCX1yHxGbDRXW3ULcuLJHVxLKcnE=;
        b=K57iEzIh3IDasI2BsQQG125AmLZwirV0sIvFB5p+EF2xN/W2hwJBBLt7CcFCwcUIYM
         7DQU8VvSrEJPLI6sjYmXFBV6nOXcfckLrFq4t1n9Cbf7Pso759PQ0OhrQ9r47gVPT57d
         Zu5nIoQCb8j6ogio4/ioWpIpzomPQjDKuaMyELJ2+S2Nr+Y01hE6iC2MH0oSb5VVm3qg
         FSuAxmruf7L6JOk3L3DAvNSSs4q64JSLm69ScJcTT15yH+4Y5nB6BI6HkcKiIAiTDhHp
         Wpa9WqvGWLsJgtoUWU46uFtZMpGuKzXP8ghLX7vbn7qpoH8PIPIP9k6PdYGlkLS9de37
         b++Q==
X-Gm-Message-State: APjAAAXHFLLDZ8s8ck2y0fe8/iQHaIVKaE4Q+ko4AkQoL2GZX/ff/8+y
        XsNSobXIlPRouHexBhrmDC4n+Q==
X-Google-Smtp-Source: APXvYqyo0i2w8e1a2NsPKmOcpRPzXWGEGPMbr1Ip5lszbEZ9rOZa8A7t4L/Cojf52gik1kDiUd7Z5g==
X-Received: by 2002:a17:90a:23e5:: with SMTP id g92mr7594799pje.14.1580930030743;
        Wed, 05 Feb 2020 11:13:50 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:13:50 -0800 (PST)
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
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:13 -0800
Message-Id: <20200205190028.183069-11-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace cros_ec_cmd_xfer_status() with cros_ec_cmd()
which does the message buffer setup and cleanup.

For one other usage, replace the cros_ec_cmd_xfer_status() call with a
call to cros_ec_cmd_xfer(), in preparation for the removal of the former
function.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.
- Used C99 element setting to initialize param struct.
- For second usage, replaced cros_ec_cmd_xfer_status() with
  cros_ec_cmd_xfer() which is functionally similar.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index d3a3626c7cd834..94e22e7d927631 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -30,24 +30,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
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
+	struct ec_params_get_cmd_versions params = {
+		.cmd = cmd,
 	};
+	struct ec_response_get_cmd_versions resp = {0};
 
-	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
+	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_CMD_VERSIONS + cmd_offset,
+			  &params, sizeof(params), &resp, sizeof(resp), NULL);
 	if (ret >= 0)
-		*mask = buf.resp.version_mask;
+		*mask = resp.version_mask;
 	return ret;
 }
 
@@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 
 	memcpy(state->msg->data, &state->param, sizeof(state->param));
 
-	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
+	ret = cros_ec_cmd_xfer(state->ec, state->msg);
 	if (ret < 0)
 		return ret;
+	else if (state->msg->result != EC_RES_SUCCESS)
+		return -EPROTO;
 
 	if (ret &&
 	    state->resp != (struct ec_response_motion_sense *)state->msg->data)
-- 
2.25.0.341.g760bfbb309-goog

