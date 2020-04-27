Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6D1BA441
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgD0NLF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 09:11:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64112 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgD0NLF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 09:11:05 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RCvCGJ022375;
        Mon, 27 Apr 2020 09:10:48 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj457vkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 09:10:48 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03RDAkc3007155
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Apr 2020 09:10:47 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 27 Apr
 2020 06:10:45 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Apr 2020 06:10:45 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03RDAfUQ011495;
        Mon, 27 Apr 2020 09:10:41 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 0/6] iio: core,buffer: re-organize chardev creation
Date:   Mon, 27 Apr 2020 16:10:54 +0300
Message-ID: <20200427131100.50845-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_09:2020-04-24,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=2 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270114
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The main intent is to be able to add more chardevs per IIO device, one
for each buffer. To get there, some rework is needed.
This tries to re-organize the init of the chardev.

 
Changelog v5 -> v6:
- patch 'iio: core: register chardev only if needed'
  - sort file_operations fields for iio_event_fileops
- patch 'iio: buffer,event: duplicate chardev creation for buffers & events'
  - fixed-up '**/' -> '*/' for 2 block comments
  - sorted file_operations for iio_buffer_fileops, after move
  - removed 'indio_dev->chrdev = NULL' on IIO device unregister
  - added comment about 'indio_dev->info' NULL check in
    iio_device_event_ioctl()
- patch 'iio: core: add simple centralized mechanism for ioctl() handlers'
  - re-using lock 'indio_dev->info_exist_lock' for new ioctl register
    mechanism in iio_device_ioctl()
  - simplified exit condition from the loop; only need to check
    `ret != IIO_IOCTL_UNHANDLED` to continue looping;
    everything else is just return/break
- patch 'iio: core: use new common ioctl() mechanism'
  - the comment for 'indio_dev->info' NULL check is being moved here to
    highlight why the null-check is being removed; or where it's being
    moved

Changelog v4 -> v5:
- dropped patch 'iio: Use an early return in iio_device_alloc to simplify code.'
  is applied upstream

Changelog v3 -> v4:
- added patch [1] 'iio: Use an early return in iio_device_alloc to simplify code.'
  it's main purpose is so that this patch applies:
     [2]'iio: core: add simple centralized mechanism for ioctl() handlers'
  depending on the final version of patch [1], patch [2] needs some
  minor fixup
- added patch 'iio: core,buffer: wrap iio_buffer_put() call into iio_buffers_put()'
- patch 'iio: core: register buffer fileops only if buffer present'
  is now: 'iio: core: register chardev only if needed'
- dropped 'iio: buffer: move sysfs alloc/free in industrialio-buffer.c'
  it's likely we won't be doing this patch anymore
- patches:
    'iio: buffer: move iio buffer chrdev in industrialio-buffer.c'
    'iio: event: move event-only chardev in industrialio-event.c'
  have been merged into 'iio: buffer,event: duplicate chardev creation for buffers & events'
  since now, the logic is a bit different, and 'indio_dev->chrdev' is
  now a reference to either the buffer's chrdev & or the events-only
  chrdev
- added simple mechanism to register ioctl() handlers for IIO device
  which is currently used only by events mechanism

Changelog v2 -> v3:
* removed double init in
  'iio: event: move event-only chardev in industrialio-event.c'

Changelog v1 -> v2:
* re-reviewed some exit-paths and cleanup some potential leaks on those
  exit paths:
  - for 'iio: buffer: move iio buffer chrdev in industrialio-buffer.c'
    add iio_device_buffers_put() helper and calling iio_buffers_uninit()
    on device un-regsiter
  - for 'move sysfs alloc/free in industrialio-buffer.c'
    call 'iio_buffer_free_sysfs_and_mask()' on exit path if
    cdev_device_add() fails
  - for 'move event-only chardev in industrialio-event.c'
    check if event_interface is NULL in
    iio_device_unregister_event_chrdev()

Alexandru Ardelean (6):
  iio: buffer: add back-ref from iio_buffer to iio_dev
  iio: core,buffer: wrap iio_buffer_put() call into iio_buffers_put()
  iio: core: register chardev only if needed
  iio: buffer,event: duplicate chardev creation for buffers & events
  iio: core: add simple centralized mechanism for ioctl() handlers
  iio: core: use new common ioctl() mechanism

 drivers/iio/iio_core.h            |  29 +++++---
 drivers/iio/industrialio-buffer.c | 102 ++++++++++++++++++++++++--
 drivers/iio/industrialio-core.c   | 116 +++++++++++++-----------------
 drivers/iio/industrialio-event.c  | 100 +++++++++++++++++++++++++-
 include/linux/iio/buffer_impl.h   |  10 +++
 include/linux/iio/iio.h           |   8 +--
 6 files changed, 276 insertions(+), 89 deletions(-)

-- 
2.17.1

