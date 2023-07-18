Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F657574DF
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jul 2023 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGRHCb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jul 2023 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjGRHCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jul 2023 03:02:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29971B6
        for <linux-iio@vger.kernel.org>; Tue, 18 Jul 2023 00:02:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3110ab7110aso5598291f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Jul 2023 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689663743; x=1692255743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUtxeuLt0e5A/vNPcKykxiuourGN5YeLLNebzm+n1sU=;
        b=TOs7k2d04sr+qWEDqUtONZhsoBUX/flJaH4UWkpVCxKRqBhMaKcTfnmKXH/4u0sYYS
         H/CREjvmulvazWdjr6ahFRsZaE65BT4qx39R7nVf1tpGkjxv+ikCVXuCz/ZV/0R66EdP
         SBmyC5Nr5SLyNqYfvnbngzFiK/PobHcisMxOgCSXBle0kJfoarTMkExOTMv0TuW1Hj1X
         PQMCyJag9msU83ANeKTfZQWp+YgaYCkuu6Xq/zCb8253z80h4xXt53o1Mc1cmXUQWVCO
         7hgBOaZZ3QwivDz2coA2eoa+YpC1aYnFogIj88f/RbkepHJ/02d3wyiw0y2HuDuF9w3L
         VeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689663743; x=1692255743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUtxeuLt0e5A/vNPcKykxiuourGN5YeLLNebzm+n1sU=;
        b=AKrFws7qu/4RiZksVF0e3DKhU2lq2HL/2DiQbAhE+uCxO9oiKBeudwSFlp6EFOA+Wm
         9aWrsvcak2JIp3pl5eDHtwpxfYMhzgxtA9T4fhbWcSAfxI/DcVIH7KXOJa2w2ehyOnZ0
         OtWTpITfcmrm1de+A0LQv6+TJ5XFpbFcTkw/9/MeZ/S+ohV5X6YcyXr/CaRgvS9msTgH
         bt6U/LJRtgYRs/5sxGp9/wIGIHZp+cDU61F6NFTsErLcZOQdK7zr8zXm01gigSWY47JH
         xQcEPC5QN1HnU1T0QVNhzh/HNQbc4PfTOBvWbFc5ik9KB/KZb2hacac0X1lvCJcw9lq5
         hKAQ==
X-Gm-Message-State: ABy/qLYsjMfr5XmDnM5F8EufGzNjZ85dJyYCB5Ym58cydua63ZNsjWLX
        TX/xg+643B/H1kWEPDE2FrtbzA==
X-Google-Smtp-Source: APBJJlHsNFO6IgYs1oo9PUaJA0ZMqdBAII53HOqi4Mhilr81K3eJKjnldbggMFwbAFxy3k039OP8cQ==
X-Received: by 2002:adf:ce88:0:b0:313:f957:fc0c with SMTP id r8-20020adfce88000000b00313f957fc0cmr12215967wrn.47.1689663743342;
        Tue, 18 Jul 2023 00:02:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i3-20020adfe483000000b00313f61889ecsm1448445wrm.66.2023.07.18.00.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:02:22 -0700 (PDT)
Date:   Tue, 18 Jul 2023 10:02:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: frequency: admv1013: propagate errors from
 regulator_get_voltage()
Message-ID: <ce75aac3-2aba-4435-8419-02e59fdd862b@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The regulator_get_voltage() function returns negative error codes.
This function saves it to an unsigned int and then does some range
checking and, since the error code falls outside the correct range,
it returns -EINVAL.

Beyond the messiness, this is bad because the regulator_get_voltage()
function can return -EPROBE_DEFER and it's important to propagate that
back properly so it can be handled.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/frequency/admv1013.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9bf8337806fc..8c8e0bbfc99f 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -344,9 +344,12 @@ static int admv1013_update_quad_filters(struct admv1013_state *st)
 
 static int admv1013_update_mixer_vgate(struct admv1013_state *st)
 {
-	unsigned int vcm, mixer_vgate;
+	unsigned int mixer_vgate;
+	int vcm;
 
 	vcm = regulator_get_voltage(st->reg);
+	if (vcm < 0)
+		return vcm;
 
 	if (vcm < 1800000)
 		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
-- 
2.39.2

