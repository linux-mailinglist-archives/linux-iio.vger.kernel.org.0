Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0216C7A9AAE
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjIUSr0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjIUSrU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 14:47:20 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C7EE84F
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 11:47:14 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-7740bc7ad68so105704185a.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322033; x=1695926833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KBlJtLtsdI3hK0QdaI1JvF2kBovJQMFIeF0KITJB/xY=;
        b=gQK6Ysrzp9bxmTYm5+Z7Pp9LOGjZ5WPfe6ibg7NDefFfJXGO019LD0go8zm30DK2t3
         yKk0/HZA2esW87EGoq2APpve9OTwr5PodSTGKLuupZ+9c2Il+mNl31/K9n0cNYoJWZyJ
         GES1CEMOeU+RapeJCNgKMOp61+N2gVI0uM1A0Zd1OBBVNcgH0BnOTnncwyoUa9mLkIDi
         6EXvSDcMliLSdNgfx95tT4dFPcI7MYOK/WBY3tcN7pjTc6UwuH+peuVNv2qR62Mkc+3x
         +xCaz4gWpYN9yu0rdIxeY3+TroFTxUbdBNW1r3kwZDGoS09ZZI6VnNvgqzI8gYbLEAHv
         Jswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322033; x=1695926833;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBlJtLtsdI3hK0QdaI1JvF2kBovJQMFIeF0KITJB/xY=;
        b=DrKH1R0ZZlNxd73NreOgcdLj8IRbQXgSP6Qq1b660olcLciKUz8QXvQ7s96Vg+nlOo
         ISg8n1WGmJrJCrloDKdOOKzeGXPPFZUtFFtFuVO1n/EzcErlvabDUxoecxjs9vWT9DTm
         C6Xm9+gE8hT2YGqeQKA8UdGkxPdmQeqpcUa+TwtL1u0FEQl8THvdwUiOCSdaWyn1osrg
         Rvd/3JgdqKwR8BJT4z3YSILVZxumAaINSnS7mea1J99eGilnyaEdpZ5ppB/VsqX8xpxW
         Q7Ay+TM5S7x8zFoM3mEccvqyvMYSro+ggpeBFKWY/lG0icwCzVrGwd9kgVPjWTMipejU
         FsPg==
X-Gm-Message-State: AOJu0YxTl1Dwp+QmeN/4a6PAqgMlQ9YvMBhoog//0Y5rgSFAj/QSb5xB
        2RzMXlnYhpBLBEev7uJ20Vnx9FG2Pg2/ePRObg==
X-Google-Smtp-Source: AGHT+IHI098EEpqO6htZ6MTc85xWWh3YpKsnqENPUYf7F/xvLGI92lITJbHV0USw1ADPIZbp1s0JkljinpuKkIaDuQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4082:0:b0:d80:1391:1f1 with SMTP
 id n124-20020a254082000000b00d80139101f1mr63208yba.1.1695272040719; Wed, 20
 Sep 2023 21:54:00 -0700 (PDT)
Date:   Thu, 21 Sep 2023 04:54:00 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGfMC2UC/x2NSwqEMBAFryK9tsEkw4BeRVzk05nphVG6RRTx7
 gZ3VbV47wIlYVIYmguEdlZeShXTNhD/vvwIOVUH21nX9dagblLiemIS3kkUmRf0KdY+O/tSRBN y777+k3MIUJdWoczH+zJO9/0A10IdAXUAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695272040; l=2097;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wxLohCJ8OZyT4ckFvNL/ySlACAagL4RRycYgRdRDcQE=; b=FJozEDATUZfUMAdvAUx5oyW6ZiVUThemIA/jnMSx8yNUj5AxeA4RjStYDSxol7J7+D4rXF5CQ
 KDXN5IlUqusC1qJ5YHBdUIOWRiGU0IIeYHvhB5gxVpdkMBQYmxwb0L3
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-iio-adc-stm32-adc-c-v1-1-c50eca098597@google.com>
Subject: [PATCH] iio: adc: stm32-adc: replace deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

We expect adc->chan_name[val] to be NUL-terminated based on ch_name's
use within functions that expect NUL-terminated strings like strncmp and
printf-likes:
| 	if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
| 		/* Check internal channel availability */
| 		switch (i) {
| 		case STM32_ADC_INT_CH_VDDCORE:
| 			if (!adc->cfg->regs->or_vddcore.reg)
| 				dev_warn(&indio_dev->dev,
| 					 "%s channel not available\n", ch_name);
...

There is no evidence that NUL-padding is needed either.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding. If, for any reason, NUL-padding _is_
required we should go for `strscpy_pad`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/iio/adc/stm32-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index f7613efb870d..9cdcf396d901 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2209,7 +2209,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				ret = -EINVAL;
 				goto err;
 			}
-			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
+			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
 			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
 			if (ret == -ENOENT)
 				continue;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-iio-adc-stm32-adc-c-1bf936a4ffbb

Best regards,
--
Justin Stitt <justinstitt@google.com>

