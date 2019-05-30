Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B502FC16
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfE3NSW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 09:18:22 -0400
Received: from mail-eopbgr820089.outbound.protection.outlook.com ([40.107.82.89]:54493
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbfE3NSW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 May 2019 09:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbXdM6CAoYE+Nce9Vna2B3m0+HU1GVp/oI4PApUVn3c=;
 b=sqH8X2jDCU30bze75XOZDN0/291TI3629nMg8S+DqTOSdJRQN3KlE5KoYcEtE4yadTONCTmRALBwaKqrT9CeXFqTQDRZ+yTVvO6frNclqkQTshLWkAfBplk0hmdJcGjN6IoICTUXFiMeDv8lnC83uFDh2T+blOx4ImW69ygEaRA=
Received: from BN3PR03CA0067.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::27) by SN2PR03MB2272.namprd03.prod.outlook.com
 (2603:10b6:804:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.23; Thu, 30 May
 2019 13:18:20 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN3PR03CA0067.outlook.office365.com
 (2a01:111:e400:7a4d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Thu, 30 May 2019 13:18:20 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 30 May 2019 13:18:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4UDIJGp024234
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2019 06:18:19 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 May 2019
 09:18:19 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/5] iio: amplifiers: ad8366: use own lock to guard state
Date:   Thu, 30 May 2019 16:18:09 +0300
Message-ID: <20190530131812.3476-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530131812.3476-1-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(189003)(199004)(36756003)(47776003)(5660300002)(316002)(6666004)(486006)(7636002)(86362001)(305945005)(14444005)(1076003)(2870700001)(106002)(2906002)(478600001)(356004)(26005)(446003)(2351001)(2616005)(336012)(8676002)(53416004)(44832011)(11346002)(426003)(126002)(476003)(50466002)(246002)(48376002)(7696005)(51416003)(186003)(70206006)(8936002)(6916009)(70586007)(76176011)(107886003)(4326008)(77096007)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2272;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87cd3f18-4b89-4e9f-a628-08d6e50148eb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:SN2PR03MB2272;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2272:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2272B6AF8CA52E9D21759629F9180@SN2PR03MB2272.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 00531FAC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WKwxg0paOM/KFgy+f0yCbjInnnu+Tg7c0GPFmAx75KJapPYD6sHRi2+ZNFZY2ei/uaYmDmK/HzFNhPxX4/Bvk9RDC1q9CRb0zcZ/fzX3/qMw4HWqL+JNtI5PlPnEaT1lqiNcj4TgueqgnSpE4POoGcuGkt69z1JunIOyaedkLx8lDvGvvLKl/nlFZqDAPUvxwKL3jmWSEVSV9AVVYMA0XWoDyEahlz0iDYIMcjMelnZtQAwcecUA05iy810v/xHq/VEV2l9G68tswbkCVpVeTUpB51Y3SKU9uwy9iKHGGrcr0+VUvJbx6LISb/20Bx1lH+0ML9/h757L+O9ksY61Rnp0fPJRw8dQfyOEyNB9R/UnJsq6SBmg1WkEyTPe5DgJe9WWE36sJqZKHg1yzSCiUTaNcJYpmKU/6lUU98x1oXY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2019 13:18:19.9704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cd3f18-4b89-4e9f-a628-08d6e50148eb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2272
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver is still using iio_dev's mlock to guard against inconsistent
state. This has been discouraged for some time.

This change switches to using it's own mutex, defined on the state struct.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 82ac15914ff3..24ff5475d9f2 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -21,6 +21,7 @@
 struct ad8366_state {
 	struct spi_device	*spi;
 	struct regulator	*reg;
+	struct mutex            lock; /* protect sensor state */
 	unsigned char		ch[2];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -58,7 +59,7 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	unsigned code;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	switch (m) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		code = st->ch[chan->channel];
@@ -73,7 +74,7 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 	default:
 		ret = -EINVAL;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 };
@@ -99,7 +100,7 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 
 	code = (code - 4500) / 253;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		st->ch[chan->channel] = code;
@@ -108,7 +109,7 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	default:
 		ret = -EINVAL;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -151,6 +152,7 @@ static int ad8366_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, indio_dev);
+	mutex_init(&st->lock);
 	st->spi = spi;
 
 	indio_dev->dev.parent = &spi->dev;
-- 
2.20.1

