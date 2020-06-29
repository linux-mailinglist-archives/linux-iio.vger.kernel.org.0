Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB620DD49
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jun 2020 23:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgF2Skb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jun 2020 14:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbgF2Ska (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DEBB2376E;
        Mon, 29 Jun 2020 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593425158;
        bh=JxZnQhlw2nhy3/u8SncM0Q8kYK47QJ0SPz/EOw5Tpw4=;
        h=From:To:Subject:Date:From;
        b=ngxxE/lsDh33mkzuffsuyLpd1gg6fyTpF9QpKESTdaam6H0FYUrDDCJjqea3rwRPS
         L/UleGewoX+FZ5R8rfpgWpPBAfNHEQGVOr4hEtewf06RWYv9G2FTFkRxw8AuwcCpi9
         dZbOUoG2/1Mx6LHyp8O98P7g4wdlvMD96Sp5Xhfo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: bmc150_magn: Document and fix missing compatibles
Date:   Mon, 29 Jun 2020 12:05:36 +0200
Message-Id: <20200629100537.20365-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver supports also BMC156B and BMM150B.  Add existing compatibles
marking the BMM150B one as deprecated (due to redundant suffix "_magn"
because the device unlike two others is a magnetometer only).  Introduce
a new, proper compatible for the deprecated one.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Add compatible only for bmm150.

Changes since v1:
1. Mark old compatibles as deprecated, add new one.
---
 .../devicetree/bindings/iio/magnetometer/bmc150_magn.txt    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
index fd5fca90fb39..22912e43b60c 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
@@ -4,7 +4,11 @@ http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS00
 
 Required properties:
 
-  - compatible : should be "bosch,bmc150_magn"
+  - compatible : should be one of:
+                 "bosch,bmc150_magn"
+                 "bosch,bmc156_magn"
+                 "bosch,bmm150"
+                 "bosch,bmm150_magn" (DEPRECATED, use bosch,bmm150)
   - reg : the I2C address of the magnetometer
 
 Optional properties:
-- 
2.17.1

