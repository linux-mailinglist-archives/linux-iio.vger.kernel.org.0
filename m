Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6338C60AE3D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiJXOxr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiJXOxU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 10:53:20 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B8D38C6;
        Mon, 24 Oct 2022 06:31:07 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id a67so31218851edf.12;
        Mon, 24 Oct 2022 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkjjo7UhHr68UQkDQLmeDc/rzOhg5k2ugSo/6Bh7PsU=;
        b=T3b3FyGncjk4zPd1OhDQJliCp91vS+wwBy7+VfIBdISFNkro26NByxQAozweGKNYzg
         hUb0D9/qt7ikl+Aqa/j3O74PUV4KwOHirptzpd0KBAz5BsOXCWAReH8oE8cbiI8LVwrU
         1f+OKPi3Lz+9Zm8UoTu7TwGhVECgERGMkq8dOGCyj9a/xV/4+zRC2eU6JLgw0iKP+pzV
         fBezP3yBvCfIF7ZKYJVZNK4r5DgCC7zEIhHKY2WMZ7g39ckpwRfb4pqSRv3fuZiFtIKB
         n16CIjE6DhzSkFz6PWc9xfAnwtn2sTSiBSG0avMOgquRYUuIXQ+R4unWYncm+3jIkovr
         sfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkjjo7UhHr68UQkDQLmeDc/rzOhg5k2ugSo/6Bh7PsU=;
        b=tIhFEgNlwqourBdmvO1xlVadn32Ow37ttk8GIhEeoMG+oG2uhcIwJdRGF+7vCS29lX
         GQRY0cbwHD0wTPs1sCkHQmELLuAotxZi/kUNoKj+7Hr/QK+YhBkJIHQ1hk6hIg3f+jOp
         YWw6X8eq7uTVgHem39QbIwpLwakjFJR17YdhR80eeEI2w8RVaBgVC0yaHhP33Ozl8vAv
         UUHdjmwAk6s/i+S2p2z2Wr3XYrNWyo18F1zaddAwBFtvgIfaB08s7JnisA0pichR2dR7
         5e8N51F+hZz3wYEd5K5Aac8dlvApcfOViSmimvlDBLx1cpQQAgZamsROPv/I+KDKJ12b
         N2kg==
X-Gm-Message-State: ACrzQf2IBbrDR9vA5BMcLco5aMnZpRG8GSZBYGPwDMTMlqrGdab8iu90
        ZcqqVJwFDwAkBBywfMh7DgfVheJfx34=
X-Google-Smtp-Source: AMsMyM6BW9Qwf1YKt0QJuHSrKBkpjQA+LWdiivjudPUUEZLBin7mbS4/9M7FDPOwmuf1TpopggBi6g==
X-Received: by 2002:a05:6402:294a:b0:461:b661:d903 with SMTP id ed10-20020a056402294a00b00461b661d903mr6155562edb.407.1666618083184;
        Mon, 24 Oct 2022 06:28:03 -0700 (PDT)
Received: from discovery.. (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id l20-20020a056402231400b00457c5637578sm18243818eda.63.2022.10.24.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:28:02 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 1/8] iio: adc: mp2629: fix wrong comparison of channel
Date:   Mon, 24 Oct 2022 15:27:50 +0200
Message-Id: <20221024132757.3345400-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221024132757.3345400-1-sravanhome@gmail.com>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Input voltage channel enum is compared against iio address instead
of the channel.

Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 30a31f185d08..f7af9af1665d 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -74,7 +74,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (chan->address == MP2629_INPUT_VOLT)
+		if (chan->channel == MP2629_INPUT_VOLT)
 			rval &= GENMASK(6, 0);
 		*val = rval;
 		return IIO_VAL_INT;
-- 
2.32.0

