Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA10B7D04D
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfGaVxA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:53:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31480 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbfGaVw7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:52:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLkPSl028214;
        Wed, 31 Jul 2019 23:52:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=STMicroelectronics;
 bh=f0XroG7xiA2VXPd3cKlOso4yHq3QzQeZcKbAS64cE8I=;
 b=t3d+4r3l+SpM2KLunLmfPFDBS757/7qag5+LI1nm0nzo501torBJICDnpkj1/y+2Xz9X
 9+puncxHg9isC0yOG5x/b6N8OVgxDmG39Lj0KVfEwfBt8PMyyOWqcW8QZiNkOmvjAzT2
 aWfCX4cj3dpu2DqjPUukH5etLnB6ux95f7eqSylh8snNfuPVqo+i1gV5zdRJyqSVzBKg
 RdloiHe38Y6d2t+WEA470ldTjdq3xWd/Pp+h6MGd84WtPzWMwh2vYNMMbhQKYiGl8ZzH
 MmeFDQcTwW8hfwZTIYOsJPGaB1LKth3io4zitthMJWq6guw3tLQRfJuRsg8WDEXKKyS1 iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0c2yjhb4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:52:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9332B31;
        Wed, 31 Jul 2019 21:52:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8ADCF777EB;
        Wed, 31 Jul 2019 23:52:52 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:52:51
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 0/5] move buffer allocation into st_sensors_buffer
Date:   Wed, 31 Jul 2019 14:52:45 -0700
Message-ID: <20190731215250.16403-1-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As proposed by Alexandru, memory allocation and de-allocation can be
performed in a more neat way in st_sensors_buffer.

Denis Ciocca (5):
  iio:common: introduce st_sensors_buffer_preenable/predisable functions
  iio:accel: do not allocate/de-allocate buffer here but link setup_ops
    to st_sensors_buffer
  iio:gyro: do not allocate/de-allocate buffer here but link setup_ops
    to st_sensors_buffer
  iio:magn: do not allocate/de-allocate buffer here but link setup_ops
    to st_sensors_buffer
  iio:pressure: do not allocate/de-allocate buffer here but link
    setup_ops to st_sensors_buffer

 drivers/iio/accel/st_accel_buffer.c           | 14 +++---------
 .../iio/common/st_sensors/st_sensors_buffer.c | 22 +++++++++++++++++++
 drivers/iio/gyro/st_gyro_buffer.c             | 14 +++---------
 drivers/iio/magnetometer/st_magn_buffer.c     | 14 +++---------
 drivers/iio/pressure/st_pressure_buffer.c     | 14 +++---------
 include/linux/iio/common/st_sensors.h         |  2 ++
 6 files changed, 36 insertions(+), 44 deletions(-)

-- 
2.22.0

