Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CEE1CBC26
	for <lists+linux-iio@lfdr.de>; Sat,  9 May 2020 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgEIBmv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 21:42:51 -0400
Received: from mail-bn8nam12olkn2052.outbound.protection.outlook.com ([40.92.21.52]:59105
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbgEIBmv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 21:42:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+kuVfGYMX1p3eajR43zJeRvnSrhNcl3F2ZKxofObIHk0xRgBztJktEBpurBdZR/9jGxHt9AgqGlM9gdZlKtscvSPdbE85eEXK2o8mVLdDklFlzVqRqlyXgQSIjzkKE34yEo9WZqusnfPLdKOEX/nheBkpZ40RLWXSZZlfUnj1uHc4rou8xFlWoeGVSEYl4dA95tlkEf9AUqh4mZe3LQYZ5CSs+coSKTwFvOnlMx+KOW9985v1uoy195Ear84VubajVHIrn4evjIhWJ3pCH3twqu/7HZg9w/TqOid2KRECW0nb7xFWsDpoysxTCWPS+SSxnM7LYW5Zy/LcVrjmHP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDH3p+hzRED8EGf/9tEbqNkQS1G8ID01Publ3nZL6Kg=;
 b=iBDyyOauZXe5S46sD3aAZRJ/1CWmbeem6UtV4ceDPwGmBPUlcolL7UO8nF8Fnzt2FfQOo2QrTfpiQyOhi3s4X3/Rf9vK+BKAVzQU/BFVGsl3Hcqgo3It83EHhQ7k37ChJIIKEeX6wOoybIAnVPDJdmLSz2QYe70Ypj3f4KbMlRGw5RWW41KSdmrenShvai/FXSaK9FZeK9mnR+MpWKerVRttYIoDQ7BaBbjhhxsfx2HvRgLUteZ5zx/RCD5+f+bjW+EsOzKuzndWktozKqYSPytybobs9frXL1hwoBAr8IKgqPSejDLposwysL82bMvsfabEPGA33A89T3lKOF0Ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::4d) by
 BN8NAM12HT116.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::225)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Sat, 9 May
 2020 01:42:49 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc66::41) by BN8NAM12FT013.mail.protection.outlook.com
 (2a01:111:e400:fc66::227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Sat, 9 May 2020 01:42:49 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:572E685D6E1F76FEC7439EE2BC29B1C4BC66E8E078DBBF84CB493AFCA0BC82C8;UpperCasedChecksum:F37D8874BCE8DB9FE1E43B387C6BC4C07905B5B0A09D28418B12068C5F766B37;SizeAsReceived:7668;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.033; Sat, 9 May 2020
 01:42:49 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] iio: light: gp2ap002: Take runtime PM reference on light read
Date:   Fri,  8 May 2020 18:42:21 -0700
Message-ID: <BN6PR04MB0660DD24B7B4418DCC2806FBA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO1PR15CA0098.namprd15.prod.outlook.com
 (2603:10b6:101:21::18) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200509014221.29882-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO1PR15CA0098.namprd15.prod.outlook.com (2603:10b6:101:21::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Sat, 9 May 2020 01:42:48 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200509014221.29882-1-xc-racer2@live.ca>
X-TMN:  [yS5/kVKGvZbsKMM3W8yVvy/1oxLonmGxl7+gJ00f4VoJngVrkrpNtpHHYLpHKDM+]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d60c85b7-a7e3-4a5d-b1db-08d7f3ba47b9
X-MS-TrafficTypeDiagnostic: BN8NAM12HT116:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UV9dv3MDqeWELU9BQhq79SH7Z6/KGyDKwisGjMik9MeLMX3P6uq0Obum5/NEb3E31UnIshB1x38NUMA/sAsyhdoeTfKi/erdfLIrm+LSNdvDcVihOhbkF/3aydhVyu+Qd0fyLo3CQO2xDnRZOb02Ksu1+zFxa9ldu8J1fSBUDSOxFUfJmSjBgawDCu8Z7FKHOVaLEOA/mISmq4ob6S1Z8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: wjY2lAYWnQBDq1OMjklYW/fc51lvjvUCHtZ3UdfWHSXy4kS47tvv3Pf8ZnUDiP7dMs5MCuJun+lR8uRd0qNiXXcSveSJPD37j3sdPX95EozvsSd+CzJBWAXj9skX3CwYml1dRbJedT2xwKPc9WJ648aata8cH3QvD6i/1U3mIz24TRUm0lUVUOmdsJwoGLtxZ0dkP+/M6aSPlPTkwJmDCg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60c85b7-a7e3-4a5d-b1db-08d7f3ba47b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 01:42:49.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The light sensor needs the regulators to be enabled which means
the runtime PM needs to be on.  This only happened when the
proximity part of the chip was enabled.

As fallout from this change, only report changes to the prox
state in the interrupt handler when it is explicitly enabled.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
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

