Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9A6CF551
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 10:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfJHIv5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 04:51:57 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:59208 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730092AbfJHIv4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 04:51:56 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x988gkD0011001;
        Tue, 8 Oct 2019 04:51:51 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxau1d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 04:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnstQhPhepCm1u07ws8wOOT1NMiuv7eR8Se0UK3SUOYyteeChoExEw7Y8pSDlVPW9XrScP5G+WFyDgEg2Hwa+yS+XzUWjNRGXjiQVsr37AXfXCII0hcktuKWaK8hUp4fHKI6qWkl+VMQiK6zuZbSGogHprImxTeymcpurGgqUP2Bd1H2KBpdVuOSU0cO2e+CQEiLrhIwSGgVgPhPfuNt20UyiBfEacBadMiAMX5v2Vrt/n3zqeZOinsoHnSKfmzCanohS0YASW3NWMVccMm/BEGuramziXv0l6LJrKFL+CfPzyNgWgCf0cAuJwFbASGD81kp3/aXc0drw1orR/E3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk5eJU28FBjYZmeWGWTK4ZhxXD3yJ1HtcCXJMbXAiw8=;
 b=ahQXQH+htIH2e5EH12U6Nr88ZCQfnUrZBOzb6UuiUwZhxanaCpy0SG8auwYKtK2QMWyrW/iaaJBqO4lTXdk4wKtHQ8jdYwzCjqwcKAZ9u+33blxdkbvokrVrOt2SfUZxV7gwc3zLxulOcXJ85ze9qBQB6lypIK8QIPy2qAbVO85stLo+73da67XVFrL2ypJFzjTV1nYGuOjIMb1fek0vO0tQa5Zr0xJim5JOoRoug4m6ItpxSCqDnf20uKWvoC1VcXZ01jMMNVg37py4PqXotc6EOC/qNsrq0qW7uDzOEmg2DTokAU8pPJ36akjMKDQhVLH6rHn+2vxhRYrT151Nrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk5eJU28FBjYZmeWGWTK4ZhxXD3yJ1HtcCXJMbXAiw8=;
 b=97wwRKaC99/GzDD5qknqdBrtPtQnc+JH7D4Xm0BceiIzRb6s+EMzFQe9n9ouXSK1S/XRq8dfyKGV/X4a4Zj+yCBEQOI+f+Th9aJxvyGShWG4yccZH8qTC9g0q7YfjSAc+my5XzMg/V/DWnfY+zaaBVZbpZBajQeA/1YfonQ98Cs=
Received: from BN8PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:94::39)
 by CO2PR03MB2390.namprd03.prod.outlook.com (2603:10b6:102:16::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 08:51:49 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN8PR03CA0026.outlook.office365.com
 (2603:10b6:408:94::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Tue, 8 Oct 2019 08:51:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Tue, 8 Oct 2019 08:51:48 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x988pmfa028346
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2019 01:51:48 -0700
Received: from saturn.ad.analog.com (10.48.65.130) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 8 Oct 2019 04:51:47 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: imu: adis16400: fix compiler warnings
Date:   Tue, 8 Oct 2019 11:51:56 +0300
Message-ID: <20191008085156.6255-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(7636002)(305945005)(356004)(36756003)(5660300002)(1076003)(6666004)(2351001)(2906002)(2870700001)(6916009)(7696005)(106002)(54906003)(50466002)(316002)(51416003)(336012)(26005)(186003)(4326008)(107886003)(426003)(50226002)(8936002)(8676002)(246002)(476003)(44832011)(126002)(486006)(47776003)(2616005)(86362001)(14444005)(478600001)(70206006)(70586007)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2390;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f132dc7-8c47-4094-19c5-08d74bccc14d
X-MS-TrafficTypeDiagnostic: CO2PR03MB2390:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2390F92BD400454EF0723168F99A0@CO2PR03MB2390.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 01842C458A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: picPm5fzr/zevqA2eKgUI2HTjKTs+BjlTDKqvVPAlr5r1Xorql70hc3dtYyWizi7mb/HlVxZVwdiuDigC7YpyWk00grkIV9QFiAW0NpIbDBYpZFXURajUtxQNUoEc5kpcST1wIKo2lDoQ4ibyBrDimUzBEFGrtA6iEQ+5a1W8gUWO9Ytys2qveZR86Ijg4s9EDwMGQ0OajEiMvyvmkZGp19V/80DoVs8BZTEm5hhomWUF1YxHrYDQnvsCafxDlMJiIG5SWbqPCNBJJxfc641RNdcSvgBwharmBnMtuNo9JpjJYL2bj9o6omPc/2Vc1GEXhP/cyluQENcTsyxP2yIyiO6lRZMMyMxO7u9DUnGXxexclTtugWkYt01d49UCbSePYkniTWq2Ysuhln6wRW04H/mf91zfYNVBzEaHyKYZ5s=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 08:51:48.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f132dc7-8c47-4094-19c5-08d74bccc14d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2390
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=1
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

GCC 8 complains about plenty of 'maybe-uninitialized' warnings.
This patch fixes all of them.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16400.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index e042a2aabf6b..d0b7dce798f4 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -325,7 +325,7 @@ static struct adis_burst adis16400_burst = {
 static int adis16334_get_freq(struct adis16400_state *st)
 {
 	int ret;
-	uint16_t t;
+	uint16_t t = 0;
 
 	ret = __adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
 	if (ret < 0)
@@ -338,7 +338,7 @@ static int adis16334_get_freq(struct adis16400_state *st)
 
 static int adis16334_set_freq(struct adis16400_state *st, unsigned int freq)
 {
-	unsigned int t;
+	unsigned int t = 0;
 
 	if (freq < 819200)
 		t = ilog2(819200 / freq);
@@ -357,7 +357,7 @@ static int adis16334_set_freq(struct adis16400_state *st, unsigned int freq)
 static int adis16400_get_freq(struct adis16400_state *st)
 {
 	int sps, ret;
-	uint16_t t;
+	uint16_t t = 0;
 
 	ret = __adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
 	if (ret < 0)
@@ -408,7 +408,7 @@ static const unsigned int adis16400_3db_divisors[] = {
 static int __adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
-	uint16_t val16;
+	uint16_t val16 = 0;
 	int i, ret;
 
 	for (i = ARRAY_SIZE(adis16400_3db_divisors) - 1; i >= 1; i--) {
@@ -554,7 +554,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
 	struct mutex *slock = &st->adis.state_lock;
-	int16_t val16;
+	int16_t val16 = 0;
 	int ret;
 
 	switch (info) {
-- 
2.20.1

