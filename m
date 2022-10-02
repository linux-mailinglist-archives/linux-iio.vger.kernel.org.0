Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26765F232D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJBMbJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJBMay (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 08:30:54 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC5D481CB
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 05:30:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id g9so1754972qvo.12
        for <linux-iio@vger.kernel.org>; Sun, 02 Oct 2022 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=R1c3R5rE0U0o8lHQihkxq4pyXx/vqIJRQ9pdL4TPGeY=;
        b=q4n8XxxUt6ZKmpbA6nWE3aV4vUPZFTlzkQXrihTZXM15Y1M4GdJ19gXV8jmb0q+w28
         cwDGe8r8VKC5TDpp41PM7csGe/LBCUodovD+WpeU4xELOzPKGNxJz9OyAc6zphF62rsP
         /7ISHTQyJVqocqmLbGNkheDsd3s2d/yisZQUvIXzY+dziHVT9ArxsR/27xUVMPE4TFyg
         PrEy/8/0JWy/oFsi6IQG6vDr4toEY2Dx8WFMzA6lulj2VUC+c0nF3zKhmWIQcCKdUSY5
         Io2ndqxlGamkBud1APehCRfofCR8iCDMIwAD7aJ+rHj87zE/HTGlyg3cvzxbNYaQE9MJ
         KCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=R1c3R5rE0U0o8lHQihkxq4pyXx/vqIJRQ9pdL4TPGeY=;
        b=bDrriDJhyqbNwolJXT0CtsYL+gCnL5iR++D7FZQg3o9V9LO2t4JGgu4YW0p7pndW8Q
         LOafS+/I2Q0Tp9j+Rh3WYqNP+OfoKd6JgNvoFStPhhRbZu900RImgdcWHpGR7Z4nKRAw
         qTazE5xyK2XnBBpk9/8dumD/N8COxIsjtM8GA7oW2b4pkMwHnW4If8KNY2np5UU1ohXE
         KNejcvWuOFy2TC7hcwzeA5Yt4Jxap1nqQudby5Z/iCWreUMndcfhb4pPkEEZ+45MRI7Z
         oKRxaBWmrs/DMttRsSiFasHeFuWYdaKtJUwFUlVfmxYFhZnGH8/0hx2FIVXbdHxPXOop
         5HRQ==
X-Gm-Message-State: ACrzQf0FiW6TVyDXtbvM5zCQ79XT7lFXOkTPBUQlMdhlwwlWQ6v6q5tg
        H2Tjq9RvK2+YNXdY1nExs0IjWA==
X-Google-Smtp-Source: AMsMyM4H8QnSwlW6IcVx+JUwbRpqVlqLyMGDkTYuAaWwkqrQcnp4IgDSeK1kvYftUEuREMmNOnCdXg==
X-Received: by 2002:a05:6214:5018:b0:4b1:718c:26e3 with SMTP id jo24-20020a056214501800b004b1718c26e3mr7386970qvb.19.1664713850363;
        Sun, 02 Oct 2022 05:30:50 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bq36-20020a05620a46a400b006bb29d932e1sm7679700qkb.105.2022.10.02.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 05:30:49 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Julien Panis <jpanis@baylibre.com>
Subject: [PATCH] counter: Reduce DEFINE_COUNTER_ARRAY_POLARITY() to defining counter_array
Date:   Sun,  2 Oct 2022 08:30:08 -0400
Message-Id: <20221002123008.57922-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A spare warning was reported for drivers/counter/ti-ecap-capture.c::

    sparse warnings: (new ones prefixed by >>)
    >> drivers/counter/ti-ecap-capture.c:380:8: sparse: sparse: symbol 'ecap_cnt_pol_array' was not declared. Should it be static?

    vim +/ecap_cnt_pol_array +380 drivers/counter/ti-ecap-capture.c

       379
     > 380	static DEFINE_COUNTER_ARRAY_POLARITY(ecap_cnt_pol_array, ecap_cnt_pol_avail, ECAP_NB_CEVT);
       381

The first argument to the DEFINE_COUNTER_ARRAY_POLARITY() macro is a
token serving as the symbol name in the definition of a new
struct counter_array structure. However, this macro actually expands to
two statements::

    #define DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length) \
            DEFINE_COUNTER_AVAILABLE(_name##_available, _enums); \
            struct counter_array _name = { \
                    .type = COUNTER_COMP_SIGNAL_POLARITY, \
                    .avail = &(_name##_available), \
                    .length = (_length), \
            }

Because of this, the "static" on line 380 only applies to the first
statement. This patch splits out the DEFINE_COUNTER_AVAILABLE() line
and leaves DEFINE_COUNTER_ARRAY_POLARITY() as a simple structure
definition to avoid issues like this.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202210020619.NQbyomII-lkp@intel.com/
Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/ti-ecap-capture.c | 3 ++-
 include/linux/counter.h           | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index af10de30aba5..b8dbf0212a8e 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -377,7 +377,8 @@ static const enum counter_signal_polarity ecap_cnt_pol_avail[] = {
 	COUNTER_SIGNAL_POLARITY_NEGATIVE,
 };
 
-static DEFINE_COUNTER_ARRAY_POLARITY(ecap_cnt_pol_array, ecap_cnt_pol_avail, ECAP_NB_CEVT);
+static DEFINE_COUNTER_AVAILABLE(ecap_cnt_pol_available, ecap_cnt_pol_avail);
+static DEFINE_COUNTER_ARRAY_POLARITY(ecap_cnt_pol_array, ecap_cnt_pol_available, ECAP_NB_CEVT);
 
 static struct counter_comp ecap_cnt_signal_ext[] = {
 	COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
diff --git a/include/linux/counter.h b/include/linux/counter.h
index c41fa602ed28..b63746637de2 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -542,11 +542,10 @@ struct counter_array {
 #define DEFINE_COUNTER_ARRAY_CAPTURE(_name, _length) \
 	DEFINE_COUNTER_ARRAY_U64(_name, _length)
 
-#define DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length) \
-	DEFINE_COUNTER_AVAILABLE(_name##_available, _enums); \
+#define DEFINE_COUNTER_ARRAY_POLARITY(_name, _available, _length) \
 	struct counter_array _name = { \
 		.type = COUNTER_COMP_SIGNAL_POLARITY, \
-		.avail = &(_name##_available), \
+		.avail = &(_available), \
 		.length = (_length), \
 	}
 
-- 
2.37.3

