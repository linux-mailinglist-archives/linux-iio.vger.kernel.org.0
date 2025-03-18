Return-Path: <linux-iio+bounces-17017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5CA670B4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 11:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE413B165F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF4B20551E;
	Tue, 18 Mar 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlwFw5we"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424C3224CC;
	Tue, 18 Mar 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292200; cv=none; b=YbMS0wtusFzlfL/w9yuXbC9ulJzVSIOzTtmvBXLoNnEkqpuNbXj4Sg61tMrG3vtlh5jFyZBFckAWwQUCvAbotFIbfS5RMG+Zixn/m0FDB9jpO6umxJ89JB2fOgikE0jqXpzAyVX8hWTbTsv3CBszAnUI5hVkXQXHSd1wdh+2D4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292200; c=relaxed/simple;
	bh=8MSk4YqEyJzClw7LWk7U9XbflLtRwCIfu+wTzTM1ov4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o3M5huTmO6fPQ75qvQwW8erbsiywTjnsWNLMJWSwk2zWN/mLaqY82ZZB7pgC2wpUSzlnhjRol9AYG9dHqMN3hGwDcfBdPQ0cWeEs3x4vJkZ9In++bG3sY6MsxQlrqKr6BKkZmdgzVYa261a8A4Nj9EEvykTa8XHuIOm2hpdB15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlwFw5we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC8DC4CEEE;
	Tue, 18 Mar 2025 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742292199;
	bh=8MSk4YqEyJzClw7LWk7U9XbflLtRwCIfu+wTzTM1ov4=;
	h=Date:From:To:Cc:Subject:From;
	b=qlwFw5weZ3GRlswm9JTUfYcM38mkFOoGktQtlApq+AKNNvbXAOi1c2RuyFTXd/xaE
	 JsuqNbu7s9/crGLhN94+w9uyW8xVJYldHB7WlE47AaBYdtA/PPPFgpMpo+0tQUP4F6
	 lrbptUIGeEN3YT2wVkBB7T2s10nkE/hXnmRKDpIh1kOBBsJ49u9WGlKOP8AfNNt7En
	 D1nEO8pllPY1Uicd+kNK3Dqm0mlewwHUWv4DVxHLnO9PJcOkTlSYyHmGxvG3jIEBJp
	 Fb6Kn4NXf+eObq0wyaCPRTclrIEX10hLqflj+eEurpIhcRtJC9C4KBx3ihx/Wsmivd
	 o+0yKTJpOhizA==
Date: Tue, 18 Mar 2025 20:33:20 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v2][next] iio: cros_ec: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z9lE6IVDeC5lnChN@kspp>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:39:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use MAX() to calculate the number of bytes for the flex array. (Kees)

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z9dy43vUUh4goi-Q@kspp/

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 28 ++++++++-----------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 7751d6f69b12..40d5b10c74e0 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -34,25 +34,19 @@
 static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 					     u16 cmd_offset, u16 cmd, u32 *mask)
 {
+	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
+			MAX(sizeof(struct ec_response_get_cmd_versions),
+			    sizeof(struct ec_params_get_cmd_versions)));
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
+
+	buf->command = EC_CMD_GET_CMD_VERSIONS + cmd_offset;
+	buf->insize = sizeof(struct ec_response_get_cmd_versions);
+	buf->outsize = sizeof(struct ec_params_get_cmd_versions);
+	((struct ec_params_get_cmd_versions *)buf->data)->cmd = cmd;
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, buf);
 	if (ret >= 0)
-		*mask = buf.resp.version_mask;
+		*mask = ((struct ec_response_get_cmd_versions *)buf->data)->version_mask;
 	return ret;
 }
 
-- 
2.43.0


