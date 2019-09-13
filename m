Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD7AB1A0B
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfIMIqi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:38 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:3550 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387688AbfIMIqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:37 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gikP017287;
        Fri, 13 Sep 2019 04:46:28 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1h9ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkbyOh5elzWjYWnGN8xf55IbDvw/rT/aIlkuQJiNrxqc1va571aaGh9LrvaWheWPGv/hQRmn2CxWKuQkgg6wYKY62kKBYGkRi40R3fhr/+ysQP/QZzdr0irTcSIuG5Funlma+O/3O2HzS9nDCizziO5cRzX/JiV2VpQFdIxIe5Ez2QQ3u1F0G8pWcQmjywPVNewXvoXZPaubt8cN9XpLm03y3MioO5TdrMStFkEbxBucKuVJHwU6TuemLvMFA1+V8Edkx4dSznmyZmSIAsPEZ/wuUlVxjJC8WTLz4g4VsOWhYHMY042Wbo75A1di69nWOGvTHcrdykjf1gSTwRUQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tAthPJJ00Md+QA2VffHOABt3RVqF/+sx3EiB52xHYc=;
 b=FYhzj6ThiDguruXNw1CihFEEVpjdZ0deNJekzlcBM12179L/TIVJV9M45kd12FTyFIm/JnVZX7JBDk/6m+z+B9HgtXf43KPApsLgezu9XC12kDAgAAtdiJYTpusHWXZdJ1zXqUw2V2qyuOqvbu12cv9B8ngXlDA5nM1+AV4AcbaEfpLQf1PM96ftDEmA12kDjRWvXfUNBkIHOj3W/Y1rBQLARirqYFsb/PkvlJiNGd5JF+c0SUHqDzUU0dPJn3ogE/i6zoFNUIzC95AxanBmXDfCLDuhClrCKRl/LSU89dzZkw4W9vNxMqc65kEN9wZwsaanJ+iXKBUtbTHKCQTHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tAthPJJ00Md+QA2VffHOABt3RVqF/+sx3EiB52xHYc=;
 b=EGzAfhTInmsFz+Z/PDybcFkUTmcHsT4HW2T7ArbeXVzDXviDH2UUT96ELkoe6J2ngUvy8qSjDD/B8H/wFoMFg1T4lREPJV4qebBZlaWXs3KYio8sfWwQZQ82TTlkg7SU5DilC9JM2KbZ5OYV6gbYZnxTX2S6/azW1VT/io7dbXA=
Received: from CY4PR03CA0017.namprd03.prod.outlook.com (2603:10b6:903:33::27)
 by BN8PR03MB5058.namprd03.prod.outlook.com (2603:10b6:408:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15; Fri, 13 Sep
 2019 08:46:26 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by CY4PR03CA0017.outlook.office365.com
 (2603:10b6:903:33::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.17 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kKog030667
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:20 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:24 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 06/15] spi: orion: use new `word_delay` field for SPI transfers
Date:   Fri, 13 Sep 2019 14:45:41 +0300
Message-ID: <20190913114550.956-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(54906003)(50466002)(186003)(50226002)(8676002)(11346002)(107886003)(446003)(47776003)(36756003)(48376002)(4326008)(356004)(70586007)(6666004)(70206006)(2906002)(7696005)(486006)(5660300002)(8936002)(44832011)(336012)(316002)(86362001)(51416003)(26005)(2616005)(2201001)(246002)(7636002)(478600001)(110136005)(106002)(426003)(1076003)(7416002)(305945005)(476003)(126002)(2870700001)(76176011)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB5058;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db00d43-9f73-4c49-79e7-08d73826dceb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN8PR03MB5058;
X-MS-TrafficTypeDiagnostic: BN8PR03MB5058:
X-Microsoft-Antispam-PRVS: <BN8PR03MB505880E7D7686118ACC52C99F9B30@BN8PR03MB5058.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LjdkS8oN9oFQwdrfav8dXbSTt94/KuCQ5olWEh0xrnfca8FbmkcsCH/Suwme7fdzCd7awroe9iwIu6hQS5OMrGA8UyJYsPvlHvtRPUiu1InlJupaopUnNv8ynrQM10EJ9aEjKS8L0m7ctGtWfM/xamPmAuUhR3g3RGeKsYRKW2Q40J183NN2DnrUgoyQ6mQmV6zSWK/N6zdFEJCt3vbWM5/+xqw/aUui7KX6bxndfPLe+OpgATV+nBg3OCuj4av8Ngb3jJA0uJG22S5Bf7mHwsohDl31bpniOlcvt69vpxmvx4hFO45RPFbmAUleG161vIZez6AqipT3fR2CEOk2V02a/R2RKr6GW8tod0blA/bdqOrXSl7sLbj3vVcPTLrOXtbNR7sLiVU+xrdABx3mz6QL43CpwidhnShr5D7kViI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:26.1125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db00d43-9f73-4c49-79e7-08d73826dceb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5058
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=802
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The `word_delay` field had it's type changed to `struct spi_delay`.
This allows users to specify nano-second or clock-cycle delays (if needed).

Converting to use `word_delay` is straightforward: it just uses the new
`spi_delay_exec()` routine, that handles the `unit` part.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-orion.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 6643ccdc2508..756c37e32dfe 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -467,8 +467,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 			if (orion_spi_write_read_8bit(spi, &tx, &rx) < 0)
 				goto out;
 			count--;
-			if (xfer->word_delay_usecs)
-				udelay(xfer->word_delay_usecs);
+			spi_delay_exec(&xfer->word_delay, xfer);
 		} while (count);
 	} else if (word_len == 16) {
 		const u16 *tx = xfer->tx_buf;
@@ -478,8 +477,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 			if (orion_spi_write_read_16bit(spi, &tx, &rx) < 0)
 				goto out;
 			count -= 2;
-			if (xfer->word_delay_usecs)
-				udelay(xfer->word_delay_usecs);
+			spi_delay_exec(&xfer->word_delay, xfer);
 		} while (count);
 	}
 
-- 
2.20.1

