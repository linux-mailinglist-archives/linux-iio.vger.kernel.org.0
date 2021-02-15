Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3631BB15
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBOObQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 09:31:16 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34148 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229779AbhBOObO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 09:31:14 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FEU6H4025770;
        Mon, 15 Feb 2021 09:30:21 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gaw29u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 09:30:21 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11FEUJYG011821
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 15 Feb 2021 09:30:19 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 15 Feb 2021 09:30:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 15 Feb 2021 09:30:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 15 Feb 2021 09:30:18 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11FEUGbh027532;
        Mon, 15 Feb 2021 09:30:17 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/5] iio: core: Add mmap interface infrastructure
Date:   Mon, 15 Feb 2021 16:32:29 +0200
Message-ID: <20210215143234.3248-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_08:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150117
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v2 -> v3:
* https://lore.kernel.org/linux-iio/20210212101143.18993-1-alexandru.ardelean@analog.com/T/#u
* added 'Documentation: iio: add doc for high-speed buffer API'
* add 'iio: buffer-dma: split iio_dma_buffer_fileio_free() function'
* patch 'iio: buffer-dma: Add mmap support'
   - unwind free on error path in iio_dma_buffer_alloc_blocks()
   - removed double mm.h include
* patch 'tools: iio: add example for high-speed buffer support'
   - call IIO_BUFFER_BLOCK_FREE_IOCTL on the error path of the
     enable_high_speed() function

Changelog v1 -> v2:
* https://lore.kernel.org/linux-iio/20210211123353.78963-1-alexandru.ardelean@analog.com/T/#t
* removed IIO_BUFFER_BLOCK_FLAG_CYCLIC flag; will be added in a later
  patch
* removed extra line in tools/iio/iio_generic_buffer.c
* patch 'iio: core: Add mmap interface infrastructure'
  added docstrings for new hooks (alloc_blocks, mmap, etc)

This is basically Lars' work adapted from branch:
  https://github.com/larsclausen/linux/commits/iio-high-speed-5.10
[hopefully i got the stuff correctly from that branch]

What is different, is that this one is adapted on top of the multibuffer
support (currently at v5) discussed here:
  https://lore.kernel.org/linux-iio/20210211122452.78106-1-alexandru.ardelean@analog.com/T/#t

Also, adapted an example for high-speed/mmap support in
'tools/iio/iio_generic_buffer.c'

The example is adapted from libiio:
  https://github.com/analogdevicesinc/libiio/blob/master/local.c#L51
but will all the ioctl()s organized after the one that are reserved
(hopefully) for IIO

Tested that mmap() works.
Moved (artifically) valid buffer0 as buffer2 and the operation still
works.

Alexandru Ardelean (3):
  Documentation: iio: add doc for high-speed buffer API
  iio: buffer-dma: split iio_dma_buffer_fileio_free() function
  tools: iio: add example for high-speed buffer support

Lars-Peter Clausen (2):
  iio: core: Add mmap interface infrastructure
  iio: buffer-dma: Add mmap support

 Documentation/iio/iio_high_speed_buffers.rst  | 100 ++++++
 Documentation/iio/index.rst                   |   2 +
 drivers/iio/buffer/industrialio-buffer-dma.c  | 324 ++++++++++++++++--
 .../buffer/industrialio-buffer-dmaengine.c    |  22 +-
 drivers/iio/industrialio-buffer.c             | 158 +++++++++
 include/linux/iio/buffer-dma.h                |  27 +-
 include/linux/iio/buffer_impl.h               |  23 ++
 include/uapi/linux/iio/buffer.h               |  49 +++
 tools/iio/iio_generic_buffer.c                | 184 +++++++++-
 9 files changed, 841 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/iio/iio_high_speed_buffers.rst

-- 
2.17.1

