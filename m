Return-Path: <linux-iio+bounces-16921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B2A63952
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 01:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42A27A238D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151831F941;
	Mon, 17 Mar 2025 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odGaLx8Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B17D517;
	Mon, 17 Mar 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742172896; cv=none; b=pGCFChMJR5qfKW2/VPv0wMgCBqWCSz3kDaTG/maU2hl8WEVfIEfL7d12Cs2jizFDZXOQxfAugRmQyv88kpJ2HlS9fDpX4sYDCyCUDqYkhJwuIl0Nomp1HV8FGetXNzc6mt8LQATuYR/W6mr+/WesO6vGlE5L8vKusWddVKbKLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742172896; c=relaxed/simple;
	bh=PhYok/zPKf3wCn1k/iNeF5smnW6Md5Du1eC4AZwuRhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kFYQFJk/iZpmhv+cjwo+I6yMdqO9ct8/G4PZlwdnzR005B6VliYXgjaBpc22BhEc6nT1/q2wef14BrwqMch7mQv7ruDpDq5E0d/cUnNY2gjwulILQHXA0EBurksv5EMEhSpIL/u8UGCOa6FRJCrRMCk9HsdZ9xJwHuI8nCqoe/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odGaLx8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD5BC4CEDD;
	Mon, 17 Mar 2025 00:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742172896;
	bh=PhYok/zPKf3wCn1k/iNeF5smnW6Md5Du1eC4AZwuRhI=;
	h=Date:From:To:Cc:Subject:From;
	b=odGaLx8YO37zkIiU+lHBSy3wwLeGCbacoan4ZIMTC5oYJWPkH226wLey9CzcHS+Iy
	 T1N0aUyW6mrGV7Tgr6zQlbeAvbFWsK32ATL5bbzV+KcvLC/HYgNUOUOPa9E1fRmM5S
	 O4PUbA9hHSc2CDiCE0utre23Ih/N6RF4R03Uf8mYebN4nWhHPI36FzNrbCvo8bEAWg
	 TZ9GjbwhFxlj32pE9S6sr06XShK7yGzMT52DgdczT2/VM6zE/DN1RmDSqs6nZqfaae
	 U2F4LcMVby0KDCZ/3CUWkcjf3BbCKNFLf75IbNKpx7FEztkzfcpdgDIHDwjlh2sEUe
	 BXJkaZx9Cc2hw==
Date: Mon, 17 Mar 2025 11:24:59 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] iio: cros_ec: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z9dy43vUUh4goi-Q@kspp>
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

This looks pretty much like the following patch for RTC:

https://lore.kernel.org/linux-hardening/Z9PpPg06OK8ghNvm@kspp/

Thanks

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 27 +++++++------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 7751d6f69b12..760a07f64390 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -34,25 +34,18 @@
 static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 					     u16 cmd_offset, u16 cmd, u32 *mask)
 {
+	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
+			sizeof(struct ec_response_get_cmd_versions));
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


