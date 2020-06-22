Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4D202F99
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 08:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbgFVGBW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 02:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbgFVGBW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Jun 2020 02:01:22 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 683CC22DD6;
        Mon, 22 Jun 2020 06:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592805682;
        bh=Eg8O1Ba1QZ4V2tztdTznSPF4KbKvCcjajbV13lHKVQ8=;
        h=From:To:Subject:Date:From;
        b=ZVwZonNkhkZPIwACioasIWXvW2hMSpKR+HOIXWxgpRoXRsR1081yw5/5hs72LOxtE
         bl0lSsKrbf6lJRSZ9APfGYT1ZPymxgzzCLQd64OnkZODCzGNboAHzYXLtq7LmU3LFE
         83L0kTheWImm+ySUgUWBjZShCmn+Vj8zJXjQkDGQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: bmc150_magn: Document and fix missing compatibles
Date:   Mon, 22 Jun 2020 08:01:09 +0200
Message-Id: <20200622060110.23192-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver supports also BMC156B and BMM150B but these compatibles had
redundant suffix "_magn".  Add existing compatibles marking them
deprecated along with adding a new, proper one for this family of
devices.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Mark old compatibles as deprecated, add new one.
---
 .../devicetree/bindings/iio/magnetometer/bmc150_magn.txt    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
index fd5fca90fb39..efeda055be6a 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
@@ -4,7 +4,11 @@ http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS00
 
 Required properties:
 
-  - compatible : should be "bosch,bmc150_magn"
+  - compatible : should be one of:
+                 "bosch,bmc150_magn"
+                 "bosch,bmc156"
+                 "bosch,bmc156_magn" (DEPRECATED, use bosch,bmc156)
+                 "bosch,bmm150_magn" (DEPRECATED, use bosch,bmc156)
   - reg : the I2C address of the magnetometer
 
 Optional properties:
-- 
2.17.1

