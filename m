Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6D5F5593
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJENhB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 09:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJENhA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 09:37:00 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0117AC2C;
        Wed,  5 Oct 2022 06:36:58 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295CtgrV012994;
        Wed, 5 Oct 2022 15:36:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=7MzB5vBMoLw2VL40nb2jEMYU1RU6/RMiE/lPBGO8ZXo=;
 b=zLItu5TzI5zinp9T+YPKxW+OTdyi6PRXw/8PKaPB7ALjAyrDo7YjMtUfYJpL86nZkLIx
 D2YjqGFiRZuUHSyU/3aPtqRHZHDdWOEfOYAxkIuzt8VcV2pspcIkoFcy633+wC76iC2q
 liBLRHl8vXaBSWuXI1hZg6ap3NWfdtkA2XOxchmytQEZ9FGJL0C0rhT7dtFIiQu7PKMJ
 rCB9WiM+57wNhL1cSppmJCe0mIAqL4WyaFHnDSQHQRDdQj/ZU/Xq/KfwIuNcyK5S7vPq
 hbV9HqGWBCnVpeYju2w3bR/VaxcgcM0R1DmTrUmSlHkOCD1fhJO7DpWuTHnn0fR+fcxS vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jxcw27hwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 15:36:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7155100034;
        Wed,  5 Oct 2022 15:36:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9EF72229A9F;
        Wed,  5 Oct 2022 15:36:04 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 5 Oct
 2022 15:36:04 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 1/8] iio: adc: stm32-adc: fix channel sampling time init
Date:   Wed, 5 Oct 2022 15:31:13 +0200
Message-ID: <20221005133120.50483-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005133120.50483-1-olivier.moysan@foss.st.com>
References: <20221005133120.50483-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix channel init for ADC generic channel bindings.
In generic channel initialization, stm32_adc_smpr_init() is called
to initialize channel sampling time. The "st,min-sample-time-ns"
property is an optional property. If it is not defined,
stm32_adc_smpr_init() is currently skipped.
However stm32_adc_smpr_init() must always be called,
to force a minimum sampling time for the internal channels,
as the minimum sampling time is known.
Make stm32_adc_smpr_init() call unconditional.

Fixes: 796e5d0b1e9b ("iio: adc: stm32-adc: use generic binding for sample-time")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 6256977eb7f7..3cda529f081d 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2086,18 +2086,19 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
 					vin[1], scan_index, differential);
 
+		val = 0;
 		ret = fwnode_property_read_u32(child, "st,min-sample-time-ns", &val);
 		/* st,min-sample-time-ns is optional */
-		if (!ret) {
-			stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
-			if (differential)
-				stm32_adc_smpr_init(adc, vin[1], val);
-		} else if (ret != -EINVAL) {
+		if (ret && ret != -EINVAL) {
 			dev_err(&indio_dev->dev, "Invalid st,min-sample-time-ns property %d\n",
 				ret);
 			goto err;
 		}
 
+		stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
+		if (differential)
+			stm32_adc_smpr_init(adc, vin[1], val);
+
 		scan_index++;
 	}
 
-- 
2.25.1

