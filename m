Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB65319C60
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 11:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhBLKKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 05:10:24 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27530 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229904AbhBLKKX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 05:10:23 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11CA5P6p032392;
        Fri, 12 Feb 2021 05:09:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw93br3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 05:09:24 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11CA9NGo022844
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Feb 2021 05:09:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2; Fri, 12 Feb 2021
 05:09:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 12 Feb 2021 05:09:22 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11CA9K63029095;
        Fri, 12 Feb 2021 05:09:20 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 0/3] iio: core,buffer-dma: add mmap support
Date:   Fri, 12 Feb 2021 12:11:40 +0200
Message-ID: <20210212101143.18993-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_03:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

Alexandru Ardelean (1):
  tools: iio: add example for high-speed buffer support

Lars-Peter Clausen (2):
  iio: core: Add mmap interface infrastructure
  iio: buffer-dma: Add mmap support

 drivers/iio/buffer/industrialio-buffer-dma.c  | 314 ++++++++++++++++--
 .../buffer/industrialio-buffer-dmaengine.c    |  22 +-
 drivers/iio/industrialio-buffer.c             | 158 +++++++++
 include/linux/iio/buffer-dma.h                |  25 +-
 include/linux/iio/buffer_impl.h               |  23 ++
 include/uapi/linux/iio/buffer.h               |  26 ++
 tools/iio/iio_generic_buffer.c                | 183 +++++++++-
 7 files changed, 704 insertions(+), 47 deletions(-)

-- 
2.17.1

