Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBE2CB8FD
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 10:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbgLBJgi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 04:36:38 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:25951 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbgLBJgh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 04:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606901625;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=+tabjWJ5R9tTtmp7BaWruIhTyrSUJG+kEDyYj1n7Eq0=;
        b=jValNypmsRujcmxnBrWqgPpst1SOeq5NM8DejlULL8OU/5/hou6+OUXgLn174svB2b
        6s43IJki3FpL7hdRy6mz4y+u7P28yji3sOxXCCPwrncSsqrWEAnhPz0uqWvAGMsOtyOz
        DBT4lN9rVF9hBn28w8IrfwNYFKSOyslZeWkDiChyWC6sIkHxOLPvgt2yd3Ypq0wqgboI
        e0CW/tdGwsrHwpF6f33w3AZP0WWotINBD81hXU67wanSHdEA26AFcjcJS5FOHvoHKrHt
        RMM97d/RIUD48npDZXaTzwD+R9WZCjRds+j5153UNwzAxRfLpHYSdXctFzy92MXknmmW
        ZJ8w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626NJkxR"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB29XbVuV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 10:33:37 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/4] dt-bindings: iio: magnetometer: bmc150: Document regulator supplies
Date:   Wed,  2 Dec 2020 10:33:19 +0100
Message-Id: <20201202093322.77114-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMC150 needs VDD and VDDIO regulators that might need to be explicitly
enabled. Document support for vdd/vddio-supply to implement this.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/iio/magnetometer/bosch,bmc150_magn.yaml           | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
index cdef7aeba708..2867ab6bf9b0 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
@@ -30,6 +30,9 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply: true
+  vddio-supply: true
+
   interrupts:
     maxItems: 1
 
-- 
2.29.2

