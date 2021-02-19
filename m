Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05431F622
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 10:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBSI77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 03:59:59 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19442 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhBSI76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 03:59:58 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J8scOx028670;
        Fri, 19 Feb 2021 03:59:05 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb9wam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 03:59:04 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11J8x376010902
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Feb 2021 03:59:03 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 00:59:01 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 00:59:01 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 19 Feb 2021 00:59:01 -0800
Received: from saturn.ad.analog.com ([10.48.65.120])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11J8wx48029584;
        Fri, 19 Feb 2021 03:58:59 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/2] iio: core,buffer-dma: 2 fixes for the recent IIO buffer series
Date:   Fri, 19 Feb 2021 10:58:24 +0200
Message-ID: <20210219085826.46622-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_02:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190070
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Patchset contains 2 fixes for some patches that are present in the
iio/testing branch.

No idea what's best now, either to re-send the series or to just send these
fixes on their own.
For now I chose to send the fixes on their (due to lack of time).

These could be squashed into the original.

I can also re-send the series, but not from an Analog email; since I will
not have access to it.

Alexandru Ardelean (2):
  iio: core: use kfree_const in iio_free_chan_devattr_list() to free
    names
  iio: buffer-dma: fix type of 'i' in iio_dma_buffer_alloc_blocks()

 drivers/iio/buffer/industrialio-buffer-dma.c | 3 +--
 drivers/iio/industrialio-core.c              | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.27.0

