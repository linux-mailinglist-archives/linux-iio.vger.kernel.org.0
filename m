Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844F127E8CB
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 14:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgI3MsD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 08:48:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60632 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgI3MsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 08:48:03 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UClcHM013986;
        Wed, 30 Sep 2020 08:47:57 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4q8t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 08:47:57 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08UClt9f035950
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 30 Sep 2020 08:47:55 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 30 Sep 2020 05:47:47 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 30 Sep 2020 05:47:36 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 30 Sep 2020 05:47:46 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08UCloll023959;
        Wed, 30 Sep 2020 08:47:50 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/4] iio: adc: at91: misc driver cleanups
Date:   Wed, 30 Sep 2020 15:52:12 +0300
Message-ID: <20200930125216.90424-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_07:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=965 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300103
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This whole thing started because the lkp bot haunted me for a while with
this build warning:

>> drivers/iio/adc/at91_adc.c:1439:34: warning: unused variable
>> 'at91_adc_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id at91_adc_dt_ids[] = {
                                    ^
   1 warning generated.

The fix may likely be patch 'iio: adc: at91_adc: add Kconfig dependency
on the OF symbol'; was pointed out by Jonathan.

Changelog v2 -> v3:
- https://lore.kernel.org/linux-iio/20200930060008.42134-1-alexandru.ardelean@analog.com/T/#t
- added 'Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>'
  for patches:
     iio: adc: at91_adc: use of_device_get_match_data() helper
     iio: adc: at91_adc: const-ify some driver data
- fixed description for patch 'iio: adc: at91_adc: add Kconfig dependency on the OF symbol'
- squash patches:
     iio: adc: at91_adc: add Kconfig dependency on the OF symbol
     iio: adc: at91_adc: remove of_match_ptr() usage
- added patch: 'iio: adc: at91_adc: remove platform data and move defs in driver file'

Changelog v1 -> v2:
- https://lore.kernel.org/linux-iio/CA+U=Dspd11N-pXXnnY_5CSzNp50iRr7h16zXTCxo8Fk+v48F7g@mail.gmail.com/T/#m7c0efef4dc623776fe8bafdb5f734b0eaca50f82
- for patch 'iio: adc: at91_adc: use of_device_get_match_data() helper'
  changed description; it's just tidy-up patch, not a fix
- added 2 more patches:
  - iio: adc: at91_adc: add Kconfig dependency on the OF symbol
  - iio: adc: at91_adc: remove of_match_ptr() usage

Alexandru Ardelean (4):
  iio: adc: at91_adc: use of_device_get_match_data() helper
  iio: adc: at91_adc: const-ify some driver data
  iio: adc: at91_adc: add Kconfig dep on the OF symbol and remove
    of_match_ptr()
  iio: adc: at91_adc: remove platform data and move defs in driver file

 drivers/iio/adc/Kconfig                |  2 +-
 drivers/iio/adc/at91_adc.c             | 64 ++++++++++----------------
 include/linux/platform_data/at91_adc.h | 49 --------------------
 3 files changed, 26 insertions(+), 89 deletions(-)
 delete mode 100644 include/linux/platform_data/at91_adc.h

-- 
2.17.1

