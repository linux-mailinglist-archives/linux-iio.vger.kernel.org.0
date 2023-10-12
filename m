Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0B7C7246
	for <lists+linux-iio@lfdr.de>; Thu, 12 Oct 2023 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjJLQSn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Oct 2023 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjJLQSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2023 12:18:41 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23904D3
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 09:18:38 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1dcead29b3eso639928fac.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697127517; x=1697732317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ooAliJQ037M4eOVQFvZfagVJEv1KTU2SclkArpuWyC4=;
        b=eK35JLp+y158CfH1wRzgZ7O3989hYXqBIfbxSoZA0sLhfLnWtq2QgsSgELqbf5pTn7
         NWr/anSNdfMj4sV01wS8MIaSd2v6N1NNOa2SgkaUXazigcHoLTfNVBk4oVJlkYs/FCmu
         RPVqg81rhiUeFftHM1wb5+xQb6fWU574SeRKNl5R70NFDKh/oMMwCKoWV/LbQa/wAluH
         AMKPDDx/noGIUiDyWkgolWeV6AIZq7bLTzrcYwHWroEREJdGpLcERVTMM7ozOvtGia0g
         OyKw5iYNdcDC+TedpD47sr9WsVWjos4o3IbPzgUU8gM8e5P5rbVXHUgAxw/Ci8Mfl6g6
         sU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127517; x=1697732317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooAliJQ037M4eOVQFvZfagVJEv1KTU2SclkArpuWyC4=;
        b=vc+iUsR4MiZue8ocwAnI2KMLX2EcNpc2+0Bc/SJUgmVoGZVATRs7kuCkYaBrDwLhoS
         P41M038YRMdQN9TMUC6M+jGOV/BItSKPbiA4iX/GdZXj6Fp+cYkhRcuhgpZbpal4rcnd
         Vx7a90sjqtVetaE1X0oP8bgv7Jv+eHilK06lRxpOpYFL0xS91rFcx9Y/BoRprkMYjx18
         K49WzxL8Ojga+6q3s6HJFtPX52BxSAm+P6n0xwXHQxgGRZlEp0d7sEngDmoM/4hC/HQh
         DIOEkuGnOUGZva1s/4TyVvA2qErWvU2Wfvl6PIl8tXSHUUHJEO7P8ZWxqrGfOBgkibjw
         7PMA==
X-Gm-Message-State: AOJu0Yyw+wYvje3/H5xbv9gBdNK99YfBVKsUzib3yN8EVc4UHf6T3O57
        ZhqTBcVqIbYG5aATI9nDKjQvTD1fqfTFc6pW3Oj64A==
X-Google-Smtp-Source: AGHT+IGhfsaoo8siNOMwmrdcB94syobcfwea8ae5I+vCaw2DtZ9MEqnRBQMD79Fap8WSS7ctfAG+CQ==
X-Received: by 2002:a05:6871:723:b0:1b7:3fd5:87cd with SMTP id f35-20020a056871072300b001b73fd587cdmr28742966oap.48.1697127517298;
        Thu, 12 Oct 2023 09:18:37 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ob16-20020a056871761000b001dd63f65870sm414529oac.28.2023.10.12.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:18:36 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: resolver: ad2s1210: small cleanups
Date:   Thu, 12 Oct 2023 11:18:11 -0500
Message-ID: <20231012-ad2s1210-mainline-v1-0-b2ee31c0e9dd@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series contains a few small cleanups for the ad2s1210 resolver
driver following up from the previous series[1].

[1] https://lore.kernel.org/linux-iio/20231012092522.27ef48dd@jic23-huawei

---
David Lechner (2):
      iio: resolver: ad2s1210: remove DRV_NAME macro
      iio: resolver: ad2s1210: remove of_match_ptr()

 drivers/iio/resolver/ad2s1210.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
---
base-commit: 291e45eeeb901b1d22b74ac5ea48cab3c407c705
change-id: 20231012-ad2s1210-mainline-d80cc13acdce

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

