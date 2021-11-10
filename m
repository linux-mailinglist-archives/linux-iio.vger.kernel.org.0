Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51CD44BFC9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhKJLKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 06:10:19 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1700 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJLKT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Nov 2021 06:10:19 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AA82ZPE018401;
        Wed, 10 Nov 2021 06:07:31 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c8a7p0jdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 06:07:31 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1AAB7TNQ047980
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 06:07:30 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 10 Nov 2021 03:07:28 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 10 Nov 2021 03:07:28 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 10 Nov 2021 03:07:28 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1AAB7OD5030773;
        Wed, 10 Nov 2021 06:07:25 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/5] iio: adc: ad_sigma_delta: Add sequencer support
Date:   Wed, 10 Nov 2021 13:17:45 +0200
Message-ID: <20211110111750.27263-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: CisWwr8YJYYEuR9F8Q9UqiCGYpwpuhVZ
X-Proofpoint-GUID: CisWwr8YJYYEuR9F8Q9UqiCGYpwpuhVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111100059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Some sigma-delta chips support sampling of multiple
channels in continuous mode.

When the operating with more than one channel enabled,
the channel sequencer cycles through the enabled channels
in sequential order, from first channel to the last one.
If a channel is disabled, it is skipped by the sequencer.

If more than one channel is used in continuous mode,
instruct the device to append the status to the SPI transfer
(1 extra byte) every time we receive a sample.
All sigma-delta chips possessing a sampling sequencer have
this ability. Inside the status register there will be
the number of the converted channel. In this way, even
if the CPU won't keep up with the sampling rate, it won't
send to userspace wrong channel samples.

1. Fix bug in AD7124 where channels stayed enabled
even when they are not supposed to, in continuous mode.

2. Fix bug in AD7192 where channels stayed enabled
even when they are not supposed to, in continuous mode.

3. Add sequencer support for sigma_delta library.

4. Add sigma_delta_info values and callbacks for sequencer
support in AD7124.

5. Add sigma_delta_info values and callbacks for sequencer
support in AD7192.

Alexandru Tachici (5):
  iio: adc: ad7124: Add update_scan_mode
  iio: adc: ad7192: Add update_scan_mode
  iio: adc: ad_sigma_delta: Add sequencer support
  iio: adc: ad7124: add sequencer support
  iio: adc: ad7192: add sequencer support

 drivers/iio/adc/ad7124.c               |  38 ++++++++-
 drivers/iio/adc/ad7192.c               |  32 +++++++-
 drivers/iio/adc/ad_sigma_delta.c       | 106 ++++++++++++++++++++-----
 include/linux/iio/adc/ad_sigma_delta.h |  22 +++++
 4 files changed, 178 insertions(+), 20 deletions(-)

--
2.25.1
