Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1F35DD9D
	for <lists+linux-iio@lfdr.de>; Tue, 13 Apr 2021 13:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbhDMLT1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Apr 2021 07:19:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20434 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345396AbhDMLTO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Apr 2021 07:19:14 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DBA8Lb002743;
        Tue, 13 Apr 2021 07:18:42 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 37vyd1swbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 07:18:42 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13DBIe2P040703
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Apr 2021 07:18:40 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Tue, 13 Apr 2021
 04:18:39 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 13 Apr 2021 04:18:38 -0700
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13DBIbD7010275;
        Tue, 13 Apr 2021 07:18:37 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/7] Adis IRQ fixes and minor improvements
Date:   Tue, 13 Apr 2021 13:20:58 +0200
Message-ID: <20210413112105.69458-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uW-Idcg0b6z7sDPZ2BxtINK72v1-IjKP
X-Proofpoint-ORIG-GUID: uW-Idcg0b6z7sDPZ2BxtINK72v1-IjKP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_04:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=669 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130078
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

[1]: https://marc.info/?l=linux-iio&m=161815197426882&w=2

Nuno Sa (7):
  iio: adis_buffer: do not return ints in irq handlers
  iio: adis16400: do not return ints in irq handlers
  iio: adis16475: do not return ints in irq handlers
  iio: adis16475: re-set max spi transfer
  iio: adis_buffer: check return value on page change
  iio: adis_buffer: don't push data to buffers on failure
  iio: adis_buffer: update device page after changing it

 drivers/iio/imu/adis16400.c   |  3 ++-
 drivers/iio/imu/adis16475.c   |  6 ++++--
 drivers/iio/imu/adis_buffer.c | 20 +++++++++++++-------
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.31.1

