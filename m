Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7AC18F2FC
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 11:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgCWKjp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 06:39:45 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:36938 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727810AbgCWKjp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 06:39:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 99A564126B;
        Mon, 23 Mar 2020 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1584959981; x=1586774382; bh=fHWb5Yr/KDrAgGobWOxbXkxjTaxaIsnDfWn
        qfiqYHjk=; b=LPVcQKnBEkMa2CBi+LBdXM/4Z8b0Bt37JCZMp/0zZDD/sX36jc4
        zNkIKTlPan/IWMNeQYGML6qFDl8EDlvhlYB7GwjGDQgq25OQrZc/mECp5zssSDI9
        w/ZW7SWU65CVHAp39XtasZAOAWDq9IXyLhHSfL1cXBzH6rlkrdeaoPLg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0juttFIPSayS; Mon, 23 Mar 2020 13:39:41 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 815F741287;
        Mon, 23 Mar 2020 13:39:38 +0300 (MSK)
Received: from localhost.yadro.com (10.199.2.66) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 23
 Mar 2020 13:39:37 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] iio: proximity: provide device tree binding document
Date:   Mon, 23 Mar 2020 13:39:25 +0300
Message-ID: <20200323103926.21271-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323103926.21271-1-i.mikhaylov@yadro.com>
References: <20200323103926.21271-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.2.66]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Mostly standard i2c driver with some additional led-current option
for vcnl3020.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 .../bindings/iio/proximity/vcnl3020.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
new file mode 100644
index 000000000000..76c29514c663
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/vcnl3020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Integrated Proximity Sensor With Infrared Emitter
+
+maintainers:
+  - Ivan Mikhaylov <i.mikhaylov@yadro.com>
+
+description: |
+  The VCNL3020 is a fully integrated proximity sensor. Fully integrated means
+  that the infrared emitter is included in the package. It has 16-bit
+  resolution. It includes a signal processing IC and features standard I2C
+  communication interface. It features an interrupt function.
+
+  Specifications about the devices can be found at:
+  https://www.vishay.com/docs/84150/vcnl3020.pdf
+
+properties:
+  compatible:
+    enum:
+      - vishay,vcnl3020
+
+  reg:
+    maxItems: 1
+
+  led-current:
+    description:
+        IR LED current value with valid Range = 0 to 20d. e.g. 0 = 0 mA,
+        1 = 10 mA, 20 = 200 mA (2 = 20 mA = DEFAULT). LED Current is
+        limited to 200 mA for values higher than decimal 20.
+
+required:
+  - compatible
+  - reg
+  - led-current
+
+examples:
+  - |
+    iio-proximity@13 {
+       compatible = "vishay,vcnl3020";
+       reg = <0x13>;
+
+       led-current = <0x14>;
+    };
-- 
2.21.1

