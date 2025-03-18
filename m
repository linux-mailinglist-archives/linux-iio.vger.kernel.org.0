Return-Path: <linux-iio+bounces-17041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA83A67D4A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 20:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231E37AADB1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA9212B1E;
	Tue, 18 Mar 2025 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="AGyn0Wpg"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-100-percent-9.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster4-host4-snip4-9.eps.apple.com [57.103.89.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC81A9B52
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327235; cv=none; b=b9a15iPmDepR5XmKGqIvIXkjdU0y3Ng0XqLJdl7oBmAFazlveT/4PBNZ4Npg79de6AIQYC/+XAYUjRz+nzABTAcip21KeRu9hJzkgOgYoE6Vnb/p4WO7pKu3b24moOlGib5rZwiU5YOZGdy0O06WtTZa114MHnrCpklf8wyEbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327235; c=relaxed/simple;
	bh=jSYigw9RHd5MXqnBsNMF/i/zXhiUyoQtQhVRk7JevBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9IM+sAqxviAwQZrn4JZ0Ow/YbXU2ISUHYM9rVYvFYAmM1sGNilcjHoCbdv7bgvMzFhfJyJuXdoP30VMydQ6/YgdeNaNsFMAryT7zcmrSI8bBbnQvMt9Cp8EDpr6+7Mh7Y6Om0+1RNyxVyOxMhTgy/VHjmzlLFTgc6vDtZozduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=AGyn0Wpg; arc=none smtp.client-ip=57.103.89.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=0YAbwE3jUJmjtAF1aTc+Ih0zOeBMB4K71DOpq7By6Pg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=AGyn0WpgjVxL7J4hRqXjxy59wKpX0U0r0OXBYOqSIc05JbGG2Y+8ziuY7TtsAyxzn
	 iSs18sLM4WxdjQfJ9W/uzUsP2P0AeibWuNZ4iwAk48vs+6EgNPfZqtciSBa8wiKq72
	 KybS2Re4m21jyF4wcWZbbfYDIyPYKENI+YljKqqLYBbzYvx3ZAe6cCAolVcvETbPSF
	 V760Vz6FXM+OJ476qXHo5+oBuOCcnhPTPJ8/ooGMNHDxv+Ls73qqddQFYeT8QSoLB1
	 waWXEjhBftOQjamgMP0hBgn95f5mxLXC4LAwH9+Qa09SgPfFTAKs7L7rUp2OUTTDBC
	 fvBfHf5+aA3Mg==
Received: from localhost.localdomain (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-9.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 527D318001CA;
	Tue, 18 Mar 2025 19:47:04 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Sergio Perez <sergio@pereznus.es>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios property
Date: Tue, 18 Mar 2025 20:45:54 +0100
Message-ID: <20250318194624.7626-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qs5RND1TH8wMqItkiprUYf94-BngdX8M
X-Proofpoint-ORIG-GUID: qs5RND1TH8wMqItkiprUYf94-BngdX8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 clxscore=1030 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=899 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2503180143

Some BH1750 sensors require a hardware reset via GPIO before they can
be properly detected on the I2C bus. Add a new reset-gpios property
to the binding to support this functionality.

The reset-gpios property allows specifying a GPIO that will be toggled
during driver initialization to reset the sensor.

Signed-off-by: Sergio Perez <sergio@pereznus.es>
---
 Documentation/devicetree/bindings/iio/light/bh1750.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
index 1a88b3c253d5..f7a8dcd7d2a1 100644
--- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
@@ -24,6 +24,10 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    description: GPIO connected to the sensor's reset line (active low)
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -39,6 +43,7 @@ examples:
       light-sensor@23 {
         compatible = "rohm,bh1750";
         reg = <0x23>;
+        reset-gpios = <&gpio2 17 0>;
       };
     };
 
-- 
2.43.0


