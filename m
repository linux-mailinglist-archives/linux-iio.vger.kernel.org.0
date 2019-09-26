Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8ABBF07A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfIZKxj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:53:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58164 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbfIZKwt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:49 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqSbm003879;
        Thu, 26 Sep 2019 06:52:44 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hj96rch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzvZ5yhm/S0nInjkC2xtfK8k9BwenpYcSE1xmRiLk628OLZoASjIK5wgsWi4Tinq4hb6EZM97moqouqfjFvXSV1HtZuMUqrWX75phwnqUwbCgWRHyelMZRmd94HWaT1qLeWkBcvuvIwQsAqaquftq6rFsJlZEnWSzXgWhaVY1EUlpEgaCt1XZd0iUu8FOt27QotBrzS545OggN944AlFUWrqeeliddZNkCahdHAxeSGdfd3P+UdB3wO/9YkU0EgwsfWrB89mwHs8eFrG5sMA3kh1B7LQktJLo3GArwMEcO6ADoH7Nys2YKz1vCeYl9k3haif5F8ZfxnRZIIrXFrPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eZVsTNwzDgCxa0wjOHr/PorZMO2qAzcIXvyuqXf5D8=;
 b=NODGpkYVaPFGyL2UIEkH9wZDXAfY/JdyqFi+dLJBt53zNKmLZoPZ4Dk/PCVpVmLRZDzL9CVdmO/EMupkjBiDBAJs134w5GDmg3Ur9Ukj3KRHDawTuahBdH63z2HrLns4aGcX0IrO5UCshN+DkVXwagI5UR198jPkkk3cKGFqtEoNoPfIEjNfhPNMYBIz5kJCVf4PUXE0hpUVn/vT4XwCnQopPpt9TiHH/I0+o3re04DOEQ9Rk5AYKKsj8S2GFJvEmNp6uIgsx7OwgjhoTqNXWfkbbzXVIpYhRUzvrnaNlZIj/MFjNwQeveVpqskIgigRJvA0bZdHQcjLv1G7SZDkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eZVsTNwzDgCxa0wjOHr/PorZMO2qAzcIXvyuqXf5D8=;
 b=xIMV4E33Fz/2wyvrAF3SJVw4lO0thekKhLXBu3oNhexc6jGtp6vIOqOgwKJeW0A/mIHNPFvE/LRo8uVK+wO9dZZFmA09stbm8m9IhFXNOWT51bAgKy9pDXXluALTc0MmiohPLmzQ7xCa/c0r2q2XUQg/p1mUUJ3qykVBBGy2yYI=
Received: from BN6PR03CA0023.namprd03.prod.outlook.com (2603:10b6:404:23::33)
 by MWHPR03MB3136.namprd03.prod.outlook.com (2603:10b6:301:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Thu, 26 Sep
 2019 10:52:42 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN6PR03CA0023.outlook.office365.com
 (2603:10b6:404:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:41 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqf3H014837
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:41 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:40 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 12/19] spi: spi-loopback-test: use new `delay` field
Date:   Thu, 26 Sep 2019 13:51:40 +0300
Message-ID: <20190926105147.7839-13-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(199004)(189003)(126002)(2201001)(8936002)(476003)(86362001)(2906002)(5660300002)(1076003)(11346002)(48376002)(426003)(486006)(106002)(70586007)(50226002)(36756003)(2616005)(446003)(478600001)(336012)(8676002)(47776003)(7636002)(356004)(44832011)(51416003)(70206006)(50466002)(76176011)(305945005)(7696005)(186003)(4326008)(110136005)(26005)(7416002)(107886003)(316002)(246002)(2870700001)(54906003)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3136;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34e14b9f-4c75-4790-0342-08d7426fa7b2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MWHPR03MB3136;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3136:
X-Microsoft-Antispam-PRVS: <MWHPR03MB3136EF7130390BF645BC844DF9860@MWHPR03MB3136.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RHBTwGjh3Oq37W1evFD1OFrktx8f3wyESOMTmDe2w+9oaH+jOb91DsgfgXHv0gkNZ3X38piiEhFRJ05Y1XXb9onuaah/ftqNx6uC7ZjYMoWADGtWDirlYbF1pThrNrd7HfFULqwYB+82HS2rAFu8ycjYXxxT5tXZmemPCpZeBpMFlcvCKC4VHfuKl3aOKSuAFpSsVMfXuuNjYyMA4qKbnK57pDgqON/w9i4LvWuDdBxPISPFs5AjX2mWmx43z3z9ZsMgnqX76gFjCBy4kJnH91vV7yAyAvgI8BVaWlSQUAequyJhmVApPGe8+zx8W2bUAAaLp3oaosMdDVkgLPzVO75aWEGDySRSe8tiggAvNdqJFoNXm7Y5E+tt6XhaGYYgNhbHkPCHvvdkvR47oWZkhW0Wh09nS3H69ltJlF+FJNo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:41.7207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e14b9f-4c75-4790-0342-08d7426fa7b2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3136
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=959 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909260103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change replaces the use of the `delay_usecs` field with the new
`delay` field. The code/test still uses micro-seconds, but they are now
configured and used via the `struct spi_delay` format of the `delay` field.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-loopback-test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 6f18d4952767..b6d79cd156fb 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -298,12 +298,18 @@ static struct spi_test spi_tests[] = {
 			{
 				.tx_buf = TX(0),
 				.rx_buf = RX(0),
-				.delay_usecs = 1000,
+				.delay = {
+					.value = 1000,
+					.unit = SPI_DELAY_UNIT_USECS,
+				},
 			},
 			{
 				.tx_buf = TX(0),
 				.rx_buf = RX(0),
-				.delay_usecs = 1000,
+				.delay = {
+					.value = 1000,
+					.unit = SPI_DELAY_UNIT_USECS,
+				},
 			},
 		},
 	},
@@ -537,7 +543,7 @@ static int spi_test_check_elapsed_time(struct spi_device *spi,
 		unsigned long long nbits = (unsigned long long)BITS_PER_BYTE *
 					   xfer->len;
 
-		delay_usecs += xfer->delay_usecs;
+		delay_usecs += xfer->delay.value;
 		if (!xfer->speed_hz)
 			continue;
 		estimated_time += div_u64(nbits * NSEC_PER_SEC, xfer->speed_hz);
-- 
2.20.1

