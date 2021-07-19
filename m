Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668FE3CEED0
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358055AbhGSVQM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 17:16:12 -0400
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:12953 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385803AbhGSTKQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 15:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626724256; x=1658260256;
  h=from:to:cc:subject:date:message-id;
  bh=MYc29Ou9YlvgD3SQj+KfJB5TjwaCedW7HGkkcEg43K8=;
  b=asdJFxuvrXDx65ZWE3nyCElyNbPk2mlIAZOAllmkYRWIqfWHnUJjmrH0
   YR12UEhL07WovRnC7N0kf17mosidp2ur7vb34377nDzwCPo3KAjUtK9R2
   ivkhie1Cm1J81fPluyTrUBBwxpYJ/4LnpA8ogU/CD1SuhXTQzKxlk5gXu
   /9eeqTM9EHTHNQLKF0QGamhFDMwrvWZh5Q/wNd9act0Xma5BbwyFeT9xx
   wXVeZWzVcZtIbwo9Tb0f81k/zxMOrTlpwLIHSkvu2+veemhvhYtLg7cRZ
   5cdmwLBywJpjXyJ72Mc0FrJhMnp2Xlozk7MnA8wD2RA9noZcNDFs9Vg+k
   g==;
IronPort-SDR: 8dyZWwLWqm/uxH/t4ll0VLv2fOMmVMlOnprH/114/2m/Jwpjokiism6pZbhG8gIZn/qtX/ReSS
 efRx8DvcCX0SO/dXTwiXB/WxJOIZEVf0y9kK58BUo4fpAMU/slR9AxrMtgLTYVToqXnJRncSoq
 vYjJdnZmsKr1QfLH/RLrOiHbsn8DqFgKF7cpVgs7iJcz6SCUi31/hEkkwQSjQ4FclmMvzkJS7G
 zZrn+NnRupD2NzooBk3azYxSqnjcXvDxKlAzQ8oCOuusEbaBlz94tk1wQCTvoWwYVq/2Hk8KTN
 aP3JWf2Cy/+8D7D3PHjTCjLQ
X-IPAS-Result: =?us-ascii?q?A2GtAwAI1/VghkXYVdFagmKDeVUWjUyHEwEBBoFBin2BA?=
 =?us-ascii?q?oZ8iGaBfAIJAQEBDQEBQQQBAYRXgwACJTQJDgIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QYBAQEBAQEFBAEBAhABAQEBgQoLWQtjgU+BeQYEPYI4KYNlCxYVUoEVAQUBN?=
 =?us-ascii?q?SI5ghYBgmEmmi2BBD2MMTOBAYgHAQkNgWMJAQiBKIh8hReBGYEQglCBM3WHb?=
 =?us-ascii?q?4JQBIMVUygTgmmBEAEBAZNQAahFAQYCgwocgxGbDkWDY4J9jl1CkF4BLZAmq?=
 =?us-ascii?q?j8CCgcGECOBOIIVTSWBbAqBQU0BAgECAQwCAQIBAgECAQIIAQECjXIBNQ0Jj?=
 =?us-ascii?q?i1BMjgCBgsBAQMJjBMB?=
IronPort-PHdr: A9a23:UV2EPhZCNbtUXPnDL/qOImb/LTH90IqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1gePBt2QsqkUw6qO6ua8AD1Guc7A+Fk5M7V0HycfjssXmwFySOWkMmbcaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 AuqoQnLuMQanYRuJrs/xxbKv3BEf/hayX5yKV+cghrx4t288IJ//yhVpvks69NOXaLmcqoiU
 LdWFi4mM2c75M3qsRnMUw6C7WYCX2sVjxRFHRHL4An1UZntvCT6sPF92DSBMs3tUb80QzWi4
 Lx1RxLulSwKKiQ28GDTisx3kaJbvBesrAFxzoLIfI2YMud1c7jDdt0GW2VOQsdRVzRAAoyia
 YsPE/EBNvtco4XkulcCsQeyCQyqCePqyz9InWT23aw80+QuDArIwhUuFM8AsHTVstr1MLodW
 v2xwKTG0TnPavVb1jDh5YXGbhwtvOiAUa5tfcHMzUUjCgPIglCWpIf4PT2ay/4NvnCb4eR+S
 OyhhW0ppQZqrzSz2sshkJXFi5gJxlzY8yhy3YY7Jce/SE5+edOrEppQtiCaN4trRcMpXmZlu
 SY7y70Go5G7fTQGxIgpyhPEdvyIb5KI7gj9W+mMPDd1nXRoc6+wiBiu60av0PH8VtWq31ZQq
 CpIitbBum4P2hLT9sSKTvtz8lmh1DuM2Q7e9P9IL0A1mKfZNpMsw7w9m54SvEnCACL7hEb7g
 LOKekgm5+Sl5PrrbLXgq5SBNIF0khnzProylsG7G+g1MQgDU3KF9eih1bDv50z0TbFSgvErk
 6TUtIrWKdoVq6O5GQNZzIQu5wyhAzu43tkVm2QMIkhfdxKdlYfpPknDIPX/DfiinVuhiCxrx
 /XaPr35BZXNM2TDnK/hfblj705czxI+zdVF6JJVDrENOerzWk3suNDBAB80Mgi5z/zoCNV60
 YMeVmaPDbGDPKzOtl+I4/ojI+iKZIALpDbwM+Yp6+LqgHMjmlIQfbOl0YUKZH25BPhrIkGUb
 WLpgtgbEGcKugQ+TPbtiF2HSTNSZ3ezX6Im6TE6FI6qEYnOS5uwgLOdxie3BINZaX1bClyUC
 3fna52EW+sQaCKVOsJhlj0EVb68S44uzB2utQ76y718I+rK9S0Xq4jj2MJ25+LNjxEy8yJ7D
 8CH32GKVWF0kTBAaSUx2fVOoF5911DLhblqg/VZTYQIz+5CSEE3OYOKnL8yMMz7Rg+UJoTBc
 12hWNjzRGxsJu8=
