Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC3C3009BD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbhAVR2C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 12:28:02 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11906 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729067AbhAVP4T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 10:56:19 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MFTuj2004455;
        Fri, 22 Jan 2021 10:55:21 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rcjhwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 10:55:21 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10MFtJxQ002544
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 Jan 2021 10:55:20 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 Jan 2021 07:55:18 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Fri, 22 Jan 2021 07:55:18 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 Jan 2021 07:55:18 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MFtF53014933;
        Fri, 22 Jan 2021 10:55:15 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 00/12] iio: core,buffer: add support for multiple IIO buffers per IIO device
Date:   Fri, 22 Jan 2021 17:57:53 +0200
Message-ID: <20210122155805.83012-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Continuing from:
 https://lore.kernel.org/linux-iio/20201117162340.43924-1-alexandru.ardelean@analog.com/

Changelog v1 -> v2:
* 'iio: buffer: rework buffer & scan_elements dir creation'
  add more doc-strings detailing the reasoning for this change
* 'iio: buffer: re-route scan_elements via it's kobj_type'
  move list_del() before the kfree()'s in the list destruction
* 'iio: buffer: introduce support for attaching more IIO buffers'
  - changed to 'cnt' variable vs re-using the 'i' for unwinding in
    iio_buffer_alloc_sysfs_and_mask()
  - removed kfree(old) in iio_device_attach_buffer()
  - made iio_device_attach_buffer() an int return; this means that some
    follow up patches are needed to make this return value be used;
* 'iio: buffer: add ioctl() to support opening extra buffers for IIO device'
  - tested ioctl() with a simple C program; attached to comment;
  - changed 'i' variable usage to 'sz' for alloc
  - changed logic for buffer0; returning FD 0; userspace should know
    that the IIO_BUFFER_GET_FD_IOCTL call returns 0 for buffer0;
    this is because I can't find a way to determine the FD of the
    ioctl() in the kernel; duplicating an ioctl() for buffer0 is also bad;

Alexandru Ardelean (12):
  iio: core: register chardev only if needed
  iio: buffer: add back-ref from iio_buffer to iio_dev
  iio: buffer: rework buffer & scan_elements dir creation
  iio: buffer: add index to the first IIO buffer dir and symlink it back
  iio: core: split __iio_device_attr_init() to init only the attr object
  iio: buffer: re-route scan_elements via it's kobj_type
  iio: buffer: re-route core buffer attributes via it's new kobj_type
  iio: buffer: add helper to get the IIO device to which a buffer
    belongs
  iio: re-route all buffer attributes through new buffer kobj_type
  iio: core: wrap iio device & buffer into struct for character devices
  iio: buffer: introduce support for attaching more IIO buffers
  iio: buffer: add ioctl() to support opening extra buffers for IIO
    device

 drivers/iio/accel/adxl372.c                   |  36 +-
 drivers/iio/accel/bmc150-accel-core.c         |  34 +-
 drivers/iio/adc/at91-sama5d2_adc.c            |  30 +-
 .../buffer/industrialio-buffer-dmaengine.c    |  13 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  30 +-
 .../common/hid-sensors/hid-sensor-trigger.c   |  32 +-
 drivers/iio/iio_core.h                        |  11 +
 drivers/iio/industrialio-buffer.c             | 647 ++++++++++++++----
 drivers/iio/industrialio-core.c               | 117 ++--
 include/linux/iio/buffer.h                    |   6 +-
 include/linux/iio/buffer_impl.h               |  25 +-
 include/linux/iio/iio-opaque.h                |   6 +
 include/linux/iio/iio.h                       |   2 +-
 include/linux/iio/sysfs.h                     |  50 ++
 include/uapi/linux/iio/buffer.h               |  10 +
 15 files changed, 790 insertions(+), 259 deletions(-)
 create mode 100644 include/uapi/linux/iio/buffer.h

-- 
2.17.1

