Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08267CF46F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfJHICo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 04:02:44 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25300 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730177AbfJHICn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 04:02:43 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x987wM3I022632;
        Tue, 8 Oct 2019 04:02:38 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2054.outbound.protection.outlook.com [104.47.32.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2veqt5ad2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 04:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBjLXW9vaG2ZK5qDgj6DNcHboz7M/4YUa1Gft5hKPq8t9pwV99RBZoVzfDy6nMmhxjFlU9Iouq5IGX1RFh2a4kcyY4lV0UF3pZDCyC21rEOfdxHS+dUn6tY8/3C3z0QQw5z4U55+az2AlbRpk0Vg5yVI5cXxNyfKnvR8PqVoJKWAP+6uRvGZsljJVShra1e7/9vpA6uHu68fhwJN0+p8+wcNRU5SfV19vaG5FD3cTdvKtnVMoz/gXUqepJaJ+3X2yjHSTuDgek4C1zPgV5ZNcUS9pv9tuyjWKRifZT5Uq2DU++Uuq+KEkBwN9bztH8jkyXibIdftpT5i1HtWDMvT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hYgFSfSLQYfq4klBdlmFr3x/u1kTfkQe/5PVA74O7Q=;
 b=UYCiPOlRbcnI11pbw6jI/mmtJTJbmu1uZ9E7kjqgL4I7G/6Z2eZO69/DT+RfZ7rY/z2CaBegC9d6i3fziUpAa5kSgHp1CaV7+xx6X7akZnFwtTW459YHcyYBlVCBl8RKsNIjQdCDgIE9RGr+unMgoA8Sb8Fx77IotJ6AzpF2GsWJSG1RVWpWgnOdu+iaPNAVGcrraaQTSrS0ux9sQ5262sIsCxD4xDkUmRF0NCJplBuzlNPcIlBSIKxh8PE1t6DVgGWW5iCCO3W2RNOR05zsozdJRcTmZ4ymJHmHHU4SqcFU89pgtxhBal3ixiq0+L4VJKE9mGKpX26KrMj95Me2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hYgFSfSLQYfq4klBdlmFr3x/u1kTfkQe/5PVA74O7Q=;
 b=w2KIXEJDx2/Ei5V4Enm36e0T4uHCG73Wk9kWx+8vo8Z9iJzh7E25BiMcf/Q5kQFbhk3yhwQgLLYWG1xPEPNzuC8JtshSSevj+FYCszrOD2wqudbQq6c2dvt1EFMTOhWSXAPzp8Q+v0XeA105DIB6D6aVVBzNUU9O0iggtvqQIHQ=
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by MWHPR03MB3007.namprd03.prod.outlook.com (2603:10b6:300:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 08:02:36 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 8 Oct 2019 08:02:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Tue, 8 Oct 2019 08:02:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9882ZCv014035
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2019 01:02:35 -0700
Received: from saturn.ad.analog.com (10.48.65.130) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 8 Oct 2019 04:02:34 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: imu: adis: update `adis_data` struct doc-string
Date:   Tue, 8 Oct 2019 11:02:38 +0300
Message-ID: <20191008080239.23239-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008080239.23239-1-alexandru.ardelean@analog.com>
References: <20191008080239.23239-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39850400004)(199004)(189003)(1076003)(6916009)(336012)(356004)(126002)(5660300002)(107886003)(476003)(2616005)(15650500001)(50226002)(86362001)(8936002)(2351001)(186003)(486006)(478600001)(70586007)(70206006)(50466002)(44832011)(26005)(7696005)(51416003)(76176011)(446003)(54906003)(106002)(426003)(4326008)(36756003)(47776003)(48376002)(316002)(8676002)(2906002)(11346002)(7636002)(305945005)(2870700001)(246002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3007;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 650e4290-55f7-4896-56eb-08d74bc5e18f
X-MS-TrafficTypeDiagnostic: MWHPR03MB3007:
X-Microsoft-Antispam-PRVS: <MWHPR03MB300776740DF9E910F0548993F99A0@MWHPR03MB3007.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 01842C458A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiD2qwHIzl6ox+P1kR48BtMs15YBmJySWUzCnFbxLk7jUTkGbGKy/xd7UAD94tLgMl2De/Qb6X4CTOqV16ju9K38zXQKldqQWaOh8z0anvYbh/D0SWie6Q+4e2DA7gYE7w9mzskkqx1dhme9UGMWSBSlTd7SIoJyGHopKEZUGzdKmzGsVMplzF3gPFK9T5Kld823sjdNujd76Msloy7+2ct9zpA5ahtWjALYzpETnaE3Xte+zoNxgCoqbZoRkH4dszLnuIM/RSDHg5Ff96w+rr8kjEFyWHgG2PjQ1yKxD+J6aA2wbZ9Z3xZTAkaW1d8DOMVxyPdoafNLjo9kMpzFR0E7dxv/zTDeT4E+seQAbghE5UT2oGmU1YgOWGKl0XLaNQipkn+P0IdBXzchJZKQUaronycJ7l4I/y9uoMeNp4w=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 08:02:36.0041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 650e4290-55f7-4896-56eb-08d74bc5e18f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3007
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=1 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080081
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The doc-string has been neglected over time.
This change updates it with all the missing info.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/imu/adis.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index dbdf421d35dd..27ebd740f626 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -30,8 +30,13 @@ struct adis_burst;
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
- * @status_error_msgs: Array of error messgaes
- * @status_error_mask:
+ * @self_test_mask: Bitmask of supported self-test operations
+ * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
+ * @startup_delay: Delay in us to be used during ADIS init routines
+ * @status_error_msgs: Array of error message strings
+ * @status_error_mask: Bitmask of errors supported by the device
+ * @enable_irq: Hook for ADIS devices that have a special IRQ enable/disable
+ * @has_paging: True if ADIS device has paged registers
  */
 struct adis_data {
 	unsigned int read_delay;
-- 
2.20.1

