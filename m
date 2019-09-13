Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB4B1A12
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfIMIqX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:23 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:59426 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387594AbfIMIqW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:22 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gi80020152;
        Fri, 13 Sep 2019 04:46:13 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2054.outbound.protection.outlook.com [104.47.45.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytcwh98m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ7msHR/jIUMfYkrc0Txj+YzGoxxhHhrlWv2HqaLKkAK6Ej3mvvwL+y76cbsAn95zHndMRPxd6BhUiIXS2/hQVFWJD6UNkeuJeuj4oIpSbI7d9i9tdnrlGg1M/OThbffG2ZOmZtrUd/ZEOSYrAAEpK4sfjXEvIVROM/we/KT95Q4yPzBoHAu5+TqJ7uDCNN7EetfLIm6lTuhNIvvvRUWQhG+MI4Q5z8vEE+fOqWUHcvK/BytbAfUDBsXBqxY7movKjZbweNs//zssRXyLP4FAroGG3ob+zfj5vvwEGYQKwAnMgxsgrjpwUvKgWo3o9vwcoMQvqPaSwOhrZFKoqmBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05ip8YYTrKlx0zGMUFmD5GRzSl/oDVHFbJgj5Q1NczA=;
 b=GVkaGiBcB2AqWtdVjf7NqZthgiVxc5sQgQiWWbr9Fxq0s8jJiTqa8Hmz63N9AbYd2WQYHk3EYGq4PcnD6/PrZ/Uug3LZvj8jEvOYJYEHTl9d28y7MpalnDMC1Ca1ScllXbu/sq9LdyjzqbGPxwaRvtona/526iwDe7r0KsvupYdNQwokWFKbPXiuHNuUBo74zAo0Sji/BXCltOKBizX7jSgaLShJHcTJqKUCUOHGCw7GNagFZK39a+arHXD805T7u7zZNTV/cObFySEE/F6wl/elQc71NElwQ0DEM4bX81osKLITV5em65XqOsvYgFWttqlVvmDmGaSgdhRQj0yY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05ip8YYTrKlx0zGMUFmD5GRzSl/oDVHFbJgj5Q1NczA=;
 b=UxXyttqyDp2IdwrLjM3jnSU+KFv2AeUfUqiXwvC0bcSkju8xQ+Fd3XbRoVBrx/WAOJC31c1dh8yYQ2+7LHlD8a8gOgT4L2qxbM0lYNJTukQV59taR1nyu1JrlpBW7xgf/BV2K9c81gndi/GkLclWLOAlvKEJAD8FjOPSfT7bFZQ=
Received: from MWHPR03CA0002.namprd03.prod.outlook.com (2603:10b6:300:117::12)
 by BN3PR03MB2132.namprd03.prod.outlook.com (2a01:111:e400:c5f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14; Fri, 13 Sep
 2019 08:46:11 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR03CA0002.outlook.office365.com
 (2603:10b6:300:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:10 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8k4ps030512
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:04 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:09 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 00/15] Unify SPI delays into an `struct spi_delay`
Date:   Fri, 13 Sep 2019 14:45:35 +0300
Message-ID: <20190913114550.956-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(7636002)(305945005)(47776003)(2870700001)(8936002)(246002)(8676002)(50226002)(36756003)(110136005)(54906003)(106002)(316002)(1076003)(2201001)(7696005)(2906002)(7416002)(126002)(186003)(486006)(26005)(48376002)(356004)(6666004)(336012)(86362001)(70586007)(70206006)(478600001)(107886003)(50466002)(5660300002)(476003)(426003)(4326008)(44832011)(51416003)(2616005)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2132;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 901dcf5f-d346-4d63-c43b-08d73826d370
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN3PR03MB2132;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2132:
X-Microsoft-Antispam-PRVS: <BN3PR03MB21328D0E623C33D470221441F9B30@BN3PR03MB2132.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: SFVSMC4UrNJzauz+dLNerpdHZGwmVHqO1j0r5bxb8rVT5U1OvO0DC/i0Q7868lsrzaNHREDnsfeJc+hqjH80cka+XG1a13ankJulk8MswiLGWdFej4FCLuAzAsD1UjcJDmN4a8/fNT8KtSiqo7hoh+q4zKQakCDqIh4jc2T0HoqQabZ3RDE37wIXG4TT0oWjGVUjC46cs2n6qo3K5999ocisSsIjfWJOMuyLqb6Hj7GloH9UScmFN/Yr4pv0XVlJSLHgEIvLaJ6/HMdvleXHez7T5c4x1UmIpEjUbLBQ3BGOPiHfMGl4388cbavfZ5z0y6oQDb1tw8pfrPG/DEQbEcn75bg0pxAyGY1YL/sMakzC3GY9J2mt4g0gKjcEXU0rJGkiussQIXJfnDQNNN7GQdY0I7L2UQC2wNt9m1SjP8E=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:10.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901dcf5f-d346-4d63-c43b-08d73826d370
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2132
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Initially, I started this patchset thinking: "we need a new delay for
something-something" (in case someone is curios, we need a CS-hold-time for
the first transfer, because the CS wakes a chip from sleep-mode).

Then I added the delay, and felt a bit dirty-inside about adding a new one
(just like that), and decided to look at maybe cleaning things up a bit,
and a few days later, I got here.

Full disclaimer: this patchset is not complete. It's an RFC.
It's based on top of Jonathan's `iio/togreg` branch which also includes the
ADIS driver library changes and also includes `cs_change_delay`.

I'll send a V2 patchset, which just the first 4 patches, since I feel that
those are a bit more complete.

I thought about just sending the first 4 patches on-their-own, but I
figured that the whole series (even if not complete) serves as a better
explanation about the whole "why?".

Hopefully, this can sort-of-explain things.
I'll reference this RFC on the next series.

Thanks

Alexandru Ardelean (15):
  spi: move `cs_change_delay` backwards compat logic outside switch
  spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
  spi: make `cs_change_delay` the first user of the `spi_delay` logic
  iio: imu: adis: convert cs_change_delay to spi_delay struct
  spi: sprd: convert transfer word delay to spi_delay struct
  spi: orion: use new `word_delay` field for SPI transfers
  spi: spidev: use new `word_delay` field for spi transfers
  spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for
    spi_device
  spi: introduce `delay` field for `spi_transfer` + spi_transfer_exec()
  spi: use new `spi_transfer_delay` helper where straightforward
  spi: tegra114: use `spi_transfer_delay` helper
  spi: spi-loopback-test: use new `delay` field
  spi: spidev: use new `delay` field for spi transfers
  spi: tegra114: change format for `spi_set_cs_timing()` function
  spi: implement SW control for CS times

 drivers/iio/imu/adis.c           |  24 ++---
 drivers/spi/spi-atmel.c          |  29 +++++-
 drivers/spi/spi-bcm63xx-hsspi.c  |   3 +-
 drivers/spi/spi-cavium.c         |   3 +-
 drivers/spi/spi-fsl-dspi.c       |   3 +-
 drivers/spi/spi-fsl-espi.c       |   3 +-
 drivers/spi/spi-fsl-spi.c        |   3 +-
 drivers/spi/spi-loopback-test.c  |  12 ++-
 drivers/spi/spi-mpc512x-psc.c    |   3 +-
 drivers/spi/spi-mpc52xx-psc.c    |   3 +-
 drivers/spi/spi-omap-100k.c      |   3 +-
 drivers/spi/spi-orion.c          |   6 +-
 drivers/spi/spi-pl022.c          |  25 +++--
 drivers/spi/spi-sc18is602.c      |   3 +-
 drivers/spi/spi-sh-hspi.c        |   3 +-
 drivers/spi/spi-sprd.c           |  11 ++-
 drivers/spi/spi-tegra114.c       |  39 +++++---
 drivers/spi/spi-tegra20-sflash.c |   2 +-
 drivers/spi/spi-topcliff-pch.c   |   7 +-
 drivers/spi/spi-txx9.c           |   3 +-
 drivers/spi/spi-xcomm.c          |   3 +-
 drivers/spi/spi.c                | 162 +++++++++++++++++++++++++------
 drivers/spi/spidev.c             |   6 +-
 include/linux/spi/spi.h          |  65 ++++++++++---
 24 files changed, 293 insertions(+), 131 deletions(-)

-- 
2.20.1

