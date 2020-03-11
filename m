Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70118137B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 09:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgCKIkz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 04:40:55 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39386 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgCKIkz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Mar 2020 04:40:55 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02B8dg5M004399;
        Wed, 11 Mar 2020 04:40:47 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yp9x3bwga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 04:40:46 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02B8ejuo003204
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Mar 2020 04:40:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Mar 2020 04:40:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Mar 2020 04:40:44 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Mar 2020 04:40:44 -0400
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02B8eSGK028151;
        Wed, 11 Mar 2020 04:40:41 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <biabeniamin@outlook.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        "Beniamin Bia" <beniamin.bia@analog.com>
Subject: [PATCH 3/4] iio: adc: ad7476: Add AD7091 support
Date:   Wed, 11 Mar 2020 10:43:27 +0200
Message-ID: <20200311084328.17680-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311084328.17680-1-beniamin.bia@analog.com>
References: <20200311084328.17680-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_02:2020-03-10,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 adultscore=0 mlxlogscore=912 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

AD7091R is already supported by this driver. While AD7091R allows the
choice of an internal or an external voltage reference, for AD7091 the
reference is only provided by VDD. Since this information is anyway
obtained through the "vcc" regulator, no other driver changes are
required for adding AD7091 support as well.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7476.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 3b48073dd62d..cd7d42df2033 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -341,6 +341,7 @@ static int ad7476_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7476_id[] = {
+	{"ad7091", ID_AD7091R},
 	{"ad7091r", ID_AD7091R},
 	{"ad7273", ID_AD7277},
 	{"ad7274", ID_AD7276},
-- 
2.17.1

