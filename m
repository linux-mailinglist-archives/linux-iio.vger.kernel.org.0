Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA21B6CD6
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 06:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDXE4k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 00:56:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38280 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgDXE4k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 00:56:40 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O4rGIZ028901;
        Fri, 24 Apr 2020 00:56:22 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6csfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 00:56:22 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03O4uLEU016508
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 00:56:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 00:56:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 00:56:20 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 24 Apr 2020 00:56:20 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O4uGpj017534;
        Fri, 24 Apr 2020 00:56:17 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v4 0/7] iio: core,buffer: re-organize chardev creation
Date:   Fri, 24 Apr 2020 07:56:35 +0300
Message-ID: <20200424045642.4903-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=2 bulkscore=0 impostorscore=0 mlxlogscore=939 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240035
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The main intent is to be able to add more chardevs per IIO device, one
for each buffer. To get there, some rework is needed.

Since v3, some changes have been done. See changelog

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

Jonathan Cameron (1):
  iio: Use an early return in iio_device_alloc to simplify code.

 drivers/iio/iio_core.h            |  29 ++++--
 drivers/iio/industrialio-buffer.c | 102 ++++++++++++++++++--
 drivers/iio/industrialio-core.c   | 151 ++++++++++++------------------
 drivers/iio/industrialio-event.c  | 100 +++++++++++++++++++-
 include/linux/iio/buffer_impl.h   |  10 ++
 include/linux/iio/iio.h           |   8 +-
 6 files changed, 290 insertions(+), 110 deletions(-)

-- 
2.17.1