IronPort-HdrOrdr: A9a23:h7MHZaBhfvUTJ13lHemt55DYdb4zR+YMi2TDGXoBLCC9Hfbo8P
 xG8M5rtiMc9gxhPk3I8OroUMLhfZq1z/9ICOIqTNOftWfdyQmVxUJZgLcKAQeLJ8QzzIFgPN
 9bAtFD4RTLYTZHsfo=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="55032891"
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2021 12:50:54 -0700
Received: by mail-pj1-f69.google.com with SMTP id v4-20020a17090a4ec4b02901731757d1a2so9707770pjl.4
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 12:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OXOnGGPnlJMlgfJA7I8h06LGQvk/TlSh7ooUa6JcARg=;
        b=Ai1gIU1j329CDyZjn2n+V+uYZr60d7YFP4V8Kg8hXyMZI6HLgHy9P9uFyVtFFYxqz7
         9vcxoskrfWjkYsKbKvNkUEOnbCFB3x6zEoBE7Zch646DomTnXW4Aruz09nDgA5rxDyJG
         YFLjCtKllwsl1y5EBd1wu0xa63z8yGTcIXB3iOSOHL1X2IbgQaYtKxTb9KZh1Svi/OYh
         +ngtN5ZIfeyfgRptFUl6ZhCVBRnnMcZXlOGccNGZDdFvN5p6e9PC/bvZk521RJWhSEc+
         DFzSTY61p6JNXvzbM+5ohK43hdG3ujn0Fi6Unzolz67mvCjjBdrE7dujEFrbfCWJ8Nm+
         7lqA==
X-Gm-Message-State: AOAM5310dFrI1lqyG7AI/Yxl2D1E89Pbf/mr842k3BhuaKMXfSuoNzbR
        pdKBBenexf3LFlMMnUf6XPZSfayh/0UeqrWf9H6K7342wRt+/ZuR590TB2ecqFWMm0H6tP0NUok
        TTUtyK6iJgxP4ITAWkSUsLA==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr31068674pjh.135.1626724253100;
        Mon, 19 Jul 2021 12:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeoggVNck06c751xfNeJAk9UTizVm33D0WmnP578NV87JKcTcN5mzJ1hVRacMKD2c9/PCsqw==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr31068659pjh.135.1626724252863;
        Mon, 19 Jul 2021 12:50:52 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id y4sm299857pjg.9.2021.07.19.12.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:50:52 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: stm32-dfsdm: Fix the uninitialized use if regmap_read() fails
Date:   Mon, 19 Jul 2021 19:53:11 +0000
Message-Id: <20210719195313.40341-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
could be uninitialized if the regmap_read() fails and returns an error
code.  However, they are directly used in the later context to decide
the control flow, which is potentially unsafe.

Fixes: e2e6771c64625 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 1cfefb3b5e56..d8b78aead942 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1292,9 +1292,11 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	unsigned int status, int_en;
+	int ret;
 
-	regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
-	regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
+	ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
+	if (ret)
+		return IRQ_HANDLED;
 
 	if (status & DFSDM_ISR_REOCF_MASK) {
 		/* Read the data register clean the IRQ status */
@@ -1303,6 +1305,9 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 	}
 
 	if (status & DFSDM_ISR_ROVRF_MASK) {
+		ret = regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
+		if (ret)
+			return IRQ_HANDLED;
 		if (int_en & DFSDM_CR2_ROVRIE_MASK)
 			dev_warn(&indio_dev->dev, "Overrun detected\n");
 		regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
-- 
2.17.1

