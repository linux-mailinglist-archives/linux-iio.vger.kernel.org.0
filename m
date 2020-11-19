Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2689D2B8E7C
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKSJOB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 04:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgKSJOB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Nov 2020 04:14:01 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CD6221F1;
        Thu, 19 Nov 2020 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605777241;
        bh=tfknIlNQ9OwoZap1SbWYKAIVoEIBaq9OGQk3lbsWs70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ps6hGNrr4pjUiS1Vx6KWUt81esuqvdbAsZFU33xKb3gwBGGtlEVJEvIyYWOPhUhnz
         zfS4p+kY5uEUb8ZDmxZvo4kk8xf2ksOhsyR+bmP9uFpjANENhy1cVw+jM1pcIFgY0+
         5RjKscVnM9XpK5WcXxkxvmgT1B+7SgoOwufL2RKs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: humidity: hts221: introduce vdd regulator bindings
Date:   Thu, 19 Nov 2020 10:13:35 +0100
Message-Id: <5e8009b293f1d5160ecbcdd33e7332ba0192b96e.1605777052.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605777052.git.lorenzo@kernel.org>
References: <cover.1605777052.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml b/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
index 396451c26728..53df083b3de6 100644
--- a/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
@@ -26,6 +26,9 @@ properties:
       The interrupt/data ready line will be configured as open drain, which
       is useful if several sensors share the same interrupt line.
 
+  vdd-supply:
+    description: if defined provides VDD power to the sensor.
+
   interrupts:
     maxItems: 1
 
-- 
2.26.2

