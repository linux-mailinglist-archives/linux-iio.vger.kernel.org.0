Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38E31F97C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 13:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBSMlQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 07:41:16 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52148 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhBSMlO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 07:41:14 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JCdvIc005467;
        Fri, 19 Feb 2021 07:40:22 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjb27cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 07:40:22 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11JCeLpc052000
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Feb 2021 07:40:21 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 07:40:20 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 07:40:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 19 Feb 2021 07:40:20 -0500
Received: from saturn.ad.analog.com ([10.48.65.120])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11JCeH4p008911;
        Fri, 19 Feb 2021 07:40:17 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/6] iio: Add output buffer support
Date:   Fri, 19 Feb 2021 14:40:06 +0200
Message-ID: <20210219124012.92897-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=9 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v2 -> v3:
* https://lore.kernel.org/linux-iio/20210217083438.37865-4-alexandru.ardelean@analog.com/T/#m396545e0c6cc9d58e17f4d79b6fc707fd0373d89
* adding only infrastructure pieces for output DAC buffers, unfortunately I
  couldn't finish a complete DAC change to showcase these changes
* patch 'iio: Add output buffer support'
   - moved new 'bufferY/direction' attribute at the end and added
     comment about what it should be added at the end
* removed Lars' comment '/* need a way of knowing if there may be enough data... */'
* updated some various formatting;

Alexandru Ardelean (1):
  iio: triggered-buffer: extend support to configure output buffers

Lars-Peter Clausen (5):
  iio: Add output buffer support
  iio: kfifo-buffer: Add output buffer support
  iio: buffer-dma: Allow to provide custom buffer ops
  iio: buffer-dma: Add output buffer support
  iio: buffer-dma: add support for cyclic DMA transfers

 Documentation/ABI/testing/sysfs-bus-iio       |   7 +
 drivers/iio/accel/adxl372.c                   |   1 +
 drivers/iio/accel/bmc150-accel-core.c         |   1 +
 drivers/iio/adc/adi-axi-adc.c                 |   4 +-
 drivers/iio/adc/at91-sama5d2_adc.c            |   4 +-
 drivers/iio/buffer/industrialio-buffer-dma.c  | 120 ++++++++++++++--
 .../buffer/industrialio-buffer-dmaengine.c    |  72 +++++++---
 .../buffer/industrialio-triggered-buffer.c    |   8 +-
 drivers/iio/buffer/kfifo_buf.c                |  50 +++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
 .../common/hid-sensors/hid-sensor-trigger.c   |   5 +-
 drivers/iio/industrialio-buffer.c             | 133 +++++++++++++++++-
 include/linux/iio/buffer-dma.h                |  11 +-
 include/linux/iio/buffer-dmaengine.h          |   8 +-
 include/linux/iio/buffer.h                    |   7 +
 include/linux/iio/buffer_impl.h               |  11 ++
 include/linux/iio/triggered_buffer.h          |  11 +-
 include/uapi/linux/iio/buffer.h               |   1 +
 18 files changed, 412 insertions(+), 43 deletions(-)

-- 
2.27.0

