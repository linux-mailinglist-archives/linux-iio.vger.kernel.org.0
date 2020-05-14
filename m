Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8223C1D3F43
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgENUtn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 16:49:43 -0400
Received: from mail-bn8nam11olkn2086.outbound.protection.outlook.com ([40.92.20.86]:51936
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728003AbgENUtm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 May 2020 16:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThLnv5lSmws+vUYa+ZgxIfkojhG9IJpWEO9C8dozW8EWVZBgK+Na+xXP+ZTTxukV6AnX6XtbEqIuiUGsq5Hq8rO1K8DL0OKoW2c8/veUGtj3zHBR0OxgqYZYp7n5gusk2Q3tE0KlqGLap/rc/N+G3YTMy2JKq8DCzM1hVqhYKfF3J9GJBJNU1RcFYU9hQ1VJuBw8P6Zh6UaUaD9GBZ0B/HpZC3ZrbVpuNWUxaGMYGea7rGUcIZC3L4AGAO4UjvAF8EEp11pxcqNO6onvMj37eszxWAZcoeuzAI3H08d4UVfSkUjmMIBx/0jGU03Aa+oNzlIT/a5D/mKM1Ynt7ZQ42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RsMuAs/ZPNrfZ7RCX424suZ/MYZz2ohqipYKr1Jd2g=;
 b=KHeUh87mDCBcZU8YZKCOjmCdsRP8IzGIjv/aqE/RLge6cdTCMTvCNopriXCn0BwEVcAnzH9X6LT51dyVc4AN1+HbfjOO1YlycEpTgmezj0kmHTo7UM36coYZcsJyr3asFsFWsgyr2kCtF0tB3npsrqM2Dtdc6gHng0Ihf5Hw+TI78ZhAcrg7EkPKPUZS/zLzmGVoqC13h8CvmUJHlsXIf6kL2/m8GA6dsPJwZBLZxuTSqSmS+snrgO08MS3dMCefYPC8SRG1Bv6yRw+lGxf7kzp1lppd8PwqVfpJwoL4RYx3/bxLFGgFudIYpZQ5SQ5MLGkfr9VhWCMb+gk2XBJlZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::40) by
 DM6NAM11HT166.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::314)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Thu, 14 May
 2020 20:49:40 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT024.mail.protection.outlook.com
 (2a01:111:e400:fc4d::159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Thu, 14 May 2020 20:49:40 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A36B77B61527388797D60F30556D9B683C6C6CE0F8DA9ED8F111124A23243BBF;UpperCasedChecksum:6CEC7650E5006B7F0739E7E06465655965F27F1CB2BF508A2473C4D47F190E7F;SizeAsReceived:7916;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:49:40 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 2/7] iio: accel: Make bma180 conflict with input's bma150
Date:   Thu, 14 May 2020 13:48:56 -0700
Message-ID: <BN6PR04MB0660FE5CCD136539A328B29EA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514204901.3199-1-xc-racer2@live.ca>
References: <20200514204901.3199-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514204901.3199-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR1701CA0009.namprd17.prod.outlook.com (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 20:49:38 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514204901.3199-3-xc-racer2@live.ca>
X-TMN:  [vTw3+WUsAml8BNH0USNY/YseRjzFYgwgAwack7XAIxrMaTHZHBYDBffO798iLn9T]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: acc3de34-4ef8-4b6f-e790-08d7f848524d
X-MS-TrafficTypeDiagnostic: DM6NAM11HT166:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYkKbpjntwU9JeBNGhy/V5z+KYoOGfiAscLtGJWLHMMNJVxRgLIizH6f6FmF7ThunoFcK6mRlBTJa9IoHqEz2356v7lWcTXxtyovb+5jwrPGOVbWtzJsEqJo7as3hNdqiHNyLQSGcIvNJNRVV/i0MUApp1idZ/KlNQBf+o+Qm+8s9ajpLiO6mVW3MEur0vbUJx/LRpgpxe4qlNZWBVQ6Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: uHCmMiNcTR3/h9dWdQb1+MddOQKOpCOxIaYcuqBR3BHJpjhT+AVUVvQyUSJrABa2eOu08b/OziiT/RgTpFSY+a8i7uPkIbqoFhshFsRgBm++7mNBlWeumagK5nqPe9weIYabVgE+07IvvSk4SIxlf+r71EBW4wg1EEY2I1fKQJ89SegSnUsp6yBt1LpWzBtV5jvPQkDK8ylZacQYNJLkBA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc3de34-4ef8-4b6f-e790-08d7f848524d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:49:40.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT166
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma180 IIO driver is being extended for support for the chips
support by input's bma150 driver (bma023, bma150, smb380). Don't
allow both drivers to be enabled simultaneously as they're for the
same hardware.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/iio/accel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 5d91a6dda894..09e8c51f854a 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -90,7 +90,7 @@ config ADXL372_I2C
 
 config BMA180
 	tristate "Bosch BMA180/BMA25x 3-Axis Accelerometer Driver"
-	depends on I2C
+	depends on I2C && INPUT_BMA150=n
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.20.1

