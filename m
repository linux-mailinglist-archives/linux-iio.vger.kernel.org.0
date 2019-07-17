Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635C36BBDA
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2019 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGQLvm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jul 2019 07:51:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14112 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbfGQLvm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2019 07:51:42 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HBmHEP030988;
        Wed, 17 Jul 2019 07:51:35 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2054.outbound.protection.outlook.com [104.47.33.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tsf0g3hw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 07:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQv5mw7mEJf/1ju9Vcb37GP+LVisiOWPpKI/4mRXw5sgGsoFYkOT+SIucbJq4gHeJ8lcdgZWqmvdU+k0RQuDhQWLrPevGVtlbEW88/GaRmi2pnK2Vffa8gLRi72L1GT41f4jp9DFDyH+CV0sEhz/eqOwpeBsIPCgLyIx/F2gqq9QWNSHI8W+tSsApEVePNfS/RgAyh3HHN0VB8f/96JS6erZ0s5RwCsJw21fop5W3GAgEz6rXH/7MPmIc4MfRcMSP7Koftk3Bbqzvl19gb6iA+Wsz8zCouFunJlRdhaszlxUdzi+ZCKt3FdrOFKhKjjYVkd9gaP0Xz8BNztUu+i2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cbABiRLotvwW8RNQ2kZxxoW3rjOrmOls2L9Ug1iQj4=;
 b=hBogeBf0CpNtgmUZbjqLp+njVo9Y9z0rkjI5fAkS3+BvwshmYXO1k95n+l0NW8BrmRLm2Nq5Jo5Fzq4/KmRZsTXiLq/vOo+1BrqCW+RxymOyUeDrzJWht0TLrRm23fpnrq31iOgxRpOO2fU01GsM01xffncWxQ9Tgvp+aoy9JINdcpZShqH2RqB3fjF8vC5KEY4sVuHbSn+TnyARKpdH/uA1oVH2NcSqoyxqGe90o48VWlTFyLScIa7AvG7x35UBcMyZUrOrNUL6/pn3icSjF0ojH/MVmNnzycIS4ykxfwB4eWLYlVBFjS9U7xnvddLMWkJZJXspk8FKj0m8i3YyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cbABiRLotvwW8RNQ2kZxxoW3rjOrmOls2L9Ug1iQj4=;
 b=bqxtEDSW/HMdygyi8o8rinftb6ZqgNbPzOCTXFXUF6fNj7F0zf5iESo4Tff1geBmXuz6RkXUOlsgxFUlULMyZskwSUtlJYspDlhTGbM8PPemLCpIsEGn0q4hdomBvMRshlIJKwQkRWfWBmpt2BRy/Mm8cXtQ85MpXbt65sv5FCo=
Received: from BN6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:404:10::15)
 by DM5PR03MB3274.namprd03.prod.outlook.com (2603:10b6:4:42::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Wed, 17 Jul
 2019 11:51:32 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN6PR03CA0101.outlook.office365.com
 (2603:10b6:404:10::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.10 via Frontend
 Transport; Wed, 17 Jul 2019 11:51:32 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Wed, 17 Jul 2019 11:51:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6HBpVSS003229
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 04:51:31 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 17 Jul 2019 07:51:30 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/4][V2] iio: imu: Add support for the ADIS16460 IMU
Date:   Wed, 17 Jul 2019 14:51:05 +0300
Message-ID: <20190717115109.15168-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(189003)(199004)(54534003)(106002)(7696005)(305945005)(336012)(51416003)(50466002)(48376002)(4326008)(2906002)(2616005)(50226002)(2201001)(186003)(2870700001)(476003)(7636002)(486006)(8936002)(1076003)(36756003)(426003)(8676002)(356004)(14444005)(110136005)(6666004)(86362001)(70586007)(246002)(70206006)(47776003)(107886003)(44832011)(126002)(478600001)(316002)(5660300002)(26005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3274;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46778ec4-e16c-42a5-5718-08d70aad1c7a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR03MB3274;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3274:
X-Microsoft-Antispam-PRVS: <DM5PR03MB3274671558B5128E2F821F7FF9C90@DM5PR03MB3274.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01018CB5B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dO/EtZPyJfCiHHvLDiUU4QyVAqbzETrisY53mwksFXTUdXUwqueckNJTi07i9Q8D1XAMhglbA/hSxaHlVh8IH+8+2R+rpvqB8ZCSKgH7Zm2+qzfi44BFiSzkGUw5jBuS4wKyjLuflN8b78BwP+7Ia1NP/5Dp+N+UGMPwdauciA0A/zFSAazrZJegxamdLMGkKUWTZFGv5OuSQNENZN8Q2lA1Mv1yyRt6n0m9HfGO5dXs0ZLnSvRGTFY632khL9BTDvVgh5azOym+xXIDOIfrtpbd0TvzL9htfGDhHuEx0Tyjy0e25FoPZhZVKMkRVhoYFkgJG/K5W36APl338RN1NNIjWt9B9bukkpcqn9cXjunfUgG+ikwWA8gjY96sp7lh/zJhJH6NnvA6r3hWmBW4pgahEOwYuSK4dyKh7kaJUtM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2019 11:51:31.5721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46778ec4-e16c-42a5-5718-08d70aad1c7a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3274
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This changeset adds support for the ADIS16460.

Support for this chip, requires changes in both IIO & SPI, in order to
support configurable/longer CS change delays.

The default CS change delay is 10 uS, while the ADIS16460 requires a
minimum of 16 uS. In order to accomodate this, the SPI transfer struct
requires a `cs_change_delay_usecs` parameter that is used when `cs_change`
is set.

The ADIS library also requires a small update to support the new SPI
`cs_change_delay_usecs`, and after that, support for ADIS16460 is added,
since all the required parts for operating the chip are in the kernel.

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

Alexandru Ardelean (4):
  drivers: spi: core: Add optional stall delay between cs_change
    transfers
  iio: imu: adis: Add support for SPI transfer cs_change_stall_delay_us
  iio: imu: Add support for the ADIS16460 IMU
  dt-bindings: iio: imu: add bindings for ADIS16460

 .../bindings/iio/imu/adi,adis16460.yaml       |  53 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/imu/Kconfig                       |  12 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/adis.c                        |   6 +
 drivers/iio/imu/adis16460.c                   | 489 ++++++++++++++++++
 drivers/spi/spi.c                             |   3 +-
 include/linux/iio/imu/adis.h                  |   2 +
 include/linux/spi/spi.h                       |   3 +
 9 files changed, 576 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 create mode 100644 drivers/iio/imu/adis16460.c

-- 
2.20.1

