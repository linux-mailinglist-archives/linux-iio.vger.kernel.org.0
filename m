Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30C31CC5E
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBPOr5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 09:47:57 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:36566 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230364AbhBPOrx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Feb 2021 09:47:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 8C66441203;
        Tue, 16 Feb 2021 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1613486829; x=1615301230; bh=GFQD4WNDs7Ml/44CSx878qcQ5bEC1vFEtyW
        z0Zks8Gc=; b=G27qyYRL9vMrxU5VbZEiRb3FtJQ9G28HwqK2DM1l/z8uZCNeGbX
        HlUucwi+dwmHXkURJiMERzqawPFxF9S0EslfJTfzXjabkvrDsXFtin/eHuH61Fqe
        Z0JZnpewZVakcvqNvB/IMl2VCKDvzRl2FVcZ2ygjR7Zb9q/nNmK+DMto=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0K7pSKg-Yg8q; Tue, 16 Feb 2021 17:47:09 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 97F5541280;
        Tue, 16 Feb 2021 17:47:09 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.0.29) by
 T-EXCH-03.corp.yadro.com (172.17.100.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 16 Feb 2021 17:47:09 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: vcnl3020: add proximity rate in hz
Date:   Tue, 16 Feb 2021 17:53:46 +0300
Message-ID: <20210216145346.18304-3-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216145346.18304-1-i.mikhaylov@yadro.com>
References: <20210216145346.18304-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.29]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Describe the possible proximity values in herzes for vcnl3020.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 .../devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
index fbd3a2e32280..1bb6ca1770f3 100644
--- a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
@@ -43,6 +43,12 @@ properties:
            180000, 190000, 200000]
     default: 20000
 
+  vishay,proximity-rate-hz:
+    description:
+      The rate of proximity measurement.
+    enum: [1, 3, 7, 16, 31, 62, 125, 500]
+    default: 1
+
 required:
   - compatible
   - reg
-- 
2.26.2

