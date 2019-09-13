Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C2DB1A41
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfIMI4F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:56:05 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:11062 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387615AbfIMI4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:56:04 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8rF0X004206;
        Fri, 13 Sep 2019 04:56:00 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2055.outbound.protection.outlook.com [104.47.42.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1h9q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENrAZRUGzaLj6r+kJMec8TyHBmWlOTfk21H878Kxjr+mSESRW+BuAkrnpjKFjKqSXANmN+p0VmFDV8c+5fGRhXUuVaGwQ0hUZvk4KFki2yIiSlwWtkHRvV7uQK6xGHPK4oUoVI1DQR4gSWFVxPpfdS5qDOfM7kuBqMvXRI4o5bPa4HDnBbibOmnGnrDeJ/WieW5B7ObQ3rqzULzJvYV8KFhknhxsy1hEMdj7vMZACFsMgxkNWLkTUpL6QYqZHh2Ks7fr2UkUnHeVb6C5jdDc8Qg2YQ9SNqV1UuQfj9BD5jzn0gv7OyYOcoW0zXT1TJMFJaZXJ84RfnFF9e2mwc0Ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4GXGw4Jaaq3D79dD1RYpAnWd2NUfIitSayBe0mznlk=;
 b=OCGwjknjjKsB8rBZB07Mo84QYrBqUHHBy2dsJ88sji7Bzv+YNHv6R7RSTgomYrRvrfWNmPOr9qWG2kTExcWAPVjd7ZyeuigIqJXzAYoIP/SAQrAnBVj3PyfuOxvhy2+bt8ESjRaEDSqAqANg7FVSILfmURk0ENWChEo+R7DYw8kdYFzs8s/VMrrFWs6pN+TaXQ0/sgDNC8EOjPq4SIjJ39eRT/DcOv5cvBRkkVaJxEZllB+l/+p7VjLnheNUQwJgVOcpUHJibox96sBsMnXWLRRefAbn7N6WmayhMhZX79H8AIRWXzb0XhpdMIIewMntysrcg1ehulCccy8n+KJ6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4GXGw4Jaaq3D79dD1RYpAnWd2NUfIitSayBe0mznlk=;
 b=D2WPk703vl6pq0lZKKHRPAIgGrnYkDy3KL57yI7tiX7hTe2xSm0bcX7ryiv/PJyb3WkAfSTKpKW0cgPu4wf6T7KNQJsL8kwvk6xJ74z9y5jkqzTqLE94Qgu2r6y6bk/dxN0D4+CYAp/5H7/L4gXU4hbuLnedBqLFqO8zZnCNARA=
Received: from CY1PR03CA0002.namprd03.prod.outlook.com (2603:10b6:600::12) by
 BY5PR03MB5235.namprd03.prod.outlook.com (2603:10b6:a03:21b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 13 Sep 2019 08:55:58 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by CY1PR03CA0002.outlook.office365.com
 (2603:10b6:600::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17 via Frontend
 Transport; Fri, 13 Sep 2019 08:55:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:55:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8tqkk000398
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:55:52 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:55:56 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 0/4] spi: introduce `struct spi_delay` data-type 
Date:   Fri, 13 Sep 2019 14:55:45 +0300
Message-ID: <20190913115549.3823-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(54534003)(1076003)(316002)(478600001)(486006)(26005)(14444005)(70206006)(70586007)(107886003)(186003)(4743002)(47776003)(966005)(6306002)(305945005)(2616005)(126002)(54906003)(426003)(7636002)(106002)(246002)(336012)(50226002)(2870700001)(4326008)(44832011)(5660300002)(110136005)(51416003)(50466002)(2201001)(8676002)(86362001)(48376002)(36756003)(7696005)(6666004)(8936002)(476003)(2906002)(356004)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5235;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64204954-c98e-4c0e-b6f6-08d7382831b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BY5PR03MB5235;
X-MS-TrafficTypeDiagnostic: BY5PR03MB5235:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BY5PR03MB52356F0AEF106FE19EEE1440F9B30@BY5PR03MB5235.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: SDp3Rfp8iwiDGI5i0EGQ7pcwj/6So+SFgExpTtwNu7HVcG328sIuaXq/7VZmv5g1y8+LHxqybLAARM7vZPJKqZ84ASj8HSAdHK02OCMlZc7mOJqgUT0R1IHFrgSq0ZmWrUa/RGhUPeGWF0PIgTW87ibnozz4b6S1Q2JX4fslEzLsmLxolZQ/p9zpgUVNHG6DjaBAsnOErYITPn76aBWicb8IBVRbbiTvv79UdNG4ryx2jbOKKWbpgsFieA2bGOq9c2TGuIjrvRRphHO42I/I1XFGm/W4puabjo2D5qV+IPB1DjaKOgZAxvRlqe2IQHISgAGV/Lz/BGS/HAyXzPTi0bMUcq46Tv9F2W12e9MG9T6QtlLaIlmacpmuEpBHUWhH+nziSOWH9qfKsDgeJYt2pkPbjhFHm/8czhbQUEYhnd0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:55:57.9019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64204954-c98e-4c0e-b6f6-08d7382831b8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5235
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=881
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Discussion reference:
  https://lore.kernel.org/lkml/20190913114550.956-1-alexandru.ardelean@analog.com/

This changeset introduces an `spi_delay` struct/data-type and makes the
IIO ADIS driver library the first user of this.

The patchset base is Jonathan's `iio/togreg` branch, but it also applies on
Mark's `spi/for-next` branch.

The reasons for choosing `cs_change_delay`, is:
1. this change introduces delay units
2. it is not yet widely used, meaning it can still be changed 

Some delays like `delay` from `spi_transfer` would require a longer
update-time change & discussion.

Alexandru Ardelean (4):
  spi: move `cs_change_delay` backwards compat logic outside switch
  spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
  spi: make `cs_change_delay` the first user of the `spi_delay` logic
  iio: imu: adis: convert cs_change_delay to spi_delay struct

 drivers/iio/imu/adis.c  | 24 +++++++--------
 drivers/spi/spi.c       | 68 +++++++++++++++++++++++++++++++----------
 include/linux/spi/spi.h | 22 +++++++++----
 3 files changed, 80 insertions(+), 34 deletions(-)

-- 

Changelog v1 -> v2:
* split away from the RFC patchset, which aims to be a broader explanation
  for this changeset; parts of v1 are not 100% defined yet, and may require
  some discussion and refinement.

2.20.1

