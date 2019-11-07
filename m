Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33592F2EBF
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 14:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbfKGNCN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 08:02:13 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:58211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGNCM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 08:02:12 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3DBb-1iU4q23Lif-003eaF; Thu, 07 Nov 2019 14:00:08 +0100
Date:   Thu, 7 Nov 2019 14:00:05 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        davem@davemloft.net, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: add vendor prefix parallax
Message-ID: <20191107130003.m6ul3klzmv2g2sbd@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:C8IX4KdRmZEk6Z1ftKghKP5WhDeC1HAho2hptIwhg03itfX28K5
 lc5HmJpLEkeM6YsYzsdC+yQbqlHpPqsnG52s/6txbNzsFteh96kfsJ9xthD+ey6/ykNbwSu
 QzDqp92HVmdqOPiXaJR22TewJPtzaY7EIOAIpm7B6e+62n9CJv+LXUNtxHyUb8cH4sJtEWW
 /elcDwQ70aljywhAYF+1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ITQGoTZy2B4=:tzABNfQqv5gz/B7DJ+4lOn
 IQKJwWy2x3whNLzk0E+i3VTumuWdeA6FYk17ZHZj4NYGC0M1v6CYu5OvitKJvGj2AwLkA3xEG
 7TjsNwvNfUdK1/4YFoTrZ/wGeleqZv84LVZZEBhICgdEdOJzLxTaUgxGZS9QEmlTP49yHoY05
 swSKIp4vGYeJvJxOI5XPunIVFNnENMM71cPh6xo9flo1/dPDLZWRrynsT543mvw1XJqlz02Hw
 K1QTDfUVfcIPP7LsVqRvZiLEEOB62nWGyxaf60wBZx2FOtwr+8c/kRIMMqHWk/zXZqF//zipc
 jKB5kE4MkR3zEMCZidBqlI0nAfNhu7EzomO9mliH9XgxREi6mT+4ACrymsEevtEctrIpIdlxP
 b9++PCKLXa2p4WeWs76emn0bo42SeiRz/pUvGMt1FfUsVE/dEt/ypWDPkn2N4zAhsgc3sEoBO
 yEhLOXgvAfxjjRemm3LR/kuNfWHwvbjRR8o5XBpbtm+TxXPdbVsJlGovLSrRcanjIVJvWOa3I
 Zadh3DPHz6QL1a+5artch818Gify7IuLyduZAD/NHBU9MJwd/w5ZAld220/mqjeyNHWc55yhx
 2vWn6DHMobtlMeThS31PErW+BPC0PmcqTAeZ1XjyqvRpvEv9ywKUEpr6e46PIMd0WcjrI/QiF
 XHctthFnuIxVz8qyhKboNgiP3qTou5wXaXn51llPkBMXh70aDHpo3a37UcXKzoRFOAeWNOcpb
 KL4JvNiFLkoQRq52sZw44mHGYFB0wAPCboBoOWDG7e3gzWg2K1yH0Wj8HmXnxYg9nschN8rtM
 ykbJ+MPdvEtLTyHGHQ5iqAHYeplO07NEbPkx577jkwEEMijIwJ2zdNg5aAyHHYcjeAtzLfifx
 Za3OoghaosvGOrkEV7lA==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new vendor prefix parallax for newly created ping iio sensors.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..d3f9690e1e4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -713,6 +713,8 @@ patternProperties:
     description: Panasonic Corporation
   "^parade,.*":
     description: Parade Technologies Inc.
+  "^parallax,.*":
+    description: Parallax Inc.
   "^pda,.*":
     description: Precision Design Associates, Inc.
   "^pericom,.*":
-- 
2.11.0
