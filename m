Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE60A71306
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2019 09:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfGWHhE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jul 2019 03:37:04 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:14278 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732876AbfGWHhA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jul 2019 03:37:00 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6N7X5dk003699;
        Tue, 23 Jul 2019 03:36:52 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2twun1892h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 03:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib4vq7WqU2aYkY57GXQrM1Ic0WtU25feRNl1VTZVMnGbhudgeuY/zty0oyMu2Cs22YIP5StnkQtuJwyUI6lZeGaD1HsnYowSCVkRhFRaESz8H7XGiaikhdSq4LqhkxpfAKub4CIAHx9JtlN4hQKfxEkANkII+VW1cpBAcCPxtBuK2f/OlMdMSpM0wAzF39UPa3Q2CV8xDGLDKdQFUrwyP4MEx3bfCK6p8IAu7dPvmq8z53KE5GOxa9nFbhHSqKNTDhtZ0Fr8TF7CWHUASkI4LZ/nHqNwV/2GEH06Gz+VZHdc0zMJmoSVWAPxviRZqgM4TH4eY74WiD9Kbnz6BG+4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPppcAnpgozGlEs0W60CaEywG0Lpw0uSoeFiv5ZE6AM=;
 b=H7EGKp4f3uTlup/9Q3W+V9/kO2CWTrjTjIM87gUBaTsUhlOQ36W6Pw5LbUBgPF4wqJWTqU2iYNpHjgYkYBjo8Y/ytspKS8PcxcvrdWBWFAdjZ7dHOHOevmAo7b/HiVY8yRC38qfawlSQOWnrkvEPeRo8ZtrNDI6KoVAa0eha7OFMf/7vn3BrqLQgrnPcjFuD44uqUxf4JTGDmxPK5+X5gu6uSmgYrk2LjGMf0bvuHS+VaisS7Hve+nCT0DeWmlWNlDEnYGPfVN3u/zLleafItM8ZKx718Z/AgB9808RuWVkItzXVQuJBdaomQ6NUka6LFMS7WIg1Pc2CzumoYuu8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPppcAnpgozGlEs0W60CaEywG0Lpw0uSoeFiv5ZE6AM=;
 b=4DC/2d9phzxK9xlJT5pktNm3DHKrMA4DeciZbO+ZpwQUfnckex6tu/xqwyo+0rvUMPMiAs9MBYvmRC/VoIUuRVTL+S3wxW0Df3b9mTL9CgysgeoUwnhNmT5XY+1bDpwX7AcWTaxvgAJKLpQz5hqzgHsGaYKASa6D+yw6xuoOyCs=
Received: from DM5PR03CA0036.namprd03.prod.outlook.com (2603:10b6:4:3b::25) by
 CY4PR03MB3272.namprd03.prod.outlook.com (2603:10b6:910:55::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Tue, 23 Jul 2019 07:36:51 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by DM5PR03CA0036.outlook.office365.com
 (2603:10b6:4:3b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16 via Frontend
 Transport; Tue, 23 Jul 2019 07:36:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Tue, 23 Jul 2019 07:36:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6N7amdI001484
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 23 Jul 2019 00:36:48 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Jul 2019 03:36:49 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/3][V4] iio: imu: Add support for the ADIS16460 IMU
Date:   Tue, 23 Jul 2019 10:36:37 +0300
Message-ID: <20190723073641.27801-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(54534003)(189003)(199004)(7696005)(4326008)(50466002)(8676002)(7636002)(336012)(126002)(48376002)(246002)(305945005)(8936002)(2870700001)(50226002)(107886003)(476003)(426003)(5660300002)(2616005)(486006)(26005)(44832011)(110136005)(54906003)(1076003)(186003)(966005)(2201001)(51416003)(478600001)(47776003)(106002)(2906002)(356004)(6666004)(316002)(36756003)(86362001)(70586007)(70206006)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3272;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c6bd4ec-f296-4948-051d-08d70f4086a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CY4PR03MB3272;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3272:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY4PR03MB3272C99DDE4F593B176E2114F9C70@CY4PR03MB3272.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0107098B6C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +PW2EDK5KKh+T2ZG+WEl5knJLl551oHGIwi1TEM2s/SwoJwwOpfHo1/QNMTnBch/F7ymGbcVSqd6PHNsv9+ERX0gwNjN7C+Y3OA/vmbYNL76dAQoOHKTQe6hF8iFj+aSZzAHw4TnXI2pqgvHuVMtxzEh/wCNIyJot+IjWSjx+XxISMWibZ8ZlflQYFnaQVNQReW57mAABrUVsPbvk734+WYln+PwOE9zVKFyiYLrYkG+KcvKHLginTEGvpP52a01S878PcyGsWhdyXqODdJO010SH+ALChk2iOBfaAVHUPOGqLiDOxNIe48fVWX6MfO6MxGuVGMzzZ1afTvMaIhnYZR1+qhtvyHl25JTS4dyP4TP2J6DCq5FqU7ND4RIcd0mryIYUA65PL6KO8H5ZHDPKLWMQcgXNWFkjDm0yGcJvZ4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2019 07:36:50.6292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6bd4ec-f296-4948-051d-08d70f4086a2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230071
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This changeset adds support for the ADIS16460.
The default CS change delay is 10 uS, while the ADIS16460 requires a
minimum of 16 uS.

As it turns out, the SPI framework support already has support for this
feature, which is currently present in the for-next branch:
   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=0ff2de8bb163551ec4230a5a6f3c40c1f6adec4f

This changeset now makes use of that feature, to allow longer CS change
times (as needed) for ADIS16460.

The SPI patch is present in the iio/testing branch, but not present in the
iio/togreg branch.

Changelog v3 -> v4:
* for SPI: no change
* for ADIS lib: use existing `cs_change_delay` feature (from SPI)
* for DT: no change

Changelog v2 -> v3:
* for SPI:
  * used `cs_change_delay` instead of `cs_change_delay_usecs` (i.e. removed
    `_usecs` suffix
  * used SPI specific subject line for SPI patch
* for ADIS lib:
  * updated to use the `cs_change_delay`
* for DT:
  * added Rob's `Reviewed-by` tag

Changelog v1 -> v2:
* for SPI:
  * renamed `cs_change_stall_delay_us` -> `cs_change_delay_usecs`
    initial recommendation was `cs_change_delay`, but decided to name this
    `cs_change_delay_usecs`, since the convention for these delays seems
    to add the `_usecs` suffix
* for ADIS lib:
  * renamed `stall_delay` -> `cs_change_delay`
  * removed some assignments of `cs_change_delay`
    where `cs_change` is not set
* for ADIS16460 driver:
  * fixed license
  * adjusted to new `cs_change_delay[_usecs]`

Alexandru Ardelean (3):
  iio: imu: adis: Add support for SPI transfer cs_change_delay
  iio: imu: Add support for the ADIS16460 IMU
  dt-bindings: iio: imu: add bindings for ADIS16460

 .../bindings/iio/imu/adi,adis16460.yaml       |  53 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/imu/Kconfig                       |  12 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/adis.c                        |  12 +
 drivers/iio/imu/adis16460.c                   | 489 ++++++++++++++++++
 include/linux/iio/imu/adis.h                  |   2 +
 7 files changed, 577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 create mode 100644 drivers/iio/imu/adis16460.c

-- 
2.20.1

