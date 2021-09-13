Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB985409C01
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhIMSW1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 14:22:27 -0400
Received: from ixit.cz ([94.230.151.217]:41004 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232400AbhIMSW0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Sep 2021 14:22:26 -0400
Received: from newone.lan (ixit.cz [94.230.151.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id BFAA823B26;
        Mon, 13 Sep 2021 20:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1631557268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vfoDdisrRD0gEyWuDlQo2+5u5Uz5hrHU5rLfPkwcZ+A=;
        b=hAAQpNkpgVGWu8leM4f1c2J8JvErhx9NQN0Jim6pgrqEB47aI+AySu0LOAxHN/BybwDEyv
        6zFo3/6MtaiNiv1rVPmr6kMH9vfgV8JEWTFwd8fmcE6V/MBO8/EbixltYVL8yL5nLpGXd2
        4r4y6V2m6egJfYiMeV8wZe/f0NBVJ5I=
From:   David Heidelberg <david@ixit.cz>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH] dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add vid reg
Date:   Mon, 13 Sep 2021 20:19:49 +0200
Message-Id: <20210913181949.83179-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Driver and device-tree also use vid-supply regulator.

Fixes: 7e000fbff7a0 ("dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index a0a1ffe017df..49e851ff206e 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -43,6 +43,11 @@ properties:
       an optional regulator that needs to be on to provide VDD power to
       the sensor.
 
+  vid-supply:
+    description: |
+      an optional regulator that needs to be on to provide VID power to
+      the sensor.
+
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
 
-- 
2.33.0

