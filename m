Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0942B69C9
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKQQSp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:18:45 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6998 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgKQQSp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:18:45 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGEPIx001175;
        Tue, 17 Nov 2020 11:18:32 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34t9ybjdff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:18:31 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AHGIUiu044672
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 11:18:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 17 Nov
 2020 11:18:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 11:18:29 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AHGIRTM032565;
        Tue, 17 Nov 2020 11:18:28 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 00/12] iio: core,buffer: add support for multiple IIO buffers per IIO device
Date:   Tue, 17 Nov 2020 18:23:28 +0200
Message-ID: <20201117162340.43924-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170117
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Continuing from:
  https://lore.kernel.org/linux-iio/20200517144023.6c5cb169@archlinux/

This is a V2 of the initial attempt in the discussion above.
But it did not occur to me that I should mark it as V2 when I generated
the patches.
I've only tested [so far] that the current IIO buffer mechnism still works.
And decided to show this sketch patchset.

This requires the ioctl() centralization mechanism, for which I sent a
fix earlier.
  https://lore.kernel.org/linux-iio/CA+U=Dsqf3UgyM666Gg9EmehpWiucDx2P0bmsC9JR--JJDT_eWQ@mail.gmail.com/T/#t
  https://lore.kernel.org/linux-iio/20201117095154.7189-1-alexandru.ardelean@analog.com/T/#u

The gist of this is that now, the first IIO buffer should work as
before, but all extra buffers should go through the anon inodes
mechanism.
I'd need to find a device or a way or a chip to test these extra buffers
stuff. But I'm confident that this current form should eventually work
with multiple IIO buffers per 1 IIO device and with anon inodes.

Maybe I'll take some of the patches in this set separately and send them
individually. The problem with patchsets like this that tackle changes
in a framework (like IIO) is that I become unsure after the 5th-7th patch,
that the approach is correct. And I get even more unsure after that.

I'll create some userspace code to test this a bit, but I thought I'd
send an RFC in the meantime.

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
 drivers/iio/industrialio-buffer.c             | 582 ++++++++++++++----
 drivers/iio/industrialio-core.c               | 117 ++--
 include/linux/iio/buffer.h                    |   2 +
 include/linux/iio/buffer_impl.h               |  25 +-
 include/linux/iio/iio-opaque.h                |   6 +
 include/linux/iio/iio.h                       |   2 +-
 include/linux/iio/sysfs.h                     |  50 ++
 include/uapi/linux/iio/buffer.h               |  16 +
 15 files changed, 735 insertions(+), 251 deletions(-)
 create mode 100644 include/uapi/linux/iio/buffer.h

-- 
2.17.1

