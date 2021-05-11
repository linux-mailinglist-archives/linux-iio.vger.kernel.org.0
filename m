Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12337A092
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEKHTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhEKHTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:43 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC52C06175F
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w3so28258882ejc.4
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42nRc1RoYbJhNJdFtPlhV0Uv4mwluFFOOWJNQT2V7xw=;
        b=iI1qpxJCMqx98GwvYhhavvuWFXAHqnZu78ocNVP23PAUS3z5/sd13wKarQoym3J1nL
         myo+991CNDs7udnQlhycuhf4VOVwYx10KVNY3N4FDS6fSw1xjd3MKT4GkipgO9XCEbiW
         yIqXpJj8CIphjXB1vYtDr1mYjgchtnWIq4kFvjmjPJKWhEGslnXNlHRjfTOUDiVO4gBq
         wOHigDkDyE9z3Pviil8GOi6+uT1YGiPbaEbKu4cx0Zg8mKBpefZX3syZQ/6CbRMCsk5b
         oTnFV0yKvuQJgDD+eY/kBolWjXVkukZgS27c+VQ4Sc6V7jIWhxLt3E1F/zuV3SAT20JS
         uIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42nRc1RoYbJhNJdFtPlhV0Uv4mwluFFOOWJNQT2V7xw=;
        b=l1Iy0UE7wrg44oqAcfN1vuPYkkIDRGm1s2ESB5Zt6pwXR5DCIt68svCd3PPrYSkVXy
         934qfOJBeWjX9bGKO6FuVuCB8FJNgWQtyDO82ho//E66q2osKIlIhr+qJSVJWs/2mqlX
         je7pMxHSk6YDa5C1hSU9Rm9G3ONNDN9mUXafgbIuEtQshdaKEzpVGCDiAEu9Uo6zOX2x
         6v34RWNFQh6CxvXV1nphY5AN9IddXr0NihnpLiNEqKEwhGp8xP3qQO5viKcWHJRV017T
         5XpW7AbweaxVRg8R35zMNz4HxJf+6BNi5WwT8Be3AyYudmoZTj1mP8aOAeGIMJmhioEz
         327Q==
X-Gm-Message-State: AOAM532yhGD95hVb64N3z+5T33JwnhIyobohHTpUopcXXcuV6TiZLm49
        UjeUB/MYaBTtlcp9dsky6b4Ah/QnIMShKyjX
X-Google-Smtp-Source: ABdhPJzlvKdO7Bp+YdLp+TiUkg1H68x4BQ7NVjZ9JuPeP23VFDaV5pngvVsxp//vCrtBBhhDTJGUIQ==
X-Received: by 2002:a17:906:3646:: with SMTP id r6mr30014424ejb.43.1620717515236;
        Tue, 11 May 2021 00:18:35 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:34 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 00/12] ad_sigma_delta: convert all drivers to device-managed
Date:   Tue, 11 May 2021 10:18:19 +0300
Message-Id: <20210511071831.576145-1-aardelean@deviqon.com>
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

Changelog v1 -> v2:
* https://lore.kernel.org/linux-iio/20210510125523.1271237-1-aardelean@deviqon.com/
* add my S-o-b tags on all patches; with @deviqon.com email
  - Note: I'm a little unsure about the correctness of these tags; there
    are a few mixed-in, with Reviewed-by & Signed-off-by; I'm fine if
    Jonathan tweaks these as needed;
* added patch 'iio: adc: ad7192: handle zero Avdd regulator value as error'
* all Fixes patches should be now at the beginning of the series

Alexandru Ardelean (8):
  iio: adc: ad7192: handle zero Avdd regulator value as error
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
 drivers/iio/adc/ad7192.c               | 94 ++++++++++++--------------
 drivers/iio/adc/ad7780.c               | 38 +++--------
 drivers/iio/adc/ad7791.c               | 44 ++++--------
 drivers/iio/adc/ad7793.c               | 53 ++++-----------
 drivers/iio/adc/ad_sigma_delta.c       | 82 ++++++++--------------
 include/linux/iio/adc/ad_sigma_delta.h |  4 +-
 7 files changed, 145 insertions(+), 254 deletions(-)

-- 
2.31.1

