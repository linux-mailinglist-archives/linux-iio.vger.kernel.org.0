Return-Path: <linux-iio+bounces-1877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0883924D
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C89C1F2658A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6515FEEE;
	Tue, 23 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG3/j4f4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385335FBAE;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022874; cv=none; b=e6KfD+NlCF0psbQvcTrqV1IOv5Ot1htwG1HM0nHMdlRaMDTHH8kD1A02J/AiLzLZj/CVAlA2rhAJi2vy1cuiVbxjZoL4JgSxMjQh4QH1tKu8ur1F3rWAIndzbnkhBvpnl5UGi8olaH6LPSQ+6t/CGuR1OO+wRBr/V/FBmthcnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022874; c=relaxed/simple;
	bh=arSvo8dXeVKn8/sPWrjvqEzdJp54ITIfgNVgakVTkro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNDti3jj+HDNbgrBsalwRav5km6Uhexx9xB1bIHDGjv2fsgT7fma7v8KzoRmdYRa4D9YSaC9O/DnKyxLe/ilLTsuqKub4/tGgb/Zr2Uunk96Hj6L1tC82eea6TNGu4gFvT4lwtPytkYyaCRD5XRO9X+oQpWN5a8vhYXBrxi5oTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG3/j4f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6572C433F1;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022873;
	bh=arSvo8dXeVKn8/sPWrjvqEzdJp54ITIfgNVgakVTkro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eG3/j4f4hEbGca96mKfIC34mmTfzD1jg6GrI2uMykAlL+RnGOBgr42kf04SuloZhv
	 Ouo/ol6JWGktIobG/0PsswmNMV7lfwCdErh9JNI9gRcJlmHtxf/dCfX+VWnmRCQtHk
	 B6qZJ8IIQhqVRNIoswcsvN/qOngVSzBnC1xiWlADjuA9xKk19+FtpApwsYe4K748u6
	 wr7aJHjtOpIdATRWg2godLsy+LPHXpFMthwfdlsEGFt952Lpw9E+uuT2CTqosqmdAW
	 JDnA4SMFzVFCWn0thTXu9PxEN7J1GRSUta/BqaUvcVO6Ruza9yqG8nJV1XAEXCS8yO
	 4J6Bk1zz8JFkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE43C47DDB;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Jan 2024 16:14:22 +0100
Subject: [PATCH v7 1/9] of: property: fix typo in io-channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-iio-backend-v7-1-1bff236b8693@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706022871; l=1099;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=w52FsK1A2hVDDxOoXRicI+QUFrzsmGZCdL/M9/Bje0E=;
 b=eGDMZkZwkifJiqNkQe+f4zqb6xVen3aR98PhQ/rPB2IykHoU0ZduFlxvmXFsvNPT2mjHWHJse
 hjAAc5eLpZcCJYhuGm0LuEJgYE7CdJpyrVulvRaSbLbTTkf+1vrtg36
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

The property is io-channels and not io-channel. This was effectively
preventing the devlink creation.

Fixes: 8e12257dead7 ("of: property: Add device link support for iommus, mboxes and io-channels")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 641a40cf5cf3..bbf0dee2fb9c 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1244,7 +1244,7 @@ DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
-DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
 DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")

-- 
2.43.0


