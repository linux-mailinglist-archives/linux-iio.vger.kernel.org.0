Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1A1F20CD
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFHUnz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:43:55 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:63416 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgFHUny (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:43:54 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KdBDI019703;
        Mon, 8 Jun 2020 13:43:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=uhhAcFl+hxJmPTBda/ZO3QJ++ggPQO22foHnCgklO1w=;
 b=nhTrhIa347JCTnkYm6JhNMA9QBN3521UcqbRseXU6FzxIbZUJDCKcB4uC2Lti6iSq32e
 i/D2DXG54MU2IwBy0MC90DdBegBdOauGDk5mDzmsL7Ujw/j9wmbif21jVxwSE9rDwtPX
 ndvEKO8HgzLvYvaHlV+MObKLBNk67+i9G8CIIE6fKersd9L2WRHtYeTPAJwwh3Z537uR
 s0l2LbV9iBsuzGharD7zbH/03bjqwMrUfrUOBS7DWJMEL1spA9KyrYkOVfwh9LsmGFs8
 YgrL+VGML86utm0aG6JOYubD8sjaCPcYJVRQWDQvXPlt10p9tdXtcLfPIFLVhCHRYg6U cw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0b-00328301.pphosted.com with ESMTP id 31g8cf0xvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXnge5IVmyImYGjWa9JXhd29YX5HYailGYdFpL748fDT0KIUGYo6YvaTwfjuUAKpwLMIH3FAzpf+GF/47LxZCZieDKWyrRQri8yh1tRr15L1VAyKLNdllBzDMUmBfhozumBS6t0aFqloc9zyf99wi9gBpHLyMyzH91+Eps1keY0lOzNgp88UpFasBzr0PSTjWECt+CwGVg8HGXGUWB419rfaTWcnoGlY2nn4JAno1UvvhDFQ3d7DHozTNMDiLbUDQPtMXavjTf/qTsxW3dQNuXBmgn6nuzTu80kGWscJyxx5ewJDsQthkIxFzf27n2cC88xpnWR5ownwWU+WEJ71wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhhAcFl+hxJmPTBda/ZO3QJ++ggPQO22foHnCgklO1w=;
 b=Dc4zxmoqlFggjX06E7N0nL1Iml5BrquTBIzsDNKBeZhTCQxTdQNQehwHoaCbFTrCWRwnQH9UqGm12PaHwzE5Ltfs0G1nxMbQrXvoobQ66hEUFpKHI44gpc1lp+or5SnObe3KkFt/BzasR1SD+PeVn+5JCIYdM/8UUKNBt4dAv1RbVNfAXK0mJeaVYpFyTvT2lp+RH0XeYzi5okLQUR6ZPOH6Tl7d5g01O30JWMZ1DVO/jOQo+jYzSZCbKcj4ezpY2o56Vnve+Sc/6LcaTqmoxeyNh4POucDp9bujbeMCPEqWdwrWVkVkRLo+MNsAJPPKVehHQVIsOrs9kFtkbyUShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhhAcFl+hxJmPTBda/ZO3QJ++ggPQO22foHnCgklO1w=;
 b=UYuq76gPVje6J1DVKyJLBSIM2rNailBgsF+ZjZFfbogTzSHiMI+BJ48thlRVTBc0zl9IIlmMmucapXAHMT84Pzjjqgc/7mfinrWQ0EqI1BAGBTdEwXstRbJQ0dPKCRBQVqWHexy/iN2NiTKx+oWpxrebneneklESUbtNzp6APuQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:43:46 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:43:46 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 00/13] iio: imu: new inv_icm42600 driver
