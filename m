Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1454BAC3
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiFNTmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 15:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245256AbiFNTmh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 15:42:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C01C91F;
        Tue, 14 Jun 2022 12:42:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id o7so19175406eja.1;
        Tue, 14 Jun 2022 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18oHUFXG2mUdcVQ1YXANbaKmOh1LlQNFTNBa3/M0B6U=;
        b=CGKqFqYtINJLcYasTd31Lo3Jgb+PK0ks3CCzmX9ymkKJwWIyb/UtJzQ0j7C7XsGKa0
         r68s7fJsZVp/4i6ik8PQAPa2RoVlIAAy4LIEqMKY2raPVz2EeuXyJp7X4Ixsf15ysoU7
         difKbRonDfW+jR2mynsHDefRzl1mDvZf5ebgT/s0igQMs+KaRDLn9A9tjcrPSjMKmMxi
         WIV2sYlG4Y3P3B5OK5LD4kKIA9JjRITnPfTkHaurq/U2UGKgxhOlqlpvddatIIZsfee3
         Yk9l2nipXY2kS9t71o7WPMG2hBi3FpenB4RxRdoV5wP3e09Y/UfM/KYvlIlr+jzwpMu/
         hibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18oHUFXG2mUdcVQ1YXANbaKmOh1LlQNFTNBa3/M0B6U=;
        b=ZirrASoE9KkRTosw/EWpG0MbCo4dw4vbF1J6kC1Io8NgfeKi+RvE7lahttUennCPed
         3I9SLEzvnAkZxtoNa0+QrQLtQAAq3MmmfdrTKHjLN6b+8MTx1Iow1JSdT2Yibs3FAJcs
         86AGR+ksMRZVWSKe5hJFknU68ni9OEuvzmeySRd1F7tHK6nSYsZ5SlYAGib2Sg7DCkba
         6vSA1h/abXL0+Ptp/0Iay11fSA9+gdQ0+OmzVNBLNTU6h/UksSdH012smnOgaCSMPO4V
         FNg9lrmryy9eSZq1oUiTVimC2A8RKSkM4wbp8xCT803hVYFtjuaFsKzZRppUJ6eEnsmw
         VV1w==
X-Gm-Message-State: AOAM5311l9oKXthsWA3S0O4i8bqnWt64Qdvz72s+68FolCoRsEWE3HOg
        TyALJ3gPcnlYYZZCSWkhDE4=
X-Google-Smtp-Source: ABdhPJxdALFhwQI2RlqE7TUoCCGB1gDIlxTax01tTePsyJZMOt7kPZAcfI+I1a2wNH9zxooxDDVjrQ==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr5427263ejc.243.1655235755002;
        Tue, 14 Jun 2022 12:42:35 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id vw5-20020a170907058500b00712057b037fsm5306699ejb.167.2022.06.14.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:42:34 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 4/6] iio: adc: mp2629: restrict input voltage mask for mp2629
Date:   Tue, 14 Jun 2022 21:42:23 +0200
Message-Id: <20220614194225.2226447-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614194225.2226447-1-sravanhome@gmail.com>
References: <20220614194225.2226447-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

add support for mp2733 which is updated version of mp2629
with a higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index e7fbfe92e884..28d048eefce3 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -64,6 +64,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 			int *val, int *val2, long mask)
 {
 	struct mp2629_adc *info = iio_priv(indio_dev);
+	struct mp2629_data *ddata = dev_get_drvdata(info->dev);
 	unsigned int rval;
 	int ret;
 
@@ -73,8 +74,10 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (chan->channel == MP2629_INPUT_VOLT)
+		if (chan->channel == MP2629_INPUT_VOLT &&
+		    ddata->chip_id == CHIP_ID_MP2629)
 			rval &= GENMASK(6, 0);
+
 		*val = rval;
 		return IIO_VAL_INT;
 
-- 
2.25.1

