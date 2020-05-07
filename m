Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE51C905E
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgEGOnM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:12 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:9114 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbgEGOnL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:11 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Eegd5005564;
        Thu, 7 May 2020 07:43:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=FLMMta27B4eNge9zl/UsA4ypqXYUsyy7p94h0/+sClk=;
 b=USg3gbcUwfIgbTElQKW3bvLvQJBS59kvJCV5F/6UjuaesLKxEPirIYMiMho4CoJC/lgp
 T9TiYh65nTvNirK/AhkzIvhL2Std2hPzkQKxB+VLiItDVVrrbFjoEBFFlnlsIiwUjPvZ
 9DUJsEuZUw0dvEm7X1hMnScMI1dl/clctBHHQXAbZHukM3zKwG6dfT7IgPG12bKkC7Li
 1LdlbyOcN5PAzHobZFVGhwKwl6hgJFc6oG1vug0VXxQnuCxJ15tIw9DLsy9zW7KzKEcj
 rPTV3W0c3LM1qvmFTUDJZr6rNpd4O1Zn05HNxrzwtvAmxy+m511OB9XklhNswlRKMLAJ Zw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00328301.pphosted.com with ESMTP id 30sfwdjs8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRgBBi5E4ZIboc+0xw8fRhNOlcjMhJHHObrrFsUvyzBtCVChr7RK7xCHd1uExCknpd/S38otZG2iKR601fsSDTSYIBx381s3sWAqhPF3lsSjoV4N5z7vfNRMeW5Cwck4d3Hv51lP8HqUSXCLNfGSr2utC49nuH5K1rMG6KRez01XZIh7OUgyNTTC/7DG1sz7vomCqFufdwkyK+RcyljSc4KUV2wmokeEqV+Pag217BvQkVQyf8k56BmKoiMSfdSmSkpDm9kpg7YB2/9icOiOirikmU23RCoMYyZvnWwJXov2mN1zYomDHi5oFYCaZDxgRol7CjqGSm1GvYUsMMHkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLMMta27B4eNge9zl/UsA4ypqXYUsyy7p94h0/+sClk=;
 b=h0D1SgJzJmzk8jc1YdV57uUf1DRSiy32OY685zLfZ6ZJoVxi/FEX9qs7811emwE/1ZjGveFkADzsW3/uRcgBliMzIubQ6sBZmbXElSWcd4pU6nq0FrCutopz0w+cU2gNe9aoPdNqd01WoAZwy221Eno2Ut0oATmGVAPuaI627TAxV6yq7ctCBgCDoo/xIpZghIPby76RDsnoEOEzy1clnjD1MFNLqslj9vx0gwYcLDVuWKAiY660JPdYPjOSyzNWOLpOh6RC0oyEkupLqiI/EYMjpY/ZIyv6yQ3qoZmUEf3qsbxYXeIPBIxfolPF7GJGOEmfXXfqkgvXgpFf6BVHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLMMta27B4eNge9zl/UsA4ypqXYUsyy7p94h0/+sClk=;
 b=Vr8XtRvC0cktAPZuiYyflLhq3Cglv2/9Rg6lp6WKzzkcz+cspj5aKSVMFnQYMpqmfKgH2PtzsSeqflo935KSFveaxJeQvuPw3JtlGl1AKY+UAlVql0jHwzVl5uEtvyArGOjYDOSBUPl4yY9YZwxfOtTBRnUSgUsgtVgB6vl8C8c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 14:43:05 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:05 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 00/12] iio: imu: new inv_icm42600 driver
