Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2958D1C2E51
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgECRWj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:22:39 -0400
Received: from mail-bn8nam11olkn2042.outbound.protection.outlook.com ([40.92.20.42]:57057
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729017AbgECRWi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 13:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVZp4ZIUCj1+vREFuzWK+AH4j+sx9awQ0ytv6Nkd58yMMQuwQns1BeYKB84OSZQ5H9z5xuvujKj0d8c4rPV8M7/2sNXjgQ0qnQApAAScUifaPENNjaOGHDBBZd5LRu3pLXi+/12jzGlXAoPZes7O9uJKgZ4nAIWiomONKoFAShPs2vU+/psTsROgRSoaSRPTdwkf4bUgYLzG+SWUZL8r+edDCDnnCUEF5tcRcqMmKO6XV1JhfGUFwC5i9oiZZ1hUBGAKQEIE8l1I33O8D2pDJBqJUMwcxfLLto2yCrBmNCS13uGS6slNpXclJfgZwK4NXL5s0iToL4urhfLuJimF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPNZ3Ud7Np307HILwUMB3QGtjDwJj2u3qprKFyJumjw=;
 b=LPtruzXjpqqlvNPVYle53ayYZXHebKtgcqEJkjkn7PH1VC6ZoHeg9ms3CwZdxHMeUVEvhws6n2rVQ1Z6l+PKoqxvnsr+jcdvAkxfdKQ4DzxbeyEFO2VhGSBXHZFS30r1ZI+YmTUopHAN/8oH6fRFDJs6J63yxC8JkMrQ+FwfUlapdOaC45QqDlayCj1MFIDHgUS68/yMDyw+VqpzLQBVbdkX6wZAsYbaphcQUpM8/YnQYsPwTUmw3V+tPL8XmenfWykqKGrA0DuOGFiM0G0qsrtKWpV6EzJtuma4McRUhATwHCwLWZ0sb59WrAH9xi/fONxVe0aGTR91K0PKFuPWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::50) by
 BN8NAM11HT043.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::380)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sun, 3 May
 2020 17:22:36 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::42) by BN8NAM11FT054.mail.protection.outlook.com
 (2a01:111:e400:fc4b::358) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sun, 3 May 2020 17:22:36 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A477503DADCB2B6AA6B3C54AC9DBBB8BE6710F418E899DC9358484ADDF276CF5;UpperCasedChecksum:2508AAB308A08505E9D1FB16F4E4008AFFB1BCCED208FCC599BB489E632C5F8D;SizeAsReceived:8014;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Sun, 3 May 2020
 17:22:36 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-input@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 3/5] dt-bindings: iio: accel: Add bma023 compatible to bma180
Date:   Sun,  3 May 2020 10:22:04 -0700
Message-ID: <BN6PR04MB0660DA2A47787A56A2FC7290A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200503172206.13782-1-xc-racer2@live.ca>
References: <20200503172206.13782-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:300:12b::33) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200503172206.13782-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR14CA0047.namprd14.prod.outlook.com (2603:10b6:300:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Sun, 3 May 2020 17:22:34 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200503172206.13782-4-xc-racer2@live.ca>
X-TMN:  [wm7OSSp0tZOupPR5H66RTs7aVsMHOIxc+h6rkamvy6mMX4E5TOVYLrvBYK22+2gr]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: a28f686b-0ba6-4f76-b101-08d7ef869259
X-MS-TrafficTypeDiagnostic: BN8NAM11HT043:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkI0Hukk9Ilff+k8ahHzUV/RIEd/wtBlTSWJSe11HUC4jWZVgydfx8Ntsr3nAlVW1J0/+UuA9PZVhfdYAyy+nxJBUqI7dz7jAye71hB9A7kXKGwVrr+49AsEVJd7BPscOdWYo0xAQIt6Iw66R82fWL7x6Bo2tzKvW+df4MAy+WehqfqAfwaBFgSubsd9e25nMbQdDKARB0cfwnp8aYN2fQPjrvYQKUwxnAiruB482Yiyg7Y+N9R3zpRHkMY31jEs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: /burLea5ria6AOkUY0Ct6bh3d+KHgVl/KEn+QvXiJHxBNmYfQ2N1LttcmbZDhb/Mlt/odSBi7dOwUE/mgL32d0J9N7ZSmLfc1OcIUu3oKvhhxrumFU9Qkqb2EoH3CpIaAR7i5dI+rU9dXVDjHZwfb+bMbHgDGc15Rz56anja7KQOZ5eyGgfcZhJGln0KVsDcvT8fJakYmBF5/qRLlinVHw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28f686b-0ba6-4f76-b101-08d7ef869259
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2020 17:22:36.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT043
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma023 is in the same family as the bma180 and support is
being added to the bma180 IIO driver for it.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 Documentation/devicetree/bindings/iio/accel/bma180.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt b/Documentation/devicetree/bindings/iio/accel/bma180.txt
index f53237270b32..48bec35f452a 100644
--- a/Documentation/devicetree/bindings/iio/accel/bma180.txt
+++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt
@@ -1,4 +1,4 @@
-* Bosch BMA180 / BMA25x triaxial acceleration sensor
+* Bosch BMA023 / BMA180 / BMA25x triaxial acceleration sensor
 
 http://omapworld.com/BMA180_111_1002839.pdf
 http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/bst-bma250-ds002-05.pdf
@@ -6,6 +6,7 @@ http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/bst-bma250-ds00
 Required properties:
 
   - compatible : should be one of:
+    "bosch,bma023"
     "bosch,bma180"
     "bosch,bma250"
     "bosch,bma254"
-- 
2.20.1

