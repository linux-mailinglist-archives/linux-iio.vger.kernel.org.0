Return-Path: <linux-iio+bounces-4490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C38B0749
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 12:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAAF1F224A7
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F7A15959D;
	Wed, 24 Apr 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="CSrSQRwp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F5159572
	for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954380; cv=none; b=GI2gIoLVyCtX/mu0YVhKO507NRmCQMLSvvZAs2c9wk50kggT/iL2FGb1x4TW8fvgAD3mI313NEjeaOku2Je8NS2akJjZf21TrsnRiz/eUvanx1lphRsyu/jnwimM6GFr/K+gYFAA0RXjVxWDjQRMZMUfNNGBLbUHj0k+HKJSUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954380; c=relaxed/simple;
	bh=GJst/GV867qu4gD0zwzxnidgVOFKeooPEn4SQf92jSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrR6klmGNQVXD+M2TROSig5BPUlTnIyQ6yAlxjdMkhLRmU8USJUauLCBtsMwXmjdq0zPhr+Hot8DX9DV/vFXDmAiefi806FlDL4oY//0O3cgZ8o6T2qnrIKln08N5l2/5WcLxy3aqJZn53nGopKDxU7mvR0LMYmo5Y/33s8X6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.org; spf=none smtp.mailfrom=baylibre.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=CSrSQRwp; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=baylibre.org
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id 68d50f39;
	Wed, 24 Apr 2024 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=s1; bh=oDfyyc2HFuIqQ885cav8ZKH+P6c
	=; b=CSrSQRwp2svrulmSIqaQHeaeyG9u2A+D8bgMxOtHvx2pC6jM6UB7vIoSHSe
	7X8O62JCM/xvo8E1dtM9FvOiS53Jl0UpDQbg6sowSYF8yMpOcfZDn5VFSYlP3hNa
	lfzWLGq6DlTHzE7w24MMXpFNvAlTWRAHrkjAuemcavuBXoVw=
Received: from localhost.localdomain (host-79-16-8-49.retail.telecomitalia.it [79.16.8.49])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id 3cb3eb52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Apr 2024 10:19:31 +0000 (UTC)
From: Angelo Dureghello <adureghello@baylibre.org>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: iio: dac: fix ad354xr output range
Date: Wed, 24 Apr 2024 12:18:48 +0200
Message-ID: <20240424101848.242749-1-adureghello@baylibre.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

Fix output range, as per datasheet must be -2.5 to 7.5.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 96340a05754c..8265d709094d 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -139,7 +139,7 @@ allOf:
                 Voltage output range of the channel as <minimum, maximum>
                 Required connections:
                   Rfb1x for: 0 to 2.5 V; 0 to 3V; 0 to 5 V;
-                  Rfb2x for: 0 to 10 V; 2.5 to 7.5V; -5 to 5 V;
+                  Rfb2x for: 0 to 10 V; -2.5 to 7.5V; -5 to 5 V;
               oneOf:
                 - items:
                     - const: 0
-- 
2.44.0


