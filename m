Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4760DB7746
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbfISKXP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 06:23:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:39958 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388940AbfISKXP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 06:23:15 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8JAMwKj023304
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 06:23:13 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v3vb5swms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 06:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnazmX/lXEqakLWPpZt9NZvO84EPSVWV0qVy1jgRGs+CHV4DwbiEqRYDMtdRiL93VKkYVCclEfJZ7KlJO30EyuDoJbzg+GvCDjmR7TqQ5mISLGXFllQQ+qvJ8Yz3oa4K+tdihOG3r7Nc2j/mlMmrnP1QW5JIOgFw8nL6yEMb9uxT5e05d3CdBLxhlqFgIDhM1WFAqB89poRrJSGJe2pRm8tkj7HWugDaVrxfWyWe3TUOGW1N41C0OR2PkVSCkviA1X5ASu6mp9o6OmrWLcSHzB0SE+Gefmd35wHtFoofLZaM8J6XjiM/rKx0H4JkVlx11gPR5hn0j/4Rr/Kc+lK2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9H/l2LjEMt9dlM2X6oNxKtsyblbdaZ23sj8qp7hVAY=;
 b=MB6FwwJ5T2r2kztH2s5wW/sbmEhn+3rMuDLvZ93xv8m6nsIisxiCgHkIpm9Q6M1gD0r5xlCWwoT5F4lFRL56n4+TQChko8NCQZlcMUVg+vgm7zfPAnz3EAdFrSJtB6AwuXmNLuRYCFwsXxOmiMT7yb5ZrqpssyZKT+3+nR0gWFVVSs+t3sJyFsdr2xkTLHi2H8Iuuhpfv9xSFNZrv/YHiJ0TVN28VEns644fKLjtgiy3jGq38HKcyzZfCONp79XEfSXWV3nRQrPXU1zBlXXts8TbY+LU2o+v4Ya4+aoxTHFFN5dEqoTwuZXZiepXG2ZxVyzeBR3u15S6qvUnxxFapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9H/l2LjEMt9dlM2X6oNxKtsyblbdaZ23sj8qp7hVAY=;
 b=6TEnP8hgIAZ/4VO+Wn1M+IHGDScppS3bF21Np2X4UIxpRnPM0Vfj9HpaKtAjCNt/Q1JD6UJ34brD8MMxqikx0INedvwH2KntPl2V9vzppd45Fui/BcbjAf4yn+B6rrYK6IRJE25cWBMkdCHY5G+CBW4nwxzOoguw/MQXf/TyHis=
Received: from DM5PR03CA0053.namprd03.prod.outlook.com (2603:10b6:4:3b::42) by
 DM5PR03MB2441.namprd03.prod.outlook.com (2603:10b6:3:71::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Thu, 19 Sep 2019 10:23:10 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM5PR03CA0053.outlook.office365.com
 (2603:10b6:4:3b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16 via Frontend
 Transport; Thu, 19 Sep 2019 10:23:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Thu, 19 Sep 2019 10:23:10 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8JAN49J009610
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 03:23:04 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 19 Sep 2019 06:23:09 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: gyro: adis16080: replace mlock with own lock
Date:   Thu, 19 Sep 2019 16:23:03 +0300
Message-ID: <20190919132303.9663-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(336012)(7636002)(2906002)(36756003)(186003)(2870700001)(44832011)(356004)(1076003)(106002)(51416003)(6666004)(7696005)(486006)(14444005)(426003)(2616005)(50466002)(2351001)(86362001)(70206006)(70586007)(26005)(126002)(476003)(6916009)(47776003)(8936002)(5660300002)(107886003)(305945005)(316002)(8676002)(478600001)(4326008)(48376002)(246002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2441;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a47ccce5-4bbd-4e2d-89a9-08d73ceb5ee8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM5PR03MB2441;
X-MS-TrafficTypeDiagnostic: DM5PR03MB2441:
X-Microsoft-Antispam-PRVS: <DM5PR03MB2441570621C43D7F21998C04F9890@DM5PR03MB2441.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TTE1peHDvhxr7w7uIPRi0P0Os7UB5gL8yZQSrQjwRFo/sj4mzk3f4L5rp2kHc/DNDzR5FmPUAvXP1SvkgO9tjz+xHU+unsDQlelr/K6jxCwJMCbQqUNOO0YtR0g/ozRWJegGxyv0Of4SF+fSNPVBWGJd1XA6eWsRIGcgMJuhtzIVSvRmWT5Jw0X7sU5lfhTiHjqrf+tAa1DiaWB2dw/1+eFG6LvSCrhptbl07rhAGUqoigFAYLPr+M8ZhOxCX5kkXPhHxDIlqtOTLedXIPIDRz4+ie/x/FXMfX8VkmiroExEYz65Jvub/7XiQSgSM9gcejWYYRZX5u45o8gmqjJC3ZLDioJ/H0Cb9m7n2UhHpFZX+smNbVZicZL6TfZOBh4zRsaE59+hjUpozmIYM3tKBtdWSXQmnLEulQE2ocHVl0I=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 10:23:10.2412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47ccce5-4bbd-4e2d-89a9-08d73ceb5ee8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2441
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_03:2019-09-18,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=1
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=933 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909190098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The lock is used to protect the buffer during reads. Though the spi
routines have their own locks, it may be the case that the buffer needs to
be protected before it's stored and passed to the IIO read hooks.

indio_dev's mlock was used before.
This change replaces it with the driver's own lock.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16080.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index 236220d6de02..1b84b8e112fe 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -38,10 +38,12 @@ struct adis16080_chip_info {
  * @us:			actual spi_device to write data
  * @info:		chip specific parameters
  * @buf:		transmit or receive buffer
+ * @lock		lock to protect buffer during reads
  **/
 struct adis16080_state {
 	struct spi_device		*us;
 	const struct adis16080_chip_info *info;
+	struct mutex			lock;
 
 	__be16 buf ____cacheline_aligned;
 };
@@ -82,9 +84,9 @@ static int adis16080_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = adis16080_read_sample(indio_dev, chan->address, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 		return ret ? ret : IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
@@ -196,6 +198,8 @@ static int adis16080_probe(struct spi_device *spi)
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
+	mutex_init(&st->lock);
+
 	/* Allocate the comms buffers */
 	st->us = spi;
 	st->info = &adis16080_chip_info[id->driver_data];
-- 
2.20.1

