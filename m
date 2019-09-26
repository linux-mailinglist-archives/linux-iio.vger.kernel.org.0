Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6DBBF0F6
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfIZLSb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22260 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbfIZLSb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:31 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBI6OA003191;
        Thu, 26 Sep 2019 07:18:27 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hjwy9ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O37tnlpZQIUfxzUMybOu/OXLUw+nn2FWHr/5xkcjznqOOM1WDMiIgUBW0cSBd8Lu5seArKGxHyBXhJMXUhTqCVWC91dwgqNBejIxeK4wTxB+oyDqImT2ILJm0IDJLHtQ1MTfXjbrBkihKd5mP1tBA9AyeCxTObFVQ5lsZWiP5fnA2xiHKRVxaa9pHDsCQi4UgOhWiXiDUDQb+dr9YVtgKLq36EnS/nHCteK/g1EfmiTI8O/8MrmPmDJ7zFta8hpEToghXgflwSdcfB82lyUcm5Dg3CzocXUMicqrrMbn3UCsEf0bFf543ZczM7fCvcRwXifB3Zv4Q0G2sm9HbwFzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44kEubpywKcZtxOtXDRhhhkTw1kJ8EtnQXmJBoxrOLs=;
 b=km8MunSVowjEMc8mhTxtIViffgPqdq4B4gLEyfeDL0J+pbcwlbrhMzKIgo2IzfO5kTNF3s1siDZozW+AeMEhky2UfMQRDsGJW5NTHsQY/09qF+HJDDsrK/hW0uN1kw+Rpz3wColN1Zi5WsxNFI6dnOKhYbLj3cclX0TGiADQtHcpB9N+aOd9V3GX6fQbVlLvh4oNclzT0u/4KIfPTEswV6g5euFWYZu0Kw3TDQyZXKXUlFWrjULqa5bauua2IZYEDP9USSR/ozghV81v8QEus6HVNi8oQnBZFvRXHArhOTufdvfa/axoxdvKN9D+heQmaDlkTeajxsTgu112aA8SfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44kEubpywKcZtxOtXDRhhhkTw1kJ8EtnQXmJBoxrOLs=;
 b=n1KCJKJTAAa7vtOf5NU/6dewYm5wJJs4j5Hnq3Mx7OiQEraVI7q0zOZRapyOy3gJ8LMQ3kSySrI1zXt93b78xDao07ruFcGaJT1dlxw+yq9mZmUpxtimJpQDHi0ciGw5u7rw2iDXx+87au1moGjf+baovZJS/ajf4GygomNW0rM=
Received: from BYAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:a02:a8::21)
 by DM6PR03MB4891.namprd03.prod.outlook.com (2603:10b6:5:18a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Thu, 26 Sep
 2019 11:18:25 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BYAPR03CA0008.outlook.office365.com
 (2603:10b6:a02:a8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.15 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Thu, 26 Sep 2019 11:18:25 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBIJeS004141
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:19 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:24 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 00/10] iio: imu: adis: cleanup lock usage
Date:   Thu, 26 Sep 2019 14:18:02 +0300
Message-ID: <20190926111812.15957-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(199004)(189003)(5660300002)(8936002)(186003)(7696005)(48376002)(305945005)(36756003)(336012)(246002)(476003)(47776003)(86362001)(44832011)(356004)(486006)(26005)(50226002)(6666004)(2616005)(50466002)(426003)(14444005)(7636002)(110136005)(2870700001)(4326008)(316002)(126002)(107886003)(8676002)(478600001)(106002)(70206006)(54906003)(1076003)(51416003)(2906002)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4891;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edafe8f5-d686-4878-e5b7-08d742733f84
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR03MB4891;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4891:
X-Microsoft-Antispam-PRVS: <DM6PR03MB489130F84203010A7B924097F9860@DM6PR03MB4891.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4vpi34lh5N1UbyfyUXnHFxXEj9E48T7Gk1utYi5zwvO+SwDm2KAkPJzDZY7PGgm3nzECXlZmTH9bng2WDHimqQUyAkUbXxBqGDQrA6KO9JHhS8lkNBLbH6RRvKS6AFqw4rV4OipsBxbVndOG8PJ6u96vvl5AHXjLS6uZjB81DpKWwRcjLf4aPDmHdYe+8AzN5Xh/cnQQRELeDNqbjCciLBZfmtivEGBN7xXvUKKUaos6T+Marki8bwQVZ1J+veDv5LnhHccMbA+zCMAXfujgLmqPkSefqMt1+p4UUT90TUTge90zAU+LMwS2ajX0RDVV1/zNtNa8V565rvt33J1/9x5KKp2w84PCdKM58SYyrfNu6Lg2X25yWueF/lUrqSZK7I8bpdfjEaKiPjxhpc0SafAQwaurHYrZPJA1OZdqJ7A=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:25.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edafe8f5-d686-4878-e5b7-08d742733f84
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4891
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260108
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
other patches).

Alexandru Ardelean (10):
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

 drivers/iio/gyro/adis16136.c  |  31 ++++---
 drivers/iio/imu/adis.c        |  95 ++++++++++++----------
 drivers/iio/imu/adis16400.c   |  51 ++++++------
 drivers/iio/imu/adis16480.c   |  17 ++--
 drivers/iio/imu/adis_buffer.c |   4 +-
 include/linux/iio/imu/adis.h  | 148 ++++++++++++++++++++++++++++++++--
 6 files changed, 254 insertions(+), 92 deletions(-)

-- 
2.20.1

