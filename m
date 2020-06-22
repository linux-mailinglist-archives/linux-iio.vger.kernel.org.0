Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F135203B31
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgFVPiC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:02 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:29714 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729452AbgFVPiB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:01 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFWDw4004965;
        Mon, 22 Jun 2020 08:37:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=OO3b4rB+9zYsVQANeUog8pBy9uZ+S99UHgmlUtm3kiI=;
 b=Aw90S5iUT1K2dyK3iCDnzRE8NTq1wI8dBk7pf5fi7W9knXWWAv8+3j5DXPXW0IYPZ2mT
 sP9DtzSi8Vnf4qtRJMJLezOfbm/+SnOMJHq8wEyJqBSs4so7FzTPm2uYFzzw4e5FJVml
 kM7UmH3B8tfuTyXCWeiwq+Y88NN+1zxhyT5PAhgeF4OFF5+4UAtb/mJP8AoH7LgbuZjV
 94noqy042EBOLgdWD9iKPz1Hr0QKBWm96IDm6LDSPf9gh1XDCBErMvv5hsuM0aLCkADX
 HUxe8Alnm+WwaVuUABu3IgLgV7IZs9fX6TEm+BEv8N2/D5amMrzfH5jlP6klQF+36J0O Pw== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00328301.pphosted.com with ESMTP id 31sedp0ukd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:37:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSdbbFjLy/CXCxcdEwK1f6nSIWCGjJpo8nKz+mW2yRYidjf1imgldqOMHCtuq7N0q8NkP2O4loy+18JkcMnLWNFOT0OK+agAcmAFkIRBsj1HsEYpAwV4Pz10YQjP5uPxRMY+7mgverPWUXOmA1DFAH3jChSaAPAz7xG6QcsaSpi/lBCDmYnphDOg1MYYKeXvvD8ew5Ip0ySYtonWjgOpyrh2W32yTQSUTnispiBXTLah2GegTbBJn0g7GqnGOxxCBwnUGvn20se0sX26MZ7CCOzgSH39BViM6z2CD4b7zHf0QNYoV+RJU5QzixPsjLnuVlVyFxZayXENFZusg2N5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO3b4rB+9zYsVQANeUog8pBy9uZ+S99UHgmlUtm3kiI=;
 b=nEj/6gSWmVql66FCuqA0ZF/nUAJacgBoM97A4NaNUy3z68acpkJ8Ky72T33y15gpl5/bxMFYVUJvw+dh7YJnV4COZxSl1WW2MJOHn4quWHV4LVc6Ijq12PBDHUI9CTG/DgQYZyOlmmh7ljecqs5hMSQQcm7Qxd7JQeJrXF2Lr3N1giMtTXYTxXxAhv+ly64WT4Yb+14ovMW3MdBkDepmT/AtZurUPskA9GJYnMOWesz3BDu2d6/Z/swVy1etTZuXM2I3UgG5zfe4NBmajByystrKq+k5QCgRLYOv7XPn4MS2g9fdaLG47YOJlPInYaz1lLx6h5CsYcOXd2I79ZfZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO3b4rB+9zYsVQANeUog8pBy9uZ+S99UHgmlUtm3kiI=;
 b=JnHkBiCnrmQepSLWyKRQwuvXztjwRqThqMMVoGCNeKXWohmH09KUyyez00cnrN+b/Qv5KFeR85WN62fTs9US95qH2sBZY9KMx2KUmWmVT/QiY3oKwCT6FySRGwYiNrjs76ZlJdmLHS1VM4R0q65bnBs/AqhRrTRRKp0uFoOl30U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:37:54 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:37:54 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 00/13] iio: imu: new inv_icm42600 driver
Date:   Mon, 22 Jun 2020 17:37:16 +0200
Message-Id: <20200622153729.12702-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:37:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bc68ee-f1a3-4b31-f866-08d816c23ac3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501587287C23D864F86589DC4970@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6gimCiqXSGWWEnyOqNx7+oBdsm5iVUdWeZb2BKvLVMTUQ2qs3AzcOaogIqWKscwb2di/H4GOKTFESwiwwhXjV7pKbP7s6JRn8mpvnWCYn18TnpcU1tW0u2ti9uZbSAqatvitChcl/Ynf6pSgpvzj32Kzs6DXP2rFNS33WLMOB3lEEPLAOWhv1CGrx1UxdzL5/5wb3tFPfi/9IkcuCnzgNkNIMDVHMLs4WNnLvJ/NkYU4+J8ivpfvNlmY8p81sdxNsSceHEzQRHL4MJWvyziv6joIdqLz9Sdjlizp1mELSuULRz/AWa50miEVCTtzBLyaMZcw0Gi5/Fe69jRE6GApQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(366004)(396003)(4326008)(66946007)(7696005)(52116002)(8676002)(66476007)(66556008)(956004)(2616005)(1076003)(83380400001)(107886003)(86362001)(36756003)(478600001)(6486002)(6666004)(26005)(316002)(8936002)(16526019)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vfoX3+GAK2yF637v1vpUs1sGH2BL13MY01Xq4UBdh3Q7tq+0cOlyujRBRIuJArzy/W8c83MdeU89h00+GnhPiv6dQuiAmvhHmGjFBsL2svTRKlTZThGDnCXOKYue/elzGk2wKshQjVoECVGUN6ULlzwNLSufNxzcGa2A6moZtE3o7Wb0bgZyW1L5Z653lS49hOgoybE9fco7PFK99+YQGDa3kAmtyTkPRZBWkQD2W/hleiDcGHotryxT7q+N4i58OOM46KNVVR57z7m7ZJnyyPGz3RC0gaovWVQI4zIlW6EY+uM0aX3EWrhpWWRQEYTjoY0q4WTqoVEPZ4ZVNbdriQTE4rr+BZ5RJ7WArbKPVN9e++NLPtoVHim2FaacaFYFZbzYmJ/z1R1QRWSA5RNE5KHUy+fO+zITlwoMokHIBiS1YuV15hVDRePPBX4Ac6+V3KSkMa5bvCaSMejKJs/lvbzbAXtSg8JprR3H5sG0jTI=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bc68ee-f1a3-4b31-f866-08d816c23ac3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:37:53.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWlF9RC16oKJmXAmYSPA9YRV7tZot4+HiweX6BWmlizr0vb29WX7dvIoJK+XUpO0I333XKh/yqlWftGCsLYwrMaVC5KBahwbVUqHSC4e+xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220116
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
v4
  - return high resolution 16 bits temperature as raw data when polled with the
    corresponding scale and offset.
  - for data buffer return temperature in the same 16 bits using the same
    scale and offset. Convert low resolution temperature FIFO data to high
    resolution format.
  - explicitely zero out data buffer before copying to iio buffer.

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
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 787 +++++++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 601 +++++++++++++
 .../imu/inv_icm42600/inv_icm42600_buffer.h    |  98 +++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 786 +++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 798 ++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 101 +++
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 100 +++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  84 ++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |  30 +
 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 195 +++++
 .../imu/inv_icm42600/inv_icm42600_timestamp.h |  85 ++
 19 files changed, 4224 insertions(+)
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

