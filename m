Return-Path: <linux-iio+bounces-1884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F093839258
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 16:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923801C22C1D
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7426024A;
	Tue, 23 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAivFQCc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844245FEF3;
	Tue, 23 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022874; cv=none; b=nVjr9PVDZLHMx2nSJwYep57kUSWl1TpFg9kpCqQnjjavZFcJpTdbJE3jrU9g6MVq6DCyzbD3Rbl45gjJei043ZNkif7ofGTQXeGhMjdhwU3gLWh1yRqRiUEVwmjwfEGxNqy+9yy/zhvfNgh+6M9kysOhjxkLllISepjyg6uLYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022874; c=relaxed/simple;
	bh=DDvab+SIwyjUlzzkcqqtJG7c1LlKzcpHtvOqQGes2S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGJg9FzZjTDPf/Sh1EbB33YWlPmTj3IOPqQ2lMDs52wUbf0oraK2gptSmn50LfUdho23HDWk5+lgCXCrmbKMQ3N0Z3Nw8cwZTUwqqAnPkCpjvFysZDouzJE5q59xse/MRTk3VcQ6q9o4JN0G7Il6MpDyPVpt9gD5vXopA/dxygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAivFQCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9297C4166C;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022873;
	bh=DDvab+SIwyjUlzzkcqqtJG7c1LlKzcpHtvOqQGes2S8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VAivFQCcaxmwvP5nM8LR2HLwecfQC6e50PCxqECHe2lFxZo5TOv9d1srWkx4SRYBl
	 /x32eGlkrtKGiXfk2P6FHv2yQa6Rw97Ed5oAYAMm9dcNabYQi8T3W9+9XOdRDaLLkD
	 MHJPGrgQdtFO5bUmZuGcrx4OfP61R2ptB4IkJeaflRBX8DEoDR8khuA6uDcCUfA2nE
	 ibe0U+EF4+L9UbsiZR4MCtuN+XI2vF0x+ZMaiUHrM86KPtJrQq9LL6ITmxyhUEjr9A
	 UByA860w8rtoYO7rxOzsgtsq/gXYK981sctXcyHkErOMBWM3Vj9AtbgkaigGp11t9H
	 aN2bJFuWcnZkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE7C48285;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Jan 2024 16:14:25 +0100
Subject: [PATCH v7 4/9] driver: core: allow modifying device_links flags
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
In-Reply-To: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Saravana Kannan <saravanak@google.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706022871; l=1762;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NiGDxynCPMyVQiMlRKprajKIkvFEj59rpo/PEr1jdRo=;
 b=7rjN//3sjqwfvphKnrFChjIdmELUlgRln3E1glI5j9JdKceVONvIGEPFYx79NY+h7ooQ7z99U
 Oc/hDTY3q4DCHv+jqCf32H4MiauZlOkARIk/3p3f0Zdjp+OKFmC/UEl
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
index 14d46af40f9a..ee8a46df28e1 100644
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


