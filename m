Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D182F4B95C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 15:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfFSNEm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 09:04:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36329 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731895AbfFSNEe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 09:04:34 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCuDOn030429;
        Wed, 19 Jun 2019 15:04:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=p5e2nfsElxNtsp+AWmabxwZass2bjpLHbaOSk3EXfxc=;
 b=xKbs6LYe8u7td8XhtcXeqRg/V8xdmFKrCFxWmC0/zvKrN5fLFw3DOaKsUJxhKt322uEk
 +qKfZIeBqlHL1/idmQY3TNWjkGPdrH+81v0MpKkcqsTA0nThikpRKcS7ZrPoWTx0SL6s
 dOeo0YBQ7FftBVl0+Pjygsff/l/RbZyNTaRyNlcSYghHOKGQ9J4ezO6wmdwfsrwSZdUp
 sY7qNwiLiThJ/UEWwX6wSzPUC7AchqjmKYqJH9i6KI1Ve8MyO5sD9QAwj/o88jgtBfZh
 uthoD49GdLN7+zR44DQ/pFmemysWLrNiJ42M8zZHsyUp/C296RY+IoSh58TLW6GcN4kz lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t781a3yy1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 15:04:02 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C24FA3A;
        Wed, 19 Jun 2019 13:04:00 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96AAB2835;
        Wed, 19 Jun 2019 13:04:00 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun
 2019 15:04:00 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun 2019 15:04:00
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>,
        <olivier.moysan@st.com>
Subject: [PATCH 4/5] iio: adc: stm32-dfsdm: add fast mode support
Date:   Wed, 19 Jun 2019 15:03:50 +0200
Message-ID: <1560949431-22948-5-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
References: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The use of fast mode allows to get a larger set of solution
for filter parameters. This can be useful to reach a better
output sample resolution, when fast mode can be used.

Fast mode is selected at startup if it is relevant.
The startup is performed in postenable callback context,
where there are too tight time constraints for filter parameters
computation. For this reason both fast and non fast filter parameters
are pre-computed previously.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 65 ++++++++++++++++++++++++++++++---------
 drivers/iio/adc/stm32-dfsdm.h     |  4 +--
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 5b19a88412a6..d855a605eab6 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -196,7 +196,7 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
 	int bits, shift;
 	unsigned int m = 1;	/* multiplication factor */
 	unsigned int p = fl->ford;	/* filter order (ford) */
-	struct stm32_dfsdm_filter_osr *flo = &fl->flo;
+	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fast];
 
 	pr_debug("%s: Requested oversampling: %d\n",  __func__, oversamp);
 	/*
@@ -217,7 +217,6 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
 	 * Look for filter and integrator oversampling ratios which allows
 	 * to maximize data output resolution.
 	 */
