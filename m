Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50E107339
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfKVNaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:11 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24100 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbfKVNaK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:10 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDN8Vf006098;
        Fri, 22 Nov 2019 08:30:07 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wabu7myuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js/jrLQ4YCXZbFjhXXjBuSDd/Ii5h/f/g8cqpMTQNgx6YuJGYCFpPtTWMibWnZK6RJSC2AmbsVyhWUcVEO0CuX+2qYyvp2gYxQuUTREx2OE+x0AUnZMxnxHZKFXsZzIPp8VyQ9QlPUhf/x7Krvwd7X+LzvArzkU0c/F4SvHjmNpoXuB9hleZmGyDD4+rlDQ2DUIAVn2BMw1yde34iaE4GmT18Fuos9PfCOdG4L/IbpkNEYRwv6J0YnYLoy8IRwZlqXeg0S5iw58wQPVthj63aDKGOJQ782qGHUhbAGYrdDqT/oIPTbGeDPtG2VeI3yNyETEzOaXz4/kkJyOdxc80NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yOwAaQjdU112y4txRQ75SDbU1oDb3E940kZ7t80gEo=;
 b=ArK5LZ4wtAqfS8F3PkO6eBSy8MNkP82aNnzJciLvXyosrySC0iuSPlW2lp1W4RRQFypVfEFypn2FG3bGirR4fpHTQPxVe53bTsaCVB2Em8ArInq4PnQ316ub4Jv4fvN+L214NFrW5nXNivnkMDOCiyceZKJeDgRVXs1rL580Jww+HaokBeJcSihxjREm1h9QHgduBMXgQaEB35Olee9HH2Mpt0oT/2WxFUgmEPqcfYNzxnXsSMYUNMyWllwKF/ePuoj/4Cp8QhCno+bUlOEVfI5X8mN0C6K3cGwHsczo+9Ug+hlSUAW4ccvg+O98Q0PKq7uJtsAwy4eoINnrHPe57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yOwAaQjdU112y4txRQ75SDbU1oDb3E940kZ7t80gEo=;
 b=6OqBkMyljXzJLQKvcyCkOL/iQlDWDdP7glP5njfIXyrorLp5EiedmRrSgiPB7g2nBkigeXs8TM0gLNeq6QbSPbbX7xFr6gxAma/ZaVu1dqDIdWbgl+ij8IsSBNUwcFsedgxjE0V1QTmZTEezFO913/jBhF4ZX1dGQJqN8KI9goA=
