Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A158137D368
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbhELSV7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350504AbhELRvF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:51:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07AEC0613ED
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:49:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v5so17014068edc.8
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CF6JaLEsr4bT8+QMif5jPEHXEsPl26FZvVRFcuOkwc=;
        b=uOBsu1XrTiZAwShcaOMcffKTDx/Ophnyzam9nkJ6oEg55xrsCEksPt88yeaVa3Ovqt
         2/SRVcnxMhYkX8I+aQHAHvvVHAEERH9RqzuRChVR45Vb8nLFAY4b+mPf7n0P6R/yAhnY
         La735GzTyGtprzS0GPLMFfXKxBsaYrUiQYIoBEOQCf8s44lJxk6UUHMuxCQr4/fwjl7n
         84f5uecYvko4pNv+RgrtmFDbLWXd2F1AS4LzNxHRZT+wE7DwWFrDOb5ytKsewOqZmC8m
         GFh5Ff8BKcz6x7jBJHc47fz8x21FoqGJA4SiGAe4LyjrqMZ600q6hfvYcyE+DNN7vvG2
         WjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CF6JaLEsr4bT8+QMif5jPEHXEsPl26FZvVRFcuOkwc=;
        b=nzp52NH7hqZaYfrXx6cHyUf2BsNGRlHlePgwZ8aJZmV67pxa66ya8On+GFqqPj83tv
         21MfPcYHOKiBb5nHR7f2YZBzYtzdMFKjPUD3ZsJggPvVn0ZcG0bntFkPWFToAYJuJl0N
         jqE+nmy/xk0At3u8NuUu10H1y2MNTazj9QFVxZRb5SB7H40jawf1I7KgBCexwvrYHJZ4
         bZc8iLAp11ucQEijt7SzU0CRzR7roRhAdwK19dteBAjJj4/MpJ+uwJFXhxwV2BciefpP
         7XV/XSP/mir5YYWu6K84IqJjaIdI6HfNSj94bAWJylHAr2Nm263ta2cg2/mJcRLn+6uZ
         EXEQ==
X-Gm-Message-State: AOAM532xELjb+NGY41IDqKRV+egWQnlGEH0eg7+qAoNfyXouIqYPML1Q
        JEC+LVfZ04wUqifriKXq5qE1dkkp04t7OQ==
X-Google-Smtp-Source: ABdhPJzy+ZctiG/CuSRiDfEFPWdzDWwJlut5GCbXDpDUdtanYQzxV0aXnNO3mPgLQRGnzdTtFbtu2g==
X-Received: by 2002:aa7:dc54:: with SMTP id g20mr45080155edu.266.1620841795330;
        Wed, 12 May 2021 10:49:55 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:49:54 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 00/12] ad_sigma_delta: convert all drivers to device-managed
Date:   Wed, 12 May 2021 20:49:02 +0300
Message-Id: <20210512174914.10549-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Well, for lack of a better title that's what this series does.
It merges Jonathan's patches from:
  * https://lore.kernel.org/linux-iio/20210508182319.488551-1-jic23@kernel.org/
    Patch 3/3 was a polished a bit with my comments from that review and also
    to use the devm_ad_sd_setup_buffer_and_trigger() function.
  * https://lore.kernel.org/linux-iio/20210509114118.660422-1-jic23@kernel.org/
    Added only to base the conversion to devm_

The AD Sigma Delta family of ADC drivers share a lot of the logic in the
ad_sigma_delta lib-driver.

This set introduces a devm_ad_sd_setup_buffer_and_trigger() call, which
aims to replace the 'ad_sd_{setup,cleanup}_buffer_and_trigger()' pair.

This helps with converting the AD7780, AD7791, AD7793 and AD7192
drivers use be fully converted to device-managed functions.

Changelog v2 -> v3:
* https://lore.kernel.org/linux-iio/20210511071831.576145-1-aardelean@deviqon.com/
* patch 'iio: adc: ad7192: handle zero Avdd regulator value as error'
  is now 'iio: adc: ad7192: handle zero Avdd regulator value'
  essentially just doing a simple 'if (voltage_uv >= 0)' check now

Changelog v1 -> v2:
* https://lore.kernel.org/linux-iio/20210510125523.1271237-1-aardelean@deviqon.com/
* add my S-o-b tags on all patches; with @deviqon.com email
  - Note: I'm a little unsure about the correctness of these tags; there
    are a few mixed-in, with Reviewed-by & Signed-off-by; I'm fine if
    Jonathan tweaks these as needed;
* added patch 'iio: adc: ad7192: handle zero Avdd regulator value as error'
* all Fixes patches should be now at the beginning of the series

Alexandru Ardelean (8):
  iio: adc: ad7192: handle zero Avdd regulator value
  iio: adc: ad_sigma_delta: introduct
    devm_ad_sd_setup_buffer_and_trigger()
  iio: adc: ad7793: convert to device-managed functions
  iio: adc: ad7791: convert to device-managed functions
  iio: adc: ad7780: convert to device-managed functions
  iio: adc: ad7192: use devm_clk_get_optional() for mclk
  iio: adc: ad7192: convert to device-managed functions
  iio: adc: ad_sigma_delta: remove
    ad_sd_{setup,cleanup}_buffer_and_trigger()

Jonathan Cameron (4):
  iio: adc: ad7124: Fix missbalanced regulator enable / disable on
    error.
  iio: adc: ad7124: Fix potential overflow due to non sequential channel
    numbers
  iio: adc: ad7192: Avoid disabling a clock that was never enabled.
  iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop
    remove()

 drivers/iio/adc/ad7124.c               | 84 ++++++++++-------------
 drivers/iio/adc/ad7192.c               | 92 +++++++++++---------------
 drivers/iio/adc/ad7780.c               | 38 +++--------
 drivers/iio/adc/ad7791.c               | 44 ++++--------
 drivers/iio/adc/ad7793.c               | 53 +++++----------
 drivers/iio/adc/ad_sigma_delta.c       | 82 ++++++++---------------
 include/linux/iio/adc/ad_sigma_delta.h |  4 +-
 7 files changed, 142 insertions(+), 255 deletions(-)

-- 
2.31.1