-	flo->res = 0;
 	for (fosr = 1; fosr <= DFSDM_MAX_FL_OVERSAMPLING; fosr++) {
 		for (iosr = 1; iosr <= DFSDM_MAX_INT_OVERSAMPLING; iosr++) {
 			if (fast)
@@ -309,6 +308,28 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
 	return 0;
 }
 
+static int stm32_dfsdm_compute_all_osrs(struct iio_dev *indio_dev,
+					unsigned int oversamp)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
+	int ret0, ret1;
+
+	memset(&fl->flo[0], 0, sizeof(fl->flo[0]));
+	memset(&fl->flo[1], 0, sizeof(fl->flo[1]));
+
+	ret0 = stm32_dfsdm_compute_osrs(fl, 0, oversamp);
+	ret1 = stm32_dfsdm_compute_osrs(fl, 1, oversamp);
+	if (ret0 < 0 && ret1 < 0) {
+		dev_err(&indio_dev->dev,
+			"Filter parameters not found: errors %d/%d\n",
+			ret0, ret1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int stm32_dfsdm_start_channel(struct stm32_dfsdm_adc *adc)
 {
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
@@ -433,11 +454,25 @@ static int stm32_dfsdm_channels_configure(struct stm32_dfsdm_adc *adc,
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
-	struct stm32_dfsdm_filter_osr *flo = &fl->flo;
+	struct stm32_dfsdm_filter_osr *flo = &fl->flo[0];
 	const struct iio_chan_spec *chan;
 	unsigned int bit;
 	int ret;
 
+	fl->fast = 0;
+
+	/*
+	 * In continuous mode, use fast mode configuration,
+	 * if it provides a better resolution.
+	 */
+	if (adc->nconv == 1 && !trig &&
+	    (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
+		if (fl->flo[1].res >= fl->flo[0].res) {
+			fl->fast = 1;
+			flo = &fl->flo[1];
+		}
+	}
+
 	if (!flo->res)
 		return -EINVAL;
 
@@ -463,7 +498,7 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
-	struct stm32_dfsdm_filter_osr *flo = &fl->flo;
+	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
 	u32 cr1;
 	const struct iio_chan_spec *chan;
 	unsigned int bit, jchg = 0;
@@ -490,6 +525,12 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
 	if (ret)
 		return ret;
 
+	ret = regmap_update_bits(regmap, DFSDM_CR1(fl_id),
+				 DFSDM_CR1_FAST_MASK,
+				 DFSDM_CR1_FAST(fl->fast));
+	if (ret)
+		return ret;
+
 	/*
 	 * DFSDM modes configuration W.R.T audio/iio type modes
 	 * ----------------------------------------------------------------
@@ -636,7 +677,6 @@ static int dfsdm_adc_set_samp_freq(struct iio_dev *indio_dev,
 				   unsigned int spi_freq)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
 	unsigned int oversamp;
 	int ret;
 
@@ -646,11 +686,10 @@ static int dfsdm_adc_set_samp_freq(struct iio_dev *indio_dev,
 			"Rate not accurate. requested (%u), actual (%u)\n",
 			sample_freq, spi_freq / oversamp);
 
-	ret = stm32_dfsdm_compute_osrs(fl, 0, oversamp);
-	if (ret < 0) {
-		dev_err(&indio_dev->dev, "No filter parameters that match!\n");
+	ret = stm32_dfsdm_compute_all_osrs(indio_dev, oversamp);
+	if (ret < 0)
 		return ret;
-	}
+
 	adc->sample_freq = spi_freq / oversamp;
 	adc->oversamp = oversamp;
 
@@ -783,7 +822,7 @@ static inline void stm32_dfsdm_process_data(struct stm32_dfsdm_adc *adc,
 					    s32 *buffer)
 {
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
-	struct stm32_dfsdm_filter_osr *flo = &fl->flo;
+	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
 	unsigned int i = adc->nconv;
 	s32 *ptr = buffer;
 
@@ -1171,7 +1210,6 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 				 int val, int val2, long mask)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
 	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[chan->channel];
 	unsigned int spi_freq;
 	int ret = -EINVAL;
@@ -1181,7 +1219,7 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		ret = stm32_dfsdm_compute_osrs(fl, 0, val);
+		ret = stm32_dfsdm_compute_all_osrs(indio_dev, val);
 		if (!ret)
 			adc->oversamp = val;
 		iio_device_release_direct_mode(indio_dev);
@@ -1430,8 +1468,7 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
 	int ret, chan_idx;
 
 	adc->oversamp = DFSDM_DEFAULT_OVERSAMPLING;
-	ret = stm32_dfsdm_compute_osrs(&adc->dfsdm->fl_list[adc->fl_id], 0,
-				       adc->oversamp);
+	ret = stm32_dfsdm_compute_all_osrs(indio_dev, adc->oversamp);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/adc/stm32-dfsdm.h b/drivers/iio/adc/stm32-dfsdm.h
index 18b06ee6ed7b..5dbdae4ed881 100644
--- a/drivers/iio/adc/stm32-dfsdm.h
+++ b/drivers/iio/adc/stm32-dfsdm.h
@@ -263,13 +263,13 @@ struct stm32_dfsdm_filter_osr {
 /**
  * struct stm32_dfsdm_filter - structure relative to stm32 FDSDM filter
  * @ford: filter order
- * @flo: filter oversampling structure
+ * @flo: filter oversampling data table indexed by fast mode flag
  * @sync_mode: filter synchronized with filter 0
  * @fast: filter fast mode
  */
 struct stm32_dfsdm_filter {
 	enum stm32_dfsdm_sinc_order ford;
-	struct stm32_dfsdm_filter_osr flo;
+	struct stm32_dfsdm_filter_osr flo[2];
 	unsigned int sync_mode;
 	unsigned int fast;
 };
-- 
2.7.4

