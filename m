Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839A3BF024
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfIZKwT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:52:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:64112 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfIZKwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:18 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAllRx017743;
        Thu, 26 Sep 2019 06:52:11 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7cbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUJT/Lsnn+wI6IYIxJG2kveLr3twkhn2EawBxxFpq0znmMQt48k4SLitdGpVP4Iq5Yru0ai56DOE+gFrKafnTAHKmkvM0VSf4JBsv6F8nEE6ETa2O5hFWWDQz29pELsSsdAgpOXnskGbSbB4+Hoh35WTvcOOTW890XnF/P8grS4563iOGoynewEXFPad/Dcl3RlMZSiqrSVmzfb5wpJ4h3PGLDvYtnUupxcZBCWWYloz5U3SBb4rnLqCrvawV20+sEANV903zUNPIJCxeS3uBRNbw143xVF7DCQCpBnRtbqYxCmeUGKZc2DDEL+AWHwHfAChzXwCtazIl/5+41F3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32XGeTJGK1w3bHifU/70XvZCqpaVoHkLZtqH5pZjj74=;
 b=Zx56XVnLuXEANzq27gYjGE5YWTpKxDNCkRpZ3w7rjF569NAo4W9UxT7j9IM35r1oyJbtfLxTQomugtgis+e1KrQS0WiTCqLgm6NPrjVXmUqfsSMjSlcGtD8270ZNh99EtHtTKi805fuBJ/nAAEgHAo8PximmBjsESTfFL1Uj/OX+8L33pFT5MZ8qQlChDYdXcH8M5H87fvoNJnYsc4YvH5d+hv53GJfXbZoCBNkn3lZkGl/Pm2EmL38Z+kv5z7FPN4j2ddpIkUM1nBK35Cf7YOtC/tNlEZaHF1jj8WYQZazwKHTdy5fO48tgSOquKZzMbp7j6TGSTjre3XqOpOT0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32XGeTJGK1w3bHifU/70XvZCqpaVoHkLZtqH5pZjj74=;
 b=H5ERfzOi/XXr+s+TEvGmyn2IaN9uX+7fqnMsk7pTlF0mnTQRryLhG8n7LV1uJdE37asPj19LAyM/T/R3/FifwHZhKdl16lUiddGnsVgoZV/kAHCFKbESUiMjd6nFB+Mt/LIHjZ5Sb0rGAxrSvLrkikUp3RVcl0IPxSCPcDYoYhU=
