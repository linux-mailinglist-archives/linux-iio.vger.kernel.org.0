Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2821A4376B5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Oct 2021 14:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJVMWJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Oct 2021 08:22:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40364 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231537AbhJVMWI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Oct 2021 08:22:08 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19M9KiFE026560;
        Fri, 22 Oct 2021 14:19:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=W+avfcbVE3ooTZraWY0QHUAVP7fdnfpPvL3ByfAnco0=;
 b=xo76YZwFxb1yVWVWLUct10G1AEatspQZxwFpEc2qOPRksjPznO/QS2ou35TQ8LRg/kls
 60FqDZo9ZtrJGCLa3EEwe+cP+ZJqB9+xvzhydouxqLiXqzsmRTVxiUSt8PPC/99S7ALD
 GTzVLxbhKVELW42zz3Txtq4mz8etZ+krUn9Snyx2x01yhuTff6UUxyPMeyCO0vZouPJs
 vtSZ3ZFb8P201Qa2ADi9BTdJJx+ilHL3bgB609x+A4UW79mk2Y5hzgOCdGT4cmOTsCaK
 nk95SQ8umpVKR9uUgoGNG+bjyEF60gzGTsKOcgzA2mmgkDQTUFJBpLCXVWXhP1BB4w7k Mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3butka12ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 14:19:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E20CD10002A;
        Fri, 22 Oct 2021 14:19:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D639C218111;
        Fri, 22 Oct 2021 14:19:36 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 22 Oct 2021 14:19:36
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32: fix a leak by resetting pcsel before disabling vdda
Date:   Fri, 22 Oct 2021 14:19:29 +0200
Message-ID: <1634905169-23762-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_03,2021-10-21_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some I/Os are connected to ADC input channels, when the corresponding bit
in PCSEL register are set on STM32H7 and STM32MP15. This is done in the
prepare routine of stm32-adc driver.
There are constraints here, as PCSEL shouldn't be set when VDDA supply
is disabled. Enabling/disabling of VDDA supply in done via stm32-adc-core
runtime PM routines (before/after ADC is enabled/disabled).

Currently, PCSEL remains set when disabling ADC. Later on, PM runtime
can disable the VDDA supply. This creates some conditions on I/Os that
can start to leak current.
So PCSEL needs to be cleared when disabling the ADC.

Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5088de8..e3e7541 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -975,6 +975,7 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 
+	stm32_adc_writel(adc, STM32H7_ADC_PCSEL, 0);
 	stm32h7_adc_disable(indio_dev);
 	stm32h7_adc_enter_pwr_down(adc);
 }
-- 
2.7.4

