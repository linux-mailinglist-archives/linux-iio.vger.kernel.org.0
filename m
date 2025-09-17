Return-Path: <linux-iio+bounces-24230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD2B81D9B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 23:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC2A1C24663
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9621FF5B;
	Wed, 17 Sep 2025 21:02:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12F17A2E8;
	Wed, 17 Sep 2025 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142940; cv=none; b=rIuew8gstH2+L+8e4BCR2iDaMohK4ikiPQtYIAN7wzFD602ls7I0El3vN9gxacSb4DS3W4WB069MzPcK+ztr20HM2fLtyxElJR4+4I9H5Pj834u8FeJSNJOXcHH3PIsoBcxLJrfhct4nQffn/uAGR7PNZOpmBhQd7NlowC962KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142940; c=relaxed/simple;
	bh=sYlqoIyTzMEuSzyl+07qVwSB9yyJ6vJQDdgi8k64bc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L0JaH/JXnGos7LVWkIi9mw3dAY+GtidO81KBsKUATcvXYzm1GO8iJrgWBjo5RU6kgjOyT8VQxaT6PtFdJDzJHbddTcfv8mBN37uxmTPGH5YCCMmoSpFR+6zCQ1iw/vNRrlDJEjQA5JkROBxnBnkUR32Pbk2yb9DbeNkZnbN3XOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5B694340EAF;
	Wed, 17 Sep 2025 21:02:14 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 18 Sep 2025 05:02:01 +0800
Subject: [PATCH] dt-bindings: iio: light: APDS9160: fix missing type
 definition warning
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>
X-B4-Tracking: v=1; b=H4sIAMghy2gC/x3MPQqAMAxA4atIZgNpof5dRRysiZqlSisiFO9uc
 fyG9zIkiSoJhipDlFuTHqHA1BUs+xw2QeVisGQd9abDhpAvVD1wPjn1ptizb61jb4gYSnhGWfX
 5p+P0vh8Af3N/ZAAAAA==
X-Change-ID: 20250918-60-dt-iio-apds9160-bdb725db100d
To: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=sYlqoIyTzMEuSzyl+07qVwSB9yyJ6vJQDdgi8k64bc8=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoyyHSeKum7Gav6n92XEDWDkSry0+fF7eUrY7qH
 hceEMXqrrWJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaMsh0l8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277cqCD/9l6zHx84NN8qYx4I
 kWm/gko41KHfSV04f9DPbVuWUoRU4rimok58e7YCEGnm/JDL3GeN62W1AohHUz3kA41ERZouw69
 aLtKINbLMc772rsPG5UoN/AXkI9jgWjiN2vWQGYECxYAqTjHx7OQc1+hbL9E/lXmGTRh5qBxTzW
 mMi/O5uR5XAzCG9tLc58IQpRIwWaO+squDbt9NuBvyboMtnUhIRIc85XGzrsw0ln7yH4thLGPx8
 8jkWYZVoWIZLUnvC/A0G/Zqk3s3wfnuKXmAJB8AqagBamCgWhv3htLivR7SxWkNt3WUH0DofcKm
 dYJGaGP6JouUiFSXzRDJT7bgkwrmXo9CAsIdiOIP6J3N/SgxbEE7d7I3GFohUxaGTp7I/NldF2K
 kLQWWDHeDi/d9RhcKy+tJFUsXSb5DRDQfBrLvc9dX1ih0rABaaAMmA+MKKTK0ntetw/Qb8nnVI7
 F1yfUaD38c+kEZveeK6n/7CkJZXjeZTnzjIYlrz9juYgePTsNVLgY9b278av6Si6p/Y6Rge/sCi
 LoGwAnze/nmWmkp/gR6+bUrWrHfEsh8QFqmn90Jd0JTvHWaNbBIMcKCK24joy37As02PEaB+Dlg
 QOnWi7IfHA3+CdBf9CjCqMCvSWOiuSaNcY9PNuovke3ezGrPzp7bAEsMKH1v93VdUqew==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

DT validation will report missing type definition warning for the property of
'ps-cancellation-current-picoamp', explicitly add type definition to fix it.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
I got following DT warning, when running dtbs_check

$ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- dtbs_check W=1
generic check all files
  UPD     include/config/kernel.release
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/work/linux-6.y/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml: ps-cancellation-current-picoamp: missing type definition
---
 Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
index bb1cc4404a55760d3f2ef3818d8f5c14782dc5b8..f9c35c29fe04c3623349b636a0dd7ffa4ea24a14 100644
--- a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
@@ -37,6 +37,7 @@ properties:
     maximum: 63
 
   ps-cancellation-current-picoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Proximity sensor crosstalk cancellation current in picoampere.
       This parameter adjusts the current in steps of 2400 pA up to 276000 pA.

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250918-60-dt-iio-apds9160-bdb725db100d

Best regards,
-- 
Yixun Lan


