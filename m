Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9FD560C47
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 00:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiF2W3t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jun 2022 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiF2W3s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2022 18:29:48 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E48D117;
        Wed, 29 Jun 2022 15:29:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z191so17426545iof.6;
        Wed, 29 Jun 2022 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoAQXdWUaz8OrO0OCG6RJCb3wGr8srIctcVYMB12eEI=;
        b=NVDqyS0eOJLQ5NsA3+OIVjsLLMtZOKl/ud+hCmRe+p7D7Lcg5lcBFKzWXp/VDN5Jim
         aDapMnvfLhk+vyhOZ71S3zB6B8+AAyGZgJdtzU0HEJ0KQKb//M6KFgBik/0DyKZMmJRZ
         pvAPQuEvo+URR4sovKdosuLp5xUUkxNxIGStHPc2hb2jNGOHcciYj8dcaPxueSyCo4ei
         r/oQ3vGh9J8aJNAr+bkcWHe6RT6HOAvKK9stfXUHw5dxxPqAXhv7Nw0e4GVqOx4PeyhM
         v/Rog8y58fikptWdsgWcibHQeR7zKZPmL1TmNLpAHmjaHF4sotwMCrEEqXzX3Z7jvEm3
         OfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoAQXdWUaz8OrO0OCG6RJCb3wGr8srIctcVYMB12eEI=;
        b=MfwwmWH0usYSRPbWs7zAiYny38/Ozg84O+pXDgGG+vJrfDzqeKc7yMa7UeuuiVzt2N
         QVIA6yHrzvsLHuZyuxSRppn+I3oGa5KEvVZQo3p8BIbiF9mPZ1yUN8uSQ7OJmi1P5fr2
         eJgTLuJbSbZDOmmBGdk1bJH9yYqeCSZUOWGuun7d3tYYcXDjjA6HWt9iep9KZc6+G61/
         n/x0m3LdkOhYIBBTwPcL03aFMcMX0bRvhE5C5ZTeJZrdo1jt3UvV/1w28MLD0I2rRHDl
         iGUv/YrHnO9cH9Ie1DoovAjlIAb4p63OHPgX/R+SoeNW/UZoEaayaNvBvDF1M7MneibN
         Ik3g==
X-Gm-Message-State: AJIora+Cwx4U5jT+52LcEnG8bTHa7oMR3xfR2QArORwJzmMgf+RFTK5W
        uAZOdqgXEmKeDQnSZt46EkKyROuEA9U=
X-Google-Smtp-Source: AGRyM1vub80+YVGQI4eCQTHu8RL9UP0Z1YsvY1kXSWXoi5x6P9ZNts9gfYmigUZfm023sIXmU8+kGQ==
X-Received: by 2002:a05:6638:3488:b0:33a:95f7:efa9 with SMTP id t8-20020a056638348800b0033a95f7efa9mr3192284jal.157.1656541786153;
        Wed, 29 Jun 2022 15:29:46 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:2d4b:b7b2:944:3519])
        by smtp.gmail.com with ESMTPSA id ca19-20020a0566381c1300b0033158c4a312sm7845597jab.55.2022.06.29.15.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:29:45 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Subject: [PATCH v6 0/3] adc-joystick: Add polled support
Date:   Wed, 29 Jun 2022 17:29:27 -0500
Message-Id: <20220629222931.30599-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to the existing adc-joystick driver to support polling
rather than relying on triggered buffers. This is useful for devices
that do not offer triggered buffers in hardware. Code adapted from
changes made by Maya Matuszczyk <maccraft123mc@gmail.com>.

Changes from V5:
 - Corrected an error found by yamllint in the documentation.

Changes from V4:
 - Added unit property to devicetree attribute making it now
   "poll-interval-ms".
 - Simplified logic for setting polled value and made variable names
   more clear.

Changes from V3:
 - After lengthy discussion decided to support with existing attribute
   of "poll-interval". If present, the driver will use polling and if
   not present, it will use triggered buffers (as the driver does
   today).
 - Corrected some lines to honor the 80 character line-limit.
 - Check return value from polling method and return early if there
   is an error reading the data.

Changes from V2:
 - Changed parameter from "adc-joystick,polled" to
   "adc-joystick,no-hardware-trigger" as it is more representative of
   what the driver and hardware are doing.

Changes from V1:
 - Removed driver compatible string of "adc-joystick-polled".
 - Added new optional boolean value of "adc-joystick,polled".
 - Cleaned up if statements regarding polling behavior.


Chris Morgan (3):
  dt-bindings: adc-joystick: add poll-interval-ms
  Input: adc-joystick - Add polled input device support
  arm64: dts: rockchip: Update joystick to polled for OG2

 .../bindings/input/adc-joystick.yaml          |  5 ++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  1 +
 drivers/input/joystick/adc-joystick.c         | 51 +++++++++++++++----
 3 files changed, 46 insertions(+), 11 deletions(-)

-- 
2.34.1

