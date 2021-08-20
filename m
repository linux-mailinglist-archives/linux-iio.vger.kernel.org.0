Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9773F31D4
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 19:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhHTRBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 13:01:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60184 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhHTRBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 13:01:30 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17KDkZMR004326;
        Fri, 20 Aug 2021 13:00:40 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3ajdjwrpmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 13:00:40 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 17KH0dba019164
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 13:00:39 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 20 Aug 2021 13:00:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 20 Aug 2021 13:00:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 20 Aug 2021 13:00:38 -0400
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.46])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17KH0YNN013729;
        Fri, 20 Aug 2021 13:00:35 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v4 0/6] iio: Add output buffer support and DAC example
Date:   Fri, 20 Aug 2021 16:59:21 +0000
Message-ID: <20210820165927.4524-1-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xVxhoPTZWahxU7TKuqmRQicDH9j6WcRA
X-Proofpoint-GUID: xVxhoPTZWahxU7TKuqmRQicDH9j6WcRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_06,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200095
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v3 -> v4:
  * https://lore.kernel.org/linux-iio/20210219124012.92897-1-alexandru.ardelean@analog.com
  * Remove DMA related commits
  * Test and add fixies to the previous version
    - Add write function to iio_buffer_fileops in industrialiio-core
    - In iio_kfifo_remove_from change number of samples to 1 instead of
      r->bytes_per_datum otherwise n square samples are removed.
    - In iio_buffer_remove_sample replace move buffer->access->write
      check to first if an replace with remove_from. Checkpatch was
      complaining about returning -ENOSYS
  * Add ad3552r example

Alexandru Ardelean (1):
  iio: triggered-buffer: extend support to configure output buffers

Lars-Peter Clausen (2):
  iio: Add output buffer support
  iio: kfifo-buffer: Add output buffer support

Mihail Chindris (3):
  Documentation:ABI:testing:add doc for AD3552R ABI
  dt-bindings: iio: dac: Add adi,ad3552r.yaml
  drivers:iio:dac: Add AD3552R driver support

 .../ABI/testing/sysfs-bus-iio-dac-ad3552r     |   10 +
 .../bindings/iio/dac/adi,ad3552r.yaml         |  185 +++
 drivers/iio/accel/adxl372.c                   |    1 +
 drivers/iio/accel/bmc150-accel-core.c         |    1 +
 drivers/iio/adc/at91-sama5d2_adc.c            |    4 +-
 .../buffer/industrialio-triggered-buffer.c    |    8 +-
 drivers/iio/buffer/kfifo_buf.c                |   50 +
 .../cros_ec_sensors/cros_ec_sensors_core.c    |    5 +-
 .../common/hid-sensors/hid-sensor-trigger.c   |    5 +-
 drivers/iio/dac/Kconfig                       |   10 +
 drivers/iio/dac/Makefile                      |    1 +
 drivers/iio/dac/ad3552r.c                     | 1419 +++++++++++++++++
 drivers/iio/iio_core.h                        |    4 +
 drivers/iio/industrialio-buffer.c             |  133 +-
 drivers/iio/industrialio-core.c               |    1 +
 include/linux/iio/buffer.h                    |    7 +
 include/linux/iio/buffer_impl.h               |   11 +
 include/linux/iio/triggered_buffer.h          |   11 +-
 18 files changed, 1854 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 create mode 100644 drivers/iio/dac/ad3552r.c


base-commit: 94a853eca720ac9e385e59f27e859b4a01123f58
-- 
2.27.0

