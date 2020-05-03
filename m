Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E161C2E4F
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgECRWh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:22:37 -0400
Received: from mail-co1nam11olkn2082.outbound.protection.outlook.com ([40.92.18.82]:50144
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728972AbgECRWg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 13:22:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dllw1WswjjvpbavJLzMPokIMuNh0VZuCbXGj1cmaFXf18worAbfYSDYGvT0kPNOhP/Yd4T7hRRkscH6ZX5mTouCRJrof/Jxmhy0oDyGm1IO/QD7uQ3TRKlGP92zFd/7/Dku+LIiyKQF2FMCUgPUJlTzVe1pfSJhTM8Q/uHOGye4cXQ2sAVjxz6Wd+zkp6F+3SZBBBscky/xlOs7K5WvY0CDJYMyWTltCufYVqPgjWitpmiuyLpCpsDLmA+XA4EU7wUUoU3FitiAUqWy3JLhLQ4T25dsSSs08/IhuxHdATf4UMIjEDS5Zyqm7CybBlZzyrgyGzQxws/CAnTokYRfSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CwtF6yiqmMqpX0VvocSY1c7abRgjEMhLeX9M4FKKjM=;
 b=UpSDpkv2fe5ufCrHUVL0Hf2QKDbSb/tmZ8nxO2GmS7J0kSgJri1UArqQe2wj1J9or4ZCcY+N6RmalrN8PtYYf1CsZdTT4k3y5xPCJSkTcIGOHedD/zLkSeBW3bPhnV8K8luRznURxlsUXFIT1e0pA76AjCjKgkt34yvhwVE/BWgZ2dAFw9YB71lUH2orgYuws1cKrhtJKHoWU0A/BuIj99OBkevqrN4duTwogSVS6KDzMMM4TF6YLTFwEwukllw6h/eT90nzuu9d4nNc9p9QWH33mCtDxk4PbDQ9SbeSb1zqAbplyULSgmkEAzclGku5YlojSFFL26tOYj6k5r42lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::4f) by
 BN8NAM11HT127.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::227)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sun, 3 May
 2020 17:22:34 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::42) by BN8NAM11FT054.mail.protection.outlook.com
 (2a01:111:e400:fc4b::358) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sun, 3 May 2020 17:22:34 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:AF6AA87CDE98DBE31D0ED6C021AA15DFC57E9B9BB3602DE9C2EA63B55C66342C;UpperCasedChecksum:C12BE145610A5E5D5CC53EC0F7F6455E2913F2206759C36D1FB97D875BB561D8;SizeAsReceived:8016;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Sun, 3 May 2020
 17:22:33 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-input@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 2/5] input: misc: bma150: Conditionally disable bma023 support
Date:   Sun,  3 May 2020 10:22:03 -0700
Message-ID: <BN6PR04MB0660B420EFA83668BBF4F315A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200503172206.13782-1-xc-racer2@live.ca>
References: <20200503172206.13782-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:300:12b::33) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200503172206.13782-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR14CA0047.namprd14.prod.outlook.com (2603:10b6:300:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Sun, 3 May 2020 17:22:31 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200503172206.13782-3-xc-racer2@live.ca>
X-TMN:  [TMGz84Okmwm9LuUwfInmLInOyR8fQWzABHdnweiK0zDrBbzd+hDGW4HjnR+lS/4y]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: f9949e8e-d872-40c5-5dbc-08d7ef869102
X-MS-TrafficTypeDiagnostic: BN8NAM11HT127:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VxYjZYTQ1oZd2ZNkAi9DNgTp+q+9Fj3k6zeF15Hkr/8119AU0d/NMBTuWd0qv3DMQr04bfBmP1bcfw9N+V2kaUOKagW8GFKW4PyF/adoID1wIv/eBxXiRkhsaKmwcPKTeKlDwqsVGzyiFZbCitavE/IzD32SqCHvOrOBE2Q7O9PzCKFUnSsqgfH7gNrm08RLE8URHOLmixaC2ozktwgrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: BqwGL9yShmYtTBpxsd3twwlATT9KUhnY9jCJczVcxUBxqCEe9oDrAJWu16gTxsPaLjq7LWdXRaaEvar+C1zQFs/NTheWWTv1RD6YZM/mUrTYWcNp1wwwmR+zP2oFrgV8WnSwVsM1qQSI/E9zBDaJfzg6GRQXX9cteOEuf0NfHKbFVKHjyDCmrXWsoQk6tlzVY/GREvfwKJ/revhrvxEdow==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9949e8e-d872-40c5-5dbc-08d7ef869102
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2020 17:22:33.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma180 IIO driver has been extended for support for bma023.
However, this could cause conflicts with this driver.  Since some
setups may depend upon the evdev setup, disable support in this
driver for the bma023 only when the IIO driver is being built.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/input/misc/bma150.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index a9d984da95f3..5d3f8b05b316 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -541,7 +541,10 @@ static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 static const struct i2c_device_id bma150_id[] = {
 	{ "bma150", 0 },
 	{ "smb380", 0 },
+	/* Prefer the IIO-based driver for bma023 if enabled */
+#if !IS_ENABLED(CONFIG_BMA180)
 	{ "bma023", 0 },
+#endif
 	{ }
 };
 
-- 
2.20.1

