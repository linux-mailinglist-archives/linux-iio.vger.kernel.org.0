Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D814154248
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgBFKqE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:46:04 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:11972 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727572AbgBFKqD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:46:03 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016AWAJ4004840;
        Thu, 6 Feb 2020 02:32:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=2QYHYJI6KrLttYkanKjBQWeJBEAqC9tf44V1j0OUpQ8=;
 b=bjZEWY2k8PfF25raMsZHR/h0Q74+e8jvVWTdTcF1f0pihRaRzizA2WZM8le3dQOuP1MO
 I/Delqh86Yqra8ajAmt/j348vAMYglQOIIT7A0HIfqMccn03dYw3sMFWpbYE6r+dIkb2
 s4ZPRptQIYukbEMxWStyF1UhTn2SBbopFvcL0WxuY5ukqlgzroK/jUidkea/pa/UMRnX
 cNSY94cWPSc4tEeFYdW51w51p/XcYQRzYOO3s1UmGja7cSb4os1kBjtN2U1zC9dP/qB4
 wAV9ZN41jdKuxafVfqa+QkZ7jktS90siaGcH0+qeZ2O1FTsIXCfmmnHWz1qugTflG+VL BA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-00328301.pphosted.com with ESMTP id 2y0e4sg2cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 02:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfSqthmiHL+Am1VhdfielMiUMdvxMyQGUY+R9p8i4zrfqVoMrfuNGrgbvid+I+0d1b5f5LTanLwB5g9xpcnN4+NpcuoBJq3pry8sDYAuvxWo4T6BfeYmA45PHTtee5x9lGa+sJ0NeWefbYkcdaOu0OYQexP0QL+5QsyfaoVJRESnCzbeF3InWP3yGVvypkgoO5HTfU7Iwq1exCdYWEObKNoif7pnlHntaWyL4lk4Xn9l/Oxc9pXqMDG1XvgRbGt8oNls/JxoERCngWGX4P5QXQrBnAsaaScb1JRb1yQURHvcUTuXNTKJ4O2LYfayp7ebC067PYJHuDW30mHdLY3aEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QYHYJI6KrLttYkanKjBQWeJBEAqC9tf44V1j0OUpQ8=;
 b=m5/wDAg9pqfV+RetKwOM3tEiGMk0ntEaeFzi15NMeepQdZ14G/mh5WNyj/GAY07apvGweOEdFvy4ZIPxBScKaXXrGGHMelp7x1ql2i8rdv4Lp/Jy9Sf+Fqe0XI+/gxA0wIEAdTVM8Jjp140PaaHEY794rh6azx+Rj7y2FVIYnWVF3lXUbrNgmutVoR/FcA6dbsdugwQVibEAuypCSuusOUJWR6TKo6IFuKH36rJI5OFlxn3Hj86/RbZgJ6QVZkuLKZsC3RsqgPoDWkKCSrNPdOx6eTygY/mqtpxOxNzmOVec6S3nM5MBeO0huPrV8nzBeI//X2555DJViFfIjMk+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QYHYJI6KrLttYkanKjBQWeJBEAqC9tf44V1j0OUpQ8=;
 b=czO3A+1VTX/D+LqCwxPHhDY175IM6K7MGQeC1/MCmPAjnkD7bKfN8pu8riVKdxx5fHqy1OAzYr/LM53XTzoT5qseRb1PhIAIcUR9j4Kw+RxKNqPmwstMUcUSDV05rMOksr+TwUrRSC+fUIJ/EAiboGh+B2iar9Ku/QFFVv6/acM=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4085.namprd12.prod.outlook.com (20.180.16.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 10:32:07 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 10:32:07 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 0/6] Add support of similar chips
Date:   Thu,  6 Feb 2020 11:30:59 +0100
Message-Id: <20200206103105.23666-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 10:32:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cd1ccfa-8dd7-4c3a-cf77-08d7aaefd0c7
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40858AA8C89B6FB94B9B7C95C41D0@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(478600001)(2616005)(956004)(86362001)(2906002)(26005)(5660300002)(186003)(16526019)(107886003)(6666004)(6486002)(1076003)(81156014)(8676002)(81166006)(4326008)(8936002)(36756003)(54906003)(52116002)(66476007)(316002)(66946007)(66556008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4085;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFGeA1H9gmmv16dvCKgvgxjnMMaq5LH+51CHZQZH2GuKfcrYaWlKUnBK9+e2VgYjrfK/Hc0c8RIbAKdG1R9TzwKsujsqYaIvD9OLaiNB6lMU7mANiDSjuSJYsfIW+Dg5i7uKxdsEvDWA/IHGlbYyDc9pjcc9lS8IuisP6vUsxAqpjlCLtTg6QiA/slXEhmC21ryJDSZakVUR89qBoHXwba/oz9uG8NuKyqxEP9Xm+4mJ8wKbVXEU4k9ESk+TkWYv/9iK+4LFINQHOQlVo+1wpDIybKLTH+a/ySVXWoULZG5hEnJELImvTqJJ/c/foW8gUswDmQNDR8/uOLJYf2o7azHDtLbGhYOhdFDbQGg0Pq5MNJxFycoq1lvud//eCQMu3iHzHe0Fby4/eyg3o6vfZCedEzvDHEwWYmFW8kKyqzJnJ4toJln2hqhQlI9khDhN
X-MS-Exchange-AntiSpam-MessageData: vci/C9TjBzvEqvhvdfCsW5+9xyVXpZw80bRv8ElaK7bWWOqHSYColVy00u8CY+Ep6thjoSLcZnVNRSG7f0fF0u8Eya42xAENnHFJ171o4UHVe/r25wjCfDL4Yj+bm/9VCV9j0KavLDL+IhWmAvEyeg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd1ccfa-8dd7-4c3a-cf77-08d7aaefd0c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 10:32:07.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZNDuC5W82D78rr5I/GDKo7o6CL8VUlNwVLQi1qPQysRbifF11Wt8rMLKcbKDYHPkGXFhLbo34W3lMutBHGgXOfnGMAwntiTzQy+GQkZJUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060081
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series add support of new chips that are similar to the ones already
supported.

Add correct OF support for spi and modify low-pass filter settings to
support correctly all the chips.

Changelog:
- v2
    * Rework of/acpi support for spi and i2c using device_get_match_data
    * Merge all dt-bindings patches in 1
    * Change the LPF bandwith setting patch description since it is not
      a fix (required only with the addition of the new chips)

Jean-Baptiste Maneyrol (6):
  iio: imu: inv_mpu6050: cleanup of/acpi support
  iio: imu: inv_mpu6050: add support of ICM20609 & ICM20689
  iio: imu: inv_mpu6050: add support of IAM20680
  iio: imu: inv_mpu6050: add support of ICM20690
  iio: imu: inv_mpu6050: update LPF bandwidth settings
  dt-bindings: add description for new supported chips

 .../bindings/iio/imu/inv_mpu6050.txt          |   5 +
 drivers/iio/imu/inv_mpu6050/Kconfig           |  12 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 100 ++++++++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  49 +++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  20 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  64 ++++++++++-
 6 files changed, 192 insertions(+), 58 deletions(-)

-- 
2.17.1

