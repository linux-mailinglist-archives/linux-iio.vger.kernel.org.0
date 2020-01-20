Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0602314302D
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 17:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgATQpT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 11:45:19 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:53927 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgATQpT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 11:45:19 -0500
Received: from localhost ([217.91.205.33]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mc02T-1jU0z03GMJ-00dY0D; Mon, 20 Jan 2020 17:44:57 +0100
Date:   Mon, 20 Jan 2020 17:44:55 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: devantech-srf04.yaml: add pm feature
Message-ID: <20200120164454.GA8716@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Z7THgzy1z2w+I54doW7pBGN6XV2b0jmwtukQsgob0iuRJwzd+yx
 8InqCrvMaQtEJRXyecfHHu/r2vM3CpwlDIdpSw3nMQbaabB7WibzkScukFFImL2wJyOXHfR
 cRyUT/NGudN2NYJB3MZpv8sK50y7krOhlzwKsmumIgl6H2WeTyjGUw0Z3CnTpvnEnejbrpm
 seKhtoHeBD35r7EcLoCyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9hWtVG83sN4=:X41VHGjp/zAdEXnG7MpJKT
 kYW0nY7iEww2vmHhd5pTobBKhfS2HiFz5u0Akkavbv4z1RcSrzULiO83othLKIi9y8RKJdxR+
 UxAOQXS05+z8N9cZm+PF+kj3hs8p/FIYjKqBvJpQ7GRS2YI/ZK2l3wU9X5dmpYFpH6mc0ErpJ
 Or6dvnWihLcP8LJtdqBM3OrXqjXH5rijGk0H7IfmsUZ3VA09k8Qv5xe2SNW+ygIvB0Mi/qYMT
 S6wnuOlR3rNc74PcbRjoMR564WVNQFodat0rR3JQXXZPP6t56VWwbJ6Ye9xVTd83R4PME5tlK
 qJ8CSgg4ubd2JrGlgbs68dc6A7f3DM9bC82Cj60UMx+9g3z0HcHcYNhzLPoFSuztwzaJ7z3Jl
 pEehfN0uHnGtkVpXXXBWKpRHEyc6Mzeabm3b290Q6iLp1jCdbxANzqSQYm7j7ZjAkwnUVESZ3
 odj4oKoWpRxTWT4XcbUHxAZqnQ02sUKPHNKZ67SQOwyxzxQ7oWTrS5kpu+wzVlMieZ+6OheKJ
 Xxwf2FLP0fe+Hb8vox4WKE9/+ULesLmtPmqueH9hXWImdLPezLvc0/wO2g3sjPNcAFRRUHFXr
 LRlcDmGODwUA+tRg5qA41mPkTL0n823N1hVESEG1+oZMTzP478oUn4bZugMddLd7rwufopt+0
 pt88IM4uks+ET0AFIbuLD9RBD5vCNmNyUy9IdD+aMAcuKhVsX9a+oNAwCXRhj6MmJ40TRDsW/
 bsuR1uAQKf5rnf+CVM4b/jrX89CQHXy6y4JHk4gOXoqZqKp+5CvlJUVdTwJR2/uVY22JfQn3u
 0dl541zcXfU5TJhjQr2F5RL/2X7CyIZKWglrk91Vh4wyMWLOLdiCQU2ofWnZRLn3llqxL0G4v
 7wzuGyhw5qbxpVIhATIA==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add GPIO line and startup time for usage of power management

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/proximity/devantech-srf04.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
index 4e80ea7c1475..8afbac24c34e 100644
--- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
@@ -51,6 +51,24 @@ properties:
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
+    description:
+      This is the startup time the device needs after a resume to be up and
+      running.
+    minimum: 0
+    maximum: 1000
+    default: 100
+
 required:
   - compatible
   - trig-gpios
-- 
2.20.1
