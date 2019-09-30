Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095FFC1B01
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 07:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfI3FcJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 01:32:09 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:52516 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3FcJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Sep 2019 01:32:09 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 01:32:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569821529; x=1601357529;
  h=from:to:cc:subject:date:message-id;
  bh=qzFcBPOoP/Rv8ykLaC0eQHksn1NzctMIHEFRc4wakkk=;
  b=Rejix8uVX4hCJNukkMO/zvTFzdAP8EKwEVHtcPrjOkf3RuW/WthtvwCX
   vWmD8APr7TPNFdcUi5Yg0Y9/eDb+nmEFeRxkNwtJnhtfcugyxrtovFXTs
   pzUnKNAYvO3j/qRz1+oOW5ITPefGsiRcIPVYCoyIvY0OUSFkCkXb8Rdp/
   8oKwc32OEqRfBGyEB/rHauGsOSLxYBzMEIfACUmpmjlKN8tidhCxtu5X6
   SzSgd2zThTLCe6DRc9nxiK7+XBZT7RhcnnfSIA9t4jyuM55fWvwjj0V+8
   9lz9kAIfRZwpQJeF6q6mN9W+RH60mRQyvLnCyzWIRnJYBOPv02IWJfeZF
   w==;
IronPort-SDR: h7rl2tPZM+V6Lg7tVj1OOE5G0K24VrKlRSflg0iKk9GUyqSM0wnnEv2Yiw5iXbL7oftQ9KQXSJ
 rHCSwxe/BEhhGtMY9l4gUDXhMa9jwKi90NtWVMEUZTOhCvw4st3nTDzQ123eFJ3qm8CrtVLpaU
 mccirgdfX/3SenPsBqKUb1WExw0MWibaZD8Ky1Y4BU+cKcCutvezMuIG5M3G1aGF2kpoRP/CJp
 K2ZQv6IG26+3/xW8TQBJ9SMcTwVLRCdcpxwbWx24ziW8RtmF6jAa3Q2ximD4fjVdrlOyR9LHlM
 Q4c=
IronPort-PHdr: =?us-ascii?q?9a23=3AveAHgxFu1nyYmeW/LtCTCp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ78r8mwAkXT6L1XgUPTWs2DsrQY0rGQ7/mrCDdIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+5oAnMucUbhYVvIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMNRVy1aAoOnbosPCeUBNvtGoYfkulAOoxq+CheoBOzy1zREgnH70bE/3+?=
 =?us-ascii?q?knDArI3hEvH8gWvXrUstv7KakcX+OywqTT0TnPc+lb1Svn5YTUbhwsp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDwHKjlSRqIzlIjOV0fkGvm+b7uthVeKgkW8npx1trjWh3cosl5?=
 =?us-ascii?q?XGhpgPxl/a6Cp53Z84KNulQ0B4ed6pCIVcuz2eOodsQc4vQ3tktDgnxrAJo5?=
 =?us-ascii?q?K3YSwHxZc/yxLCavGKd5KE7gztWeuROzt0mnNodKi9ihu990Wr1/fyWdOu0F?=
 =?us-ascii?q?lQqypIitzMtncQ2BPN8sWHUf59/lu52TaIygDT9vlIIUAqmqrfLJ4s2rswmY?=
 =?us-ascii?q?ASsUTHByP2gEH2gLKPekUq5+Sl7+fqbq/ppp+bMI90hQX+Pbo0lsOjBuQ4Nx?=
 =?us-ascii?q?ACX2md+euiyL3u5VP1TKlOg/EskaTUsIrWKdoGqqO2GQNZz4Iu5hWnAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI1HPIfH4DfilglSgjCtnyv7dM738HprNNGLPn6n8cr?=
 =?us-ascii?q?Zg80Jc0hY8zchD55JIDbEMOPbzWk73tNzFAR41Kg20w+fgCNhmyIMeVnyAAr?=
 =?us-ascii?q?WDPKPRr1CI/OQvLPeIZIMPvzb9MfcltLbAl3g8zG4cb6m02tNDeWK4F/U+ex?=
 =?us-ascii?q?6xfHH2xNoNDDFZ7UIFUOX2hQjaAnZobHGoUvd5uWk2?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FJCADEkJFdh8bWVdFmgh6DXkwQjR6?=
 =?us-ascii?q?FcVEBAQaLJoEJhXqIMYF7AQgBAQEMAQEtAgEBhECDPSM2Bw4CAwkBAQUBAQE?=
 =?us-ascii?q?BAQUEAQECEAEBAQgNCQgphUCCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWefoE?=
 =?us-ascii?q?DPIwlM4hcAQkNgUgJAQiBIoc1hFmBEIEHhGGHY4JEBIEvAQEBiz4BgjGHK5Z?=
 =?us-ascii?q?JAQYCghAUgXiTByeCN4ICiT05iwYBLYoonGsCCgcGDyOBNgWCBU0lgWwKgUR?=
 =?us-ascii?q?QEBSBWg4JjkIhM4EIkAYB?=
