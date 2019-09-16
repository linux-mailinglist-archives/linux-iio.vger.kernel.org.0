Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CBB352C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfIPHKd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:10:33 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:15046 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726927AbfIPHKd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:10:33 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G77lut019376;
        Mon, 16 Sep 2019 03:10:30 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v0vu6b631-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 03:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQJWV31PQB9anrpwW61jfUwayxM4Jib069bRAl4P1BJhZp4sN3bjVOYPoKEcxkXKukQAUTf/h2AtBSVWwwibaO/HzVPWo2tcL/6p6s85neDUoEWKjdCdvwUmO+WEyLOJDh8MA3rf2iaH6m87QsNCJF5NoukrVLSALl/B0URYyUWtEabbGkT5IIGilz/eD1ikH64+DePnubX1kiZZ5QksArO4adi0Ag6KJ/8Fk99OKeWbCDPW7qrO/K7whtB9BlXtBBe74BWrnbAxnfrHY8sNdzm/IS/GrMA4smjoVqFIAVFt+x3EFtpN/XcyXeT0LClwvFTljEeD3xabVezzOnBbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gzTY+IJdMHQD4O49EIkPuQUT7zI4xclvKN9ugH7cBc=;
 b=hqvPqCxAOR77W0ujobsskZXfBEnd2/hr8+Z7HxugufwjxbakU4LEpR4UqTC7lNy6d2/wAwfMOczUjo0nR9jLmXnusoPKWoA4YgeR8GYwh9DgnHuTl4DzVSTJ945u/01x4uPYP3zBUTa1ZQn3DdeMJayGXI9Mt3eCkaMVGSYC+Bm0zCiqtB9xbOh7Z0SxwyqqIciKnnQNXGESuOAINnBwjXBFlngrOCuMrliKDE1Gz9o9u5piivXps7qzyTvx6d7kdLMf9LsSwEuqX0mjluGD9ILMMerazgRP8NejgZ5NO4aKI4hsKFnPjpuNPtu/jaNjCHM4WRM1AXcVUYE4bIcF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gzTY+IJdMHQD4O49EIkPuQUT7zI4xclvKN9ugH7cBc=;
 b=1lfnHSbvvgvcQoGMujUMwK3wEWeRJkFJO5NrAB6h3nqlH8qTyh6V7xaUxborj6BfPv4prwGY8tF6JI95f6IIE297tvUZnat0MwrKwn302PnPcw5r1N5lc4O6zkPmbdlzmF22USnueMC5+KNzx4toDzUcQRgl95eanlPr5h3eoC0=
Received: from BN6PR03CA0013.namprd03.prod.outlook.com (2603:10b6:404:23::23)
 by SN6PR03MB3983.namprd03.prod.outlook.com (2603:10b6:805:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.24; Mon, 16 Sep
 2019 07:10:28 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR03CA0013.outlook.office365.com
 (2603:10b6:404:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17 via Frontend
 Transport; Mon, 16 Sep 2019 07:10:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Mon, 16 Sep 2019 07:10:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8G7ANoa016098
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 16 Sep 2019 00:10:23 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 16 Sep 2019 03:10:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/3] spi: introduce `struct spi_delay` data-type
Date:   Mon, 16 Sep 2019 10:10:21 +0300
Message-ID: <20190916071024.21447-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(54534003)(199004)(189003)(106002)(2870700001)(2906002)(14444005)(70586007)(70206006)(8936002)(8676002)(246002)(50226002)(486006)(44832011)(48376002)(7636002)(305945005)(86362001)(50466002)(2201001)(47776003)(6306002)(4326008)(107886003)(356004)(966005)(478600001)(36756003)(6666004)(26005)(5660300002)(51416003)(7696005)(1076003)(186003)(426003)(336012)(126002)(54906003)(2616005)(476003)(110136005)(316002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3983;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53735e4d-3b72-4afb-8941-08d73a74f432
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN6PR03MB3983;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3983:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN6PR03MB3983DA178616AF1922CBB0CCF98C0@SN6PR03MB3983.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0162ACCC24
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Si5r4+2lYnxbvy1giGFVprRZvTfjbaCpGhCmR7bseILxWuMNopYdh8mXYhLziGlvbQEtOlO44yIDSN2+tHHTdcG0dfjk5VWEMQDgG+HVh9/J5fnN5mBMh5ISZXYK+ujRbbMR2fSfz89MMKe3NyjdzVwj1vQMMokoR6bxwSRnTJ78BMK/yjKtD9oGE+gAn5Bvr3AvpOWaUYqhXLncvYLsKlkHZyN+DIiZvhFRyiLfgR8Pf1EjWtwLj+X/7WGHDEj6rcG2ep6N41hfrktfaPKEygCpGhSJMVnUykYG0B2DDseze9Q1wS5V/ieumOcKr3eyJilXQYVy0VwyznMqxccytryLPRb+h0oa4h9OomBLzpV2ck2MoP1KqpRGnY6ghgEj+jipepO/YQQ8525HLugHDYsy2fwPQxz/xp6tnbRQDbc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2019 07:10:28.3354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53735e4d-3b72-4afb-8941-08d73a74f432
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3983
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_04:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=965 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160077
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

Alexandru Ardelean (3):
  spi: move `cs_change_delay` backwards compat logic outside switch
  spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
  spi: make `cs_change_delay` the first user of the `spi_delay` logic

 drivers/iio/imu/adis.c  | 24 +++++++--------
 drivers/spi/spi.c       | 68 +++++++++++++++++++++++++++++++----------
 include/linux/spi/spi.h | 22 +++++++++----
 3 files changed, 80 insertions(+), 34 deletions(-)

--

Changelog v2 -> v3:
* squash patches 3 & 4 into a single patch; otherwise the kernel is in
  broken state between those 2 patches

Changelog v1 -> v2:
* split away from the RFC patchset, which aims to be a broader explanation
  for this changeset; parts of v1 are not 100% defined yet, and may require
  some discussion and refinement.
 
2.20.1

