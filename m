Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F195222F4BA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 18:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbgG0QQf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 12:16:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14046 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgG0QQf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 12:16:35 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RG7wf5019076;
        Mon, 27 Jul 2020 12:16:34 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32ghn5eykm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 12:16:32 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06RGGVwN050426
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 12:16:31 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Jul 2020 09:16:29 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Jul 2020 09:16:17 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 09:16:29 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RGGShh009603;
        Mon, 27 Jul 2020 12:16:28 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v7 0/9] hwmon: pmbus: adm1266: add support
Date:   Mon, 27 Jul 2020 19:18:05 +0300
Message-ID: <20200727161814.14076-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_11:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add PMBus probing driver for the adm1266 Cascadable
Super Sequencer with Margin Control and Fault Recording.
Driver is using the pmbus_core, creating sysfs files
under hwmon for inputs: vh1->vh4 and vp1->vp13.

1. Add PMBus probing driver for inputs vh1->vh4
and vp1->vp13.

2. Add Block Write-Read Process Call command.
A PMBus specific implementation was required because
block write with I2C_SMBUS_PROC_CALL flag allows a
maximum of 32 bytes to be received.

3. This makes adm1266 driver expose GPIOs
to user-space. Currently are read only. Future
developments on the firmware will allow
them to be writable.

4. Allow the current sate of the sequencer to be read
through debugfs.

5. Blackboxes are 64 bytes of chip state related data
that is generated on faults. Use the nvmem kernel api
to expose the blackbox chip functionality to userspace.

6. Add group command support. This will allow the driver
to stop/program all cascaded adm1266 devices at once.

7. Writing the firmware hex file with offset 0
to the nvmem of the master adm1266 will trigger
the firmware programming of all cascaded devices.
The master adm1266 of each device is specified in
the devicetree.

8. Writing the configuration hex file to 0x30000
byte address of the nvmem file will trigger the
programming of that device in particular.

9. DT bindings for ADM1266.

Alexandru Tachici (9):
  hwmon: pmbus: adm1266: add support
  hwmon: pmbus: adm1266: Add Block process call
  hwmon: pmbus: adm1266: Add support for GPIOs
  hwmon: pmbus: adm1266: add debugfs for states
  hwmon: pmbus: adm1266: read blackbox
  hwmon: pmbus: adm1266: Add group command support
  hwmon: pmbus: adm1266: program firmware
  hwmon: pmbus: adm1266: program configuration
  dt-bindings: hwmon: Add bindings for ADM1266

Changelog: v5 -> v6:
  - added adm1266 to index.rst
  - changed max lines length from 80 to 100
  - replaced i2c_get_dma_safe_msg_buf with the use of kzalloc and ____cacheline_aligned
  - removed #ifdef CONFIG_GPIOLIB
  - removed ioctl commands, the state of the device can be read through debugfs
  - use the device managed version of nvmem_register
  - on power-up, set the UNIX time to adm1266 (this value is reset
  to 0 on each power-cycle).
  - removed patch adm1266: debugfs for blackbox info, rtc in blackbox is enough
  to help identify the current index
  - added two new nvmem cells for firmware and configuration

Changelog: v6 -> v7:
  - fixed compilation warning: removed unused variable ,entry, in
adm1266_init_debugfs

 .../bindings/hwmon/adi,adm1266.yaml           |   56 +
 Documentation/hwmon/adm1266.rst               |   37 +
 Documentation/hwmon/index.rst                 |    1 +
 drivers/hwmon/pmbus/Kconfig                   |   10 +
 drivers/hwmon/pmbus/Makefile                  |    1 +
 drivers/hwmon/pmbus/adm1266.c                 | 1272 +++++++++++++++++
 6 files changed, 1377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
 create mode 100644 Documentation/hwmon/adm1266.rst
 create mode 100644 drivers/hwmon/pmbus/adm1266.c

-- 
2.20.1

