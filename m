Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C30455DAC
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 15:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhKROPz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 09:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhKROPz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 09:15:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EA6C061764
        for <linux-iio@vger.kernel.org>; Thu, 18 Nov 2021 06:12:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m27so26593675lfj.12
        for <linux-iio@vger.kernel.org>; Thu, 18 Nov 2021 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Or4AgXyW4tgl2yKbvbtrdnKt4RJ7VfsqFDnQl/vuTc0=;
        b=7D2x6Zw+zQCe/b4dFMjkLMGeg/ONrzRoCRRyI4h5ma2+YlV7tsKBCBXfdu9/h+qudn
         CA20OmsXGnLzEE6YvRwLEf3bjOqtMKU+PTQZYoUkfhF1lsOjDNPq8oVedIZwyz4xRx0t
         /k+uYxAW7Q2Bi8noo4cJPzB5XfpPqJL3pr/AYW+t47Pt/VhcT+TNtxq7TvDyH+x8rVAE
         l4wbFEP2yt/6AWekU5uml5vvNw0E2xu08mz12SzqB7PnNNtEoRUvbzodoFHHI8q5wl6j
         Gn/LSbKaPx0hyA85wZXz2JpeJLD8xR8anrxpRwMcP2HGWUav2z6MIUhIVfcUS29m+xFh
         TQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Or4AgXyW4tgl2yKbvbtrdnKt4RJ7VfsqFDnQl/vuTc0=;
        b=6iPzxdQ19B4aBV4a3ECT2oEHcHYw+L4k2ExNq8fbg6ASHS1GRVY+m0suj4Mz8Gh8Z+
         pikBgKvIlPFFDJh138QtVmC0VI2xqrauTSpm22u2Thb1c2swggtKQkgQbNCuz1Yc8S0M
         K+eV/xWB6BS+553OnN4jc0th64fZle+Xisqjwz4f6XEjGFifkhcpqKTky/HoKn7teIfK
         FAkUVDtRmdc7BH+qT6YV+i98e9Zk+4zDEm6VO53w+BrdNEzWGHLa/ef82El2Q4IGVBhY
         33nDwPJIedAhBGzniuokwNcLGBhDhx/tQxA5R/UJke/zh0ji4EnECb8KabyH7IMYzgGo
         sVPw==
X-Gm-Message-State: AOAM530/pPfx0cdDtZY3lm4a2EAi3E/hJ7DYbk08jMizEZ+M7bPTYtPx
        PgfsxCQd7AWRlnUjhUYeHaWxJ1xcH5eG9A==
X-Google-Smtp-Source: ABdhPJyghWKlwD40NYXvO7Wpmo/rE7eEgxm6PEby+PI/2Q5Arc3dROddVEFwY23331mAF7yf5pEk0g==
X-Received: by 2002:a05:6512:22cd:: with SMTP id g13mr23684891lfu.417.1637244772797;
        Thu, 18 Nov 2021 06:12:52 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.gmail.com with ESMTPSA id s15sm193634lfp.252.2021.11.18.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:12:52 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     linux-iio@vger.kernel.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Quentin Schulz <foss@0leil.net>, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/2] iio: adc: axp20x: add support for NTC thermistor
Date:   Thu, 18 Nov 2021 17:12:31 +0300
Message-Id: <20211118141233.247907-1-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Most AXPxxx-based reference designs place a 10k NTC thermistor on a
TS pin. When appropriately configured, AXP PMICs will inject fixed
current (80uA by default) into TS pin and measure the voltage across a
thermistor. The PMIC itself will by default compare this voltage with
predefined thresholds  and disable battery charging whenever
the battery is too hot or too cold.

Alternatively, the TS pin can be configured as general-purpose
ADC input. This mode is not supported by the driver.
    
This patch series allows reading the voltage on the TS pin. The voltage
can be then either processed by userspace or used by kernel consumer like
hwmon ntc thermistor driver.


Evgeny Boger (2):
  iio:adc:axp20x: add support for NTC thermistor
  dt-bindings: iio: adc: document TS voltage in AXP PMICs

 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  3 ++
 drivers/iio/adc/axp20x_adc.c                  | 45 ++++++++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.25.1

