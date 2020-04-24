Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE6A1B6D10
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 07:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDXFSI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 01:18:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32018 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgDXFSI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 01:18:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O53hkB004892;
        Fri, 24 Apr 2020 01:17:56 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6cua0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 01:17:55 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03O5Hr8W019472
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 01:17:54 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 22:17:52 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 23 Apr 2020 22:17:52 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O5HnSR025747;
        Fri, 24 Apr 2020 01:17:49 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 0/4] iio: scan_mask rework to track enabled channels on per-channel basis
Date:   Fri, 24 Apr 2020 08:18:14 +0300
Message-ID: <20200424051818.6408-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240037
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From my side, I'll admit that the specific use-cases for these patches
are a bit outside of my scope of understanding.
I did my best to re-apply them on a newer tree, and dig-up the
information from the ADI tree [where they've been living for a while
now].

Also, I don't have any idea if there was a prior discussion about this.
I could not find anything on a quick search.

I'm hoping that the author would have some input on them/

Hence the RFC.

Lars-Peter Clausen (4):
  iio: Move scan mask management to the core
  iio: hw_consumer: use new scanmask functions
  iio: Allow channels to share storage elements
  iio: Track enabled channels on a per channel basis

 drivers/iio/buffer/industrialio-buffer-cb.c   | 17 ++--
 drivers/iio/buffer/industrialio-hw-consumer.c | 19 +++-
 drivers/iio/industrialio-buffer.c             | 98 +++++++++++++------
 drivers/iio/industrialio-core.c               | 27 +++--
 drivers/iio/inkern.c                          | 30 ++++++
 include/linux/iio/buffer_impl.h               |  3 +
 include/linux/iio/consumer.h                  | 12 +++
 7 files changed, 154 insertions(+), 52 deletions(-)

-- 
2.17.1

