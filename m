Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F27401690
	for <lists+linux-iio@lfdr.de>; Mon,  6 Sep 2021 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbhIFGuy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 02:50:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9234 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233156AbhIFGux (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Sep 2021 02:50:53 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 185Lt4FW026199;
        Mon, 6 Sep 2021 02:49:48 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3aw2wh9x6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 02:49:46 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1866njGV024688
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Sep 2021 02:49:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Mon, 6 Sep 2021
 02:49:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Mon, 6 Sep 2021 02:49:44 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1866nhgI010164;
        Mon, 6 Sep 2021 02:49:43 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 0/3] iio: adc: Fix flags in sigma-delta drivers
Date:   Mon, 6 Sep 2021 09:56:27 +0300
Message-ID: <20210906065630.16325-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6bXk80JpVpc4Kf_DgzhuSPsCdKpKN7_f
X-Proofpoint-GUID: 6bXk80JpVpc4Kf_DgzhuSPsCdKpKN7_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-06_02,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

In Sigma-Delta devices the SDO line is also used as an interrupt.
Leaving IRQ on level instead of falling might trigger a sample read
when the IRQ is enabled, as the SDO line is already low. Not sure
if SDO line will always imediately go high in ad_sd_buffer_postenable
before the IRQ is enabled.

Some sigma-delta drivers use wrong irq_flags specified in the
ad_sigma_delta_info struct. Add the flags corresponding to the
interrupt type specified in the data-sheets of each chip.

Alexandru Tachici (3):
  iio: adc: ad7192: Add IRQ flag
  iio: adc: ad7780: Fix IRQ flag
  iio: adc: ad7793: Fix IRQ flag

Changelog:
- Changed commit messages

 drivers/iio/adc/ad7192.c | 1 +
 drivers/iio/adc/ad7780.c | 2 +-
 drivers/iio/adc/ad7793.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

--
2.25.1
