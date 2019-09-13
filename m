Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D98B1A09
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbfIMIqi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26254 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387649AbfIMIqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:37 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gaAe015972;
        Fri, 13 Sep 2019 04:46:31 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdksa6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU0bJwiEo2gLUAlSjbI0/SV8Q94Dn8AYc6NL+7MlXoZ4UtCOJ3vNoLaXSHukye8xJ1/2Y6ojk4uwYwuOLidHq9NmqZy4k18ko8oDiSbtK9zOkOL2gujo865HilWXg18UovWAwx7I+vZ9UtV81PCzmXNGQmXWOGhEC2eWgH0Wan42Ra6Tqc0YjiiADbZDMXBnkCdgceeLPuhv6jfZ85i1nW1XKpL3zoMUvTr+lw1t/XyF22l/xQqaiz+aCH77q/85nspnmqrcEOlgWSP9X2OZCUDf2JxWjxG03wvMRq0A7BoCunET534xjj/VKEgVRoyWwb2XeNo8bYuL5ox4bGiBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZSDTjpFf1yZc16/IDU9rKofLB8/ySMkTzgyv2YEtVU=;
 b=fmqdr89Pys4zAwQ+l8WzDY1Zj3UJMglpgqLiSnbi9B5cRWiFenKMTAY2w7CP7ajG8n0ERE9aOROIUyzuC7j+opboyHDVzXA9TNkW6JpeOYPoYRh4GAxJHF2NPfUqXUM+91hBktRC6PzrwO3nQ5pHLjMSs5zNERoBkl93mfDH9bMnwiDUkg/zvUUUBF1UeMUE0V2kq6qKG3ynRtq1BG/3FXQE5pDC/Pd1Ee+nZYpNW4DEgWCLx3YJUsGDbe3r62BNimd+1znMb/kBnfNNb8GtsyHADWCK7Pp8OoCxJwf+tKip8rSxgL6kT0rfCTOAdoZiuggX260BBJhbRmZ9UDSoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZSDTjpFf1yZc16/IDU9rKofLB8/ySMkTzgyv2YEtVU=;
 b=zQZu59kf//DDNYsEcv1ThQzjxknwdaZZDdH97quPqqBAuC6jMIVnYvaS+pxv/pMVDmi1YQJwKzmpkXsOwm3y4GTYsZ0lVvAQfJyHG6zTAB0Mbin4gnM3+2+1ZYthebkETdAMkUCFv8mUYHGjN6QB1YjtBMwugrs7eCxshkb6x8k=
Received: from DM5PR03CA0049.namprd03.prod.outlook.com (2603:10b6:4:3b::38) by
 DM6PR03MB3611.namprd03.prod.outlook.com (2603:10b6:5:b6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 13 Sep 2019 08:46:29 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by DM5PR03CA0049.outlook.office365.com
 (2603:10b6:4:3b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kNKJ030677
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:23 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 07/15] spi: spidev: use new `word_delay` field for spi transfers
Date:   Fri, 13 Sep 2019 14:45:42 +0300
Message-ID: <20190913114550.956-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(186003)(48376002)(8936002)(50226002)(336012)(426003)(126002)(446003)(476003)(86362001)(2201001)(2616005)(2870700001)(11346002)(7696005)(51416003)(76176011)(5660300002)(36756003)(6666004)(106002)(50466002)(486006)(26005)(54906003)(316002)(110136005)(1076003)(47776003)(70586007)(4326008)(44832011)(246002)(356004)(70206006)(8676002)(14444005)(2906002)(478600001)(305945005)(7636002)(7416002)(107886003)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3611;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392e077a-1c0d-483a-8f05-08d73826de8f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR03MB3611;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3611:
X-Microsoft-Antispam-PRVS: <DM6PR03MB36119F85B67AEAF263FE65E9F9B30@DM6PR03MB3611.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MvMnJZpD4UA27SawFtG1rCdEBzPabJd69SyMjrwoaQxTUXwnAJM5MksW/gV2+HtN58VFoDk7L25JWxILcSa6z9D6sx8B5O0hHyCX+b3PAmxflgSbvBEmN9bLlu+Z4TpwewWbvampLgMnKATAtaLt4lauoOEDfqkF1CyeQ5M+lkfToO1n/4gpUwEESG2FC8Ekwa8U8tVItUVXMQQeO8wnb8CFJb6jFKDec5ms11ewWchEY5/QIzuEA4dEO1EMxkLib5PxyZYgMuf/bC5J1fiTRIE1IgxSBLSO8hfzthRplJnB8xo+BdYmzDE7QJPPxf/d/VW0kI7wWdjfKs/ZIJAAT+PxyPZaONtuqC8q6Kj5JrgzRkk4T1tRl06onMkutmzLe6gx0rr3mb7YbM5YYzFJmsqMhMUy+QJFTL6BdcoWQO8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:28.8756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392e077a-1c0d-483a-8f05-08d73826de8f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3611
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=769 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The `word_delay` field had it's type changed to `struct spi_delay`.
This allows users to specify nano-second or clock-cycle delays (if needed).

Converting to use `word_delay` is straightforward: it's just assigning the
value to `word_delay.value` and hard-coding the `word_delay.unit` to
`SPI_DELAY_UNIT_USECS`

This keeps the uapi for spidev un-changed. Changing it can be part of
another changeset and discussion.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 255786f2e844..495319c2fa11 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -267,7 +267,8 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->bits_per_word = u_tmp->bits_per_word;
 		k_tmp->delay_usecs = u_tmp->delay_usecs;
 		k_tmp->speed_hz = u_tmp->speed_hz;
-		k_tmp->word_delay_usecs = u_tmp->word_delay_usecs;
+		k_tmp->word_delay.value = u_tmp->word_delay_usecs;
+		k_tmp->word_delay.unit = SPI_DELAY_UNIT_USECS;
 		if (!k_tmp->speed_hz)
 			k_tmp->speed_hz = spidev->speed_hz;
 #ifdef VERBOSE
-- 
2.20.1

