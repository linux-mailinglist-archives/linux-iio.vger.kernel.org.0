Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80515CC38
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2019 10:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGBItw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jul 2019 04:49:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55928 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBItw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2019 04:49:52 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:8ae7:f3be:9ccd:d8f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AA6B728939D;
        Tue,  2 Jul 2019 09:49:49 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] iio: common: cros_ec_sensors: determine protocol version
Date:   Tue,  2 Jul 2019 10:49:38 +0200
Message-Id: <3fc3e1e606bc1e5478fca0888f9c005df6e52745.1562056868.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1562056868.git.fabien.lahoudere@collabora.com>
References: <cover.1562056868.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a function to determine which version of the
protocol is used to communicate with EC.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 130362ca421b..81111af8a167 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -25,6 +25,31 @@ static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_MAX] = "unknown",
 };
 
+static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
+					     u16 cmd_offset, u16 cmd, u32 *mask)
+{
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		union {
+			struct ec_params_get_cmd_versions params;
+			struct ec_response_get_cmd_versions resp;
+		};
+	} __packed buf = {
+		.msg = {
+			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
+			.insize = sizeof(struct ec_response_get_cmd_versions),
+			.outsize = sizeof(struct ec_params_get_cmd_versions)
+			},
+		.params = {.cmd = cmd}
+	};
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
+	if (ret >= 0)
+		*mask = buf.resp.version_mask;
+	return ret;
+}
+
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device)
@@ -33,6 +58,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
+	u32 ver_mask;
+	int ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -47,8 +74,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 
 	mutex_init(&state->cmd_lock);
 
+	ret = cros_ec_get_host_cmd_version_mask(state->ec,
+						ec->cmd_offset,
+						EC_CMD_MOTION_SENSE_CMD,
+						&ver_mask);
+	if (ret < 0)
+		return ret;
+
 	/* Set up the host command structure. */
-	state->msg->version = 2;
+	state->msg->version = fls(ver_mask) - 1;
 	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
 	state->msg->outsize = sizeof(struct ec_params_motion_sense);
 
-- 
2.19.2

