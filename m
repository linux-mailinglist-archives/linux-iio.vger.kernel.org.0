Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5230AB52
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 16:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhBAP3u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 10:29:50 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27574 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhBAOt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Feb 2021 09:49:27 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 111El4L0009549;
        Mon, 1 Feb 2021 09:48:30 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36d26a4h74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:48:30 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 111EmSVo060970
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 09:48:28 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 1 Feb 2021 06:48:27 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 1 Feb 2021 06:48:27 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 111EmNu6027350;
        Mon, 1 Feb 2021 09:48:23 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 00/11] iio: core,buffer: add support for multiple IIO buffers per IIO device
Date:   Mon, 1 Feb 2021 16:50:54 +0200
Message-ID: <20210201145105.20459-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102010079
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v2 -> v3:
* added commit 'docs: ioctl-number.rst: reserve IIO subsystem ioctl() space'
  reserving 'i' 0x90-0x9F ioctls for IIO
  I did not see any conflicts with others (in the doc)
  - related to this, the new IIO_BUFFER_GET_FD_IOCTL is now at 'i' 0x91
* changed approach for creating sysfs buffer directories;
  - they are now created as groups on the IIO device; that also means
    that the groups array needs to be krealloc-ed and assign later in
    the registration
  - merged bufferX/ and scan_elementsX/ directories into a single
    bufferX/ directory
  - for legacy the buffer/ & scan_elements/ directories are kept; but
    they're groups objects have been moved on the iio_dev_opaque object
  - internally, the iio_dev_attr type is being extended to hold a
    reference for an IIO buffer;
    = this is great for scan_elements attributes
    = and for the rest of the iio_buffer attributes, it means we need to
      wrap them into iio_dev_attr

One thing to be determined: if IIO_BUFFER_GET_FD_IOCTL for buffer0 should
return an FD or not.
Right now, it's returning 0.

Alexandru Ardelean (11):
  docs: ioctl-number.rst: reserve IIO subsystem ioctl() space
  iio: core: register chardev only if needed
  iio: core-trigger: make iio_device_register_trigger_consumer() an int
    return
  iio: core: rework iio device group creation
  iio: buffer: group attr count and attr alloc
  iio: core: merge buffer/ & scan_elements/ attributes
  iio: add reference to iio buffer on iio_dev_attr
  iio: buffer: wrap all buffer attributes into iio_dev_attr
  iio: core: wrap iio device & buffer into struct for character devices
  iio: buffer: introduce support for attaching more IIO buffers
  iio: buffer: add ioctl() to support opening extra buffers for IIO
    device

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/iio/iio_core.h                        |  10 +
 drivers/iio/iio_core_trigger.h                |   4 +-
 drivers/iio/industrialio-buffer.c             | 420 +++++++++++++++---
 drivers/iio/industrialio-core.c               |  87 +++-
 drivers/iio/industrialio-event.c              |   6 +-
 drivers/iio/industrialio-trigger.c            |   6 +-
 include/linux/iio/buffer.h                    |   4 +-
 include/linux/iio/buffer_impl.h               |  21 +-
 include/linux/iio/iio-opaque.h                |  14 +
 include/linux/iio/iio.h                       |   5 -
 include/linux/iio/sysfs.h                     |   3 +
 include/uapi/linux/iio/buffer.h               |  10 +
 13 files changed, 487 insertions(+), 104 deletions(-)
 create mode 100644 include/uapi/linux/iio/buffer.h

-- 
2.17.1

