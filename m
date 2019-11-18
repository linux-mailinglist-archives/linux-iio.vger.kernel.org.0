Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04FDFFF8F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 08:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKRHgd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 02:36:33 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRHgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 02:36:32 -0500
Received: from localhost ([185.35.208.129]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSI6i-1iPxjA08gS-00Sf2D; Mon, 18 Nov 2019 08:35:56 +0100
Date:   Mon, 18 Nov 2019 08:35:55 +0100
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
Subject: [PATCH v3 1/4] dt-bindings: add vendor prefix parallax
Message-ID: <20191118073553.2df736if7xk65e3y@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:TeNg++7sRkqzr8V4ATPKw5QJFR+hTRa8RtZs3qVR/V8YQG3oCuX
 yFUBXXjlVmc9aRAtL2h2XmPjFtHLuWieU5uvRE9Z9Ez3r80EV0AV0zsgZJmP3mivSfS5kId
 zRszrZO+dUZVdovJ8eSNKXDCHHdiKR0zHArkgJXQGYrj9YdZ7DK9+lzI8iSxNCO5MPKuHEL
 lH2VBpoHSgdpVMx9+FeYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bFjPiAQHctg=:lkhXud5BdPyXw0x4UbyF3g
 dI/5HzBI5ve+7P1VvEYZ0h+zwq7DI6p/BIHQcl6SD/P2YCpTvke4yS5tWnoldkJrNbtnleaQw
 sxrY35GvmIuP5Bw5gFGFtM1YBmB9vPnfFschJFo+DrGfG2uJryQpejojVNGseFR+pqjqkadrr
 JlXnX5WyZ1FY87SNhycyO6Rz5L98X8WLRg4GPvDHA8d63P5oTcSU02GzJsMZ4TP+2rJCIPqb+
 wXYpGluMt5yg/5pZ3MKIcvirGO91KA0ioK3qkxoj+SS7f2AnGh/jwgcTDXQkhDr9B8yTqzea2
 TwtFhSfpS7Ft/BDNXzMYmbuqMJnfDDLfhu8ivmZrXezm9r8J8us5CWWv2bLe/cpUX4ahrYMfH
 Qqldo54lhGBjzhhigB2bdg44gSKo/fM6K9sXxqY7NnQGIVkDGN/JS+QBUb8TmP1LZ4mjWNBBF
 F5yYpq0PFc4VAqNdEHS1Eq+xZ2iw94cEuTvEOeX1hmwdlAcK4x3BgzxhlbBKBAba4lOQhynPZ
 5m3xYqRdCB0mHws/yuX4vfrruvTWvPnPy0WPGs2NX134eMDEW/WvkbLgQ1pffdNjlS3dqRyZ1
 wWtTRGVqgRo1DeOKLRvy9pboUM4KAxtP8MUfyCyohf5Kj7nY1TznP8MEqpRAIBOxAOPUn+yMC
 n2TtSIetjopWjVDM5gLkhJoENxmuQlv6q2CdYmvHUe7YTs70TkUTm6UmLvoGJl8+8FKh5HeEd
 W1+E1wzBdHB6/ERl3xv0ypQlj6czVrqyXrx0AuBMEu88Pwjy5cfkUZQV3bcbJ+yV8wzJRqj+4
 BI163WnfQTRBwenJhDCOltTiCaNAF+5Zv+0FTxFQTGmoDGsPx1wc2PcetNp6Hp+M54ZPb7Xko
 zYiPaSZA2K9NlBBNsa0Y3It0iAn/sfEIoBSuihrPM=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new vendor prefix parallax for newly created ping iio sensors.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Acked-by: Rob Herring <robh@kernel.org>
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
