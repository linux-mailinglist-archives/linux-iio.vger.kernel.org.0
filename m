Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE9316346
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 11:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhBJKJh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 05:09:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33030 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229678AbhBJKHA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 05:07:00 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AA3JOK017536;
        Wed, 10 Feb 2021 05:06:04 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw8v4a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:06:04 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11AA63QW025880
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 05:06:03 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Wed, 10 Feb 2021
 05:06:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Wed, 10 Feb 2021 05:06:02 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11AA5x06018045;
        Wed, 10 Feb 2021 05:05:59 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 00/17] iio: core,buffer: add support for multiple IIO buffers per IIO device
Date:   Wed, 10 Feb 2021 12:08:06 +0200
Message-ID: <20210210100823.46780-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100097
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v3 -> v4:
* patch 'docs: ioctl-number.rst: reserve IIO subsystem ioctl() space'
   remove 'uapi/' from `uapi/linux/iio/*.h`
* patch 'iio: core: register chardev only if needed'
   add commit comment about potentially breaking userspace ABI with chardev removal
* patch 'iio: core: rework iio device group creation'
   remove NULL re-init in iio_device_unregister_sysfs() ; memory is being free'd
* patch 'iio: buffer: group attr count and attr alloc'
  extend commit comment about the 2 or 1 buffer directores
* patch 'iio: core: merge buffer/ & scan_elements/ attributes'
   fixed static checker complaints
    - removed unused global
    - initialize omitted 'ret = -ENOMEM' on error path
    - made iio_buffer_unregister_legacy_sysfs_groups() static
* patch 'iio: buffer: wrap all buffer attributes into iio_dev_attr'
   - update some omitted unwindings; seems i forgot a few originally
     this was showing up when trying to read from buffer1
* add patch 'iio: buffer: move __iio_buffer_free_sysfs_and_mask() before alloc func'
* patch 'iio: buffer: introduce support for attaching more IIO buffers'
   - removed 'iio_dev_opaque->attached_buffers = NULL' after kfree()
   - using 'iio_dev_opaque->attached_buffers_cnt' to check that we have buffers
      instead of checking 'indio_dev->buffer'
* patch 'iio: buffer: add ioctl() to support opening extra buffers for IIO device'
   - replaced -ENOENT with -ENODEV when buffer index is out of range
* add 'iio: core: rename 'dev' -> 'indio_dev' in iio_device_alloc()'
* add 'iio: buffer: dmaengine: obtain buffer object from attribute'
* add tools/iio patches for new multibuffer logic
   tools: iio: make iioutils_get_type() private in iio_utils
   tools: iio: privatize globals and functions in iio_generic_buffer.c file
   tools: iio: convert iio_generic_buffer to use new IIO buffer API 

Alexandru Ardelean (17):
  docs: ioctl-number.rst: reserve IIO subsystem ioctl() space
  iio: core: register chardev only if needed
  iio: core-trigger: make iio_device_register_trigger_consumer() an int
    return
  iio: core: rework iio device group creation
  iio: buffer: group attr count and attr alloc
  iio: core: merge buffer/ & scan_elements/ attributes
  iio: add reference to iio buffer on iio_dev_attr
  iio: buffer: wrap all buffer attributes into iio_dev_attr
  iio: buffer: dmaengine: obtain buffer object from attribute
  iio: core: wrap iio device & buffer into struct for character devices
  iio: buffer: move __iio_buffer_free_sysfs_and_mask() before alloc
  iio: buffer: introduce support for attaching more IIO buffers
  iio: buffer: add ioctl() to support opening extra buffers for IIO
    device
  iio: core: rename 'dev' -> 'indio_dev' in iio_device_alloc()
  tools: iio: make iioutils_get_type() private in iio_utils
  tools: iio: privatize globals and functions in iio_generic_buffer.c
    file
  tools: iio: convert iio_generic_buffer to use new IIO buffer API

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 .../buffer/industrialio-buffer-dmaengine.c    |   3 +-
 drivers/iio/iio_core.h                        |  24 +-
 drivers/iio/iio_core_trigger.h                |   4 +-
 drivers/iio/industrialio-buffer.c             | 483 ++++++++++++++----
 drivers/iio/industrialio-core.c               | 108 +++-
 drivers/iio/industrialio-event.c              |   6 +-
 drivers/iio/industrialio-trigger.c            |   6 +-
 include/linux/iio/buffer.h                    |   4 +-
 include/linux/iio/buffer_impl.h               |  21 +-
 include/linux/iio/iio-opaque.h                |  14 +
 include/linux/iio/iio.h                       |   5 -
 include/linux/iio/sysfs.h                     |   3 +
 include/uapi/linux/iio/buffer.h               |  10 +
 tools/iio/Makefile                            |   1 +
 tools/iio/iio_generic_buffer.c                | 133 +++--
 tools/iio/iio_utils.c                         |  18 +-
 tools/iio/iio_utils.h                         |   8 +-
 18 files changed, 658 insertions(+), 194 deletions(-)
 create mode 100644 include/uapi/linux/iio/buffer.h

-- 
2.17.1

