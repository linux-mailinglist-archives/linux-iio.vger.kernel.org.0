Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED571D3F33
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgENUtp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 16:49:45 -0400
Received: from mail-co1nam11olkn2099.outbound.protection.outlook.com ([40.92.18.99]:17094
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728043AbgENUto (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 May 2020 16:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb6hRy9ddj3dXjHy1nMXDh5DPQgEoBXxWTJRM2l6v8FBqMdsnFphp0VGuk/VQzLUqcgU2bYlXTv58vc4UJ58CYrGbUdlVFv6RWYMdiWl/ZypTmCUVDGevf9J9uZQOLhf46PQh1rIQuIGRWnXxOinL30Ya1MI0u5yAxERDgyG+CqtXGg9qDwJbdlW41WZckJu2GJ2jLcPa51UNnjnPPhyRFDbkZMp6CXUQ5WiF4KpKYMf56dUnPyVw2wTvcGXu/oQ9Z4+6QvaZmcNKqja7ivP4NUahWF2HTZ4+GZMibz7NoDq7fu7XVwM44OTnTnzqP0M/f+A6nBOjONcFZc9pRZiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfEHPjQV3/S3/BubNXOrz/qI5VTIYVI0tRKCgSR1bcc=;
 b=H1huJZXdy02AloXBGBKoZjv5LEpp00CO3ZYAyB69u8uxFKSurY6vJu1fzEE+0axSSI+gD6NIaUbgRgOtGmsNQN4E7bxrT+y0GE6HeoU4mvaKDQ1lPnLV2h8VlVERFSpK3E6xFi98cr/WteN134XXxmktdpdQbYWTBC6F1vA1pIyoXNUFhnpt8Ba9lKR4UiDO4I5sQ6UDfHkOFIWChajXJdiSP4/prTTjThPz4/Ap5XhmAILwBsbOW8pagYfDo2xtZ+NKHbKXNKT7nw7QVm9ycan1ehlZSE6bGzu6K7BogaPVrTTWkLU5zCZ/A64ulXSVYxwBWWxk/pyr+wv1sDBQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::40) by
 DM6NAM11HT064.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::306)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Thu, 14 May
 2020 20:49:42 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT024.mail.protection.outlook.com
 (2a01:111:e400:fc4d::159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Thu, 14 May 2020 20:49:42 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3509A4331E9A7B6A52478916A01C093A3E959AA3239CC90AB3B8829C18BF1D07;UpperCasedChecksum:5E1D8BCCAD08570790C7D84D82554A1051091F87155F47D7D6DFF4691B046C3C;SizeAsReceived:7927;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:49:42 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 3/7] dt-bindings: iio: accel: Add bma150 family compatibles to bma180
Date:   Thu, 14 May 2020 13:48:57 -0700
Message-ID: <BN6PR04MB0660521FD10959715AD7AD45A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514204901.3199-1-xc-racer2@live.ca>
References: <20200514204901.3199-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514204901.3199-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR1701CA0009.namprd17.prod.outlook.com (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 20:49:40 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514204901.3199-4-xc-racer2@live.ca>
X-TMN:  [tqFHEkPrfGGfie177htcY6hU0921D5YNadUo8b5BV1p0iZ4d0uU06bydvhql4FdF]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 42d6530f-24d7-4b52-3cf6-08d7f848536f
X-MS-TrafficTypeDiagnostic: DM6NAM11HT064:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V53LVQGT4L41L144iN1tEOjkzz6y88M9ogwMkToAkAB6hGywAaOzLRsffLjmTUoqXUuVbvx0mzaFY01mZxILT2xmexgP/SRm6hkO6SlMlqaSrZ8i6ailxLznX7AMglyW6C/z+VTC7CxTAkqDCQhf5r2uLYwAgjkLbt2/JaO5asFdO5tL9efqZVsp3YO1FCuOz4qTq39lKIKCZxkQcTBw9aFxmf13MBr47dUwExn9PC1RdsSdr4RryES1oyDMreG2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: DpzgYHpY+ndRQLeHat6m563tlQvu4X/9i6huGzukl6W2HUG0RFu7XRATdTX9NOCvPHqFJdr4LRyclyMu0O3r0OUCPe6y1jYxFO8vK81YFMUAcAvDSpMmJo7Tc+wumIj8wOxyr0Afij0ZjyYCE+2wzD8LBiEeiNtnwQ9+gDra15KiVmmANaquF1DjNYqA5V/YWu6DCR+nDkDuQVHp3m0VTg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d6530f-24d7-4b52-3cf6-08d7f848536f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:49:42.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma023, bma150, and smb380 are in the same family as the bma180
and support is being added to the bma180 IIO driver for them.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
Changes from v1
- Added bma150 and smb380 compatibles
- Added R-b tag
---
 Documentation/devicetree/bindings/iio/accel/bma180.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt b/Documentation/devicetree/bindings/iio/accel/bma180.txt
index f53237270b32..cfbfc6276b3c 100644
--- a/Documentation/devicetree/bindings/iio/accel/bma180.txt
+++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt
@@ -1,14 +1,18 @@
-* Bosch BMA180 / BMA25x triaxial acceleration sensor
+* Bosch BMA023 / BMA150/ BMA180 / BMA25x / SMB380 triaxial acceleration sensor
 
+https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA150.pdf
 http://omapworld.com/BMA180_111_1002839.pdf
 http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/bst-bma250-ds002-05.pdf
 
 Required properties:
 
   - compatible : should be one of:
+    "bosch,bma023"
+    "bosch,bma150"
     "bosch,bma180"
     "bosch,bma250"
     "bosch,bma254"
+    "bosch,smb380"
   - reg : the I2C address of the sensor
 
 Optional properties:
-- 
2.20.1

