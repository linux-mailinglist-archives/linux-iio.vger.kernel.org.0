Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83C7EC095
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfKAJf2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55472 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727143AbfKAJf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:28 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19XUD9003905;
        Fri, 1 Nov 2019 05:35:14 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhjrw11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES3qcq385Ccy2UgW7Vt9s1CnWyqjaqKfYHaAeQt5dfU0dlMDabhDppu0LvjTU5Yy9trrPU/yhCm8uttQQnI8RmfxSDZoePU3ZZtw1XMDNasgRUxTEuH0uggcXVDNSU94Cn6d990kwnqUZfM6LnBBzg0tU7tponN2p6g9tqVJzKEuo5bIhNTFSUHOunkui5ibK60qSO+Rg3qmaqb2XSE760sxJ9rkPj34l70Zn9eQQlnnaueaIz7AXwsw0PjZo88SlMN5TqK0YFCPhqPDK9ByJMGJC0o3qSOVbp1dK2meS43whn5m8DgQa7DRSEIYn1JIvQAWa7qgSoOqDajZxOhKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr9hAdVLEOx5rXJex2uW8yRqB3FPyi2Ej5hbZnW2ZOI=;
 b=YIkxpmckbiF8zgK9c+T1tyADfjRt3BMhbeoks1HZF1U1lQLuPZ8LGThTvFvJlJQm+Q+XT4n8kOfslaVraoYnrLhQErJ92G6W12Ntr+VFFDFSMuWC24d8zbyw/F3DUzNtRrc8M0SplW+P7aSqf/OHMFlALsavChmx6zQpqe9OPzaFNIqwkWUd/U2bbvwOfnrJP4UP5bmNMmCTmc71hE2alWD7qjkJhz2gDO4djKsc/zBP6+F/9e0dSXSFgSLPdfVY1t/O/1QdEF4Cb/uvTUPlN2XuqC8r89pLOkbf+WwuyIu5V2nt6hbQuiMow53VI3VGBfp/Okh8TmdIQJsbQS3wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr9hAdVLEOx5rXJex2uW8yRqB3FPyi2Ej5hbZnW2ZOI=;
 b=jmwC6yHM3gr10AVhYEQEp+69UY5UlCY6VoGRUNUQe3gdbvcWGhnd6xoGsI0MLs8AW3hrMsmGynGpMtTW3TyF89XPKiSO/bVpuo76FxiAGDAuSpvB8w3KEXDEc27+G9p7GVUuGCTipd/meR8dXkv65mUu5XDkARUeGsor/9YNbUU=
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Fri, 1 Nov
 2019 09:35:12 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:11 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19Z4sC024989
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:04 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 00/10] iio: adis: cleanups and fixes
Date:   Fri, 1 Nov 2019 11:34:55 +0200
Message-ID: <20191101093505.9408-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(8676002)(478600001)(107886003)(50226002)(26005)(54906003)(8936002)(70206006)(4326008)(70586007)(316002)(110136005)(36756003)(246002)(51416003)(7696005)(48376002)(186003)(1076003)(47776003)(2906002)(7636002)(305945005)(86362001)(44832011)(106002)(426003)(486006)(5660300002)(336012)(476003)(2616005)(126002)(6666004)(356004)(2870700001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5081;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa451490-1110-4dbe-50d7-08d75eaecaff
X-MS-TrafficTypeDiagnostic: DM6PR03MB5081:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5081F7C4F8F3AF5D40D6451BF9620@DM6PR03MB5081.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPkmKfWiQW7XyRG64zFp6S/0rqSDeNoaS1w9/sz/Q3jY5soi5fxumY7eV9i0YUYIqdFtb63Tvg4/Lb4qT2Csm5NtWOIqb8NdilBrmNLGHsg8/vRp55WLDqdE6gVsE4UTHbjFuXYFP3363uARO/Om87fDMccYD4Vb/c9kNfH6fSxvcb9ZpeYy7LU5zc6e3lsqrunuqaZYHqzUPXUNVr7NjF4TLFQ5Z7EWAwYZMK2FV2+gBuqsAXIImyWvuJZjKnMFvjm+nhq8AgLgzbUuc/kIPkXYiu5BoYpOsz1bpP56KqXTVP4A9pVteU5zGz5/dNm2b9T3AXMjJqeyeALIa3jAH+Zjwc0LPuZUbo0jg7eDwvvwqMOMabNT6kM1pl0x2JogpT5iQGUNlKMxviORTOfti6skjFe+bga8/9dxfARqH/pGWiG6ivQOJBy7xltkE1IU
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:11.8844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa451490-1110-4dbe-50d7-08d75eaecaff
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=803 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch-set addresses some issues, where [when making the functions
inline], the GCC [especially for x86_64] compilers start to report
`-Wmaybe-unitialized` warnings/errors.

The warnings are valid from a general stand-point, but are also
false-positives, as the ADIS read functions return 0 or negative values. So
for most cases `ret < 0` is fine [as is done in many drivers].

To appease the compiler, this changeset converts
 `if (ret < 0)` -> `if (ret)` [which is also a valid check]

There are also 2 checkpatch complaints addressed.

And lastly, 3 minor fixes. In some cases, the value of the ADIS read
function should be checked for 0 (success) and only then assign the read
buffer/value. These also contain Fixes tags.

Alexandru Ardelean (10):
  iio: gyro: adis16136: check ret val for non-zero vs less-than-zero
  iio: imu: adis16400: check ret val for non-zero vs less-than-zero
  iio: imu: adis16460: check ret val for non-zero vs less-than-zero
  iio: imu: adis16480: check ret val for non-zero vs less-than-zero
  iio: imu: adis: check ret val for non-zero vs less-than-zero
  iio: imu: adis16480: fix indentation of return statement
  iio: imu: adis16480: prefer `unsigned int` over `unsigned`
  iio: imu: adis16480: assign bias value only if operation succeeded
  iio: imu: adis: assign read val in debugfs hook only if op successful
  iio: imu: adis: assign value only if return code zero in read funcs

 drivers/iio/gyro/adis16136.c | 24 +++++++++++------------
 drivers/iio/imu/adis.c       |  5 +++--
 drivers/iio/imu/adis16400.c  | 22 ++++++++++-----------
 drivers/iio/imu/adis16460.c  |  8 ++++----
 drivers/iio/imu/adis16480.c  | 38 +++++++++++++++++++-----------------
 include/linux/iio/imu/adis.h |  6 ++++--
 6 files changed, 54 insertions(+), 49 deletions(-)

-- 
2.20.1

