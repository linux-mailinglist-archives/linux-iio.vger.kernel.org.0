Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9708107326
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKVN35 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:29:57 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbfKVN35 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:29:57 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDNBxr026861;
        Fri, 22 Nov 2019 08:29:53 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2waew7wbpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:29:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyUGfC4bHeyLa7DB4KwxMiu0Z7QGFnhg13cDitjwpAmPLfjloIki45H+YfNHQKGbEmHQC22aKdehs9hb60INcr5W9/gIAiuPHEIM3ymUCkwcxr5lmEA3o7gEiKhon3Q6U+3hTQKlzxIa0Q9Nlz8Ceg351RpJRAwAtP/SJGCxtrtmzpUMHmqLd4NCVC4Vc6kGD5EU87yBuFfYiifPb9Yh/qAn+/eADSiw5QaDEFDnmUIvluO5NhSzU2Ms3wmOyP8R5hMeldt31T1ARHX/s8IykchUUSEwMNQ63cdW0dvOaUZUh8X1eRvCPnp3EmXGzR/la8UssidEwt6NLSkvWlyg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMwmpCgg/m99sfkBp+85v9GJAYElCIsyQuS2mUtuXJ4=;
 b=XQ7FXDCressrwJ4RBP7LYRBuSvk920827WoG/cVTLleCmz7OIs9XEIZE8jD3qdrDb0GYtKJ00jwV5pO9+IbHIIHuzE80CAbEoUy65W/AJOhFPkPniy5As6brgfmbVfk8MyWXmykmTr5UZnbub4mfyCHiAmyAES1jmSQk45PxQKzIWxaVVi2Atzo5UEGITbnZRwM8A347lKafM0b0kso+DBZuk6DLqGVR4UNRC57hU3xLkJwcxBMi3HHYPM6AckRXr1zUh4lQlAx2ZtTn4EqT8GdOOVzO7txe868Ny3XrRWUoc+GDlafWzi9O5y9UbI/vZSdRXu3P3tN1pNIrO6ymyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMwmpCgg/m99sfkBp+85v9GJAYElCIsyQuS2mUtuXJ4=;
 b=wgiiZuFtdcHt2tdJ3O+k7Lje1hLauvC9TeyM6W12qn5GXiWc3ZbzHalFifpA3xkoI7mRRgSa70caMoA12UqbRd1aidJOpPAsJHqH0lGPro6wiPS36D2/Xj9SQkVfdIUQ8d1YWnnyByF0JE1YxTz4eiVNbYfUPKAYycgs+AuL0FY=
Received: from BN6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:405:6f::34)
 by DM5PR03MB3098.namprd03.prod.outlook.com (2603:10b6:4:3e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18; Fri, 22 Nov
 2019 13:29:51 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR03CA0096.outlook.office365.com
 (2603:10b6:405:6f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18 via Frontend
 Transport; Fri, 22 Nov 2019 13:29:51 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:29:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTgXV015747
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:42 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:29:50 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 00/11] iio: imu: adis: cleanup lock usage 
Date:   Fri, 22 Nov 2019 15:24:10 +0200
Message-ID: <20191122132421.5500-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(199004)(189003)(54534003)(36756003)(2870700001)(1076003)(44832011)(5660300002)(356004)(70206006)(246002)(8936002)(70586007)(48376002)(4326008)(4743002)(8676002)(6666004)(107886003)(186003)(26005)(50226002)(50466002)(14444005)(51416003)(426003)(2616005)(336012)(47776003)(110136005)(478600001)(106002)(86362001)(54906003)(305945005)(2906002)(7636002)(7696005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3098;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f07eaf5-6dad-49f2-13e2-08d76f500d87
X-MS-TrafficTypeDiagnostic: DM5PR03MB3098:
X-Microsoft-Antispam-PRVS: <DM5PR03MB30981576B35502665772CAA5F9490@DM5PR03MB3098.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5HA6FqorIQbwO5U+JAROh3q/JEtvMQq7tDrahDa+0A8jkELKV4ilrubQb/PkuBsnRjmpzSdYQT8xFDTugkoG3jvyTiJU94GvJGjBHJMmLWHGWKn3FpXSixAIXR7Jc6OkxvHgEF9a6mzdu15HxJTW4/zGo+hL/gR19VLd42b3iNu3RUM/cYutZvFKD1etw7zbrR4KkWgSL+PL2VlIOxpw8kHbEdu5gZsmVm4t0aIr5nQFb67HQVLTockjIDkaqS0+Hd45XQMqD/rOFHSoDQWULxNT1P3VVTm26HlDdnxR2unktIc5pD2kwNTGL6enAQaqAbjDQbJ8Xx8tVS+VV+w8mqe+UH0XK2oIh3G4D7/XIiz3H2WJD5RQw1jVA5lPDulUyXtBsk6nI8uTNQblRxyr6nGLXh13eHofavuF8jZ41IbgFu8NB7HUReDpY1k909h
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:29:51.0827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f07eaf5-6dad-49f2-13e2-08d76f500d87
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3098
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is a general effort for cleaning up `indio_dev->mlock` usage in IIO
drivers. As part of that some ADIS drivers also need to do that.

This changeset does a little more, by reworking the `txrx_lock` from the
ADIS library to be used as a general `state_lock` to protect state between
consecutive read/write ops.

As such, all users of the ADIS lib have been verified to have their usage
of mlock checked. Some just needed the mlock usage removed (as done in

Changelog v1 -> v2:
* this patchset has got more testing in our repo since last time - also
  found a bug in v1
* tested with `make ARCH=x86_64 allmodconfig` ; seems this is how Greg
  found the issue and we didn't

Alexandru Ardelean (11):
  iio: imu: adis: rename txrx_lock -> state_lock
  iio: imu: adis: add unlocked read/write function versions
  iio: imu: adis[16480]: group RW into a single lock in
    adis_enable_irq()
  iio: imu: adis: create an unlocked version of adis_check_status()
  iio: imu: adis: create an unlocked version of adis_reset()
  iio: imu: adis: protect initial startup routine with state lock
  iio: imu: adis: group single conversion under a single state lock
  iio: imu: adis16400: rework locks using ADIS library's state lock
  iio: gyro: adis16136: rework locks using ADIS library's state lock
  iio: imu: adis16480: use state lock for filter freq set
  iio: gyro: adis16260: replace mlock with ADIS lib's state_lock

 drivers/iio/gyro/adis16136.c  |  31 ++++---
 drivers/iio/gyro/adis16260.c  |   6 +-
 drivers/iio/imu/adis.c        |  94 +++++++++++----------
 drivers/iio/imu/adis16400.c   |  51 ++++++------
 drivers/iio/imu/adis16480.c   |  17 ++--
 drivers/iio/imu/adis_buffer.c |   4 +-
 include/linux/iio/imu/adis.h  | 150 ++++++++++++++++++++++++++++++++--
 7 files changed, 258 insertions(+), 95 deletions(-)

-- 
2.20.1

