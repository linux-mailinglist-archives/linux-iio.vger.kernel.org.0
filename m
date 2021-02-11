Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251A2318AD9
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhBKMgu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:36:50 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48462 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231531AbhBKMcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:32:25 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCPLVm030484;
        Thu, 11 Feb 2021 07:31:32 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw905xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:31:32 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11BCVVQL004799
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 11 Feb 2021 07:31:31 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 11 Feb
 2021 07:31:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 11 Feb 2021 07:31:30 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCVRdl011921;
        Thu, 11 Feb 2021 07:31:28 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/3] iio: core,buffer-dma: add mmap support
Date:   Thu, 11 Feb 2021 14:33:50 +0200
Message-ID: <20210211123353.78963-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110111
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
 include/linux/iio/buffer_impl.h               |  11 +
 include/uapi/linux/iio/buffer.h               |  27 ++
 tools/iio/iio_generic_buffer.c                | 184 +++++++++-
 7 files changed, 694 insertions(+), 47 deletions(-)

-- 
2.17.1

