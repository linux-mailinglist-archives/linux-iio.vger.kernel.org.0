Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145127A9D48
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjIUTal (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIUTaJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 15:30:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC565AE24B
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 11:04:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503065c4b25so2110671e87.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695319492; x=1695924292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dbJ671h4+Zrpefl6Lm2RwGWdFjdR10s5YR4gHySBBk=;
        b=U9TJmf9tPRA8YXaMJ/Nn5ww/D+9eIqEIbk0UMZsz5i0gIvxJwCjYIclnYXJQGva6wX
         8fXOhKyRL45oShUUuFXlnbS3E+OgoNz9l6sD22dg+ltr67RmxF3AaxzCeGm6QEzsgJ1N
         H+M0QfAme2upb8gfGGlPgIdDi4mRr0bJsFi0qacvSdnkw0UZx5bYzvCBKgRlsAcNvLw9
         sWGiQNx+4cKotVeNqwuqDoO226HkZ59c/ViPxhvRK8l1tCPhmWiBPH5lKqMeBVaN4190
         NSQBj+LJvMDOo6Wh/0HZAolfjA2FR3l+YwNPWRtEx6peh+2M/zJtyN2/Wrz+ytYKBG0s
         nPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319492; x=1695924292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dbJ671h4+Zrpefl6Lm2RwGWdFjdR10s5YR4gHySBBk=;
        b=YTaDzuZssPEvoOxgGVmaYf9DTgWBc0wfPT93Zroyfvvubdm3RL6mCHYMxLsvyAfN+u
         e68dyerVh2DHf3elQTnDNyHZqeq8KJSvNMRmfV7YZBMsRm1cGyFU++iQAUEdEGecd6bH
         6OQBXXWY3ddfyAITHvfMjfJwCALmmVE9J9EzO3ud9sM3w7eSWk5fdJ2vayb852waEtDO
         /cP/bILKMcZE0P7ku2lj9iSpKwfKpZ2iHJcodPCNS56nqumuBRz0DsR/hjmn7ewEykuY
         HGRvlS9fLAj5Ub7/oatrkj+aIS6p6KOz0D4gRJYh6PI+ZOK2lUa8WquZWbjgd16jmspz
         T1BA==
X-Gm-Message-State: AOJu0YwRnuBB+iPrsHlJpLcyS0A7DZOkLPgQSPP9nve9sWDnM/8CeKpL
        4k+FNuPwpSCavwKuqKMhRKX2gtfeN/m5DiuZwR0FWdvW
X-Google-Smtp-Source: AGHT+IFl1Y1y2zMR1iNlW+1IiVeZ0qyN3wFDv4S8/6ruNMMK2i/+yZoG4piAY0plFw/WCYJXxcy+mQ==
X-Received: by 2002:a05:600c:152:b0:404:2dbb:8943 with SMTP id w18-20020a05600c015200b004042dbb8943mr5711734wmm.2.1695307452618;
        Thu, 21 Sep 2023 07:44:12 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:12 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 00/19] iio: resolver: move ad2s1210 out of staging
Date:   Thu, 21 Sep 2023 09:43:41 -0500
Message-Id: <20230921144400.62380-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Resending v2 with proper `PATCH v2` prefix.

Changes since v1:
* Address initial device tree patch feedback
* Drop "iio: sysfs: add IIO_DEVICE_ATTR_NAMED_RW macro" (related cleanups
  also dropped for now, will address in a future series if needed)
* Apply improvements as a series as patches to the staging driver. It is not
  quite ready for the move out of staging patch yet.

This series has been tested on actual hardware using a EVAL-AD2S1210 evaluation
board. (Note: not all device tree features have been implemented in the driver
since the eval board doesn't support them out of the box. We plan to add them
later if needed.)

One thing left over from the staging driver that probably needs more attention
still is the fault handling (both the fault threshold attributes and how
userspace gets notified of fault conditions). We considered adding these as
events, but the fault conditions are related to internal measurements in the
chip that aren't available as channels.

Since the chip is designed to read the fault register each time we read the
data registers for one of the two channels it seems like faults should be
associated with channels one way or another. Would it make sense to add extra
channels for the internal signals that only have fault events (mostly with
IIO_EV_TYPE_THRESH)? Or would it make sense to add a new "flags" channel type
where the "raw" value is bit flags? Or something else?

Here is the table of available faults for context. Sine/cosine inputs are
internal signals.

| Bit | Description
+-----+------------
| D7  |  Sine/cosine inputs clipped
| D6  |  Sine/cosine inputs below LOS threshold
| D5  |  Sine/cosine inputs exceed DOS overrange threshold
| D4  |  Sine/cosine inputs exceed DOS mismatch threshold
| D3  |  Tracking error exceeds LOT threshold
| D2  |  Velocity exceeds maximum tracking rate
| D1  |  Phase error exceeds phase lock range
| D0  |  Configuration parity error

David Lechner (19):
  dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
  staging: iio: Documentation: document IIO resolver AD2S1210 sysfs
    attributes
  staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault
  staging: iio: resolver: ad2s1210: fix not restoring sample gpio in
    channel read
  staging: iio: resolver: ad2s1210: fix probe
  staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
  staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE
  staging: iio: resolver: ad2s1210: use devicetree to get fclkin
  staging: iio: resolver: ad2s1210: use regmap for config registers
  staging: iio: resolver: ad2s1210: add debugfs reg access
  staging: iio: resolver: ad2s1210: remove config attribute
  staging: iio: resolver: ad2s1210: rework gpios
  staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
  staging: iio: resolver: ad2s1210: refactor setting excitation
    frequency
  staging: iio: resolver: ad2s1210: read excitation frequency from
    control register
  staging: iio: resolver: ad2s1210: rename fexcit attribute
  staging: iio: resolver: ad2s1210: convert resolution to devicetree
    property
  staging: iio: resolver: ad2s1210: add phase_lock_range attributes
  staging: iio: resolver: ad2s1210: add triggered buffer support

 .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 +++
 .../sysfs-bus-iio-resolver-ad2s1210           | 109 ++
 drivers/staging/iio/resolver/Kconfig          |   1 +
 drivers/staging/iio/resolver/ad2s1210.c       | 948 +++++++++++-------
 4 files changed, 857 insertions(+), 351 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210

-- 
2.34.1

