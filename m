Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5E6367B4
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiKWRyk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiKWRyj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:54:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B073165844;
        Wed, 23 Nov 2022 09:54:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so2507498pjc.2;
        Wed, 23 Nov 2022 09:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jn5MZcNh2x03wcluRihWf/zpmE/+RC3E3wxSqrYuECU=;
        b=XgY+YonMSrw3Jz5ILqJxJY3pwwBDrqgmMg7lExUiJdp4S+QNJq2lIsNmgFOSumeO53
         2sLqeIv4fR2LCygE9qjR52R/lg6Rmk1I7hU7a0kkPhNuPBbq5r0n1reSonBZcaZQDfNZ
         Au4Ae56/mSvXYMeP2aUUhJUZoW+wszaNmk3GTNzGencEu3us0+M6jSaZlI/vlM9f0ylJ
         wMouRrdmo5lxaXdq1QoiIvF04/EkTH0u4NK2l7YJX6y/PZaEVQnIiwGke2gE5HqrGEC+
         5X4Qkh4HuGUz9z2rLxA4QFedTVZuTyzdjHyu3DGCqzB0VWB025keUsOpPJ6MtWlwrHRZ
         f//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jn5MZcNh2x03wcluRihWf/zpmE/+RC3E3wxSqrYuECU=;
        b=DYoY9J7+rIq1B+oUOpaSX/Wn/72SpF5nEgSiFxcb8tV5lIhC/TNuysvzRSU4+/yYUv
         GN77yNEkSjWwK0O6opPzO0OGJBOfibyqQE0tXfXxmD5sO1vMkmGDRczkAucES/BkLp+k
         tQfrhymgVyQ+mLawda7HsMB8r599n/F+/KpgiHIHsI0luM/gIJ5u9AGCqZN/zHBs9QvV
         obHfdba2mAgdJdtYxLhFHfsdm3+vRPmkDiWbiFfN8v8rGY/imRrEmaauN0VoUdtV2w7f
         f7jtaTnKuXoQBsnTo5DH60HfwCDmYMAtB3UGEsrvbCjj9XXddlTS2AcDU+paLSxqRmra
         E8tg==
X-Gm-Message-State: ANoB5plV6CUSRKqPV6pTtKDDRxC0hChHVrJhcigwi6NzAXwYDMzZ9+OR
        jezMNFKvcBDXRGYajtvo+ZKMOK6mGJU=
X-Google-Smtp-Source: AA0mqf5ZmsFRAn3ynNCYOWBprdM0Zoj6Lsc0Obskdvrh3K/x0aBaL/MLh+4L1CRBj3W16kZzahobGg==
X-Received: by 2002:a17:90a:4c:b0:218:b187:d7da with SMTP id 12-20020a17090a004c00b00218b187d7damr16344674pjb.68.1669226078191;
        Wed, 23 Nov 2022 09:54:38 -0800 (PST)
Received: from discovery.. ([2401:4900:483b:e422:60e:77bf:baa2:9d8b])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0057470a06694sm837503pfb.40.2022.11.23.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:54:37 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 0/7] Add support for mp2733 battery charger
Date:   Wed, 23 Nov 2022 18:54:18 +0100
Message-Id: <20221123175425.564042-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes in v6:
  - splitted chip id to v6-0003 and support of mp2733 to v6-0004 patch
  - fixed commit message English grammar

changes in v5:
  - fixed commit message on v5-0002 and v5-0004

changes in v4:
  - fixed attributes groups review comments in v3
  - added new bug fix patches v4-0007 and v4-0008 

changes in v3:
  - fixed dt_binding_check error
  - fixed spelling usb->USB

changes in v2:
  - fixed spelling
  - revert back probe to probe_new in mfd driver

add support for mp2733 Battery charger control driver for Monolithic
Power System's MP2733 chipset 

Saravanan Sekar (7):
  mfd: mp2629: fix failed to get iio channel by device name
  power: supply: fix wrong interpretation of register value
  mfd: mp2629: introduce chip id machanism to distinguish chip
  mfd: mp2629: Add support for mps mp2733 battery charger
  iio: adc: mp2629: restrict input voltage mask for mp2629
  power: supply: Add support for mp2733 battery charger
  power: supply: mp2629: Add USB fast charge settings

 .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
 drivers/iio/adc/mp2629_adc.c                  |   5 +-
 drivers/mfd/mp2629.c                          |   7 +-
 drivers/power/supply/mp2629_charger.c         | 229 +++++++++++++++---
 include/linux/mfd/mp2629.h                    |   6 +
 5 files changed, 226 insertions(+), 37 deletions(-)

-- 
2.34.1

