Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5F1DE206
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 10:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEVIga (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 04:36:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17980 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729151AbgEVIgY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 04:36:24 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M8Ycaj015231;
        Fri, 22 May 2020 04:36:24 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 312a17dtfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 04:36:24 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04M8aMWC040313
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 May 2020 04:36:22 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 04:36:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 04:36:21 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 May 2020 04:36:21 -0400
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04M8ZhUR005306;
        Fri, 22 May 2020 04:36:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-input@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     <vilhelm.gray@gmail.com>, <syednwaris@gmail.com>,
        <fabrice.gasnier@st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <jic23@kernel.org>,
        <dan@dlrobertson.com>, <jikos@kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <linus.walleij@linaro.org>,
        <wens@csie.org>, <hdegoede@redhat.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <peda@axentia.se>, <kgene@kernel.org>,
        <krzk@kernel.org>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <ak@it-klinger.de>, <paul@crapouillou.net>, <milo.kim@ti.com>,
        <vz@mleia.com>, <slemieux.tyco@gmail.com>, <khilman@baylibre.com>,
        <matthias.bgg@gmail.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <heiko@sntech.de>,
        <orsonzhai@gmail.com>, <baolin.wang7@gmail.com>,
        <zhang.lyra@gmail.com>, <mripard@kernel.org>, <tduszyns@gmail.com>,
        <rmfrfs@gmail.com>, <lorenzo.bianconi83@gmail.com>,
        <ktsai@capellamicro.com>, <songqiang1304521@gmail.com>,
        <tomislav.denis@avl.com>, <eajames@linux.ibm.com>,
        <dmitry.torokhov@gmail.com>, <coproscefalo@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/5] iio: light: lm3533-als: remove explicit parent assignment
Date:   Fri, 22 May 2020 11:22:07 +0300
Message-ID: <20200522082208.383631-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522082208.383631-1-alexandru.ardelean@analog.com>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_05:2020-05-21,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=737 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220070
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This assignment is the more peculiar of the bunch as it assigns the parent
of the platform-device's device (i.e. pdev->dev.parent) as the IIO device's
parent.

It's unclear whether this is intentional or not.
Hence it is in it's own patch.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/light/lm3533-als.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index bc196c212881..0f380ec8d30c 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -852,7 +852,6 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	indio_dev->channels = lm3533_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
 	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.parent = pdev->dev.parent;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	als = iio_priv(indio_dev);
-- 
2.25.1

