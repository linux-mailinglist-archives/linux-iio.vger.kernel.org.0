Return-Path: <linux-iio+bounces-1609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7582C3C8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92946285D60
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3F77635;
	Fri, 12 Jan 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6TZgYcm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7531B745D6;
	Fri, 12 Jan 2024 16:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BAC6C43142;
	Fri, 12 Jan 2024 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705077627;
	bh=OPRTb/XW+2zsH8AnZHeRHdEClBBBI7WQURvAeLFHUZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u6TZgYcmfyf2q25wF1wyvMPxFu2uELuhvV9vFbIxcuCp5CmxKnt6rdPeDo+9FntMf
	 qSkrILcniqSIymAD9qBof8Pd/uWBZFtPwSt1I9m0LDO4qgntqcbyC3stOkEuU3kl37
	 lj4yNY6CORF0eIzNBB4KS+nLNr319GzlXhDOlbxzB20INB3AC5po5b3eGy9OjuEO2p
	 PsCrhu+wroYuVFuBxNRCvc3+W1wfZPmS0V5mhVU0LQ7eomUmFQNoMfGvJB8acG3/7n
	 rDolVsuKupQWI2AWOxqc+Ibg8OvTpHA+PxIfGBbNseverN//fVGK1kNVKpqx1sR7nX
	 9gjW9Mnta9+cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04310C47DA2;
	Fri, 12 Jan 2024 16:40:27 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 12 Jan 2024 17:40:17 +0100
Subject: [PATCH v5 3/8] driver: core: allow modifying device_links flags
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-iio-backend-v5-3-bdecad041ab4@analog.com>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
In-Reply-To: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705077624; l=1762;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NLZHAx7QEa2fUUjKTtfo6RESv2OQO0JG++qc/yxWC4M=;
 b=CdHkNa09HRJ9A/cdFWtfO1CwgAf2mwqm7enEyDx/k4YrFh8LAWb/u7wjzch7bk+21bk4ruuLM
 mz+i8/NGCj1DcUo/2OHMferCnI1muElWYjJj5Pj5lorpNHK8FeGLJ/z
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

If a device_link is previously created (eg: via
fw_devlink_create_devlink()) before the supplier + consumer are both
present and bound to their respective drivers, there's no way to set
DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks to allow
for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
DL_FLAG_AUTOREMOVE_SUPPLIER is done.

While at it, make sure that we are never left with
DL_FLAG_AUTOPROBE_CONSUMER set together with one of
DL_FLAG_AUTOREMOVE_CONSUMER or DL_FLAG_AUTOREMOVE_SUPPLIER.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/base/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67ba592afc77..fdbb5abc75d5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -807,11 +807,15 @@ struct device_link *device_link_add(struct device *consumer,
 		 * update the existing link to stay around longer.
 		 */
 		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER) {
-			if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
-				link->flags &= ~DL_FLAG_AUTOREMOVE_CONSUMER;
-				link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
-			}
-		} else if (!(flags & DL_FLAG_AUTOREMOVE_CONSUMER)) {
+			link->flags &= ~DL_FLAG_AUTOREMOVE_CONSUMER;
+			link->flags &= ~DL_FLAG_AUTOPROBE_CONSUMER;
+			link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
+
+		} else if (flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
+			link->flags &= ~DL_FLAG_AUTOREMOVE_SUPPLIER;
+			link->flags &= ~DL_FLAG_AUTOPROBE_CONSUMER;
+			link->flags |= DL_FLAG_AUTOREMOVE_CONSUMER;
+		} else {
 			link->flags &= ~(DL_FLAG_AUTOREMOVE_CONSUMER |
 					 DL_FLAG_AUTOREMOVE_SUPPLIER);
 		}

-- 
2.43.0


