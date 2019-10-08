Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82DAECF46E
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 10:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfJHICo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 04:02:44 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25344 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730468AbfJHICn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 04:02:43 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x987wXgr000787;
        Tue, 8 Oct 2019 04:02:39 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxatvwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 04:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADsGDlQ43aAXctWt9pMI6o0ZPmQIajEAoayfIQANYB1A5V27KQRjr4eiFxl8LPew6X7yvV75pV3jxhGiQz+PcpY8ox5gkrqOhxj6wKbYbZ+tJnXeM8KC5PJv+fgZZ3KfEWl2LNTr/j/MtfcaCfQ5OVy9O87QuUs1LQ0U0hF+/I74++tiW9fQe4C290ucwBSGfZTPTVKExU6+N1zx1ZEc3C0CtElfiduyPoLEEy9I4CMPsD9ZZIrJAujI2XJrrot3aT0J0QtDKzlg1186KST+Hc0dblD3fKxYg8H/J8A/rdv9pkWNBZrsXveuIk/jihw1cQcp2lWRVHRALgQRVPkpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf0E1pjD1amJPaE5EuqErhiU6zsjah7ZrcbRKg7cBzQ=;
 b=PTRxVo+oCCj1SHVDAxhqrfTF6IS6q8ZOticZ6g9zX8FB9+N1zhbRumYPGyutTvggg4hwo6KM6yEBnDD2kzb+LiiE1fItVOLI/XAP7bag7ivVBiuNoQ3ygYSdTGv/IaoUvd7qcfMKvsJd2jI8bwMVYw5+112Z16N+VzRUZqsAyfyHoLAl3Q5KGIE/VJE1/a4a0Q0RK7qUn62nELxe/b89boxAkBdYuvLrP4eihi3e/me9+fEEO4zAKMgJZ36u6pvBpkVykwqF9eQri++Haf6KXXibL6mtsVRTw4RPyRRj0DIdR7xffkTW7OXrMb5ybczQmkta5c81El4uomt/tlDWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf0E1pjD1amJPaE5EuqErhiU6zsjah7ZrcbRKg7cBzQ=;
 b=F5EXFaqKzGqXu2awBw+fmjnupJXpSe5tjBt+tHytFoHo7nUYiWeMYnnedJECrpGPrM3LGFTTm1huAZM0LhaquSPWvXVSktrFz08GoTNqEk77c+sp7qppw57pcL+9tPTgvaL2mtyTkW/7r9O3x5tDUcCe/7NGWNuE0D9idIKSbpQ=
Received: from DM5PR03CA0047.namprd03.prod.outlook.com (2603:10b6:4:3b::36) by
 BN8PR03MB5026.namprd03.prod.outlook.com (2603:10b6:408:d6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 08:02:37 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by DM5PR03CA0047.outlook.office365.com
 (2603:10b6:4:3b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.25 via Frontend
 Transport; Tue, 8 Oct 2019 08:02:37 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Tue, 8 Oct 2019 08:02:37 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9882aAv014049
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2019 01:02:36 -0700
Received: from saturn.ad.analog.com (10.48.65.130) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 8 Oct 2019 04:02:36 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] iio: imu: adis: add a note better explaining state_lock
Date:   Tue, 8 Oct 2019 11:02:39 +0300
Message-ID: <20191008080239.23239-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008080239.23239-1-alexandru.ardelean@analog.com>
References: <20191008080239.23239-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(70206006)(70586007)(48376002)(107886003)(36756003)(14444005)(4326008)(2870700001)(356004)(47776003)(1076003)(2906002)(50466002)(86362001)(246002)(5660300002)(8676002)(476003)(478600001)(7636002)(8936002)(50226002)(486006)(446003)(126002)(305945005)(54906003)(76176011)(316002)(51416003)(106002)(26005)(7696005)(2616005)(44832011)(2351001)(426003)(336012)(6916009)(11346002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB5026;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b32cc8ad-6cbb-4c37-50d5-08d74bc5e269
X-MS-TrafficTypeDiagnostic: BN8PR03MB5026:
X-Microsoft-Antispam-PRVS: <BN8PR03MB5026E284EB1E631D239978C2F99A0@BN8PR03MB5026.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01842C458A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flJdq0doUO1JqyBjs6+B3xceMeSrPTC/xlE3kXe40+NmwEdysY2+InrZI7aQuhJ/GZ2ZBzTMYPlD1sZyL9DpVAc4Ft5gYqGuR7lmbRdxWXGFoMdPjZIBhHja8Hes/qJbx20ULdPv6JEEmMOIC/vyFB4GwEzQdufM3zvkAVuxrw9VGOHVTXXGYS3QY8g9hIfA4g8N9OKyFauiQI0SbUrPGIZXzneWPqPG/sW8ORzYwKUK36jdq/6TkdjSLSRe9dJENvxkU87ATOcjuFmTMDn5XSSpZRGd1600XyDq9cRNa2tqTDNBVOIaGlCJwCYoMINAY1HwFTCOBVhLmlUHOB10EW5JrfZcFLDHzHDm6id2dczae7PoYAVRI/QIDuliwbNxu0EPmukLiqhzrmD6LxNgS4uyILWvPF/ar12byF3CY1c=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 08:02:37.4286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32cc8ad-6cbb-4c37-50d5-08d74bc5e269
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5026
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=1
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=874 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080081
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The `state_lock` mutex was renamed from `txrx_lock` in a previous patch and
is intended to be used by ADIS drivers to protect the state of devices
during consecutive R/W ops.
The initial patch that introduced this change did not do a good [well, any]
job at explaining this. This patch adds a comment to the `state_lock`
better explaining it's use.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/imu/adis.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 27ebd740f626..abd4bd07e960 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -80,6 +80,17 @@ struct adis {
 	const struct adis_data	*data;
 	struct adis_burst	*burst;
 
+	/**
+	 * The state_lock is meant to be used during operations that require
+	 * a sequence of SPI R/W in order to protect the SPI transfer
+	 * information (fields 'xfer', 'msg' & 'current_page') between
+	 * potential concurrent accesses.
+	 * This lock is used by all "adis_{functions}" that have to read/write
+	 * registers. These functions also have unlocked variants
+	 * (see "__adis_{functions}"), which don't hold this lock.
+	 * This allows users of the ADIS library to group SPI R/W into
+	 * the drivers, but they also must manage this lock themselves.
+	 */
 	struct mutex		state_lock;
 	struct spi_message	msg;
 	struct spi_transfer	*xfer;
-- 
2.20.1

