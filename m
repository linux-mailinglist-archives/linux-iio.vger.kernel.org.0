Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A05AB223
	for <lists+linux-iio@lfdr.de>; Fri,  2 Sep 2022 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiIBNwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Sep 2022 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiIBNvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2022 09:51:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0C2138C94
        for <linux-iio@vger.kernel.org>; Fri,  2 Sep 2022 06:26:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c7so2296323wrp.11
        for <linux-iio@vger.kernel.org>; Fri, 02 Sep 2022 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yJzALTHOqe6QfIve70YAaeVz9nTrBVF/M11ycFDNp24=;
        b=eFgGQSodHUN4MdqbSOoaPRy6Ygqxtz0Yjc3JL0GXIySm/S2cj2nytxdq9aDHq5iq9K
         OW2WpoFBVAc125W6YSj1u1t2AE3n6cX5jfOCzg7EtBHKR0twuoXBHdTXcwg1GugHLVhf
         aM3c+epDVCAOBpW+o2VrTYXSQ9Ki+yWHomeBhTjHpBPYscuKXde7/WIAJkGqFV1/qavl
         zI/OPUD5Oe10jgW4TqCEkpDKxtQCsrQWsURZooKGO1KLOGs3LVHa7h6eFTefS1YxIVYf
         xoZ9KqLmSgj+LYZB4ygFbnbSwR0wQTQJiqBpN9R2YUBFtQq4V+tPUF1NQnPxfWVZtgUK
         KkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yJzALTHOqe6QfIve70YAaeVz9nTrBVF/M11ycFDNp24=;
        b=JMN3eWVPOiTpTugbrS6nMlTDxk5dD522KEctwqLkVuOfFdk1iCfhSGX/0HaEkuOE2y
         sIkqwV403aIF1Q4s1wplLSGdw71kGhZF1qatT7zKT2gujaIPn0ML6JgIiHR4g3+qs9Bl
         g0IWM0MzNZoo1EdbaUQDjOyd2FM6iieDjnJy+w4ZXjjsXYzXufal5XxDZ4TGUr8UWQuU
         40mYT8Am1jv2tJ3AOulP3vo2C6ZxPB755ONlIloAzbKHLSqLuGpjFGWD1lZEqwux+6k1
         2e69wxzBOJ2p0/jmgnaLJxzzddXG9JiUCymdxKWWPpzRpJIBGsw+b57DyAFWoECmYFL7
         +7zw==
X-Gm-Message-State: ACgBeo291nQxUx3DsXoxerTf/RRRT6ljspk5HbYxpdf5dBOXO+0jHtXj
        vjJD3Cal5BUCOf/R6c1wuR0Jaw5Y4b4WSA==
X-Google-Smtp-Source: AA6agR7rKNmnZfJhKmVwR5qy2gB0K/NDDZuacrO5wNDa9phlXV34WsFsTRZMZGPf0hlpMvmvtRt6Ug==
X-Received: by 2002:a17:907:7b95:b0:731:113a:d7a2 with SMTP id ne21-20020a1709077b9500b00731113ad7a2mr26274699ejc.377.1662124358992;
        Fri, 02 Sep 2022 06:12:38 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id gz28-20020a170907a05c00b0072b92daef1csm1243371ejc.146.2022.09.02.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:12:37 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Fri,  2 Sep 2022 15:12:10 +0200
Message-Id: <20220902131210.3316286-1-cmo@melexis.com>
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

Crt Mori (3):
  iio: temperature: mlx90632 Add runtime powermanagement modes
  iio: temperature: mlx90632 Read sampling frequency
  iio: temperature: mlx90632 Change return value of sensor measurement
    channel

 drivers/iio/temperature/mlx90632.c | 355 ++++++++++++++++++++++++++---
 1 file changed, 317 insertions(+), 38 deletions(-)

-- 
2.34.1