Received: from BN6PR03CA0115.namprd03.prod.outlook.com (2603:10b6:404:10::29)
 by SN6PR03MB4590.namprd03.prod.outlook.com (2603:10b6:805:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Fri, 22 Nov
 2019 13:30:02 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR03CA0115.outlook.office365.com
 (2603:10b6:404:10::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Fri, 22 Nov 2019 13:30:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:30:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTrug015814
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:53 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:30:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 07/11] iio: imu: adis: group single conversion under a single state lock
Date:   Fri, 22 Nov 2019 15:24:17 +0200
Message-ID: <20191122132421.5500-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(7696005)(8676002)(51416003)(8936002)(2906002)(26005)(305945005)(86362001)(246002)(76176011)(47776003)(70206006)(6666004)(356004)(14444005)(107886003)(186003)(50226002)(1076003)(70586007)(2870700001)(336012)(2616005)(48376002)(478600001)(11346002)(446003)(106002)(426003)(4326008)(7636002)(5660300002)(316002)(54906003)(44832011)(36756003)(110136005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4590;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b05cefba-75cb-42e3-fa30-08d76f501475
X-MS-TrafficTypeDiagnostic: SN6PR03MB4590:
X-Microsoft-Antispam-PRVS: <SN6PR03MB4590872ACA1F80837E0C3CA8F9490@SN6PR03MB4590.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aC6zPktTZzbFqlXj2cXcPqp6um9O/OQU8uh/Mr9zrFx8NFITaQj4WpA7sMAg?=
 =?us-ascii?Q?2WoqbKTQUOFzoBxlJRCIOrqEPySt+SLE49Hpl10b8/yGOUlDq0qXB6kxiZGe?=
 =?us-ascii?Q?nnjqBZ5IhSMaoXtrKbeEt+Z5Y1WzM83VS1nSTVhdaSvcZ5dXpYbuVlo1+oIQ?=
 =?us-ascii?Q?z1PiFgimT8LC1eYGWORJ7rWPZpbxNkUE/HharXujXH9lou8cPtDB8gpLpT+T?=
 =?us-ascii?Q?Kg9EDQDVupN0vbjo5uekwurN6AGBWg/I3/7faP9TzmUrfeRhu6y+93HK8xVg?=
 =?us-ascii?Q?l4kAUwZDCnFF1JGktBo61dnGmN+FGoXRhX+crFQio90sFS4gjXyyYWx0eqlL?=
 =?us-ascii?Q?LY+dnRSMbXwhU2z2i56GGoxqZFJJFCETH7iiFuh/DMbL3SIj5zvxFEY3WfjD?=
 =?us-ascii?Q?rCYuqzusV648H+0rU47rDV7UwPa5o075VIpNM9xEaPzwhxneQTM89CT+fD03?=
 =?us-ascii?Q?gjJNa2winhiR3YFepAKWdU1LK48RANrjOGp3IhUPstwcom/mvF/1nlQnvmH2?=
 =?us-ascii?Q?ZqFb6sW8euUgMfXkoMvAV3CAx0spy4qg37+k1NLc7PqohsnuFXv5PbyOg0tA?=
 =?us-ascii?Q?ihoeDlxkXRAV9RxFto4PAr3gDVhOiiVItDBu1u0uOfo/oolrpBdyQgZB33Aa?=
 =?us-ascii?Q?XGHQkwTUd24in3DXBHuyZdSsXyQVSyIG1hnChDmZRw40L4wNaFdivmf0nQkn?=
 =?us-ascii?Q?Iax+B44JLdw2MzK1YRx3EzG1LPsx0jP2jB7L9okAYuNRS7GX1577GSPyPRK7?=
 =?us-ascii?Q?5UveJvLVOkq8qXXEINNkEJMtjHeLDTwYft0W1Nl5SDY3pvw7QgQQ4LNAr3fY?=
 =?us-ascii?Q?BIZZ/jkCynGBfTLmGGoplZrgOF2B15+KSIWfg2qHotqfYaNwpkAmdiSstNHh?=
 =?us-ascii?Q?k/X8eLJ0gZYE6Qw38YQG1dTFmnefIdAmUu89BnB4QbJ4bor9q1i5mKaNFQZk?=
 =?us-ascii?Q?m+duz1mxHvN0xi17MyWhvZbJb/sXuLQ9Xu4YxUTEIVI3woo5kZBw6Wlr3YoU?=
 =?us-ascii?Q?vwhkBxkzBOmDh7UWgbQprRDFGJZ2fnXGgPDlzBCwv28nTCK9vfCSLcQaL2A7?=
 =?us-ascii?Q?1ALmx9rS5Esihj8Wad87joEaGnf6+PqCPtkBqv7yda53AKb/pzgKgKld2pLu?=
 =?us-ascii?Q?Jlqr/7wvL07ThrcCKNzhD6vFbRs1sPoye3IsSh02ztcGhd813ZEe8+L34zJx?=
 =?us-ascii?Q?cp9Zku3qgEd5BJ5tJwtSM2G1/TyIB4wzL/mOLtX8XEMeRwbsh2jqxO2xW6aN?=
 =?us-ascii?Q?o/Wsp84wRxNAr88ReKxXSxUG7s1uaKZkFlzW66d9ioqesuJGB8cu9Q/fMBDI?=
 =?us-ascii?Q?cprVK58wsF/8AtBgjMALTFylIIXiddcLFc9QmA3dVtnAPCqfwKqvQ8+OYCT9?=
 =?us-ascii?Q?dgJfHj9yQDcArByjJSvg9UR1eSwzF7Yhz4mfRYcFL3N61o8izEj/Jnd3x1UY?=
 =?us-ascii?Q?8OrGMqo0biS5vD7jwEZqg7SRzoXJart2?=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:30:02.7147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05cefba-75cb-42e3-fa30-08d76f501475
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4590
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The single conversion function does a series of reads + writes. This change
extends the use of the state_lock for the entire set of operations.
Previously, indio_dev's mlock was used. This change also removes the use of
this lock.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 10b8922fd51b..c53f3ed3cb97 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -404,15 +404,15 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	unsigned int uval;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&adis->state_lock);
 
-	ret = adis_read_reg(adis, chan->address, &uval,
+	ret = __adis_read_reg(adis, chan->address, &uval,
 			chan->scan_type.storagebits / 8);
 	if (ret)
 		goto err_unlock;
 
 	if (uval & error_mask) {
-		ret = adis_check_status(adis);
+		ret = __adis_check_status(adis);
 		if (ret)
 			goto err_unlock;
 	}
@@ -424,7 +424,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 
 	ret = IIO_VAL_INT;
 err_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&adis->state_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adis_single_conversion);
-- 
2.20.1

