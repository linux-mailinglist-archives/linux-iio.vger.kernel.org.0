Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDAB210ABC
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 14:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgGAMFN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 08:05:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37668 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730103AbgGAMFM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jul 2020 08:05:12 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061C0Wk5023938;
        Wed, 1 Jul 2020 08:04:54 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31wyy6csm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 08:04:54 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 061C4qMD038691
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 1 Jul 2020 08:04:53 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 1 Jul 2020 05:04:51 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 1 Jul 2020 05:04:51 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 1 Jul 2020 05:04:51 -0700
Received: from NSA-L01.ad.analog.com (fpaumier-l01.ad.analog.com [10.32.224.81] (may be forged))
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 061C4lbs020721;
        Wed, 1 Jul 2020 08:04:48 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] iio: adc: adi-axi-adc: Fix object reference counting
Date:   Wed, 1 Jul 2020 14:04:41 +0200
Message-ID: <20200701120442.258-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 spamscore=0
 cotscore=-2147483648 adultscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When looking for a registered client to attach with, the wrong reference
counters are being grabbed. The idea is to increment the module and device
counters of the client device and not the counters of the axi device being
probed.

Fixes: ef04070692a2 (iio: adc: adi-axi-adc: add support for AXI ADC IP core)

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 63d926e86798..86b6b65916ee 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -332,12 +332,12 @@ static struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
 		if (cl->dev->of_node != cln)
 			continue;
 
-		if (!try_module_get(dev->driver->owner)) {
+		if (!try_module_get(cl->dev->driver->owner)) {
 			mutex_unlock(&registered_clients_lock);
 			return ERR_PTR(-ENODEV);
 		}
 
-		get_device(dev);
+		get_device(cl->dev);
 		cl->info = info;
 		mutex_unlock(&registered_clients_lock);
 		return cl;
-- 
2.25.1