X-IPAS-Result: =?us-ascii?q?A2FJCADEkJFdh8bWVdFmgh6DXkwQjR6FcVEBAQaLJoEJh?=
 =?us-ascii?q?XqIMYF7AQgBAQEMAQEtAgEBhECDPSM2Bw4CAwkBAQUBAQEBAQUEAQECEAEBA?=
 =?us-ascii?q?QgNCQgphUCCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWefoEDPIwlM4hcAQkNg?=
 =?us-ascii?q?UgJAQiBIoc1hFmBEIEHhGGHY4JEBIEvAQEBiz4BgjGHK5ZJAQYCghAUgXiTB?=
 =?us-ascii?q?yeCN4ICiT05iwYBLYoonGsCCgcGDyOBNgWCBU0lgWwKgURQEBSBWg4JjkIhM?=
 =?us-ascii?q?4EIkAYB?=
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="scan'208";a="79084791"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2019 22:25:03 -0700
Received: by mail-pl1-f198.google.com with SMTP id o12so4593568pll.2
        for <linux-iio@vger.kernel.org>; Sun, 29 Sep 2019 22:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fPKABXGUyoM/LSYBewEpMZXiulfn1+x5kwR93rT2pjY=;
        b=E7HzIjOI2dyszT7GtNWsYfRarfVx1yAvWOPhXfgCL2cnXwnAVUje341J6+HUXHPliR
         RSn1NzC2U51pHcWPuhiETy6f8jqm5TUyG83yIzQTl5ACrQa4bVYpoUH7hI+ShiwjFq39
         fZj2c8y42wlircoHRTmfiGC/Escu65VMATDlTYzQ9mnRaPfNjHcxXJtgQlc95NILix+v
         VBz9vRUsKgjaWyhWGvZwYMYCXcrXRgjXrKtxo5JqRb9YJ3SYJRYxJm9Cdxp/fx1EZNh4
         wrajFLw7jrDXTDRNZpYDt+lIKyOzP6UkKffPLC2/mM/5bJhpcpVmbT1/f88uD8gcN1l4
         o6AQ==
X-Gm-Message-State: APjAAAU/0PGpm9F2LiSCZ7nucJzczwLV6SOg72u2r7JGjBOB6RYmxaI/
        sdyWNFUTlCg2R0LxOWKQjZpODScnL3F4a5ZuITxteKVzn2Uxpw1hB7ZN6jUP9Ih8Tyee+Yn+jpm
        VHzRbCtGvfKmHWovqRAMl0w==
X-Received: by 2002:a63:5652:: with SMTP id g18mr21799331pgm.393.1569821101510;
        Sun, 29 Sep 2019 22:25:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyPeVROo1TnM+H1kGzA7cRPqfO3NXggBNlKrrjPDdQwOcK4O2BhRFl7aOQNC2xwRWyuzG9QsA==
X-Received: by 2002:a63:5652:: with SMTP id g18mr21799307pgm.393.1569821101057;
        Sun, 29 Sep 2019 22:25:01 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id a11sm11186636pfg.94.2019.09.29.22.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 22:25:00 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: Variables could be uninitalized if regmap_read() fails
