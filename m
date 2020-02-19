Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83370164734
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSOk0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:40:26 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:65068 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBSOk0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:40:26 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEandT007777;
        Wed, 19 Feb 2020 06:40:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=0icWU/JPRTHYDy/sGubjUjX/KVwTgLokBnYC/5iFMa0=;
 b=OvYfgjYE+WLttYqG6YOMYbWDrssWyMctCQu2yQ/AWNvLe5t0cLC/u9jNhGfMyOvn3MbB
 FBiPOUWnk6KvqcqncQ58DAFQeQfm7x9HBBrgfTHCIfP5QJ9+dqRWZPR3Q++E6ApbXRlV
 t8o2Mrk7HjW2WesXrrKwjfBnwnFtsAU8h6DBYYABLH/vxlfmJxARpUn67/+D0I3NFwNu
 kcYiXpCruj4fc6KbkeqJfdgElsjHR9egmLlnU7/EMJJeSfKIyKpF69xred1aTqKK384S
 DB6SSX4MM87Wj2Q1gPvSZ8+EZ1tsGl4CMxK4M7qb6LbrBTcNAmah3GkvsaWcgbA5MkX4 Ag== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-00328301.pphosted.com with ESMTP id 2y8uc908gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:40:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3SgQZgXlp0Y7MFLgmMO8LbWbDNCIDYHxiOqMgPjn52dy1kAJ6Q0G4HChmJ5GeEFROG39vV0uEyBcgKu4OwQ5tRIHtEVbU3j5XIV+qKrnmNsBRIE9o9zOFcrcCAEPb5mb4NB6QWPR/oddfh7Wwn+t1iuWEthcgfUDHLGXzfDlniMhGnDuLNEns9YTCmfT0yPyqZW1Z3sz8BVPe5titiKgOc8WbRixBkwuxXqRWaYtytjOp65FD3MUFWdMMcRT7ALAttrWZgO6HG9PJ7VNBwl0cSKdwvtpUgNaHeaGnuCFDTkDT2aWcyzBR0U2MlEKhvwMKWrRTCHo3i2suNJrtsq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0icWU/JPRTHYDy/sGubjUjX/KVwTgLokBnYC/5iFMa0=;
 b=nZq7XKNlmHG2ub8S6NoCmE0ii4kDNM1H9qXGwtHt0hLxwdHgKnHp0WpUGHraKISMLjTd3wN7EJzHohUBmUYAWNO2/Ndr8VvCKveFNJnphoBvETxrwrCfWnRqWOr/oVdXdO7akVQuPuQWzwsGkc712s0BeBwDtswEXFhDxJbSZgET4PCAakWWuVi5Y4RRUjx279aeWGKxsGl+SD/Hdodo127vA5RQ36Wz0V7UgpJzcNpmcP7PSLzXhZe89uFKozICRm8bwQtb6Gph4cq6Idf81x77g95ZF81oXtxhg/aPrNsDls4TghvNwDxLRE7Viq9xr02TNjYHkMzVY7WYIfyVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0icWU/JPRTHYDy/sGubjUjX/KVwTgLokBnYC/5iFMa0=;
 b=bKtPgqrSziP/TBg/DyJFhhIv59iTr/Az2rAn/RTfrlB9MY04+ux/xHny4mXWy8rZgARYvKoOKkPLTcbE20ZSAtSoo4CPyIBOFKtrO5sx+4SV6pTuz6pBd7JNruYuC2LY9pkGGfgDCTfzOJxq/jWz+4Vc4UJGUHDKbN7H8vZNpbM=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4213.namprd12.prod.outlook.com (20.180.5.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:40:21 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:40:21 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 00/13] Rework sensors engines and power management
