Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E36367C4
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbiKWRzJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbiKWRzH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:55:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28340B97CF;
        Wed, 23 Nov 2022 09:55:02 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2774524pjc.3;
        Wed, 23 Nov 2022 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa9+zB2hHRJShe6/SZl8Kai19estoaLiBOw5LdWRhFM=;
        b=i1mnF3o9X2VVwhcc/7mMkcUzGBgFLXlUVrVryPxRvZVsboC0Rm6ZtiAC47G13l29v3
         QlAI45XfTHCQeT/uWgld7yZY0122erVTLAgKPzLOFtPIpDRi7fTCuSU6iU0nSvpMBbxU
         /5JGmSUYmEWuvYa4/55dWhFarMPXtnfJYKECPD0CkybsHQ+GBVFnPHxRe/b/20qWS9TM
         UuhGzgezb8h3iVXmpMM0raRV38ya4qirlq64bspEZQCl5MmagksPUJY/ApqAS5W2x+uZ
         1vZcgd0KsrjJo4E1dgVWDF4oa6LIAJ1EVFhTlGJYA78XD3dJ78kjjZj2mVbSrO34mdrd
         PPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa9+zB2hHRJShe6/SZl8Kai19estoaLiBOw5LdWRhFM=;
        b=vHZ7krtrk7HpzcJGnOGx4mF64BpsTLhgChr2fZ5tyQXjjxdZusKZqhUWRAdEyGosqs
         eWILvFOZRZrIfj4d/Uq/Ps+ltCO6Rh2Lcm9Pfxp6+7RYW9VzKM/W4gu2Z/TmzVHVSHfR
         Nh+vEzlC5ttB/7p30hpnGALZgMURNaobcLuf4habeKL9h06pXqN0YhclMTIatoqTdDmw
         Nfq+qwO5wvhUYJEUr0td+8dz2/KM336lNT2dsXEaItpKogh09TFJy5ufH/aSLYoavvk6
         DgI+Nk23XlxDLkOQ4L1E3pAIDQ688zcTtZr3wbBkgd16IdCj89K0mwFCBpODdJdH9h/u
         gg+A==
X-Gm-Message-State: ANoB5plL83w7SEZo/s6u/Y8/ITRP4YAbr5OzyrugM9mL7qCRlHz5njHY
        spoeollx3ubMzzys3jVMy53RV6RW+hs=
X-Google-Smtp-Source: AA0mqf6G/6YAi7FR4gkYG/ewDYRZ832a02qcb3kGoos+y+LKdcuH19EwQgU6xU5ZkvW9mk3IfneIlA==
X-Received: by 2002:a17:902:ce90:b0:186:6d34:b7b5 with SMTP id f16-20020a170902ce9000b001866d34b7b5mr13021371plg.37.1669226101693;
        Wed, 23 Nov 2022 09:55:01 -0800 (PST)
Received: from discovery.. ([2401:4900:483b:e422:60e:77bf:baa2:9d8b])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0057470a06694sm837503pfb.40.2022.11.23.09.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:55:01 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 5/7] iio: adc: mp2629: restrict input voltage mask for mp2629
Date:   Wed, 23 Nov 2022 18:54:23 +0100
Message-Id: <20221123175425.564042-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123175425.564042-1-sravanhome@gmail.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for mp2733 which is updated version of mp2629
with a higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/mp2629_adc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 88e947f300cf..18290e176e1e 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -66,6 +66,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 			int *val, int *val2, long mask)
 {
 	struct mp2629_adc *info = iio_priv(indio_dev);
+	struct mp2629_data *ddata = dev_get_drvdata(info->dev);
 	unsigned int rval;
 	int ret;
 
@@ -75,8 +76,10 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
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
2.34.1

