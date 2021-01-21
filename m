Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87982FE96B
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 12:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbhAUL5H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 06:57:07 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5546 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730170AbhAULsv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 06:48:51 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10LBeF2M029625;
        Thu, 21 Jan 2021 06:47:52 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rbp83q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 06:47:52 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10LBlpgG005255
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 21 Jan 2021 06:47:51 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 21 Jan 2021 06:47:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 21 Jan 2021 06:47:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 21 Jan 2021 06:47:50 -0500
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10LBllDf013729;
        Thu, 21 Jan 2021 06:47:47 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/4] Fix/Improve sync clock mode handling
Date:   Thu, 21 Jan 2021 12:49:50 +0100
Message-ID: <20210121114954.64156-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_04:2021-01-21,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The first patch in this series is just a simple helper to lock/unlock
the device. Having these helpers make the code slightly neater (IMHO).

The following patches introduces changes in the sampling frequency
calculation when sync scale/pps modes are used. First, it's important
to understand the purpose of this mode and how it should be used. Let's
say our part has an internal rate of 4250 (e.g adis1649x family) and the
user wants an output rate of 200SPS. Obviously, we can't use this
sampling rate and divide back down to get 200 SPS with decimation on.
Hence, we can use this mode to give an input clock of 1HZ, scale it to
something like 4200 or 4000 SPS and then use the decimation filter to get
the exact desired 200SPS. There are also some limits that should be
taken into account when scaling:

 * For the devices in the adis16475 driver:
     - Input sync frequency range is 1 to 128 Hz
     - Native sample rate: 2 kSPS.  Optimal range: 1900-2100 sps

 * For the adis1649x family (adis16480 driver):
    - Input sync frequency range is 1 to 128 Hz
    - Native sample rate: 4.25 kSPS.  Optimal range: 4000-4250 sps 

I'm not 100% convinced on how to handle the optimal minimum. For now,
I'm just throwing a warning saying we might get into trouble if we get a
value lower than that. I was also tempted to just return -EINVAL or
clamp the value. However, I know that there are ADI customers that
(for some reason) are using a sampling rate lower than the minimum
advised.

That said, the patch for the adis16480 driver is a fix as this mode was
being wrongly handled. There should not be a "separation" between using
the sync_scale and the dec_rate registers. The way things were being done,
we could easily get into a situation where the part could be running with
an internal rate way lower than the optimal minimum.

For the adis16475 drivers, things were not really wrong. They were just
not optimal as we were forcing users to specify the IMU scaled internal
rate once in the devicetree. Calculating things at runtime gives much
more flexibility to choose the output rate.

Nuno Sá (4):
  iio: adis: add helpers for locking
  iio: adis16480: fix pps mode sampling frequency math
  iio: adis16475: improve sync scale mode handling
  dt-bindings: adis16475: remove property

 .../bindings/iio/imu/adi,adis16475.yaml       |   9 --
 drivers/iio/imu/adis16475.c                   | 110 ++++++++++++----
 drivers/iio/imu/adis16480.c                   | 120 +++++++++++++-----
 include/linux/iio/imu/adis.h                  |  10 ++
 4 files changed, 178 insertions(+), 71 deletions(-)

-- 
2.30.0

