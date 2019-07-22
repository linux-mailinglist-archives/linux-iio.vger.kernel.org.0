Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4711E70018
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 14:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfGVMs1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 08:48:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21052 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728596AbfGVMsG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 08:48:06 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MCShHn011804;
        Mon, 22 Jul 2019 08:47:59 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tuyv3wv1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 08:47:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE9iLm81U9bJ07cxLinppz48DhGju65r1lBafbX4bI2vbVUDGBxB8tV9N8yFzqhbDOUmwP9/sPAPZCL7ALzC/KFqhRBHNS/plgf2BQ1mcK9Oz6c7f2utSE5+t0l2RKJelnJyf7Z0h2mcpo/2T+91fF+SJ10nWyyELK+2QIi4IuKwCiyhTh9PAVIFSlcnMWlq7EJYaMcQjTPp07rDPeIjUmJGNi7QtlyDSBJPjzLUhU4RPQIFLuM4VGG8HqiKik1vAvOkWCps2rZtHABwkT8+bydxRM/pV2pNAw6V2aots9ryLQb02Ql1S/acX1HjQtwoIXt+aHPzND1o5QrPfCgjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZQ17OTmhxC8xUM6JXeYhXizhO83gBVH6BbgQRYxqpE=;
 b=eWUT+KqKyKZLlZ2kdd3qK0Q/dCBfiPgljboNpwyxe7w2gnHAL4QXlaYPIgijgdUQQtdcJBpjT9nNp0droRX8Du58qFtY0qW5WjnBxytud0utK8FHhWB6ipj8/RvJmgEKCTDqn7XK0YDm/TGKqH6EJ/EWPqP3eOrdC09SbEy8hz9G6sgElywc2oIZOFiwzxVxSrWDbQrPN7FO9mn8s8tW/4PeGK42c6DuqZUfDXlFzL5WBuvrrZUOA4/cdIWgtQPCQ0nCu8PU6+rDxwGFAf0icrFv1NU3RPIma5/5zsIJ3oVvip/5HkBTVGfVFvTLlcF64TRjM3fJ2KssJx38B4FxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZQ17OTmhxC8xUM6JXeYhXizhO83gBVH6BbgQRYxqpE=;
 b=VqKGelrvzaOYdrLJ2ihKqfg/uR8z7vPbQyXMyM5sSDHjsRWNvVFlG6wqzk7DUxo5g4jtRIXfU7FWIKZPlPjvNF5Rgzfi/bPe/pJwvT9uvuDP0c0RnxmQjZ7WNvSTw8UMSNqOTY8M3iNHtcyIPxY32VRpSD7qBBCHHW5yXTzyfuA=
Received: from BN6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:404:23::14)
 by DM6PR03MB4714.namprd03.prod.outlook.com (2603:10b6:5:181::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Mon, 22 Jul
 2019 12:47:56 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN6PR03CA0004.outlook.office365.com
 (2603:10b6:404:23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2094.15 via Frontend
 Transport; Mon, 22 Jul 2019 12:47:56 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Mon, 22 Jul 2019 12:47:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6MClqfr019615
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Jul 2019 05:47:52 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 22 Jul 2019 08:47:54 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/4][V3] iio: imu: Add support for the ADIS16460 IMU
Date:   Mon, 22 Jul 2019 15:47:43 +0300
Message-ID: <20190722124747.4792-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(54534003)(199004)(189003)(336012)(107886003)(246002)(50226002)(2906002)(14444005)(316002)(486006)(110136005)(54906003)(106002)(2201001)(26005)(126002)(44832011)(966005)(186003)(8936002)(8676002)(51416003)(7696005)(4326008)(1076003)(86362001)(50466002)(48376002)(305945005)(5660300002)(426003)(476003)(70206006)(36756003)(2616005)(47776003)(478600001)(356004)(6306002)(70586007)(7636002)(2870700001)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4714;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11132758-a20f-4c2f-2bbd-08d70ea2d185
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR03MB4714;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4714:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM6PR03MB4714D7B9633843E7D79020BDF9C40@DM6PR03MB4714.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01068D0A20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: P14AwspHzirCSORe2R5a5h4rr70bhtUtAhuxoz4posE778ZQ+msJ0axcFOmr70pfCCNYxcAnPhFBabx8yCy+11gRcW9R87edJ3FTiSivCCYQja+jxIJRIUGSo0MimnWrzH0V9urHefHq1LFeCcXsWKBT7ljo2vIrgqHcihSuX5ZC1J7eR+W30Xmr3kcMDpp7WnhymehAqMGo4IFLeLy8H6+DvSSaS8RatqayALEu47E3b8T1OFoJiV5EDq7g4GVSgcyeiXkww92py89ubtU6YQpQ0NIlTuzqgHPSelHh8kzVNY2FLz4q7W132zIacB4meJSFbKMQQg2Stu/C9zJXOKZe+EAXaQncRn30X6m7jdewajkuA0zPXh3odqltpLEiFYAjLx+26cq6XsVXQaFIMTq5OuDZdBYiEpkFfJBFIKc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2019 12:47:55.5057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11132758-a20f-4c2f-2bbd-08d70ea2d185
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4714
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220147
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

Continuing discussion from:
  https://lore.kernel.org/lkml/20190717115109.15168-5-alexandru.ardelean@analog.com/T/

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

Alexandru Ardelean (4):
  spi: Add optional stall delay between cs_change transfers
  iio: imu: adis: Add support for SPI transfer cs_change_delay
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
 include/linux/spi/spi.h                       |   2 +
 9 files changed, 575 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 create mode 100644 drivers/iio/imu/adis16460.c

-- 
2.20.1

