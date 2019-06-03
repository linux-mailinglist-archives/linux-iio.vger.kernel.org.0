Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8633923
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 21:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfFCTfb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 15:35:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45486 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCTfb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 15:35:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so1212351qkj.12
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=flnePExtC+ruu5dhcQrai04re/FGxZ1Oi9gicuNZPPI=;
        b=fklkNTmFbnN6dxKgeKiYAQ41+ZyCTKhT8Lo5FjSygFZk7wX2w8MaPrkUn57XLq+Uf8
         kkgSuj4twdq0KQsTVXUsXzB+4KMf4IiM/mL1O/GOdHIK6BazHKlcwKCv5crRFSPx2aoG
         aKdssGZ6DhEUH+lwLLmaGLFi/YSMHDysN7fIfuYtscni5TjUgNuSqiEFfdWZegLAyPoD
         zV/CDiiAbrV7pmaUk6nhRMFbuZsd4TA+rmEypx/z8U9pG5XxPZDwgHMY15kU+cLTCdNi
         xYwFkX6pe/ZWfM4RBYCsaXuSObuPhiI6J2C6pmiWNwhF0hMn69wST/SXBdFHrUKkVhS1
         C4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=flnePExtC+ruu5dhcQrai04re/FGxZ1Oi9gicuNZPPI=;
        b=ljK99NSIDl3zyLWzRNxO8UVZpqOC41HwudXmBPoEXFJ/gptPLGeXQlKrvcRjwsso34
         p0R2aQj4dP4Um/Or9GIIoC2F94mwt8cashsslDCCxzdldI3YZVTSXnZ5bu7K02dJ3LQW
         t4RKC3pTj+tbxIst2GK0V6XVhOet1JuL31UeH47iL4bH/nxv7JW6e0fWSlDA1jyLvOFx
         CdJkL1l1YwHh55uPWw3kKGk4cFvI02zx15JaQmoSgK2d7ESLnQTESrEK/D3ZgANd8IX+
         ZO0goj0WqSUJQgdkEvu/JQgItLtUiGApSLIEYcGypKjgIICm4OR50Ee83fRWaFlpK/PQ
         wMuA==
X-Gm-Message-State: APjAAAWa8FgJc6F9WWzyHh9Xt5YQ3hIRA3wlSd+pBoq3Zq/xsLfTeXA4
        mwYc2ElbpSIFq2q+Vci39cc=
X-Google-Smtp-Source: APXvYqye522K4085TBXZolIuU0HD3iKHnMAZkm5nQHeGnOGQWfiwRrFRJWMJbmmW++K0nnFee1i1TA==
X-Received: by 2002:a05:620a:147:: with SMTP id e7mr23254276qkn.247.1559590530334;
        Mon, 03 Jun 2019 12:35:30 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id t80sm7539231qka.87.2019.06.03.12.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:35:29 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     andrew.smirnov@gmail.com, linux-iio@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] iio: imx7d_adc: Fit into a single line
Date:   Mon,  3 Jun 2019 16:34:32 -0300
Message-Id: <20190603193433.6394-3-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603193433.6394-1-festevam@gmail.com>
References: <20190603193433.6394-1-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All the parameters of devm_request_irq() can fit into a
single line, so place them all in a single line
for better readability.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/iio/adc/imx7d_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index bffc172e7635..46e88899ad74 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -527,9 +527,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = imx7d_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(imx7d_adc_iio_channels);
 
-	ret = devm_request_irq(dev, irq,
-			       imx7d_adc_isr, 0,
-			       dev_name(dev), info);
+	ret = devm_request_irq(dev, irq, imx7d_adc_isr, 0, dev_name(dev), info);
 	if (ret < 0) {
 		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
 		return ret;
-- 
2.17.1