Date:   Wed, 19 Feb 2020 15:39:45 +0100
Message-Id: <20200219143958.3548-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:40:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f78b30-0add-4a2d-1ed7-08d7b549a54f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4213584AA46114480CFE7A50C4100@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(199004)(2906002)(36756003)(16526019)(6666004)(26005)(86362001)(107886003)(2616005)(66556008)(66476007)(4326008)(5660300002)(66946007)(81166006)(186003)(478600001)(81156014)(7696005)(8936002)(1076003)(8676002)(6486002)(52116002)(316002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4213;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2ycw1izCx+SqVFQLc4X9t/wO6MqZVKSp9FGt3+Rilu5YdniMGmOp2Tsq3If92nxeFAuKM5rPem+UnvQ2pE1xeD7iK+WjRhhSjlyDYG9XsuiYQ1WiQjFyWRdcRmdGAyr89KemRGWp49uxI6Go0V5O5HAIy2impHbGp0iAGkLjAdCtGQJqb7q+VIBfVBZEClJPUwhWvxeIyweUP2uOvGYyeSGqA4NsjHpdXND+GJksKmrzBI7kmC8MfMGS/MzRgaw2m9qG9FTmnYPqIfpdJoMsAOfP13fl029UkwY9CjyQ/gGxcQ1s4KMFI3F7cANKBgasYIK3/ZqSnNrDqNfwAErSMObGURKAGsPlLJn4PGSEIqqRRoomh7Lgx+WWmOvISz5s4ZHfcDxPM1TD7bK0JiYrmoTLEVSebdElpUUHn9z3CdQlqXJ8jZyPjEyaBuh0a2N
X-MS-Exchange-AntiSpam-MessageData: WaGS4IGD14GbISt+KkHQJN4alwoTi8nxS+kHHZx5xQn0DQn9rlYtMsD2WUsHpmyGG3pC+bTwWclhScRJ/n6Gp10BY3raMePGNNSqV6gole+D4flVEBoovGmXlVclG05XIufzNBa5OZB8kmgyF2h4LA==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f78b30-0add-4a2d-1ed7-08d7b549a54f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:40:21.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruTvE3aOrTkLpdmrNI1MAZxMJKWM2jBI7PxfbRXhm+IcHdj3SKgHOwXWLLB3Forx1itdB8v/8JtZBPQxyu2wed/y+MW5Wm79pw8xN6b7ZZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The goal of this series is to rework sensors engines and power
management using runtime power with autosuspend. By reducing power
on/off it enables correct usage of the polling interface at low
frequencies. It also simplifies a lot of things inside the driver,
making it much more simpler and easier to read.

The series also include several reworks required to have the
implementation working.

Changelog:
- v2
  * use runtime pm with autosuspend:
    - add comments and fix whitespace changes
    - delete ifdefs of CONFIG_PM_* and replace with __maybe_unused functions
  * temperature only work with accel/gyro
    - replace error code with EBUSY

Jean-Baptiste Maneyrol (13):
  iio: imu: inv_mpu6050: enable i2c aux mux bypass only once
  iio: imu: inv_mpu6050: delete useless check
  iio: imu: inv_mpu6050: set power on/off only once during all init
  iio: imu: inv_mpu6050: simplify polling magnetometer
  iio: imu: inv_mpu6050: early init of chip_config for use at setup
  iio: imu: inv_mpu6050: add all signal path resets at init
  iio: imu: inv_mpu6050: fix sleep time when turning regulators on
  iio: imu: inv_mpu6050: rewrite power and engine management
  iio: imu: inv_mpu6050: fix data polling interface
  iio: imu: inv_mpu6050: factorize fifo enable/disable
  iio: imu: inv_mpu6050: dynamic sampling rate change
  iio: imu: inv_mpu6050: use runtime pm with autosuspend
  iio: imu: inv_mpu6050: temperature only work with accel/gyro

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 562 +++++++++++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  62 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  38 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    |  49 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  57 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 160 ++---
 8 files changed, 571 insertions(+), 372 deletions(-)

-- 
2.17.1

