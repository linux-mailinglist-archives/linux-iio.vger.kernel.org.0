Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84A27E0C0
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 07:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgI3F4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 01:56:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63650 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbgI3F4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 01:56:03 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U5tJcV015253;
        Wed, 30 Sep 2020 01:55:58 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg666b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 01:55:58 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08U5tvv9004188
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 30 Sep 2020 01:55:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 30 Sep
 2020 01:55:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 30 Sep 2020 01:55:48 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08U5tkgj031934;
        Wed, 30 Sep 2020 01:55:52 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/4] iio: adc: at91_adc: add Kconfig dependency on the OF symbol
Date:   Wed, 30 Sep 2020 09:00:07 +0300
Message-ID: <20200930060008.42134-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930060008.42134-1-alexandru.ardelean@analog.com>
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_03:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300047
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This tries to solve a warning reported by the lkp bot:

>> drivers/iio/adc/at91_adc.c:1439:34: warning: unused variable
>> 'at91_adc_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id at91_adc_dt_ids[] = {
                                    ^
   1 warning generated.

This shows up with 'compiler: clang version 12.0.0' and W=1 (as the bot
mentions).

Forward declarations for global variables can be a bit weird; forward
function declarations are more common.

Maybe another fix for this would have been to prefix with 'extern' the
'at91_adc_dt_ids' variable, thus making it more friendly as a forward
declaration. It would look weird, but it would work.

But, we can avoid that forward declaration altogether simply by obtaining
the private data with of_device_get_match_data().

This appeared after commit 4027860dcc4c ("iio: Kconfig: at91_adc: add
COMPILE_TEST dependency to driver"), which put this driver on the lkp's bot
radar.

Fixes: 4027860dcc4c ("iio: Kconfig: at91_adc: add COMPILE_TEST dependency to driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 91ae90514aff..17e9ceb9c6c4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -295,7 +295,7 @@ config ASPEED_ADC
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91 || COMPILE_TEST
-	depends on INPUT && SYSFS
+	depends on INPUT && SYSFS && OF
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.17.1

