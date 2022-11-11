Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADC625D41
	for <lists+linux-iio@lfdr.de>; Fri, 11 Nov 2022 15:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiKKOju (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Nov 2022 09:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiKKOjg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2022 09:39:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A869627F2
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 06:39:27 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k2so13059189ejr.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 06:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BpIqKmaepR1SpUgklkTdQKDocBg8CsmOhHMlVS5EHA=;
        b=DrM+gnHh97vdiwSHvs4Vlne0TO7c7w6abdslmDlScfvk00Y2RXCkV1/198Pr+SVcbm
         n84m7ML0SQY10/bU7IEnnEcKIHqkZ20R7/yCuFd2+jYTc3uRCe18o/7sh7Ix2V05Gdge
         f0lgC7FK/NGYosoVXQ1uY9SHIUGtr4TPm7JrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BpIqKmaepR1SpUgklkTdQKDocBg8CsmOhHMlVS5EHA=;
        b=dfraVuo00vCFwQs8Z/uOtrUB2kVsYTn/qfH0huKKlsKxNqb5QlbPjX90CY1jWZPowp
         ONu59heCGg9+7fwSTYAFwOJ0aWnrreMTc/3seBBDNs8V6zoRUuLmiyHeHgc5RlywDHc8
         vL5sT1jWq4ymXujiKASHV+PUhLYo2MsxqdFRlES8Yc72EUtfSO7ggZM6vrzgveJyJ/N2
         jznKrmjRAGKL7b+rcIMzbUFpvz+OgapeomYj40NO9Umy2+rrjbccr9rwq3UwPYvIqHaD
         80UniOrLSF4nqcwwMNOIyRC5gzJihLUwtzBYR0PovL1o6TDsXKawQoF67yfWSpnUUZNM
         MebA==
X-Gm-Message-State: ANoB5plGBYuVViFo4ozjEuq+23MxMeD2hJ1OcFUVO08j8N1AVkihq0Xw
        FNMfKNPc7kRCKfwlQdhgSgadWw==
X-Google-Smtp-Source: AA0mqf7L3DlioxGxsRAlHlmZuxIAKfkei/P6adHOCk7nBRhv6rfyvwNL24gmqVIp5PiVy6hCz3zUyw==
X-Received: by 2002:a17:906:388c:b0:7aa:97c7:2c04 with SMTP id q12-20020a170906388c00b007aa97c72c04mr2100956ejd.191.1668177566016;
        Fri, 11 Nov 2022 06:39:26 -0800 (PST)
Received: from prevas-ravi.tritech.se ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b007a1d4944d45sm945886ejc.142.2022.11.11.06.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:39:25 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] iio: addac: ad74413r: add spi_device_id table
Date:   Fri, 11 Nov 2022 15:39:17 +0100
Message-Id: <20221111143921.742194-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Silence the run-time warning

  SPI driver ad74413r has no spi_device_id for adi,ad74412r

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 899bcd83f40b..37485be88a63 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1457,12 +1457,20 @@ static const struct of_device_id ad74413r_dt_id[] = {
 };
 MODULE_DEVICE_TABLE(of, ad74413r_dt_id);
 
+static const struct spi_device_id ad74413r_spi_id[] = {
+	{ .name = "ad74412r", .driver_data = (kernel_ulong_t)&ad74412r_chip_info_data },
+	{ .name = "ad74413r", .driver_data = (kernel_ulong_t)&ad74413r_chip_info_data },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, ad74413r_spi_id);
+
 static struct spi_driver ad74413r_driver = {
 	.driver = {
 		   .name = "ad74413r",
 		   .of_match_table = ad74413r_dt_id,
 	},
 	.probe = ad74413r_probe,
+	.id_table = ad74413r_spi_id,
 };
 
 module_driver(ad74413r_driver,
-- 
2.37.2

