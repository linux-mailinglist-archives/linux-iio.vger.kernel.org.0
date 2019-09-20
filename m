Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143CAB8C3C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437717AbfITIEH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 04:04:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31388 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437716AbfITIEG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 04:04:06 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K7dMca032763;
        Fri, 20 Sep 2019 04:04:02 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v3vbqc678-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 04:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfG3ZsjNq2wkVk2noulrzsOFOP8qfyP7bUOza94RUWZj4kRzDktS4Nu8ca5fBHXkEZMZSG5mfSbOFTt1f0icXHIwZuFCRoxnDDagBPN4UK1Aza2BJaka4j6gmIHUYFfY3ixua9TpeE3tFvxFZhkCdlx6CULKsL15qPULIYAqv91SpKJiaix6rql5G73eOkpcpxiCXujZKiPqWGRaeLj61SYO/D0QY/goQC4/VdG9F7ED7U2KFILt/nQcD6kg6qS9+PKXcDgKSegv2g+d10RZus2kKzOvy0EspcjOh6TvywhjYJl24aa7A5pGK8dpbARvQwYRP9I1WwhlfqDudg04uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rq9RpTIUEOiPv/sMLrDz0QHOmkjz0GtkoEQV08FkyU=;
 b=Rd9V7aAuXz6KFZ+Gwy2rBxd02LJRmXyV/DPYnp4pqpzv6u+7lXfddpi0Iq/CMgJ9V/KLos57qlfe1W8wICvw1JHtmHoV1aQbc7fqdHSTsF8PQwz5ZBPE0m632E47308YGiGNA3gof7gA3EqgRfU1wi1QYIBcQzWygQBoBZMb8HuBlkQQTzlx6YLX5UIsUtEUfBsYF7e8LqOBd3cjoI/UVq7CByP15+NsWBwznWJxx2CBS1ieFGaIMB2u+eOcYOdF/0qb1vIlFY7zEJjbhmQRVoHntnLkBL9d5YG2yTu7YFmC1Dm6RKi6mPHjSWZdzZpOxlZfcddqBbdMg6YjytLo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=parrot.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rq9RpTIUEOiPv/sMLrDz0QHOmkjz0GtkoEQV08FkyU=;
 b=deL8aM36Q6qiANti8/LpsB6lhXFhhdREJfgCafzJiVVDXAy7Qf8PVhg3lG/q6yHFzA8gbNVBuAPQwZqV+66Jqdj0AkorOZEB0gKkgf2orVkao9gzAwSEeW2RXD847RsIqUHItemhIQxXVFsIiNwsy2kkzhSyYrU7cVlSW0j/R1M=
Received: from BN3PR03CA0097.namprd03.prod.outlook.com (2603:10b6:400:4::15)
 by DM6PR03MB5162.namprd03.prod.outlook.com (2603:10b6:5:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Fri, 20 Sep
 2019 08:03:59 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN3PR03CA0097.outlook.office365.com
 (2603:10b6:400:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Fri, 20 Sep 2019 08:03:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 20 Sep 2019 08:03:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8K83wIb011149
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 20 Sep 2019 01:03:58 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 20 Sep 2019 04:03:57 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <gregor.boirie@parrot.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: pressure: zpa2326: fix iio_triggered_buffer_postenable position
Date:   Fri, 20 Sep 2019 11:03:48 +0300
Message-ID: <20190920080348.29995-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(70586007)(70206006)(4326008)(246002)(8676002)(44832011)(36756003)(2906002)(106002)(8936002)(54906003)(486006)(2351001)(2870700001)(7636002)(107886003)(50226002)(316002)(48376002)(50466002)(305945005)(426003)(5024004)(1076003)(6916009)(86362001)(2616005)(7696005)(51416003)(478600001)(26005)(47776003)(186003)(6666004)(356004)(5660300002)(126002)(336012)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5162;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c0f30a2-7296-4ad5-2dd2-08d73da11796
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR03MB5162;
X-MS-TrafficTypeDiagnostic: DM6PR03MB5162:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5162A511C645E8D2C95D94DFF9880@DM6PR03MB5162.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0166B75B74
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lw5iQrKo10fvTGbaMyJrr25y4nRIuY4fFVJgUQiwZLCZII4woCPkZh0qShxNA7v59vBoaiKo6j/CkNfBu+oAmt02aZ5CLo4HAWu7zmo3SA+DzfYbULRk8sfeWxcI9g27Y+7AaUVaRDh/C6zuHhFHPID2ieJyFITXoCQqLe1jLroUialhyNg5hTcaJNvd1mq/LGWeLxMngWfmTKPTlrj2x/sy/59ePG/hK9zbSKck8/ARx9Wi/e4eZervORp32iFpYqA+RzCA9v/VABRM0SVpCTBs0HGHtYyPZ0+l+Pj6lPUIL9/c/EYXAzXbwXR4tbxyXxua24TqJ8vQADoG2Vkab5YE3z/N2ODbhJYcVpJP3q60OjHVOPM5eciGHXBheoiw39YSW+U1X+Tg2IDr9iw+ETuIZiMi+iukn+rNBa1xw8Q=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 08:03:58.9810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0f30a2-7296-4ad5-2dd2-08d73da11796
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5162
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_02:2019-09-19,2019-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909200077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

The iio_triggered_buffer_postenable() should be called before (to attach
the poll func) and then the

The iio_triggered_buffer_predisable() function is hooked directly without
anything, which is probably fine, as the postenable() version seems to also
do some reset/wake-up of the device.
This will mean it will be easier when removing it; i.e. it just gets
removed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/pressure/zpa2326.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 9d0d07930236..99dfe33ee402 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1243,6 +1243,11 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 	const struct zpa2326_private *priv = iio_priv(indio_dev);
 	int                           err;
 
+	/* Plug our own trigger event handler. */
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err)
+		goto err;
+
 	if (!priv->waken) {
 		/*
 		 * We were already power supplied. Just clear hardware FIFO to
@@ -1250,7 +1255,7 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 		 */
 		err = zpa2326_clear_fifo(indio_dev, 0);
 		if (err)
-			goto err;
+			goto err_buffer_predisable;
 	}
 
 	if (!iio_trigger_using_own(indio_dev) && priv->waken) {
@@ -1260,16 +1265,13 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 		 */
 		err = zpa2326_config_oneshot(indio_dev, priv->irq);
 		if (err)
-			goto err;
+			goto err_buffer_predisable;
 	}
 
-	/* Plug our own trigger event handler. */
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err)
-		goto err;
-
 	return 0;
 
+err_buffer_predisable:
+	iio_triggered_buffer_predisable(indio_dev);
 err:
 	zpa2326_err(indio_dev, "failed to enable buffering (%d)", err);
 
-- 
2.20.1