Received: from BN6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:404:10::15)
 by BY5PR03MB5079.namprd03.prod.outlook.com (2603:10b6:a03:1f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15; Thu, 26 Sep
 2019 10:52:09 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN6PR03CA0101.outlook.office365.com
 (2603:10b6:404:10::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAq8FZ014747
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:08 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:07 -0400
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
Subject: [PATCH v4 00/19] spi: introduce `struct spi_delay` data-type
Date:   Thu, 26 Sep 2019 13:51:28 +0300
Message-ID: <20190926105147.7839-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(54534003)(478600001)(8936002)(50226002)(47776003)(316002)(336012)(246002)(7416002)(2870700001)(486006)(426003)(476003)(110136005)(54906003)(2906002)(126002)(2616005)(186003)(8676002)(4326008)(70206006)(107886003)(70586007)(50466002)(86362001)(36756003)(51416003)(2201001)(48376002)(7696005)(26005)(305945005)(44832011)(7636002)(1076003)(6666004)(5660300002)(14444005)(356004)(106002)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5079;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d04d8143-387d-42ca-9cf7-08d7426f9429
X-MS-TrafficTypeDiagnostic: BY5PR03MB5079:
X-Microsoft-Antispam-PRVS: <BY5PR03MB507968B2CBF81FC07417E1F7F9860@BY5PR03MB5079.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGU1WzIbATgUIXI965X46cQKRb92HAQWuIIWGA5nURv2WueG1NjVRJowKc15DM7nLnGzaYDzJd4Y07JAxelAPhB0D1K1Y0UyTovJcMiOTips8TklmEn5YMeMloG11Td6aBVX625UxouBdNpkyKnvfnZGWkhQqLjDqPQFJx7KTPfx2/CLy0ZFWuiWkf04ChF+H/p14UOxsTv2Iof+i2wFj6aXD8uLa5vdaG0yzoegcwyi1zh64BNc5SKiHyWg3GFKHgwUJky/cNN+dpWlkIs1qcmyhVwojlYQ3So3vfUi9+oQXiGgJsViujiUrxIMYoWbLXusnEorSCjI232L2TSUZ082Ndv+wZCsvRNwjGKyuakiJqsTWn3v2lIlWN3tlDvd9r1yqwxZ/zwYqiEtRl4YlQ00xD9u1JBWJJ4si/gUjG0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:08.9441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d04d8143-387d-42ca-9cf7-08d7426f9429
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5079
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Initially, I started this patchset thinking: "we need a new delay for
something-something" (in case someone is curios, we needed a CS-hold-time
when CS is asserted, because the CS wakes a chip from sleep-mode).

Then I added the delay, and felt a bit dirty-inside about adding a new one
(just like that), and decided to look at maybe cleaning things up a bit,
and a few days/weeks later, I got here.

It's based on top of Jonathan's `iio/togreg` branch which also includes the
ADIS driver library changes for `cs_change_delay`.

The current v4 tries to be a complete change as possible about converting
all delays to the `struct delay` data-type; at least in the scope of the
SPI subsystem. Many external users of the SPI subsystem use the
`delay_usecs` field to specify delays for transfers; which is why this
field is still kept temporarily for backwards compatibility until all other
delays are switched to `delay`.

Thanks
Alex

Changelog v3 -> v4:
* re-unify all `spi_delay` changes into a single big series spanning SPI &
  IIO subsystems; patches are based on top of IIO, so patch
  `drivers/iio/imu/adis.c` does not apply on top of SPI/for-next tree

Changelog v2 -> v3:
* squash patches 3 & 4 into a single patch; otherwise the kernel is in
  broken state between those 2 patches

Changelog v1 -> v2:
* split away from the RFC patchset, which aims to be a broader explanation
  for this changeset; parts of v1 are not 100% defined yet, and may require
  some discussion and refinement.


Alexandru Ardelean (19):
  spi: move `cs_change_delay` backwards compat logic outside switch
  spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
  spi: make `cs_change_delay` the first user of the `spi_delay` logic
  spi: sprd: convert transfer word delay to spi_delay struct
  spi: orion: use new `word_delay` field for SPI transfers
  spi: spidev: use new `word_delay` field for spi transfers
  spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for
    spi_device
  spi: introduce `delay` field for `spi_transfer` +
    spi_transfer_delay_exec()
  spi: use new `spi_transfer_delay_exec` helper where straightforward
  spi: tegra114: use `spi_transfer_delay_exec` helper
  spi: tegra20-sflash: use to new `spi_transfer_delay_exec`
  spi: spi-loopback-test: use new `delay` field
  spi: spidev: use new `delay` field for spi transfers
  spi: tegra114: change format for `spi_set_cs_timing()` function
  spi: implement SW control for CS times
  spi: spi-fsl-espi: convert transfer delay to `spi_delay` format
  spi: spi-falcon: extend warning to `delay` as well
  spi: bcm63xx: extend error condition to `delay` as well
  spi: spi-axi: extend support for the `delay` field

 drivers/iio/imu/adis.c           |  24 ++---
 drivers/spi/spi-atmel.c          |  29 +++++-
 drivers/spi/spi-axi-spi-engine.c |  16 +++-
 drivers/spi/spi-bcm63xx-hsspi.c  |   3 +-
 drivers/spi/spi-bcm63xx.c        |   2 +-
 drivers/spi/spi-cavium.c         |   3 +-
 drivers/spi/spi-falcon.c         |   2 +-
 drivers/spi/spi-fsl-dspi.c       |   3 +-
 drivers/spi/spi-fsl-espi.c       |  19 +++-
 drivers/spi/spi-fsl-spi.c        |   3 +-
 drivers/spi/spi-loopback-test.c  |  12 ++-
 drivers/spi/spi-mpc512x-psc.c    |   3 +-
 drivers/spi/spi-mpc52xx-psc.c    |   3 +-
 drivers/spi/spi-omap-100k.c      |   3 +-
 drivers/spi/spi-orion.c          |   6 +-
 drivers/spi/spi-pl022.c          |  25 +++--
 drivers/spi/spi-sc18is602.c      |   3 +-
 drivers/spi/spi-sh-hspi.c        |   3 +-
 drivers/spi/spi-sprd.c           |  15 ++-
 drivers/spi/spi-tegra114.c       |  39 ++++----
 drivers/spi/spi-tegra20-sflash.c |   5 +-
 drivers/spi/spi-topcliff-pch.c   |   7 +-
 drivers/spi/spi-txx9.c           |   3 +-
 drivers/spi/spi-xcomm.c          |   3 +-
 drivers/spi/spi.c                | 158 +++++++++++++++++++++++++------
 drivers/spi/spidev.c             |   6 +-
 include/linux/spi/spi.h          |  66 +++++++++----
 27 files changed, 323 insertions(+), 141 deletions(-)

-- 
2.20.1

