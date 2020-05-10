Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9471CCC15
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEJP6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 11:58:34 -0400
Received: from mail-bn8nam11olkn2039.outbound.protection.outlook.com ([40.92.20.39]:52416
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728238AbgEJP6d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 11:58:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njDN6exeUY04LOL0PP4CAv843ukZ4OLqtmW4rGnxSAjr2m44jLXUWrcZTC+17Eh26+daSdaXtJBlhO+7isrxfDt6NRD7VTIPPTeoat1WH0lKGspQA8kGLDVygR6AkjEqfFxvXGNl9AiNyvPa9wHPR0VUk7Ur2y/dQo/5de19w4o2gcEQEjQnzfU49E/hYkd3tr/QdLwzaEGGom2sMHxU6KJTTPCCs6CACeL3Nc0nGiCBdcDAkGcM7f9L40K3BvH09ABFmVYM4Agigoh3+HNsJdkZkr9jBsTjCnlq2vqFlEhBhjwV0c4aEGhsn6sO9ubdRMZrYSJtuPxyj3ygF6CvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdoBzBgyosu+3dx95pruqT6k/KZPdkukav+dI6xGvbM=;
 b=WhRfO3oTlT3VrcEUrR4Sn+CYfpKoN7+Xc1d6n0e5M2zpbvXTXOBp3sGajWo3gkBH3y29IrVztPtY3PACvJK1DAlvBdrrgLzSw7JthiuS0F7yf7uvlil/F+2oritzqeQR10xnjgaaIuKS4amPo2JaKuikxuN40+A0XW/93sqpnLfsY/MDIPs1mRe8wM3fZiMBM2vSB0d5k+wyMmfXEZrpgVp7a9CcmCzS37ZVUch8k7wS6fVDjSgA+uOas96x/1SFkHkmCyqnmUp/NAtak9VT73gr1ThZ1uooLQ0sF6vqrs6Dot9sGmRRBcRsXcIUoa8K12AFpfclLBhCsJtznHozLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::51) by
 BN8NAM11HT217.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::100)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Sun, 10 May
 2020 15:58:31 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::49) by BN8NAM11FT025.mail.protection.outlook.com
 (2a01:111:e400:fc4b::392) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Sun, 10 May 2020 15:58:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4B0EDEBFA48EF442FF42CF3D9471F50E1ECC50783AA7E7A13AAA83D16792EDE8;UpperCasedChecksum:5FA957DF3594E7EC12B1A1E087D685EFDA9E512902CA1E881AE915CB335228D4;SizeAsReceived:7861;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.033; Sun, 10 May 2020
 15:58:31 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2] iio: light: gp2ap002: Take runtime PM reference on light read
Date:   Sun, 10 May 2020 08:58:18 -0700
Message-ID: <BN6PR04MB066041D27D2A70B6B00C4751A3A00@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <BN6PR04MB0660DD24B7B4418DCC2806FBA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
References: <BN6PR04MB0660DD24B7B4418DCC2806FBA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR18CA0039.namprd18.prod.outlook.com
 (2603:10b6:320:31::25) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200510155818.16455-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR18CA0039.namprd18.prod.outlook.com (2603:10b6:320:31::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Sun, 10 May 2020 15:58:29 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200510155818.16455-1-xc-racer2@live.ca>
X-TMN:  [ODvRchQ/V6UpaEvSIMRRx5rRR1nOjhr+DXFydDe2AxKEFu2gICs6Ug9W6fWtVQmt]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 5df48078-4709-4367-5739-08d7f4fafc3c
X-MS-TrafficTypeDiagnostic: BN8NAM11HT217:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9w6NJ9C0+0fcYbF80DWde9HnhzSi7WtPptZR9urXjFB+q12MyO7om+42sqXGCkUMLW4PXpGJ3InQ+CGJNJuN+W2f/emFvy3w89IUoUfUndCnKO+0yJLKoBbIRg5E2azDaD3JcqdBT5R8MApkgYahapk78p11eby+YoxnuRVBdaJ4j8f4pnhQq9AmZyhez/Sm0F/TFfIGt3ChfB07jzN5gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: pDnlqIZqNtOIrOBdm543296RGz3Ouk5vRVJfRyNtEF6YuDZiFU6q0jksVHvyH+RDrN7NUe7BhEJZdJtdw97UWqkN+9YqV6bJ3UpcFRN/kF3N5HUtbgAS0HNiksZVrAl0HAMpDRxSK2fJkTDbJkB/mIdZkARmlFw72xewRg+DCt/I7DxXffDgwzNfa4D+5pJyYxuphZFII0ejUM3xEH1D2g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df48078-4709-4367-5739-08d7f4fafc3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2020 15:58:31.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT217
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The light sensor needs the regulators to be enabled which means
the runtime PM needs to be on.  This only happened when the
proximity part of the chip was enabled.

As fallout from this change, only report changes to the prox
state in the interrupt handler when it is explicitly enabled.

Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
Changes from v1:
- Add Fixes tag
---
 drivers/iio/light/gp2ap002.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index b7ef16b28280..7a2679bdc987 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -158,6 +158,9 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
 	int val;
 	int ret;
 
+	if (!gp2ap002->enabled)
+		goto err_retrig;
+
 	ret = regmap_read(gp2ap002->map, GP2AP002_PROX, &val);
 	if (ret) {
 		dev_err(gp2ap002->dev, "error reading proximity\n");
@@ -247,6 +250,8 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
 	int ret;
 
+	pm_runtime_get_sync(gp2ap002->dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
@@ -255,13 +260,21 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 			*val = ret;
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			goto out;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+out:
+	pm_runtime_mark_last_busy(gp2ap002->dev);
+	pm_runtime_put_autosuspend(gp2ap002->dev);
+
+	return ret;
 }
 
 static int gp2ap002_init(struct gp2ap002 *gp2ap002)
-- 
2.20.1

