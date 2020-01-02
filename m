Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C9112E963
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2020 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgABR2L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jan 2020 12:28:11 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:43099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgABR2K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jan 2020 12:28:10 -0500
Received: from localhost ([31.212.60.142]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXXdn-1jELFl2hBv-00Z0ZR; Thu, 02 Jan 2020 18:27:54 +0100
Date:   Thu, 2 Jan 2020 18:27:51 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: devantech-srf04.yaml: add pm feature
Message-ID: <20200102172749.v7ufupd32ytf7jda@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:twtpBPb9KWROwZySwiuyXDwXX6qeWA5mWAW+x4wn8wM67nRTwe6
 ZSlxkH4GwZxwh9CdipN/SmD6ekPysE5S3lJFpSOcJnObfiRAYmgJ5sIs6syghn+4D6EFMG0
 8UtCLK4fKNz/Hx6vfE4ves9pTCoZJqw/515et4d7qHl4yxksK9h6TOvKxfChoYvcBRm2JIF
 +rTX7ZheKNDF/k+iKOb5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2JbhkBLaumQ=:Q3nFZQ78naGyBYH/muDFpn
 iS0Sx6w/fx2srMl805v4vMjmID0mhYyGxWP7NsRDigFRJ3qmL/aSxnCzjao1dkWqaaaqLr/lX
 08ciheX2GqCquQAJ5Hql4YZkBGakg+Y4BN5Vwk/Fh2AkIRA+fjKMwMTu7ivD7/0Mynw+xBboq
 4Bn9WvSfA3845ST8EX6bdT6quHQlqJbjeMbRpmYAArzUnf1y5cKeN2dCL2kolWlnvdNgnKUSp
 piyOqgGWVSDua0yP5MnSDnnfmgw+7OwHtwcvfGdhW8mxmndJYcRWO4rHLkkJqbYNAwJ54RiVg
 WwZMAmdCFFDcIzCIMcbcv0FNp1NLd6I/0RjOPAFICSad/37bCyrncgE1ieboEGyAEaj7YKrxQ
 r0CQ4yG8hC46ZYkKa0wPgD7K7ykQMpbx2aPRZCEZh/9uGLfdTC0hEdOIsxCLbQ3bUDDS7Ut7E
 lEXogP/R9nre+/thSfa8AIgJrMRzfHe9bAs0DeG6S8DdLQt8mhlKZkPnIs8bhUDY33oaDT2XR
 vLK7670P0uMXnHbRcPFwp4IIyr7HIBiXNR7sJWTVhSp8kCau2zPMNW91Tkq2k82oJZ1XfqMRu
 BkwKdnotgjz3qedfAU87LrQ1aE5tbR5N8u7swtE7Jxmfcfa3THNaCCeBjObA+sLvdC9u6aN3s
 /0Oi5+FbVBkSEMnvkcaQCYBI/k3BSLeFqyRCLUXFyX1TkgnQ8hka29pKFVIV95O41ecBz8WcN
 2dV4iURGK6sGO3U3Z/wEFfL9EhwJQz9IM+VFW7aPaKDqs9JlQ8scPgWsl+NxL09bOxVNUV137
 rvYAIgEnTB1xc091CRvKFPULipJM+qgotmoGzxkbhbVPJwaH2q6dGA5EY+L03LMjI6glsJUc1
 wgMBmIIViuJN6LVnw8Bw==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add GPIO line and startup time for usage of power management

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/devantech-srf04.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
index 4e80ea7c1475..b3fcb3b79485 100644
--- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
@@ -51,6 +51,22 @@ properties:
       the time between two interrupts is measured in the driver.
     maxItems: 1
 
+  power-gpios:
+    description:
+      Definition of the GPIO for power management of connected peripheral
+      (output).
+      This GPIO can be used by the external hardware for power management.
+      When the device gets suspended it's switched off and when it resumes
+      it's switched on again. After some period of inactivity the driver
+      get suspended automatically (autosuspend feature).
+    maxItems: 1
+
+  startup-time-ms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This is the startup time the device needs after a resume to be up and
+      running.
+
 required:
   - compatible
   - trig-gpios
-- 
2.11.0
