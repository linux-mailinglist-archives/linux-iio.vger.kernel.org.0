Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83156C2863
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 23:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfI3VPp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 17:15:45 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:42529 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfI3VPp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Sep 2019 17:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569878144; x=1601414144;
  h=from:to:cc:subject:date:message-id;
  bh=6pCT4FCPO1NK+0ZWeQGx+EaJmUPdETidBAplVSBV5bg=;
  b=EM5IpVa803foSV/ySpUMkNnsFVj5szddP04sOQvKFqHkIuZ29TtE6gu7
   Y72fVMiPxJ6uLaI9Umw4hiSBBEOpbvbnRMEoK88qVuB9ZvYEVivX/2xhZ
   TDDw2iAK+y9EJObigwLgZURyRE0PMgcPANutONrNCZf65nbMsvCILhee0
   1L53SAZv80RD7OUkOv3kpQU1Oby+D7CEvQzD7cxRUA1TJYFJnV/iEr6sV
   XbvpznPbGv5CAHd7qCy1o7FYBgFhr8fcreQbWps9hWKgSBmn/8U6kSA0l
   JX5N3u4P+B3Wt5HDQ0RGvtLpK7JmYmuTSp2yFgzNRsFgTBo4TpDn6txsF
   A==;
IronPort-SDR: LWOR4GcAxIkdf7v5tnrRfui6dRIqxDKFUOoqsg+0bqOBogZ0aDQmUcO3Szbpv4nwGHL1qCFxoe
 SWEpRUtRH7yotC3b4xVYNOKWUjD0KKBQQ4Tx8Y5meoCxkDkWFmBRD5IT5p6yPQmOHI++QB2psl
 pjiunc9MT4nDEWZykpNJhCQfPvY1fZUmhYmledvvnIK3P4JU5tV9Kjebwpy8rxZwU0q1aR/m/F
 pdbSqluMmY/DjZSfhWqZqE+vCkwuKnDa2/L0FnMbT/UHV5HxgkYjsbYg2+gC+Ox9l0QlJkUv5N
 Rzw=
IronPort-PHdr: =?us-ascii?q?9a23=3ARTkDchWIRDaRrkVaG3PydMaQ/YDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxyPt8tkgFKBZ4jH8fUM07OQ7/m7HzBaqs/a7zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMYbjZVtJqosxB?=
 =?us-ascii?q?bEoGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI68aooPD/EaPeZZqYn9qEYFowWnCwKxCuPvyyFHhnvr0qYn1+?=
 =?us-ascii?q?gsHx3K0AkmEtkTsnrbsc/1Ob8SX+6r0afGwzbNYfRN1Dvh9ITFaAwtrOuQUb?=
 =?us-ascii?q?5sd8fa1EkhFxnCjlWVsYHqPTKV1+UNs2iG6OprSOWiim4mqgFxuDevx9sghp?=
 =?us-ascii?q?XHi48O11DL6T95zJwrKtKlVU52eNipG4ZTuSGCL4Z6XN8uTmVytCs5yrAKo4?=
 =?us-ascii?q?C3cDUFxZg92hLSb/+Kf5CV7h/iUOudOyl0iXxldb6lmRq/8FKsx+/zW8SyzV?=
 =?us-ascii?q?1EtDBKksPWuXAIzxHT78+HReZj8Uq5wjaP0hzT6vlDIUApiarXM54hzaA0lp?=
 =?us-ascii?q?oUqUnDGzX5mETyjKOPbkUk/vWk5/3pYrn7opKRNJV4ig75MqQplcy/Bfo3Ph?=
 =?us-ascii?q?ISUGic/OSwzLzj/UvnT7VWlvA6jLXVvZTAKckYpqO1GRFZ3pss5hqlEjur1N?=
 =?us-ascii?q?cVkWECLF1feRKHi4bpO0vJIPD9Ffq+g1WtkDdxyPDHIrHtHpvAI2PekLj9Z7?=
 =?us-ascii?q?Zx8VBTxxcuzdxH/ZJbFqkBIO7vWk/2rNHYCh45Mwqpw+foEdl914IeWWWUD6?=
 =?us-ascii?q?+HP6Pdr0WI6vgsI+aSfo8VvijyK/w/6/7pl385lgxVU7Ou2M4maWK4A/Mud1?=
 =?us-ascii?q?SLYXPt2o9aOXoBpEwzQPG82w7KaiJae3vnB/F03To8Eo/zSNibSw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E5BQBrXJJdh8bWVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNHoZGAQEGiyaBCYV6iDGBewEIAQEBDAEBLQIBAYRAg0YjNgcOAgMJAQE?=
 =?us-ascii?q?FAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopgzULFhVSgRUBBQE1IjmCRwGBdhS?=
 =?us-ascii?q?iP4EDPIwlM4hdAQkNgUgJAQiBIoc1hFmBEIEHg25zh2WCRASBNwEBAYs4gji?=
 =?us-ascii?q?HK3CVWQEGAoIQFIF4kwcngjeCAok9OYsGAYpVnGsCCgcGDyOBNgOCCE0lgWw?=
 =?us-ascii?q?KgURQEBSBWw4JjkMhM4EIkBoB?=
