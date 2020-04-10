Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA61A4662
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJMjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 08:39:12 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64622 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgDJMjL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 08:39:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ACYeOw028712;
        Fri, 10 Apr 2020 08:38:58 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3091nb13ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 08:38:58 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03ACcvCp054815
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 10 Apr 2020 08:38:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 10 Apr
 2020 08:38:56 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 10 Apr 2020 08:38:55 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03ACcqPM021764;
        Fri, 10 Apr 2020 08:38:53 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 0/5] iio: core,buffer: re-organize chardev creation
Date:   Fri, 10 Apr 2020 15:39:43 +0300
Message-ID: <20200410123948.80578-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_04:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=2
 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The main intent is to be able to add more chardevs per IIO device, one
for each buffer. To get there, some rework is needed, and one important
facet is to move the creation of the current chardev into
'industrialio-buffer.c', so that control/logic of these chardevs is
localized in that file.

This changeset does that [incrementally] by moving the common chardev
creation from 'industrialio-core.c' to 'industrialio-buffer.c' &
'industrialio-event.c'.
The common chardev is required for both IIO buffers & IIO events.
In order to make this work, the 'iio_device_event_ioctl()' needs to be
passed from 'industrialio-event.c' to 'industrialio-buffer.c' flying past
'industrialio-core.c'. This sounds a bit wrong [at first] but it has the
effect of reducing inter-dependencies between 'industrialio-core.c' to
'industrialio-buffer.c' quite a bit.
The IIO buffer also has a CONFIG_IIO_BUFFER symbol which can turn it
off. No idea how widely this is used [as disabled], but this changeset
also takes that into consideration.

So, now the logic [for __iio_device_register() with regard to chardev
init] is:
1. iio_device_buffers_init() will init buffer and the chardev, if that
   works, the 'iio_device_event_ioctl()' will be attached to the chardev
2. if CONFIG_IIO_BUFFER is not defined or 'indio_dev->buffer == NULL'
   (no buffter attached), -ENOTSUPP should be returned from
   iio_device_buffers_init(), in which case the chardev should be
   initialized in  'industrialio-event.c' via
   'iio_device_register_event_chrdev()'

One neat side effect of this logic, is that we can also move the buffer
sysfs alloc/cleanup into 'industrialio-buffer.c' under the new
'iio_device_buffers_{un}init()' functions.

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

Alexandru Ardelean (5):
  iio: core: register buffer fileops only if buffer present
  iio: buffer: add back-ref from iio_buffer to iio_dev
  iio: buffer: move iio buffer chrdev in industrialio-buffer.c
  iio: buffer: move sysfs alloc/free in industrialio-buffer.c
  iio: event: move event-only chardev in industrialio-event.c

 drivers/iio/iio_core.h            |  30 +++----
 drivers/iio/industrialio-buffer.c | 144 ++++++++++++++++++++++++++----
 drivers/iio/industrialio-core.c   | 107 +++-------------------
 drivers/iio/industrialio-event.c  | 124 ++++++++++++++++++++++++-
 include/linux/iio/buffer_impl.h   |  10 +++
 include/linux/iio/iio.h           |   4 -
 6 files changed, 287 insertions(+), 132 deletions(-)

-- 
2.17.1

