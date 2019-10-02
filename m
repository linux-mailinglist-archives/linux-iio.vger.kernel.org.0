Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFABC8BA9
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfJBOps (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 10:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfJBOps (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Oct 2019 10:45:48 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6899521783;
        Wed,  2 Oct 2019 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570027547;
        bh=SXe17vrbHkVlM0RCGidTEhpOBN/l5bCrym5HW7DvdFg=;
        h=From:To:Cc:Subject:Date:From;
        b=PclAPwyu3Y8IyJgvNG74xX1lRVQmepT6W1ETT1+BG2WaO98vOHrlO3D3oPWEGFsBS
         R7+i3u2v1bfk10R6N1g6zYF5Zt+Ya1ocYrHQKJMQJE3zBxeueMwA/IdX9D642XUNkB
         uF1SIoD6CjRKybjE9R8wv9PJEJlCzXboQpdKD9Og=
From:   Maxime Ripard <mripard@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: ad7192: Fix Regulator Properties
Date:   Wed,  2 Oct 2019 16:45:41 +0200
Message-Id: <20191002144542.114722-1-mripard@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD7192 binding describes two regulator properties, avdd-supply and
dvdd-supply, but describes it as a constant string that must be avdd and
dvdd. This is wrong since a *-supply property is actually a phandle, and
results in warnings when the example is validated (or any device tree using
that device, for that matter).

Let's remove that requirement.

Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 676ec42e1438..9e62f54c891a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -43,13 +43,9 @@ properties:
 
   dvdd-supply:
     description: DVdd voltage supply
-    items:
-      - const: dvdd
 
   avdd-supply:
     description: AVdd voltage supply
-    items:
-      - const: avdd
 
   adi,rejection-60-Hz-enable:
     description: |
-- 
2.23.0

