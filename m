Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D017437F779
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhEMMJx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhEMMJJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1A6C06174A
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c20so4122151ejm.3
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AN97NCj3eyvmEj45BFIuT9uvO8IkUB2UbSSyCQn8Ghs=;
        b=tEx6qYEor3OyFWaQgEUDBFivqR6GNXeHbrQwOymPBF1ZsUBVw7XmlkwLTLEa/Jr6SG
         6xXLeHtfZXMEh31mWXIiUBBYc82I7eDlPWrG0s1tqWNhdTttNk7A4JFvncP+nn9P1ifh
         JDYdhtCBdZfrrCQ+wNDo2BOWMycTA8diYsNzHx75pgzxj2017Nwp/6U4gt5z1bGADy0q
         qAylCQbSF8guSIgoYc8xIB8m6iPHAehp1uWQbBjTHp03/vQ3pPhD2Ho1TOwIMiF3n8tO
         jDuWAhrPtaQdY4tEcCA0tDsRlPwZq/miX11alcAwAQqBM1x0bKMdbXGQZET9U13Elgnj
         cwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AN97NCj3eyvmEj45BFIuT9uvO8IkUB2UbSSyCQn8Ghs=;
        b=FJBqn1PKZzgYOFs2KBOAOmOxbKvvugnawZvgJIoSIOTskJXOGaEko50XfE2y1p4cO/
         8kNp3k7Tix0+oanIHQOPijyBou7rrbBV3swEo5zOTcilK2g6euWeDU62vfvrMioYhV6M
         IUex+Od94LkaZ+Yr5fGXwl7ExWbWAUMElbYnnAPlxMGaqk7R4RSSSaSv1Io28x/W69pi
         46weEOb/zhE8YDHQb6p0yMB0kSYPAzCdUp79TcJ7HoOZ0NdflH5J9rXN0f4gjGnIEiQQ
         31hnEdAlNYMQr1BFbIgmHMmtg4wQiDdBoI6hZj7PxR5r0zDoav8zy2iAPb/vqdYFEvqz
         gg1Q==
X-Gm-Message-State: AOAM531P2f2BqfcddwmQakq8+CuY9tVvMVwbM5FdMYlRSyu8D6F1zQAh
        JfTCJ4d0/aJX9NK8uJsbUwmUt83NJKEPUA==
X-Google-Smtp-Source: ABdhPJwXrvl6/wqfYK1LxNxWtGb9h1LLHpAch6sGCil60LnfuskQucPhvPqFdFXolG4BP/lMFERejQ==
X-Received: by 2002:a17:906:1399:: with SMTP id f25mr5940122ejc.29.1620907678519;
        Thu, 13 May 2021 05:07:58 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:07:57 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 00/12] ad_sigma_delta: convert all drivers to device-managed
Date:   Thu, 13 May 2021 15:07:40 +0300
Message-Id: <20210513120752.90074-1-aardelean@deviqon.com>
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

Changelog v3 -> v4:
* https://lore.kernel.org/linux-iio/20210512174914.10549-1-aardelean@deviqon.com/
* patch 'iio: adc: ad7192: handle zero Avdd regulator value'
  is now 'iio: adc: ad7192: handle regulator voltage error first'
  - now checking the regulator_voltage() return first for an error

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
  iio: adc: ad7192: handle regulator voltage error first
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

 drivers/iio/adc/ad7124.c               | 84 +++++++++-------------
 drivers/iio/adc/ad7192.c               | 98 +++++++++++---------------
 drivers/iio/adc/ad7780.c               | 38 +++-------
 drivers/iio/adc/ad7791.c               | 44 ++++--------
 drivers/iio/adc/ad7793.c               | 53 ++++----------
 drivers/iio/adc/ad_sigma_delta.c       | 82 ++++++++-------------
 include/linux/iio/adc/ad_sigma_delta.h |  4 +-
 7 files changed, 144 insertions(+), 259 deletions(-)

-- 
2.31.1

