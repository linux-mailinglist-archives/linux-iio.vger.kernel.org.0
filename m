Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5AE5AE3D3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Sep 2022 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiIFJGg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Sep 2022 05:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiIFJGd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Sep 2022 05:06:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D548E9F
        for <linux-iio@vger.kernel.org>; Tue,  6 Sep 2022 02:06:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id nc14so21659910ejc.4
        for <linux-iio@vger.kernel.org>; Tue, 06 Sep 2022 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ApCvKf3zMouc6AAO9enLRrRsW9rTa7FiMgUGsRYHip4=;
        b=pH3gGvUSPyHd/d/Bql7KLmqhrh4iGF4F0ZteFlG9Qx0TPal5X1Ct5YguvHhzg5js36
         OPO3vp6e3WvRZGr4FyETuGq5QeeHcy0LifNziAr5baIVX5yXqNOciz+Ik6rYDSh0/1+8
         xrOs0bUTtPcNZvuPgNPKUsC06tJ2EZh2evbQqadq/7Nja0m+++GwVtC/KAyxUWDP8IBO
         mGlDnQuH7O8OLrDmvLz0zeq/dF4YV1bMTQsZlxuCTPmFc910XpY4XM8thMZj/LZ7AWTD
         iBEGX5oWNNNn94FelgcThCmuMm1zseXLuBFLaYUt9gyz3S1qTciSFo2K9z7Av0hh0oZG
         QMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ApCvKf3zMouc6AAO9enLRrRsW9rTa7FiMgUGsRYHip4=;
        b=O7pIfabf66W85o5QgcQqc74JcT2UzgKw/iJT7Sqk3+9k5hlitkByD4AU9+ze6/jk30
         NSMfYysc01ZyoQmUFETPE9yv1rIhCcidwz20aly1yQFJBxNlX5mjN15JqkKrHbAEYdnR
         9xDEZWQfjHROfMWv0YqcK51yxLSKxxTHvgXzbFd+6kWFQKjsuvht3u5pfYkDsPI8YcpB
         1iAvl4yO/rztvxKTLip98gaUSsfwIEbXC+wFUbsWzmAVlst39p7a1NZX6SvDIRfj1MqT
         qroMuANMDAExMRHbOquKVrZGDdDk6tn1H7y1KN0Q2ABmmika6av/MMnef+0pGGgl3dBJ
         eh0w==
X-Gm-Message-State: ACgBeo1eX4urvpy8caqarC8T8HKK7dz5ho1mcRgqBBMN5iLTYaHwNOsm
        Kfk7DlNQJJGN2Fe04F52DlPF4Q==
X-Google-Smtp-Source: AA6agR60PpdOWUyNCjNiQPV55QXCUUhxETXPhy01tqt05CYPoTEYlW5+PtKr0uvRF4Xx0YsCZ7CjIA==
X-Received: by 2002:a17:907:3e0a:b0:741:4b9b:8d08 with SMTP id hp10-20020a1709073e0a00b007414b9b8d08mr32286606ejc.113.1662455190085;
        Tue, 06 Sep 2022 02:06:30 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906200a00b0073dc4385d3bsm6338600ejo.105.2022.09.06.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:06:29 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Tue,  6 Sep 2022 11:06:18 +0200
Message-Id: <cover.1662454215.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes in v3 (per review comments from Jonathan Cameron):

 - Change the "available" attribute presentation to more recent way
   suggested
 - Replace devm_pm_runtime_enable with enable and devm_add_action_or_reset
 - When suspending device also put it to lower power mode in case there is
   dummy regulator
 - Use more switch cases instead of if/else

Changes in v2:

 - apply review comments from Andy Shevchenko

Crt Mori (3):
  iio: temperature: mlx90632 Add runtime powermanagement modes
  iio: temperature: mlx90632 Read sampling frequency
  iio: temperature: mlx90632 Change return value of sensor measurement
    channel

 drivers/iio/temperature/mlx90632.c | 400 +++++++++++++++++++++++++----
 1 file changed, 354 insertions(+), 46 deletions(-)

-- 
2.34.1

