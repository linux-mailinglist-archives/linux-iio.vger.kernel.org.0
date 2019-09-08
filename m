Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B49ACC17
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 12:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfIHKkP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 06:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbfIHKkP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 06:40:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F7E321479;
        Sun,  8 Sep 2019 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567939215;
        bh=IbcI3d9U+iuh6SaYmp34+y+NCuBB9DAYXtRHIi15OzA=;
        h=From:To:Cc:Subject:Date:From;
        b=QkBiLK+Q/Z5RWfgTZ/UVk/as4v8hvA7BYqpshh6GF2sjwTyHktSfzHxlV9mogDZsj
         DXquSDqF5BHLvqN8KTGTqBGRZyKrzGBp4+MSzRCJjbOo49mP4Owqysfuu+zjmbivFE
         eZWpsaUvaIKjRPCjtLIX2med+NHOgseKD1nDdTEU=
From:   jic23@kernel.org
To:     Mircea Caprioru <mircea.caprioru@analog.com>,
        linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] dt-bindings: fix regulator names to not be constant.
Date:   Sun,  8 Sep 2019 11:40:07 +0100
Message-Id: <20190908104007.6593-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This was corrected in the V4 patch, but I messed up and had applied
the V3 patch.  Hence the need for this fix.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 676ec42e1438..040af0bcc92e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -43,13 +43,11 @@ properties:
 
   dvdd-supply:
     description: DVdd voltage supply
-    items:
-      - const: dvdd
+    maxItems: 1
 
   avdd-supply:
     description: AVdd voltage supply
-    items:
-      - const: avdd
+    maxItems: 1
 
   adi,rejection-60-Hz-enable:
     description: |
-- 
2.23.0

