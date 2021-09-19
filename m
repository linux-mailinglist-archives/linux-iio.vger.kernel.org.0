Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77E410D5F
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhISUju (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 16:39:50 -0400
Received: from ixit.cz ([94.230.151.217]:46540 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhISUjt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 16:39:49 -0400
Received: from newone.lan (ixit.cz [94.230.151.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8ECC823B26;
        Sun, 19 Sep 2021 22:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1632083901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nA+NW/b7+b7haYLG+uQbafzK8BKgNXcmDGWEVpVpYgI=;
        b=sN0B2riOY7Beq/2wQ158gxqDK033xhk+KmK3jnurv3+bjTZFd+RCy3mBG2jz2VTeeL3e2/
        BLasuCqjzzMqS3l2kR+enHjL5wE4NzYICpzOcV0A1nvP/xtLslXb2AOI+1WcQvRj5AanzY
        36MLJw6XCJANjkOQ6hH/5/Vr2deONi8=
From:   David Heidelberg <david@ixit.cz>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Devajith V S <devajithvs@gmail.com>,
        Robert Yang <decatf@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: kionix,kxcjk1013: driver support interrupts
Date:   Sun, 19 Sep 2021 22:36:56 +0200
Message-Id: <20210919203656.119742-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Driver has interrupts support, which description was missing in the bindings.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
index 52fa0f7c2d0e..714e48e613de 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
@@ -21,6 +21,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   vdd-supply: true
   vddio-supply: true
 
-- 
2.33.0

