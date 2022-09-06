Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15E5AE3C5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Sep 2022 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiIFJEy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Sep 2022 05:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiIFJEx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Sep 2022 05:04:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C33EE0B0
        for <linux-iio@vger.kernel.org>; Tue,  6 Sep 2022 02:04:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qh18so21642400ejb.7
        for <linux-iio@vger.kernel.org>; Tue, 06 Sep 2022 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yJzALTHOqe6QfIve70YAaeVz9nTrBVF/M11ycFDNp24=;
        b=Owl86h5NR9ReQqMeW7GT73P3dQdBR/VZcA8FxJuxfflV8hFzauw8TySH5B7FsJBg7m
         PCyjKKUHWZ9WWIrRORwpSCc9Ivji7EmIa6gx1M9QaTUufhql8Bh+u5B+6hzhEwf73MBD
         dDeoWb2Dv5ZF5JrQBWmo6evRCi/jQN0ZldsTTyZpLL6vdZ6BgJQtruezX2fX7inDchga
         6SXNKwghFvbLUD9eveL5ztihgkAyTbRaAfhiR3jMy0gonGuaaZ8d7OqJLQw/NbFDmP0S
         cOr2BwJTjPajtEht9UZqiHwmssQ2M2Cf1bkeeFU4mzaMZ8VaILaqMzRxsF2ajx/rrm1X
         qWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yJzALTHOqe6QfIve70YAaeVz9nTrBVF/M11ycFDNp24=;
        b=UIUpI8pD1prQvX5q00Gnf08fQT/ArexOMk0IbHpkvbxQbXOz7nOSnUfBVnzN7ZY+Ct
         xiolCKtSm6w4zYG/+D9uvx1uPL/TOjPmhdmLiIWHwid4ZdTUq/nyId3tFjB06KPaLSWV
         B4CZXr2EwHRQMq6k1q8XNqu991Jr4dNCUa6cSwRTPtyknQU0QoBJuJ+a3XF8kU2t0xGP
         anH1URUtrQRqW1TpYz9QRgmkKHMsf9EiHO6i8FUYiluWIHOwGkmc9GvffqluHAG4vF1V
         igGkv0liKF09E0EFV1CzyAQXJiUbMPUB9q3iLkQ3oqUxko5RNe9mkUEQ48JAmjJyynko
         kthw==
X-Gm-Message-State: ACgBeo3SFpW/pFuAdgqdqyjnPHi8T6d4mWaUr2BW3QCALB/xxZSwUfNV
        d8GMHtL6KtFJ2ev/4IO3ev58OQ==
X-Google-Smtp-Source: AA6agR4kyo8ymwNi/buAaAyJGzBLg9A3uOBIj7OJzRib/Q9Qr8Ybqc8r07OCZ7BGQzb0/1Ms4Z6/2g==
X-Received: by 2002:a17:906:da85:b0:741:40a7:d08d with SMTP id xh5-20020a170906da8500b0074140a7d08dmr35269094ejb.263.1662455089627;
        Tue, 06 Sep 2022 02:04:49 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id b29-20020a50ccdd000000b0044ebf63d337sm1612531edj.57.2022.09.06.02.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:04:49 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Tue,  6 Sep 2022 11:04:29 +0200
Message-Id: <20220906090432.33841-1-cmo@melexis.com>
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

Crt Mori (3):
  iio: temperature: mlx90632 Add runtime powermanagement modes
  iio: temperature: mlx90632 Read sampling frequency
  iio: temperature: mlx90632 Change return value of sensor measurement
    channel

 drivers/iio/temperature/mlx90632.c | 355 ++++++++++++++++++++++++++---
 1 file changed, 317 insertions(+), 38 deletions(-)

-- 
2.34.1

