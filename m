Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873CCCDD37
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfJGI0s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 04:26:48 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37454 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbfJGI0s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 04:26:48 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x978NJ48021619;
        Mon, 7 Oct 2019 04:26:41 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2051.outbound.protection.outlook.com [104.47.48.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxaqqf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 04:26:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRvPb9mFr/ynfIGgEByiq1SieTCp3zt7tQgz1Enz7LYJGQZTITf+9fYOjTq9rwDhW/Pu6Jas6nAyzpqcm3oRQsfT+qvfbVanGkZxpQSQSMhUn8DP/KEQ29BC1l3BYA0lL1CIeX0+ZXVCN52WLDQUuWvkSD6z6UWez8jlm2PG9ufcHP/jDMCsnFhQfeam+9OeOtKZe1hpFNjk4trTufg/x/K065/XnMdSY9V+UdKh2l+Z6C3PwmZU/hqhTP1VGbCO97oPxhJSpCmJZFFeO8IfJarLY+XULPBsqs9HV9uoiloRb+4IFhFMUGDqJ8tV60Yfj8iK4ZxOFzLCzbqB3c7Png==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulzZd9TGMIJAZIxZJ+F+jnNp5VpiH7n62WWGWi3gBh0=;
 b=WWqgtEcd3+l0UWlaEfqHEYtfJkgD3dW00owT3zIm1qUNyPVT4OniAqUZEV9WExGwNp8VZEgX8DAuZ+zBCoQ0ZTviYFrAJqzaZQlxBr739TJy7u0XAM1DeUjNeW1kN+TpudGbhRLrsAgVE0pzFOwMyJzXlJkBLHdL9A3SKQW428M3MNF9PL25ybOj/buxiU7RYLOs29wc/do2E4BD9Bhey0XlDfoiY2MKIs5mJD/6a9fXLcvq6V8ldf3UcZBsJVcyThdSxatEVJ8PN7AeXwCFX4xpjr64HqhaYl6TmZe5GcWzgp5qYfBRhvee+N+RFg5VCDX0DENqEZjhLivz83yBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulzZd9TGMIJAZIxZJ+F+jnNp5VpiH7n62WWGWi3gBh0=;
 b=Ywu8GKfZgbA9xopTE+YUBTT29FFsGDhtaf6109aYZa+FKB/WIWU8oBO1PYub1UXd9LuojyLB2l9TB9+iI4e7bbOXsepZEfHmeIplsJTDmMpFm7NtMDzlPgSoCwW81iK2LetED2W75L/KTZrwoe8LwUC8ClrqMVD5dTZoD9EYh9I=
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by MWHPR03MB2685.namprd03.prod.outlook.com (2603:10b6:300:47::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Mon, 7 Oct
 2019 08:26:38 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Mon, 7 Oct 2019 08:26:37 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Mon, 7 Oct 2019 08:26:37 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x978QVZB028843
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Oct 2019 01:26:31 -0700
Received: from saturn.ad.analog.com (10.48.65.130) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 7 Oct 2019 04:26:36 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: dac: ad7303: replace mlock with own lock
Date:   Mon, 7 Oct 2019 11:26:42 +0300
Message-ID: <20191007082642.21798-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919131328.13633-1-alexandru.ardelean@analog.com>
References: <20190919131328.13633-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(189003)(199004)(54534003)(44832011)(2616005)(1076003)(4326008)(246002)(5660300002)(6916009)(8936002)(54906003)(426003)(106002)(11346002)(305945005)(107886003)(446003)(2906002)(336012)(186003)(50226002)(48376002)(14444005)(26005)(486006)(126002)(476003)(47776003)(70586007)(50466002)(316002)(86362001)(36756003)(478600001)(2870700001)(7696005)(2351001)(51416003)(8676002)(6666004)(356004)(70206006)(7636002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2685;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82a94431-e808-4a15-c008-08d74b00125a
X-MS-TrafficTypeDiagnostic: MWHPR03MB2685:
X-Microsoft-Antispam-PRVS: <MWHPR03MB268528A5F3B342DC551CC3BEF99B0@MWHPR03MB2685.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 01834E39B7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3GkWRbvnRkfEfLcdXP4NRg97M3/iGajQSX+iF25j3pWvwjGNbL2dQ9L1NCQh2OxhaaD+PFrmZp4c0wq9ETPcVBsedjbJ/WMpZZYvl/zE08T5UuJuhoYMoMyDlxzvpIHDQ+lnNKq104eFn3/BWL18d37PVJbkszD8hW2o11bn/ssF8wN0JN0/aJvdUaVRiVmLcpWHxqShClfGSzR3IJDkDN9D4QCaVTcAlYO/CwsrY67JfRjTkhk+T4bG9Bx06k072i9IEAtkclGpFDjt6+qXOhwsCczxxqeN0DwIGXJd2BCfCZdjd0MNrCOxVkKsc5zfd8ESeNGSYdyTmfrjWoHgBdfpxutLM/SVK6ye6P93Lb2N+ZeQHSipiIw3JeoabJpmZpeVYaAlKNhXgCM+F2HjSbr/JPN/nH04k8TVlIeJPM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2019 08:26:37.5834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a94431-e808-4a15-c008-08d74b00125a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2685
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_01:2019-10-03,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=1
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=855 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change replaces indio_dev's mlock with the driver's own lock. The lock
is mostly needed to protect state when changing the `dac_cache` info.
The lock has been extended to `ad7303_read_raw()`, to make sure that the
cache is updated if an SPI-write is already in progress.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* remove lock from `ad7303_read_dac_powerdown()`

 drivers/iio/dac/ad7303.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 8de9f40226e6..14bbac6bee98 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -41,6 +41,7 @@ struct ad7303_state {
 	struct regulator *vdd_reg;
 	struct regulator *vref_reg;
 
+	struct mutex lock;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -79,7 +80,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	if (pwr_down)
 		st->config |= AD7303_CFG_POWER_DOWN(chan->channel);
@@ -90,7 +91,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
 	 * mode, so just write one of the DAC channels again */
 	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return len;
 }
 
@@ -116,7 +117,9 @@ static int ad7303_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
 		*val = st->dac_cache[chan->channel];
+		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		vref_uv = ad7303_get_vref(st, chan);
@@ -144,11 +147,11 @@ static int ad7303_write_raw(struct iio_dev *indio_dev,
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = ad7303_write(st, chan->address, val);
 		if (ret == 0)
 			st->dac_cache[chan->channel] = val;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 		break;
 	default:
 		ret = -EINVAL;
@@ -211,6 +214,8 @@ static int ad7303_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
+	mutex_init(&st->lock);
+
 	st->vdd_reg = devm_regulator_get(&spi->dev, "Vdd");
 	if (IS_ERR(st->vdd_reg))
 		return PTR_ERR(st->vdd_reg);
-- 
2.20.1

