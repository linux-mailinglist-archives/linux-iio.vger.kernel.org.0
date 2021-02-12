Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BF319C81
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 11:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhBLKS6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 05:18:58 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63242 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhBLKSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 05:18:54 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11CAFOpp001736;
        Fri, 12 Feb 2021 05:18:02 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw93ca5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 05:18:02 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11CAI0hh025137
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Feb 2021 05:18:01 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Fri, 12 Feb 2021 02:17:59 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 12 Feb 2021 02:17:59 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11CAHu5j029319;
        Fri, 12 Feb 2021 05:17:56 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 0/5] iio: buffer: add output buffer and cyclic mode
Date:   Fri, 12 Feb 2021 12:20:16 +0200
Message-ID: <20210212102021.47276-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_03:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=930 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120077
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Largely, an adaptation of Lars' work, applied on the IIO multi-buffer
support + high-speed/mmap support [1].
Found here:
  https://github.com/larsclausen/linux/commits/iio-high-speed-5.10
But this isn't tested.

[1] Requires that these sets be applied (in this order):
* https://lore.kernel.org/linux-iio/20210211122452.78106-1-alexandru.ardelean@analog.com/T/#t
* https://lore.kernel.org/linux-iio/20210212101143.18993-1-alexandru.ardelean@analog.com/T/#t

Some of the variation from the original work are:
1. It's applied on top of the multibuffer support; so the direction of the
   data is set per iio_buffer, and not iio_dev
2. Cyclic mode is a separate patch
3. devm_iio_dmaengine_buffer_alloc() requires the definition of
   'enum iio_buffer_direction'; which means that 'linux/iio/buffer.h'
   needs to be included in  buffer-dma.h; Lars tried to use a bool, but
   using the enum seems a bit more consistent and allows us to maybe
   go down the route of both I/O buffers (some day); not sure if
   that's sane or not (you never know)
4. Various re-formatting; and added some docstrings where I remembered
   to so so

Lars-Peter Clausen (5):
  iio: Add output buffer support
  iio: kfifo-buffer: Add output buffer support
  iio: buffer-dma: Allow to provide custom buffer ops
  iio: buffer-dma: Add output buffer support
  iio: buffer-dma: add support for cyclic DMA transfers

 drivers/iio/adc/adi-axi-adc.c                 |   5 +-
 drivers/iio/buffer/industrialio-buffer-dma.c  | 120 ++++++++++++++++--
 .../buffer/industrialio-buffer-dmaengine.c    |  57 +++++++--
 drivers/iio/buffer/kfifo_buf.c                |  50 ++++++++
 drivers/iio/industrialio-buffer.c             | 110 +++++++++++++++-
 include/linux/iio/buffer-dma.h                |  11 +-
 include/linux/iio/buffer-dmaengine.h          |   7 +-
 include/linux/iio/buffer.h                    |   7 +
 include/linux/iio/buffer_impl.h               |  11 ++
 include/uapi/linux/iio/buffer.h               |   1 +
 10 files changed, 348 insertions(+), 31 deletions(-)

-- 
2.17.1

