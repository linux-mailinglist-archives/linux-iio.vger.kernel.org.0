Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381C31E4DB8
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgE0S5t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:57:49 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:61788 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728742AbgE0S5s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:57:48 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIqS4B003313;
        Wed, 27 May 2020 11:57:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=wsSX1WEuyZTsLOEi5idunx5Pem0SfDQj35BaQZdmmOg=;
 b=scfDTQcQB6MenQXBQLB9awFQT2hGPOUxfNHkrmL0x5RkNQtIswALZxXWOLWNZErT/dxa
 HzZShcmLlnQ4YvKefk76B3eI2Oj2pmwxLci4JI5tKKmE0CdOHZUjs1SFfoQ0WG3UkIJz
 jlDPSdre2R206yWkxPu22oH+nMbeHR1E35n1YAjtNsxf0r/OomHz0UnYK/GrWYRfponV
 ugXR5vuhxMsAHWmKqVNn4smXZie8YJjCtjYdW2IVW1l8kLKOJofAL/XjFxFyqUbZVdjL
 qMLRpTEZdLyyX4Z9ZrCuuwudFiEV5Z7LFo4TNV14djJQyT0wzFjpwQ9KoCj48XBy3rYY Dg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-00328301.pphosted.com with ESMTP id 3185ap9ewn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:57:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdzwJedMHw3Q+nMWZLsu20o09QF1XDTxq5WFHF1phiCHawa+WKRwPFzKKkKSIOXR0A0pY2nongqUtIWZdOVrq80LqQ1NslDxJsDXR2BOmuKjHW+l759l6aiRaF23iDA1wqadEH4k88fBcMK5iwnJFdpPu4A0uET+NNDh/Cqy+S952jJNVrQRoEOTfIcgR9zVxgQBz1KSHVBwawKHP7iz2tGXvfk0YR7ZfM5KJOMLK57dLKFVBk3NUJ9TLS2C8deYbthJStAepM/Tju/P2LUnzu3gGwc5yMLb7reZt3D1P672Ye5/Ttz2IHWlAu6PGlblmpM7m0KZMY7V2+mDrDoLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsSX1WEuyZTsLOEi5idunx5Pem0SfDQj35BaQZdmmOg=;
 b=no1iPGsUHeBggFU8c1zcqBWW13PyVwqwIYA2rRt3QEMQI29WtkyuVGPUqvw4XOFJjCrWenckCAYOQbV4+ckwRci8yvLr4q/Vfi9oiO7GvglbM0DwyVDMZWJxsyOZqVW9PSjazv2A9IwHCwU8EttwqfddxBTz9hiUYXqjS7R5/ZOtn87JC8JPL2XJIY9BDJu3KWXauEMVOdczsLfhoiHdBHOVedYMc8ABmHVORF8mE+IQWuxu2CZIMqFvgyLsIGCodNg3ca3zl9PdGPKWPnmZCPb1epcbkhK2UYqvDSO1HfdjtljVwWQkkuRXK79wRNNDmlGMJEjOZxWiWKtD/WfTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsSX1WEuyZTsLOEi5idunx5Pem0SfDQj35BaQZdmmOg=;
 b=Y/dxDbfy0WUNfaNztguRf2se9sV9avRqodnqfxMHhVlK5FDHi9p7uQHbsNnHLa95Y0sird1iTOtW+BHTV2wDc2CuCx3g67dr5MuxskEin4YMBGwNNSu8bFdSF9lIYpcLQIDY93tJaDT3jrK2WZkKVW+r9yEzhIwgMr2SN/Kk8PE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 18:57:39 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:39 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 00/12] iio: imu: new inv_icm42600 driver
