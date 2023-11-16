Return-Path: <linux-iio+bounces-128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F77EE6AD
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 19:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4309281112
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3748CE8;
	Thu, 16 Nov 2023 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A4D4E;
	Thu, 16 Nov 2023 10:25:31 -0800 (PST)
Received: from localhost.localdomain ([46.183.103.8]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRTEp-1qgmUB0B0f-00NVDe; Thu, 16 Nov 2023 19:25:15 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: honeywell,mprls0025pa.yaml: fix function numbering
Date: Thu, 16 Nov 2023 19:24:43 +0100
Message-Id: <20231116182443.7290-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jpI3HRtq1qrPEfvCSYZnREA78HrIVFvSWaWp/K9JH6x5XqCpToM
 ZWds6VPXrqCK0QLHzR8LtNzq6jUPGJ3Dp0ltedT6ehxC+W4pSPDpAu7XhdWXZSrXHzqDrWv
 reBU9xa6LAmLYH9UhofWb+vqpkneKz3yocy4onlPmAMhcmjSBxE6QadNuFWP/OHLx3LEefO
 7TAnxofAHezJyo+cgu8Dw==
UI-OutboundReport: notjunk:1;M01:P0:qNpRdEEawM8=;DC0ckfU5aHXfCWvWfnggXc20720
 zU25oKtBekvw3crMhVi5Y9pvR1vzm8vzQeBAUqOvl+sgjfMke0V9Xi+WzmWpJum1nSOKQPLrj
 QQhl7cdy2HEfREY+KGifdOBWxYREK9kxENBxVGBAUpX6yDeH0ekpvqedIECQ63H/QZoqCyoht
 +OBltXpcoqNLYm89pVIgsGZWQBnvJ+6Mnck/0GYXfbRVJtkBLDf+Z+XyRuPo7dTgt1uKI4vJX
 2zQUxz51Ay4YPD0ezJalU0m/M9DIhBCk9ywE8pR9DPCydYkEzgB2gQyRWGk0j24oCDEUJymSY
 SMDGpKO10VHtF8wRKgHmBL4/dXy72DmV1KQfXnAXcw+raBtS81xCvNyQsbaTWIokvt/iLlTD8
 5ZmWsVg9DHgtqqZ/EaU5EDvvgSYPi9bphaGpBtCa8ug/QDXEi1CrZTMta1LN6fc+S0mH3okgS
 SKOM8ImQ8S76aL947eOiNn5Y3EDroVhT9DkGT/PJxsYA2LRuwOSrR5/+sQouGRj+vB6BgmQvo
 Lb/DeUaPBAAj8NyajTN3GSF/4lujJM1wTWEttmzfYSDOuGdNNX2v8clSmKzCGYQlPsSSMbSL3
 Y/0f7VkatwVtBZwqyrBXLPUzHtOUBlsAgwM1vNNrjLV9+lBtHrCxD8ueFqnRInZvSHjsMF4Jh
 egsH5FI1IOp5c7OMnI8rMWWnoynqkOXI0pVh4rEy9TyVlvxuP5Z8wSSNnF5RXaHewCr66rGu2
 H8AWUf/WdxWtLLLtk84zv6uODByVqor2RRX46xJgjfLz3cmQ0Sm6ivi7k3NR90HiDVFJJa0ki
 4IYpg04DADHiJhSUjj6XHZaidXoZ2eeDfAH868mfw6TM5kgAVm0SubOc6dcdZGprJXR//6+mf
 Qqs3nPKqR/Fz+hjg0jZz6W2lLQkCi2eu2gMw=
X-Spam-Level: *

Fix wrongly documented numbering of transfer functions.

Fixes: a765c985e696 ("dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor")

Suggested-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/pressure/honeywell,mprls0025pa.yaml        | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index b31f8120f14e..61775eff1128 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -64,9 +64,9 @@ properties:
     description: |
       Transfer function which defines the range of valid values delivered by the
       sensor.
-      1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
-      2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
-      3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
+      0 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
+      1 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
+      2 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
     $ref: /schemas/types.yaml#/definitions/uint32
 
   vdd-supply:
-- 
2.39.2


