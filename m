Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097747A9777
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 19:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjIURYZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIURYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 13:24:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C740648
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:13:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-532784c8770so1463886a12.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316386; x=1695921186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWszhBlTWMiwkXqgF1w4h8oNmYkV0xe9wPBMJvnXBgI=;
        b=2cLamBgFbuV4oHtjQATBRq3H6ggxaukolIyxrg2Kug5+HuWoJa9IAo6zGyW5lne8oA
         TOOJLZkcBLSxKF16epf0YBSeXLb1w86upNK13/kMiEElXus15h4Bmi2QY6sCDNKEUH5R
         dVDYYG7h1Kd4PH37FW6F3y0TWMk20iujbsVKbzewGCl7zq6fFkE8gOGu1Gx4LzcvNU4r
         HNXR/GLLms+zWEN0Le5F3CbbyKgcpHsuLLN9YZHbSYgPQzpvqZGz4V7vIFPaoMZHcL2w
         EYTaRRkXGlet2prTKxluMuVwgEuj4QLQsRSL97TmWoWunhlvvU07u7p0LQvaohCLBXLq
         958w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316386; x=1695921186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWszhBlTWMiwkXqgF1w4h8oNmYkV0xe9wPBMJvnXBgI=;
        b=hUxjtuHXLmxAtQd2lIvXMf4XjsFk4FXKGPmW6c5jYAjwDC3w9vGkrp3vsInWRL5k2s
         fmOZU17gJNw97xnOQ5HnLzCUYkZZXh2cuaadtG+TIwIoonJYxbx7p6txFl1EO80UBLxh
         3flN/31XL6D4n3KnIHH7WKD9rJO7ioK+VxgPZZU2r/kHXZdb74D77qYONM8ZMEdXX5jO
         4BrI2NiKLyA87eMgBpyRfgjy6m53Ws9IC4zELbLQ0MgCsMcOyaEJCvW0N+vDBdKdWc45
         LPN8ZlTuD7Q1sH4qpUIdc1ygM7I+/jghxO7ISNTXaoKFpiZqkvtNHi177bRpncGl1lZ4
         az3Q==
X-Gm-Message-State: AOJu0YyG58+y2UMTQ6SDTmGtAqrjJiAlznfwrpCpw++wNvNe+hvUxKZD
        7Gj1mR4OwNtGQHpk+y0A6+Jt+jxz3kHxw9WhwCvssa2x
X-Google-Smtp-Source: AGHT+IGfS13FEnLVNfJuIWeRBxS2FNjPxoFFMDKS2aE22dbReCOydRtLnM6n0AwKa1SbUdaYxLP7RA==
X-Received: by 2002:a5d:4a82:0:b0:31f:ec91:39a7 with SMTP id o2-20020a5d4a82000000b0031fec9139a7mr5419502wrq.14.1695306154592;
        Thu, 21 Sep 2023 07:22:34 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:34 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [v2 03/19] staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault
Date:   Thu, 21 Sep 2023 09:19:31 -0500
Message-Id: <20230921141947.57784-6-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When reading the fault attribute, an empty string was printed if the
fault register value was non-zero.

This is fixed by checking that the return value is less than zero
instead of not zero.

Also always print two hex digits while we are touching this line.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 06de5823eb8e..84743e31261a 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -393,7 +393,7 @@ static ssize_t ad2s1210_show_fault(struct device *dev,
 	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : sprintf(buf, "0x%x\n", ret);
+	return (ret < 0) ? ret : sprintf(buf, "0x%02x\n", ret);
 }
 
 static ssize_t ad2s1210_clear_fault(struct device *dev,
-- 
2.34.1