Date:   Mon,  8 Jun 2020 22:42:37 +0200
Message-Id: <20200608204250.3291-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:43:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515f7dc6-eda0-405b-8aa5-08d80beca36f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39511329D110C7CCDDD24C2FC4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPzSCw7nKFgJHZOpJ1BnhOhVUmIJB+uMqK4i8rekZtt46t7wx8XJFDpTObzk9YJt+DSjL6enj1v+RUhYGFJU6rHVnQjAQwkPvsnCDIpsfNsRnYZqh+VIlDfuNg7MFdM5e0Qw16eKFR+5kLxUpdAqpiVY+CLRNrUx06ht+PKLSfNVWMwrwWahKD+AH1Uj+SZEj9l37d2ob0hoAaVIKcvYxj8JMWnPQIIeVSyh+DcdiLWv/ITlAwKL2sHxQkHV55219Sc+5XBN3iVt4/HD7Oh5r1XdHgnt4QqoAK7MhNWP5cFX3u+ImKP0uy7qnkMoEtziYrt8b9VXPvKlBbHbMNzkPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Rxhn2zekOV/h7FI7r0ZuxXpYXqic8U1Q9YFsEQ/xRP5nzEPA0SFnpuv4Eg+DCMslcrXQ/H3rQdtggJTs3owv7qFBA1tPpQIAy2gaFonSB/HpgE/WjlnARO+YZ9KkDGFUMxUqD4K27y/tE4tpqeygRnogbHbW5aTJfWgiVGvgVyj3+UPKcVp592WjfzHNA6rkRpssZANAS1QjRNwYxim4q6FMM1JVg0/C2F0m2/nR2xWoO/hBU8KeV/4NSX1FRnDxtn18VrZB7XsHwzScEpPULl/tsoCYbIBGYGI6brn8cx/U8uvIbKBSSVsqrmnYuoHL/MW8fCvJbCNHNCPhtq43SMVuY7I8q1SabM/lS3LoJTBjXlJpGq72onetO+3AKSSdcgwzG5SrkvXPRXWgn/7XGIQNFjNaY5HUqjPp2ADUtRPjOxI1HT/UuACN50ZWt6/EnqGc9NMewKiCwfgxkOeGpaHGiViG5xluDaMh+3HH0Mc=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515f7dc6-eda0-405b-8aa5-08d80beca36f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:43:45.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVe93TBI1IgcXkUADaULpi5e0ZKuV7AeMyz57VLUjpjguwI3y4jrcqkVNBwbnOQUFGM7vBQTYvrUnFwnSRQgkODHkOEBMp3Y+stI9PHVcI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080144
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
v3
  - delete const pointer cast for iio_device_get_drvdata
  - change gyro and accel init to return the allocated iio_dev structure
  - delete manual parent device assignment
  - correct style and improve readability
  - add commentaries about IIO buffer and watermark complex computation
  - add timestamp alignment in IIO buffer structure
  - wrap lines 80 columns for dt bindings
  - add ABI documentation for calibbias values in SI units

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

Jean-Baptiste Maneyrol (13):
  iio: imu: inv_icm42600: add core of new inv_icm42600 driver
  iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
  iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
  iio: imu: inv_icm42600: add gyroscope IIO device
  iio: imu: inv_icm42600: add accelerometer IIO device
  iio: imu: inv_icm42600: add temperature sensor support
  iio: imu: add Kconfig and Makefile for inv_icm42600 driver
  Documentation: ABI: add specific icm42600 documentation
  iio: imu: inv_icm42600: add device interrupt
  iio: imu: inv_icm42600: add buffer support in iio devices
  iio: imu: inv_icm42600: add accurate timestamping
  dt-bindings: iio: imu: Add inv_icm42600 documentation
  MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor

 .../ABI/testing/sysfs-bus-iio-icm42600        |  20 +
 .../bindings/iio/imu/invensense,icm42600.yaml |  90 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42600/Kconfig          |  29 +
 drivers/iio/imu/inv_icm42600/Makefile         |  15 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 395 +++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 789 +++++++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 601 +++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.h    |  98 +++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 786 +++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 800 ++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 101 +++
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 100 +++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  87 ++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |  30 +
 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 195 +++++
 .../imu/inv_icm42600/inv_icm42600_timestamp.h |  85 ++
 19 files changed, 4231 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600
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

