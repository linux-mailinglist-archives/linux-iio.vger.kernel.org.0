Return-Path: <linux-iio+bounces-7334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAA59284DF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6221F229E3
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 09:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38735146A8C;
	Fri,  5 Jul 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="RjA/187x"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40403145B24;
	Fri,  5 Jul 2024 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170779; cv=none; b=szw1vGGgrQpvfZkWxP4WcoGDtJqLP35b9br1BUQmt7WfwYOdftnDCCLtaK+zmOCJ5WOcAPrc+zLXnWfnMtiLiE+AbXdX9TMtmQcB/ID3/6EEWnRR6PfGUWCz3PFJ1LwVgHHDmLT2UtiUQ5kFX09GgpdIVVmfUkvx9I6mgAnrXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170779; c=relaxed/simple;
	bh=ACvKso2muyG+2Ki8bEeEqxM/VsZ7BFCG4ofC2NwZY4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XU92K+XnByp3nL58AWaky7cv+IcsoYRsN1188JLCsCqafQ4vniz+vF985H8kOKgTD7+jo3Ehjf+mnfrkSxKI1wbQzoQ1dPG7OgVRM4S0v3byuF/kh7a2JpZCJPsuN1L+Xm63QuNvIccvxzHn/GJ8pALliHtLoBubkfBFwd7zK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=RjA/187x; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0A4EF87EBD;
	Fri,  5 Jul 2024 11:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720170775;
	bh=RBjZOEGgB6K8uHCO8W2qroU0VrZQXd0M+yUIdog/a0U=;
	h=From:To:Cc:Subject:Date:From;
	b=RjA/187xmIHcSIfVE1lYQIM4aMneVepygzztWFOBDqRnT6tF3Roh5mSPBbY4ieO6x
	 tWIhn3RRTAENZuWUnGAlBbOmL+QLn07Bjpf8gzRg1RBpn/Xm3YXymuGNriMHKlqINA
	 wBFHVaJ/NoLPWwMigsVIqcUW3NP2B2SNRQ+RUccgR4ZkxVGiANftClISxHqL/5aGvW
	 SeaLWgShquhxjGAjZ2vVzIpBS8uBXzYpxRqA5Ux87YkeUyFYIj4x0llQPbPq6UU43t
	 /f8/nS9csVY4xweUSvi+k+GQg/nRMmB+cVvBcBpF4rG9EyJve9q/TnQQFjPABVASp8
	 VpgnGH7lNLpXw==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: light: ltrf216a: Document LTR-308 support
Date: Fri,  5 Jul 2024 11:11:44 +0200
Message-ID: <20240705091222.86916-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Document LiteOn LTR-308 support in LTR-F216A bindings.

The two devices seem to have almost identical register map, except that
the LTR-308 does not have three CLEAR_DATA registers, which are unused
by this driver. Furthermore, LTR-308 and LTR-F216A use different lux
calculation constants, 0.6 and 0.45 respectively.

https://optoelectronics.liteon.com/upload/download/DS86-2016-0027/LTR-308ALS_Final_%20DS_V1%201.pdf
https://optoelectronics.liteon.com/upload/download/DS86-2019-0016/LTR-F216A_Final_DS_V1.4.PDF

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
 .../devicetree/bindings/iio/light/liteon,ltrf216a.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
index 7de1b0e721ca2..877e955d4ebd1 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
@@ -14,7 +14,9 @@ description:
 
 properties:
   compatible:
-    const: liteon,ltrf216a
+    enum:
+      - liteon,ltr308
+      - liteon,ltrf216a
 
   reg:
     maxItems: 1
-- 
2.43.0