X-IPAS-Result: =?us-ascii?q?A2E5BQBrXJJdh8bWVdFmHgEGEoFcC4NeTBCNHoZGAQEGi?=
 =?us-ascii?q?yaBCYV6iDGBewEIAQEBDAEBLQIBAYRAg0YjNgcOAgMJAQEFAQEBAQEFBAEBA?=
 =?us-ascii?q?hABAQEIDQkIKYVAgjopgzULFhVSgRUBBQE1IjmCRwGBdhSiP4EDPIwlM4hdA?=
 =?us-ascii?q?QkNgUgJAQiBIoc1hFmBEIEHg25zh2WCRASBNwEBAYs4gjiHK3CVWQEGAoIQF?=
 =?us-ascii?q?IF4kwcngjeCAok9OYsGAYpVnGsCCgcGDyOBNgOCCE0lgWwKgURQEBSBWw4Jj?=
 =?us-ascii?q?kMhM4EIkBoB?=
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="83994458"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2019 12:53:19 -0700
Received: by mail-pl1-f198.google.com with SMTP id o9so2955580plk.13
        for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2019 12:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mtpDHPmhW0Yh7Xz6JlH7yVqsGjbzLMx+b7ky5TSik5U=;
        b=D0lo54g3R+kXqD9WxJz6kr7UN6kcOdrPxxUsoCQcHFRh1hhs5z/CMZpJOKR1f7hKvY
         lCqkxm9UZabINmEUHG4idlw8rVj8ATzXdHqlN/UWm7i59BONprkMl6mqvuoPrmJ6iakf
         i5dN6I4I0MS4ufu7nylXnr+lTZVKCyzFBBIun/ilcvJPyGvgMk/a8DF4lFXVTC7F0w84
         8YPOtfrOqi61UwAxcZHVLISTUv4jBqx40+Kj8cxk6sgGn6NPQSF7oCUAgLYmVctC9NJC
         /k6wCHtmhBqpJ8mgk5GIgma6EyNE+Lsh4nrW2GuLT/PpGm33o+bf0WoyCeS9RTarDN1F
         2m1Q==
X-Gm-Message-State: APjAAAUT96J9skSVFdOF0GAmVLUeplkiJUhqB8q4nj9iAUqjnFLs9yiS
        ERZlZBf3csMEY01y3LggMAjoNPanW8U6uxzHimHz0vcYSBRgT6Y2suTHUN2e5a5X5Rxzdkw09vh
        xIbYxT2Ie0EXG/6GxAjgdlQ==
X-Received: by 2002:a63:2aca:: with SMTP id q193mr25799136pgq.156.1569873197819;
        Mon, 30 Sep 2019 12:53:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxF6lwNas3D/FgEkqSm4zKuRr+Ixd0SEanVYzHGnmwSzt46Z2CHd4yfGTjhZMCMas6tzuHMXg==
X-Received: by 2002:a63:2aca:: with SMTP id q193mr25799110pgq.156.1569873197327;
        Mon, 30 Sep 2019 12:53:17 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id p17sm12179234pfn.50.2019.09.30.12.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 12:53:16 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: imx25-gcq: fix uninitialized variable usage
Date:   Mon, 30 Sep 2019 12:53:54 -0700
Message-Id: <20190930195358.27844-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In function mx25_gcq_irq(), local variable "stats" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement, which is
potentially unsafe. The same case applied to the variable
"data" in function mx25_gcq_get_raw_value() in the same file.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index fa71489195c6..3b1e12b7c1ac 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -73,8 +73,12 @@ static irqreturn_t mx25_gcq_irq(int irq, void *data)
 {
 	struct mx25_gcq_priv *priv = data;
 	u32 stats;
+	int ret;
 
-	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+	ret = regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+	if (ret) {
+		return ret;
+	}
 
 	if (stats & MX25_ADCQ_SR_EOQ) {
 		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
@@ -100,6 +104,7 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 {
 	long timeout;
 	u32 data;
+	int ret;
 
 	/* Setup the configuration we want to use */
 	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
@@ -121,7 +126,11 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 		return -ETIMEDOUT;
 	}
 
-	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+	ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+	if (ret) {
+		dev_err(dev, "Failed to read MX25_ADCQ_FIFO.\n");
+		return ret;
+	}
 
 	*val = MX25_ADCQ_FIFO_DATA(data);
 
-- 
2.17.1

