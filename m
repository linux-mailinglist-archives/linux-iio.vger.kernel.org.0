Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47195276FB0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgIXLSU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 07:18:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30264 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727421AbgIXLST (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 07:18:19 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OB6dUP000402;
        Thu, 24 Sep 2020 07:18:07 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5p6bq6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 07:18:07 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08OBI5Fd063193
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 07:18:06 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 24 Sep 2020 04:18:03 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 24 Sep 2020 04:17:31 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 24 Sep 2020 04:18:03 -0700
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08OBI2VL007892;
        Thu, 24 Sep 2020 07:18:02 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/3] iio: add titles to some Kconfig symbols 
Date:   Thu, 24 Sep 2020 14:17:55 +0300
Message-ID: <20200924111758.196367-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_08:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=878 impostorscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For some embedded systems, a workflow involving external kernel modules
that implement IIO devices is more practical than working with in-tree
sources. However, there are number of features in the IIO KConfig that can
only be switched on by enabling a particular sensor.

This came as a request a few years back:
   https://github.com/analogdevicesinc/linux/issues/140

This patch implements that request.

After a quick run-through the iio Kconfig files, 4 seem to be useful to add
titles to.
i.e. IIO_TRIGGERED_EVENT, IIO_TRIGGERED_BUFFER, IIO_BUFFER_DMAENGINE &
IIO_BUFFER_DMA.

It's possible that for some out-of-tree drivers this could be useful.

Alexandru Ardelean (3):
  iio: dma-buffer: Kconfig: Provide titles for IIO DMA Kconfig symbols
  iio: Kconfig: Provide title for IIO_TRIGGERED_EVENT symbol
  iio: buffer: Kconfig: add title for IIO_TRIGGERED_BUFFER symbol

 drivers/iio/Kconfig        |  2 +-
 drivers/iio/buffer/Kconfig | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

