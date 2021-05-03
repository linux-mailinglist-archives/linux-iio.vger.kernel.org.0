Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362BC371172
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 08:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhECGFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 02:05:34 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:49801 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231531AbhECGFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 02:05:33 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.33])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 042C5A3C2AFA;
        Mon,  3 May 2021 08:04:39 +0200 (CEST)
Received: from arch.lan (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 3 May 2021
 08:04:38 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v3 3/3] dt-bindings: iio: chemical: sps30: update binding with serial example
Date:   Mon, 3 May 2021 08:00:14 +0200
Message-ID: <20210503060014.7632-4-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503060014.7632-1-tomasz.duszynski@octakon.com>
References: <20210503060014.7632-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 10553904252065111063
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdeffedgvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevjedvkeeuieehveeggeduuddvhfduhffhhedufeejudehkeeuhffgheduffduudenucfkpheptddrtddrtddrtddpkeelrdejtddrvddvuddrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sps30 has gained support for serial communication so add example to the
binding file. While at it remove reg property from list of required
properties because it's no-op in case of serial communication.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 .../devicetree/bindings/iio/chemical/sensirion,sps30.yaml  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
index a93d1972a5c2..967500b7e773 100644
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
@@ -22,7 +22,6 @@ properties:
 
 required:
   - compatible
-  - reg
 
 additionalProperties: false
 
@@ -37,5 +36,11 @@ examples:
         reg = <0x69>;
       };
     };
+  - |
+    serial {
+      air-pollution-sensor {
+        compatible = "sensirion,sps30";
+      };
+    };
 
 ...
-- 
2.31.1

