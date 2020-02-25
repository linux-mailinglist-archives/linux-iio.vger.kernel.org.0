Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFAB16C05A
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgBYMJa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:09:30 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6366 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgBYMJa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:09:30 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PC71cx010548;
        Tue, 25 Feb 2020 07:09:28 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23agfxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:09:28 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01PC9Qcd058795
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:09:27 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 04:09:25 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 04:09:25 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PC9N1C003238;
        Tue, 25 Feb 2020 07:09:24 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 0/6] iio: accel: adxl372: add peak mode 
Date:   Tue, 25 Feb 2020 14:09:03 +0200
Message-ID: <20200225120909.12629-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds the posibility to configure
the device, from sysfs, to work in peak mode. This enables
adxl372 to capture only over threshold accelerations.

1. Create sysfs files for falling_period and rising_period
in events/ dir.

2. Create sysfs files for thresh_falling_value and
thresh_rising_value for each axis.

3. Set INT1 reg for acitivity/inactivity and push
event code in events fifo on irq.

4. Add additional ABIs in order to explain the
user that setting values in the events/ sysfs files
also changes device behaviour.

5. Update sysfs docs: renames, added two new
entries for the activity_detect_event/
inactivity_detect_event

Alexandru Tachici (5):
  iio: accel: adxl372: add sysfs for time registers
  iio: accel: adxl372: Add sysfs for g thresholds
  iio: accel: adxl372: add iio events
  iio: accel: adxl372: add additional events ABIs
  iio: accel: adxl372: Update sysfs docs

Stefan Popa (1):
  iio: accel: adxl372: Add support for FIFO peak mode

1. Device FIFO can now be set in peak mode and only over the
threshold accelerations will be stored.

Changelog V1 -> V2:
- switched from custom sysfs for setting the accel thres/timings
to standard events interface.
- renamed fifo_peak_mode_enable to buffer_peak_mode_enable
- on activity/inactivity, event codes are now pushed in
the events FIFO
- added additional custom sysfs for explaining that setting
values in the events/ sysfs files will change the device's
behaviour.

 .../ABI/testing/sysfs-bus-iio-accel-adxl372   |  30 ++
 drivers/iio/accel/adxl372.c                   | 265 +++++++++++++++++-
 2 files changed, 293 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372

-- 
2.20.1

