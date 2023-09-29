Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D137B38A2
	for <lists+linux-iio@lfdr.de>; Fri, 29 Sep 2023 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjI2RZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Sep 2023 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjI2RZx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 13:25:53 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFF01B4
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:51 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57bb0f5d00aso6062395eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008351; x=1696613151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7PDmHSczFeqgAzbimbZilruGj50u/2gIL6ZrFf0Suo=;
        b=tPqTfgr7eS8w94njpeNR2mA4fJMEkZl4vcBfgDwqGnY7WAt/hyF+JYt41g+LD1pjG2
         +r2w+dszYB7Ks63dx5V6O9uP/HLESAEZOdXe3bPB7xfoCyVMUGmL6LAnMVoOr6a/vLLu
         0tH1hmGkaGedT4jHw6xjH1rCqCTiaa5m6k1kesaRIS8LwFBHHkV1hoS/2JrJETGrpm/9
         ae7ivzQNuhvmStWtZVFxFXzNQWpeQDi1v/91KqGis/OpFPby4ixe6H6TAwLM68div8mQ
         msVXMafiXTHV691q71BE/bfySAr8eZJW0dCA9tRr0M8Iyu5xpdfKMoyUsObaNa87qztZ
         jkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008351; x=1696613151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7PDmHSczFeqgAzbimbZilruGj50u/2gIL6ZrFf0Suo=;
        b=hZVclaje+cPru4/R6SB2D8Zhr4JCiZYNO9IdIJc6wcAk3aH0eaAhPwzaJvX2Fw/d+s
         ATJkSzWA5GQF5UxSkFFY4AXLB6Cm1W4DNufGKZ4QnsS03E4vYTRXvLAmOzBR8se1CgEr
         WixGkbHmIjj5HuixecRf+3WQGIRQFKr3DrgvdCXON9sw+wsluye4jHSWqF9ijWs0xnAc
         ZkAPy3CpDqxRofb9QVZFmKiK3r9aocpyzM1e6KxUYWBAz7sxf6NBMQEzX4lw+yrCbtSc
         AoTRjkCC/QabSRVcK0qE/Mw4j5yhL2ha/7CK06ovlf364wSMBe58nNGmt1HWm0bK7x48
         gm+w==
X-Gm-Message-State: AOJu0YxSBOFg5WaPMyE0N6kb1ASEKujDRurjy0eR95EJYvvwEtqP7OYP
        T24w7KXL5+PQxN3jM5ogOHqWMjrNO065SpFsWLChRg==
X-Google-Smtp-Source: AGHT+IHxogutDZ1XLOIzr9/nOTx5KhbYFs+7hKsrWe7PtJOi6WwkLjfxiyyCL5MSgpTSmN6+IIr3og==
X-Received: by 2002:a4a:7319:0:b0:57b:3a07:181c with SMTP id s25-20020a4a7319000000b0057b3a07181cmr4656794ooc.9.1696008351082;
        Fri, 29 Sep 2023 10:25:51 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:50 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 05/27] staging: iio: resolver: ad2s1210: remove spi_set_drvdata()
Date:   Fri, 29 Sep 2023 12:23:10 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-5-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

Since we never call spi_get_drvdata(), we can remove spi_set_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* This is a new patch split out from "staging: iio: resolver: ad2s1210:
 fix probe"

 drivers/staging/iio/resolver/ad2s1210.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index b5e071d7c5fd..28015322f562 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -659,8 +659,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	mutex_init(&st->lock);
 	st->sdev = spi;
 	st->hysteresis = true;

-- 
2.42.0

