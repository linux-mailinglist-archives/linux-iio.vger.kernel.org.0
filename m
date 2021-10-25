Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17693439609
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhJYMWS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 08:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhJYMWR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 08:22:17 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0A2C061745
        for <linux-iio@vger.kernel.org>; Mon, 25 Oct 2021 05:19:55 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id f24so2473725uav.12
        for <linux-iio@vger.kernel.org>; Mon, 25 Oct 2021 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=zwmpU/4wUBOOjvtzhmHsdtzGo9J9noPc+g2NVU0zBxc=;
        b=zdb7e5wgfnKy23IF9N+nt68OhysvD7UjZ5zDYtdgZ0sivFULWY9/ugfSFeix0JXopS
         ziNYkrV3JAE2eoI6BDjbLHmoKFCYJhdkfryGUfZ1xdgLM9FzxTcSgi1+WnWe8gTYD0/8
         fPAZq4D3xit+HpvCyLjEsQDxQerW6UcSkXtExYFNZwK6CFsRw+1soqeGeq5rhVfpmHv6
         Rvpk8+miDk28wz2oH2daV0v4ZJJCP4OvMBslThVP8Jve9hlzk75Yi+hoyxdHZZ5ShbY8
         OJGl02WdhcSzIg1ke8hQ3ndiRB8p/Cwj/fJrlQFasC0E9Befo3N/NnG2UY1gyauJ61V7
         F5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=zwmpU/4wUBOOjvtzhmHsdtzGo9J9noPc+g2NVU0zBxc=;
        b=z3wka7xMTJJSKwUBZP/MkTUwy2C+ajbU2CUoVx5jlKWMUnAQbgyLrUncWBhxQRvnQK
         mcsLEHQG4lLxyRPJz3HfweByTB04bZz3MW/2yRVjgRWXar1QoNO4KU7AjUh4oS/79nYB
         +kcoUy4CqIPz1EePVb2A4BUpRTaLGTN+1f4lrpgqh6+3O0lw6qz22hLNGhlzw/3TXnRU
         P48bODD1eOobGvKC/GxpOCZg7dXx4Uxorx/H8JXjiQ+iwamsJ3aW/wvJuPduJ9zpTbXg
         +kT9P0X4RXVBMX4aRuP07dZalUOjb8a/AxufwHE1Kb2jW1lRWJSYRkeJyU+faBaxeeWZ
         kdTw==
X-Gm-Message-State: AOAM5321xuGq/ljcuvDnE9bqbxHh7pvl3jnUEz8sj5bnJ1ioxg4dw953
        bsnALBEwad/1gxLnYSBfPEeh0w==
X-Google-Smtp-Source: ABdhPJwO0IHmRP033afGZOvNBH76vR6CJDWgHofTo24bK/FSoHv7O6QBDFOMfGnQpyjlLwXwYtmSGA==
X-Received: by 2002:a67:b202:: with SMTP id b2mr14375566vsf.33.1635164394426;
        Mon, 25 Oct 2021 05:19:54 -0700 (PDT)
Received: from Andryuu.br ([2804:431:c7fd:423:9dac:f639:6086:598])
        by smtp.gmail.com with ESMTPSA id ba22sm848466vkb.7.2021.10.25.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:19:54 -0700 (PDT)
Date:   Mon, 25 Oct 2021 09:19:50 -0300
From:   =?iso-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez <andregnl@usp.br>
To:     jic23@kernel.org, lars@metafoo.de, vz@mleia.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: lpc18xx_adc: Reorder clk_get_rate function call
Message-ID: <YXag5l4xBkGQH3tq@Andryuu.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

clk_get_rate is not guaranteed to work if called before clk_prepare_enable.

Reorder clk_get_rate, so it's called after clk_prepare_enable and
after devm_add_action_or_reset of lpc18xx_clk_disable.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
---
Change log V1 -> V2:
		  -Fixed typo
		  -Added appropriate Suggested-by and Acked-by tags
 drivers/iio/adc/lpc18xx_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index ceefa4d793cf..ae9c9384f23e 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -157,9 +157,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
 				     "error getting clock\n");
 
-	rate = clk_get_rate(adc->clk);
-	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
-
 	adc->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(adc->vref))
 		return dev_err_probe(&pdev->dev, PTR_ERR(adc->vref),
@@ -192,6 +189,9 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	rate = clk_get_rate(adc->clk);
+	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
+
 	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
 			LPC18XX_ADC_CR_PDN;
 	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
-- 
2.33.0

