Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C83D9FB6
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 10:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhG2Ije (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 04:39:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35198 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234986AbhG2Ije (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 04:39:34 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16T8aFdo008858;
        Thu, 29 Jul 2021 04:39:31 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3a3kfd0x1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 04:39:30 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 16T8dTkw045916
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Jul 2021 04:39:29 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 29 Jul 2021 01:39:27 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 29 Jul 2021 01:39:27 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Thu, 29 Jul 2021 01:39:27 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 16T8dPfb011624;
        Thu, 29 Jul 2021 04:39:26 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH 0/3] iio: adc: Fix flags in sigma-delta drivers
Date:   Thu, 29 Jul 2021 11:47:28 +0300
Message-ID: <20210729084731.79135-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ufcYpsXLRoBiqHoVL95R9TEYzmNTd4sB
X-Proofpoint-GUID: ufcYpsXLRoBiqHoVL95R9TEYzmNTd4sB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_09:2021-07-27,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0 mlxlogscore=751
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290056
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Some sigma-delta drivers use wrong irq_flags specified in the
ad_sigma_delta_info struct. Add the flags corresponding to the
interrupt type specified in the data-sheets of each chip.

Alexandru Tachici (3):
  iio: adc: ad7192: Fix IRQ flag
  iio: adc: ad7780: Fix IRQ flag
  iio: adc: ad7923: Fix IRQ flag

 drivers/iio/adc/ad7192.c | 1 +
 drivers/iio/adc/ad7780.c | 2 +-
 drivers/iio/adc/ad7793.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

--
2.25.1
