Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70E424E72
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhJGIEA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 04:04:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19286 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240397AbhJGIDX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2021 04:03:23 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1975TvsS002754;
        Thu, 7 Oct 2021 04:00:58 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bhtt1gmh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 04:00:58 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 19780tcM046280
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Oct 2021 04:00:56 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 7 Oct 2021 01:00:54 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 7 Oct 2021 01:00:54 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 7 Oct 2021 01:00:54 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 19780oHv008100;
        Thu, 7 Oct 2021 04:00:51 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v6 0/6] iio: Add output buffer support
Date:   Thu, 7 Oct 2021 08:00:29 +0000
Message-ID: <20211007080035.2531-1-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hlRRmfVGKFRqMZmmSbatt1lKi8SgSPoz
X-Proofpoint-GUID: hlRRmfVGKFRqMZmmSbatt1lKi8SgSPoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-07_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110070054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v5 -> v6:
  * https://lore.kernel.org/all/20210916182914.1810-1-mihail.chindris@analog.com
  * Fix check in  iio_update_buffers adding test on insert_buffer 
  * Return if check in iio_update_buffers fails.
  * Fix length typo
  * Add rb->direction check in both read and write functions.
  * Add fixes tags
  * Add  Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com> line
  * Remove unnecessary (u8 *) cast
  * Remove unnecessary AD5766_NUM_CH define

Changelog v4 -> v5:
  * https://lore.kernel.org/all/20210820165927.4524-1-mihail.chindris@analog.com
  * Remove ad3552r example from series and replace with the update of an
    existing driver: ad5662. Will add ad3552r in other another series.
  * Make normal comment from kernel-doc comment. (A bot was complaining about that)
  * Add indio_dev->info check 
  * Rename iio_buffer_remove_sample -> iio_pop_from_buffer
  * Fix comment of remove_from: sample -> scan
  * Change iio_pop_from_buffer data type to void * to be consistent with
    iio_push_to_buffers
  * Remove use watermark, in our kernel is not used and I can't think of an
    usecase for it.
  * Reimplement write to increment buffer index and handle blocking and
    noblocking calls
  * Move `if (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT)` outside lock
  * Remove redundant checks of `if (insert_buffer->direction ==
    IIO_BUFFER_DIRECTION_OUT)`

Alexandru Ardelean (1):
  iio: triggered-buffer: extend support to configure output buffers

Lars-Peter Clausen (1):
  iio: kfifo-buffer: Add output buffer support

Mihail Chindris (4):
  iio: Add output buffer support
  drivers: iio: dac: ad5766: Fix dt property name
  Documentation:devicetree:bindings:iio:dac: Fix val
  drivers:iio:dac:ad5766.c: Add trigger buffer

 .../bindings/iio/dac/adi,ad5766.yaml          |   2 +-
 drivers/iio/accel/adxl372.c                   |   1 +
 drivers/iio/accel/bmc150-accel-core.c         |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c            |   4 +-
 .../buffer/industrialio-triggered-buffer.c    |   8 +-
 drivers/iio/buffer/kfifo_buf.c                |  50 +++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   5 +-
 .../common/hid-sensors/hid-sensor-trigger.c   |   5 +-
 drivers/iio/dac/ad5766.c                      |  48 ++++++-
 drivers/iio/iio_core.h                        |   4 +
 drivers/iio/industrialio-buffer.c             | 127 +++++++++++++++++-
 drivers/iio/industrialio-core.c               |   1 +
 include/linux/iio/buffer.h                    |   7 +
 include/linux/iio/buffer_impl.h               |  11 ++
 include/linux/iio/triggered_buffer.h          |  11 +-
 15 files changed, 269 insertions(+), 16 deletions(-)


base-commit: 94a853eca720ac9e385e59f27e859b4a01123f58
-- 
2.27.0