Date:   Thu,  7 May 2020 16:42:10 +0200
Message-Id: <20200507144222.20989-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd476020-509d-465f-6808-08d7f294f3a9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB426915120EC9917242B0250EC4A50@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npQ4heBtGSplG76oxvyhH4IBGFbpoE4grymmO8BgNhtB1lpvT6SYY49l+QAnDCO6DLZ/q6UITX0S8w7nDPq9/NLoNZfeueVEg3Hm8Y0IKtGoWJQRid8vSump4jSnfEddDvc9XxNbHcDkwpaYRQZ7cvdTwybKNOoQEY6KaTZOSvcRSqVl5wvBdVkzrqPGv+RNwfnCUYebqE5pu5kUrYsY4QYg/5piAkGYK0eLN6BxlD78ger2pcHGP0v66RoXC8/ccc96BsVQsveCjNDOZpW7LnkPYEzAcaF/G2h9xKhIA8QMh8t7r6Aqw+Hf21+gEzgr+yEpffzkWOLQAEZuLxWBFWiv84jVDdEgFbwvrJh3lKjAV2cITn1n1TvyUGiY0ehxyMfLHXPcEcgmBBjUc4PTwWpEdBBI+XF4Du3o0yqRH7cy4Ao4JveX1BrKzmG+p0YFd5CRVUwwEkjjKpe9G6K6IfoXelcbKl4cimABG+0juoIjAMBAu71qNn7Y1zLKYaoB+w7EJ8433HZypuSIN0B90g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(186003)(6486002)(478600001)(16526019)(5660300002)(4326008)(33440700001)(66556008)(8676002)(1076003)(36756003)(316002)(66946007)(66476007)(6666004)(52116002)(8936002)(86362001)(2616005)(83280400001)(956004)(83320400001)(83290400001)(83310400001)(26005)(2906002)(7696005)(83300400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dcka/gsgMm+BqeX8TTMzVbp4WUxovW5fgV5rtjrDJUbOb+hlCxdG9Ci6Ku5RzVt8ABACXJA03fNDJ34C3glhH6MMyNzm0A0LE07oa9r5T1rtHLzBBdHw46SfDgbjon13L3i6OXaBgWofVA1naXRLcildrzw/jOoNEPwmGGBPlkIySe9SZbTUTZu5ljp9mpI4xHWjtqqAgXsmqz/IS1gaLlnB3Mo9YWtw1qfqMxLt0QPUODtnmPBBf+aKhBdXrf7qPZTnHAUeIzvRm6bUpyAFlCpySMHq+Zu5u3VrrO56BnkRasrHJDSuqgtWqbSzq/pIf5+HgVIlfxr2POLzX087iV3VaCG0X+peK6B7soD8C+ad3cz0px7wuD6VMPhmlAHkBQUmwrpxPZBDg/Ts63L6E779joHuIjzhEGLFjeLk2aghjXNsHPc5GVeLzHfOuUy2+DrJVI5DEhhrZgTj8NmD5wm86UEhKX/fIocp2DDKSV7voNPNWcjHfRF8nQwr5EE+SRHLfLMdHy3b2TFTDfk6tHI1d+MOW0kNdQxjLKUFm8djfxKhzxZk0REyhRMDfW+pryOvtugfaMFdprgGrkOSwDTc92U0Fps7L+BhGpwpNLbzX1LGlMfu7xg9nskfmQ5BE+dcyoXfUdpgcvnGqbF9IGqzowq3iCKNlBzTTf09g8eEtoK9OEHDFE+fYyLsYVe5pwgjU58svPtp3SXRDsX94IdH4LsPrgLGOfoedzGrpXLbykm84NVUMesxCpFt/4zrcKikQ8DcFUmm80NTtpMFTQ+JkuSRr7wLa9w16QZJo7o=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd476020-509d-465f-6808-08d7f294f3a9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:05.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hzRw886e8xw9HV3J86GFgt6QxNp/X+fZ8QLbnikNwDkJWAPXnWzJQBeoimpflwROgyXvkgxkZlzz+Be1I5n4h/cT+pVWQo/1YBKqUcxHDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=712 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series add a new driver for managing InvenSense ICM-426xx 6-axis IMUs.
This next generation of chips includes new generations of 3-axis gyroscope
and 3-axis accelerometer, support of I3C in addition to I2C and SPI, and
intelligent MotionTracking features like pedometer, tilt detection, and
tap detection.

This series is delivering a driver supporting gyroscope, accelerometer and
temperature data, with polling and buffering using hwfifo and watermark,
on I2C and SPI busses.

Gyroscope and accelerometer sensors are completely independent and can have
different ODRs. Since there is only a single FIFO a specific value is used to
mark invalid data. For keeping the device standard we are de-multiplexing data
from the FIFO to 2 IIO devices with 2 buffers, 1 for the accelerometer and 1
for the gyroscope. This architecture also enables to easily turn each sensor
on/off without impacting the other. The IIO devices are using triggered buffer
as sub-interrupts of the device iio trigger using the interrupt pin. A complex
timestamping mechanism is added to handle correctly FIFO watermark and dynamic
changes.

Jean-Baptiste Maneyrol (12):
  iio: imu: inv_icm42600: add core of new inv_icm42600 driver
  iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
  iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
  iio: imu: inv_icm42600: add gyroscope IIO device
  iio: imu: inv_icm42600: add accelerometer IIO device
  iio: imu: inv_icm42600: add temperature sensor support
  iio: imu: add Kconfig and Makefile for inv_icm42600 driver
  iio: imu: inv_icm42600: add device interrupt trigger
  iio: imu: inv_icm42600: add buffer support in iio devices
  iio: imu: inv_icm42600: add accurate timestamping
  dt-bindings: iio: imu: Add inv_icm42600 documentation
  MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor

 .../bindings/iio/imu/invensense,icm42600.yaml |  90 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42600/Kconfig          |  30 +
 drivers/iio/imu/inv_icm42600/Makefile         |  16 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 400 +++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 752 +++++++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 373 +++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.h    | 162 ++++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 674 +++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 764 ++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 117 +++
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 117 +++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  86 ++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |  32 +
 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 246 ++++++
 .../imu/inv_icm42600/inv_icm42600_timestamp.h |  82 ++
 .../imu/inv_icm42600/inv_icm42600_trigger.c   | 188 +++++
 19 files changed, 4139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
 create mode 100644 drivers/iio/imu/inv_icm42600/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm42600/Makefile
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c

-- 
2.17.1

