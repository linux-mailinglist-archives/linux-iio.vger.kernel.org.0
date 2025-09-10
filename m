Return-Path: <linux-iio+bounces-23926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C918B51044
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 10:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A631BC2751
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24987311967;
	Wed, 10 Sep 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="YSZ4poHY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CC3101AB;
	Wed, 10 Sep 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491096; cv=none; b=cwMdWBtXZc3++HMX80GeZ0nvagPK4kjkvMCj6JsgEv8rViK/Ayp9jk8IFI7EKJawxOZ9xc9iGUVboZ9Dkr+8Ah3SI9xKRTdvj3V2KaCuR1H5MY8fBzszRl+l6lKB5QzDaCZhjE0IGb1u8gq4YIJdt7WqEGDlc+u4kLO1BMZvlvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491096; c=relaxed/simple;
	bh=/4zN9lAblT0/99lYnfhdg1WFLieqr7yBVjvAKHYmEwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8Pagbu4bG9bh2EwCTpFHqFATH8DyodgBNg7or2rmwUbbH/xMbWQF9JjE0eOgNyEe0yO1JOR2aLSE4QrpSgOiRx0nvAQH8wB9/KTVhO4kF2oFk8JlT+2c9obLvmI1EGH5Fr01drfkT/O2wAEayARvPMAZn+Nz+UqW1Pf4DHspTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=YSZ4poHY; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id CB295173BF6;
	Wed, 10 Sep 2025 10:58:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBVWElmnKoZWfiu+W3DAEuKmhtUcJOutX7gM+xyCT/0=;
	b=YSZ4poHYLa7t+NByxsJdnS3ubRhWWN5Ylo5moL6tafU5AiCHY2pFj/Bphild9Fav9JQMBL
	A/KhwfNxygqO9WpNb4xtJwaGoEDSvoH1EfyILtix/0kqzBBXYw5L/d/AiXAF/uudpivc+I
	iHUNgXqmWPoiTM9uPfsSZObMEfkYVkUqrrvLy5va+MaSHnO8SMX37CLLwMU7oZkm+MZsq1
	dxhOdfcaLYGmVedh/yRBopdlgFKYfxQxDJcGgFd/gRkBn0TGTQ2Lmujz9WHFqkJrp2KE57
	x8yJPKreA/GjsyNQHPYhLb6yqW4KcaQk+YxpUgWKqiBOULHvwcfRy7rRK0iZvg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:19 +0300
Subject: [PATCH v2 14/14] iio: accel: bma220: add maintainer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-14-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=868;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=/4zN9lAblT0/99lYnfhdg1WFLieqr7yBVjvAKHYmEwQ=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+H4A6LtCJHII2vKHnVxOJivcCT+5zMAibi3
 nh7cjCHiF+JAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhwAKCRDPJpmZhE5/
 MP8xEACVIrH4hJGpvJQtu9YlB/zRRcGF0QTywNNETqL2pDw4HO55vMOIP1gXkVMvMZC2P0ul6bu
 lgIxx8SGrVHpa2CcibHplQ/3ItrMRG0jlVEEFft6MMIohy379n/hUwfjfrJGiRZcGkwQZEWiQWj
 lCOZn8sCDYrDob47CKOyabLFVHVRDFVbXkZ5zXXs0P6/GnDn8RgZtGNpunfgImKYMeW7cK5JaEu
 f2UnpwWUOotSGVNuiXpyjmPfmVL463XuZM4seuhfz6yhqgTecKii4buTtuzOaIhw2eB+fv4fDFJ
 9u01o3cCYYEpA+RW2WGgFLw5DNkZzVGc7mqLgJ964DaYodZevuXKcBFi27aEyHC2p3UbtprGPF7
 ekZt94k4+MBhqZnBAOYmKXKOGATt0FoteorcmREDbMUkN1PNV69vIyNvzf/GodzMdhCSL+KUHtz
 x7FdTazMiVhv3nh9tsE09EeHyR2ta0sTfZltB2el3YwfJ/TojxaVi6juGgEqzLRPdMGHL1+W+tC
 vIZ2/78RNkCQcNHnrPLhRE4a5h6wFq1UKnSXPJMAa/syD/s/kk6fcV5gjcknaxKR7ObxKUGEJH/
 NIJ+YKejhF/VqMYjJqhoE7ct272vPu11/W1G1nZ+r0ulk1jrdVzg9hTgUBUu2dXTe/ekj9LfwPu
 cdhGrYOk4He3HXQ==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add maintainer for this driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
no change
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75615d82593e173a9e07fd269163fecdc4711e8b..eb985bd06b7d960bbc25941a8ea7b420d83483b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4402,6 +4402,13 @@ F:	include/net/bond*
 F:	include/uapi/linux/if_bonding.h
 F:	tools/testing/selftests/drivers/net/bonding/
 
+BOSCH SENSORTEC BMA220 ACCELEROMETER IIO DRIVER
+M:	Petre Rodan <petre.rodan@subdimension.ro>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+F:	drivers/iio/accel/bma220*
+
 BOSCH SENSORTEC BMA400 ACCELEROMETER IIO DRIVER
 M:	Dan Robertson <dan@dlrobertson.com>
 L:	linux-iio@vger.kernel.org

-- 
2.49.1


