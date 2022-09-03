Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7968B5AC191
	for <lists+linux-iio@lfdr.de>; Sun,  4 Sep 2022 00:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiICWXW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Sep 2022 18:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiICWXV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2022 18:23:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5375072A
        for <linux-iio@vger.kernel.org>; Sat,  3 Sep 2022 15:23:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kk26so10276477ejc.11
        for <linux-iio@vger.kernel.org>; Sat, 03 Sep 2022 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RikyeRhtTjZQf6Z0LsrWIp4MCeNe6eLO0VxkuE+qkkA=;
        b=eIjuYfkQrDxnrBhwfjg4I9hBju/kaQWdcPKaO/xmz1BuUewAAVC861WDsOaZVOYMxC
         OZvMvtnVw/qLwo94/i4Ro4F2Frxyq2UcCFmQuCnNbUod+Yio689NFjW61yef0BOEs8DN
         5JM9AwHfm2sc1rNxFKyTZY+eILPYE4IU/gw5W3BYOv2cC/U5byrR4Fp2mp9FcWRB69WL
         benBRKbTkfdR1iclyXYz3qvroT8sPF/yTqEbadm7wyPjDSUFfT1ZO8bq/nNbAOViXFfA
         AtVWhDN3ClB0za8GEWc5NpE20mKWW6kXS2nDJG1OjPb0uWzp8Fr36o13XpHln9N3LNbh
         ng/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RikyeRhtTjZQf6Z0LsrWIp4MCeNe6eLO0VxkuE+qkkA=;
        b=Z8nvxnSkQ7+L/hdfT1nIHMIrC2R0bF5b76UyPmQJPvkZuQQa9rSNchT8s0NjzBG+3L
         qbzYL44/G4vENtW/rhNGUrolZvKUvuGCjI6RGhf+NIT/NvcPSG8KM1oziepfe33LaYAh
         d1efcNM7WpvDQ06JSg6BCoaxN99zM8lvwHbM80Rl1LPlO4pmm3gh5QKDFF3Q2lEq2npj
         TRJYMGrTW1isM6Lu+nbZySRnRONleExCS51o7/QIvluk5rG0iMBXzPpo0Ddj1NpFmrBf
         MLu6yDwgMw2ObbAf8maCYeJM9RnmDGrTqH7hIi+58GupRAbPwuhHGBb2+yRjS2YrjHmI
         rndA==
X-Gm-Message-State: ACgBeo0xQ/ATiz716juqTxdHIoXQKJeKX6CCpwCiQ4g+Um6DAciuSWSD
        eqoIGHz8BdqajQbaaJHZG3Y1xQ==
X-Google-Smtp-Source: AA6agR6GOIH/BsTE0X08m/aK8ufZqc8tFC0gEmADamEnmioH96FH76Mo3DJe9L4a1Y3NPU8eWia52g==
X-Received: by 2002:a17:906:cc12:b0:741:64ed:125a with SMTP id ml18-20020a170906cc1200b0074164ed125amr23073729ejb.713.1662243798565;
        Sat, 03 Sep 2022 15:23:18 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3sxu2v33e81l49.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:d4a:f526:3662:1129])
        by smtp.gmail.com with ESMTPSA id n27-20020a056402515b00b0043cf2e0ce1csm3788106edd.48.2022.09.03.15.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 15:23:17 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Sun,  4 Sep 2022 00:22:48 +0200
Message-Id: <20220903222248.3425902-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

As discussed previously on the group under the
"Controlling device power management from terminal" thread the mlx90632
sensor provides measurement capabilities under sleep_step mode. This
series runtime suspends the unused chip to sleep step mode to save power
but in case of continuous sequential reading it switches to continuous
mode for faster readouts. This value is hardcoded to
MLX90632_MEAS_MAX_TIME (with some buffer) and not user configurable.

The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
hardcoded to 3 times as much as MEAS_MAX_TIME.

Changes in v2:

 - apply review comments from Andy Shevchenko

Crt Mori (3):
  iio: temperature: mlx90632 Add runtime powermanagement modes
  iio: temperature: mlx90632 Read sampling frequency
  iio: temperature: mlx90632 Change return value of sensor measurement
    channel

 drivers/iio/temperature/mlx90632.c | 361 +++++++++++++++++++++++++----
 1 file changed, 314 insertions(+), 47 deletions(-)

-- 
2.34.1

