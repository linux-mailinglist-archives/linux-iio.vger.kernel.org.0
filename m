Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9272236C136
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhD0IxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:53:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37478 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhD0IxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:53:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13R8p1jY005446;
        Tue, 27 Apr 2021 04:52:28 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3866auh9d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 04:52:28 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13R8qROd033982
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Apr 2021 04:52:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Tue, 27 Apr 2021
 04:52:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 27 Apr 2021 04:52:25 -0400
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13R8qNJk007577;
        Tue, 27 Apr 2021 04:52:24 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 0/6] Adis IRQ fixes and minor improvements 
Date:   Tue, 27 Apr 2021 10:54:48 +0200
Message-ID: <20210427085454.30616-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: k8eYQIGn-GA7P7wnCUZ523Ts5tNL_oup
X-Proofpoint-GUID: k8eYQIGn-GA7P7wnCUZ523Ts5tNL_oup
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_05:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=740
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


The primary goal of this series was to fix the return value on some
trigger handlers as spotted in [1]. While doing it, I found some minor
improvements that I think are simple enough to include in this series.

As for the first 2 patches, I opted to not do any functional change so
I'm keeping the 'if (!adis->buffer)' check. However, 'adis-buffer' is
allocated in 'update_scan_mode' hook which means we should be sure that
the buffer is allocated and the check is really not needed. I did not
went into the details but is there any way for the trigger handler to be
called before the 'update_scan_mode' hook? If not, I'm happy in sending
a v2 where we just remove the 'if'...


Changes in v2:
 * Remove the 'if' check for the allocated buffer;
 * Make sure the adis 'state_lock' is unlocked on error paths;
 * Fixed the commit message on the first 3 patches.
 * Dropped ("iio: adis16475: re-set max spi transfer") and added 3 new
patches (last 3 in the series ) to fix a potential race with the spi core
as discussed in [2].

Changes in v3:
 * Improved commit description on ("iio: adis16475: do not return ints in
irq handlers");
 * Reordered patch 2 and 3 so that patch 3 is easier to apply;
 * Re-arranged the error handling on 'spi_sync()' error path.

[1]: https://marc.info/?l=linux-iio&m=161815197426882&w=2
[2]: https://marc.info/?l=linux-iio&m=161884696722142&w=2

Nuno Sa (6):
  iio: adis16475: do not return ints in irq handlers
  iio: adis_buffer: update device page after changing it
  iio: adis_buffer: don't push data to buffers on failure
  iio: adis: add burst_max_speed_hz variable
  iio: adis16475: do not directly change spi 'max_speed_hz'
  iio: adis16400: do not directly change spi 'max_speed_hz'

 drivers/iio/imu/adis16400.c   | 15 ++-------------
 drivers/iio/imu/adis16475.c   |  9 +++------
 drivers/iio/imu/adis_buffer.c | 16 ++++++++++------
 include/linux/iio/imu/adis.h  |  2 ++
 4 files changed, 17 insertions(+), 25 deletions(-)

-- 
2.31.1