Date:   Sun, 29 Sep 2019 22:25:39 -0700
Message-Id: <20190930052540.19168-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Several functions in this file are trying to use regmap_read() to
initialize the specific variable, however, if regmap_read() fails,
the variable could be uninitialized but used directly, which is
potentially unsafe. The return value of regmap_read() should be
checked and handled.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/bcm_iproc_adc.c | 45 ++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 646ebdc0a8b4..6df19ceb5ff2 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -137,6 +137,7 @@ static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
 	u32 channel_intr_status;
 	u32 intr_status;
 	u32 intr_mask;
+	int ret;
 	struct iio_dev *indio_dev = data;
 	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
 
@@ -145,8 +146,19 @@ static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
 	 * Make sure this interrupt is intended for us.
 	 * Handle only ADC channel specific interrupts.
 	 */
-	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_STATUS, &intr_status);
-	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &intr_mask);
+	ret = regmap_read(adc_priv->regmap,
+					IPROC_INTERRUPT_STATUS, &intr_status);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_STATUS.\n");
+		return ret;
+	}
+
+	ret = regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &intr_mask);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_MASK.\n");
+		return ret;
+	}
+
 	intr_status = intr_status & intr_mask;
 	channel_intr_status = (intr_status & IPROC_ADC_INTR_MASK) >>
 				IPROC_ADC_INTR;
@@ -162,6 +174,7 @@ static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
 	struct iproc_adc_priv *adc_priv;
 	struct iio_dev *indio_dev = data;
 	unsigned int valid_entries;
+	int ret;
 	u32 intr_status;
 	u32 intr_channels;
 	u32 channel_status;
@@ -169,23 +182,37 @@ static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
 
 	adc_priv = iio_priv(indio_dev);
 
-	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_STATUS, &intr_status);
+	ret = regmap_read(adc_priv->regmap,
+					IPROC_INTERRUPT_STATUS, &intr_status);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_STATUS.\n");
+		return ret;
+	}
+
 	dev_dbg(&indio_dev->dev, "iproc_adc_interrupt_handler(),INTRPT_STS:%x\n",
 			intr_status);
 
 	intr_channels = (intr_status & IPROC_ADC_INTR_MASK) >> IPROC_ADC_INTR;
 	if (intr_channels) {
-		regmap_read(adc_priv->regmap,
+		ret = regmap_read(adc_priv->regmap,
 			    IPROC_ADC_CHANNEL_INTERRUPT_STATUS +
 			    IPROC_ADC_CHANNEL_OFFSET * adc_priv->chan_id,
 			    &ch_intr_status);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Fail to read the register.\n");
+			return ret;
+		}
 
 		if (ch_intr_status & IPROC_ADC_CHANNEL_WTRMRK_INTR_MASK) {
-			regmap_read(adc_priv->regmap,
+			ret = regmap_read(adc_priv->regmap,
 					IPROC_ADC_CHANNEL_STATUS +
 					IPROC_ADC_CHANNEL_OFFSET *
 					adc_priv->chan_id,
 					&channel_status);
+			if (ret) {
+				dev_err(&indio_dev->dev, "Fail to read the register.\n");
+				return ret;
+			}
 
 			valid_entries = ((channel_status &
 				IPROC_ADC_CHANNEL_VALID_ENTERIES_MASK) >>
@@ -230,6 +257,7 @@ static int iproc_adc_do_read(struct iio_dev *indio_dev,
 	u32 mask;
 	u32 val_check;
 	int failed_cnt = 0;
+	int ret;
 	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
 
 	mutex_lock(&adc_priv->mutex);
@@ -284,7 +312,12 @@ static int iproc_adc_do_read(struct iio_dev *indio_dev,
 	 * Testing has shown that this may loop a few time, but we have never
 	 * hit the full count.
 	 */
-	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &val_check);
+	ret = regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &val_check);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_MASK.\n");
+		return ret;
+	}
+
 	while (val_check != val) {
 		failed_cnt++;
 
-- 
2.17.1