Date:   Wed, 27 May 2020 20:56:59 +0200
Message-Id: <20200527185711.21331-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 634970a7-46ca-4fec-3854-08d8026fd367
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB315102C8896F96E58C417658C4B10@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/+TUklGhrq0MbpQRisTOcJti4NW9z7LAm3v3PESWpz26+GYDIvNqqlfD4lOsjFrxJTj94AyQI9sYjasjpEyi7McbfZOgY8AlI9bl8K+4L6jt/x8K4NvyiZPMjUyKDLh+CdrpmOfqBSp7oT2wNbSsnj7XAfrVgf7BQOz4jV35esZKtyIMLccUEtqrj76Huw1LH/WP6ITPCFxwxJTBjykG0Sv/+a7Qb7O7mA5/CH0ajsZA+C8T6aMnExxhYG91aytyf64arr8aF9N96UCXeLNxv0O4jFyD+hIt5eSY60DC+rkxBlV91RE/bHUXepkSIwramZlxQ1XYrZAjfgPUe8jFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(346002)(366004)(396003)(376002)(16526019)(478600001)(107886003)(8676002)(5660300002)(186003)(8936002)(316002)(6666004)(6486002)(1076003)(7696005)(66946007)(26005)(2616005)(956004)(2906002)(86362001)(36756003)(52116002)(4326008)(66556008)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rDSAd7E+Igyk4ONbXrCMci0a44eBdy9Mh1YwpSykDdEWCqgmi6edwuNylNIRyYPM1PP9TP7KwObpOryOBYP4xkm/Cjz79bGvAtEJr+OduaqRUkYCsAv/VLbrF/lflxqdh9hA/vIZKfUAxDgC8DapR6EnqNhv1XR6c7R4/BT59G8TcpygoKQoyg9V+ht/tn2+Ue6hQvGBdV3g8+/P+QK9tKLfjhhtyEn/iCq21g2xIP3zEVLuEGvRM29rtchS+/VHlhxM9eOyiMfHeaJ8A5NjDTlD8bQb1civk9ZForsw4CUBGyArz3RkOplGy5uwS7KZmmhJXZGqkfv0NzpnENPQ2VYAa8B8mFq1xpRbU4y9ciXUylr/XXvoQ1SVi1p06MTW62dxewUWkD8t878t9STUdNR5rHkcLje80ciWEeYCLY1aKY4x36vQvjremoMCfN3pf0hsoiUQE3L95XkTBt+INYvyjnwjd+BDYYkdMsq9ASw=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634970a7-46ca-4fec-3854-08d8026fd367
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:38.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJggE7IASi+EPbc+Jimo8jbGcSikPh1gKNpNEp4ggPim0B8Szf5nvY20tgc/IV2P/sNR6I9lorhxbR2GUGKgaDhxtWdGCAh4ksMBX1z20M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=907 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270144
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog
v1
  -initial patch submission
v2
  - formatting reworks, missing headers, code cleanup ...
  - delete all debug traces
  - add commentaries for better explanation of suspend/resume, timestamp, ...
  - delete i2c/spi table ids keeping only of, and use I2C probe_new function
  - switch calibbias to SI units and add calibias_available attribute
  - use DMA-safe buffer for all regmap_bulk_* calls
  - delete iio trigger usage and setup/handle interrupt in core module
  - add open-drain interrupt support
  - add FIFO on reference counter and buffer postenable/predisable to replace
    iio trigger usage
  - check that temperature data is present before copying in buffer
  - add temperature sensor off when fifo is turned off
  - delete timestamp channel reading
  - move timestamp state in IIO device private data
  - allow only 1 ODR change in a batch of data
  - add driver-open-drain in devicetree YAML and delete spi options

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
on/off without impacting the other. The device interrupt is used to read the
FIFO and launch parsing of accelerometer and gyroscope data. A complex
timestamping mechanism is added to handle correctly FIFO watermark and dynamic
changes of settings.

Jean-Baptiste Maneyrol (12):
  iio: imu: inv_icm42600: add core of new inv_icm42600 driver
  iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
  iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
  iio: imu: inv_icm42600: add gyroscope IIO device
  iio: imu: inv_icm42600: add accelerometer IIO device
  iio: imu: inv_icm42600: add temperature sensor support
  iio: imu: add Kconfig and Makefile for inv_icm42600 driver
  iio: imu: inv_icm42600: add device interrupt
  iio: imu: inv_icm42600: add buffer support in iio devices
  iio: imu: inv_icm42600: add accurate timestamping
  dt-bindings: iio: imu: Add inv_icm42600 documentation
  MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor

 .../bindings/iio/imu/invensense,icm42600.yaml |  86 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42600/Kconfig          |  29 +
 drivers/iio/imu/inv_icm42600/Makefile         |  15 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 395 +++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 784 +++++++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 583 +++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.h    |  98 +++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 782 +++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 795 ++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 101 +++
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 100 +++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  87 ++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |  30 +
 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 195 +++++
 .../imu/inv_icm42600/inv_icm42600_timestamp.h |  85 ++
 18 files changed, 4175 insertions(+)
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

-- 
2.17.1

