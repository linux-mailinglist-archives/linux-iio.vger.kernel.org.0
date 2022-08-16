Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD86596422
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiHPVEu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiHPVEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 17:04:49 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD878BD6;
        Tue, 16 Aug 2022 14:04:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so4479756otr.4;
        Tue, 16 Aug 2022 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hd8yc6iAzkICvQl/Lh1+nmP9sXsafYAx6xZmZA3Al+Q=;
        b=FDPA6gXF6v5o/ZYL1dk7r4KJIGhnXB1vexECJHynpfEUBlykflrpRSJYt99G6EMAfs
         NAdi4hNDEomPjVQ/oH3PhWqdlpZjVhslyTBTsI9okLajG/RSZLhrBCrsO0blkuxR5qa3
         V0UojOKdCgYcEi0DUeMvOnDO9ftQk2l3RXPARqhZBYVcSMgBLgK8LCwQvTm8wNVSXvqu
         s8fNl9zT0zWws9054r05SePehn/hxoC/zH8SOYyRWg63h2w2PAZiBKKX0ndSLtGwzrFX
         uN5U7V72Bfb8s4xAwT9azJtmeaM0XLQ22QPKSsu8ilkqqIiCYK5Dd/mkarY8I5auH1Zg
         ywKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hd8yc6iAzkICvQl/Lh1+nmP9sXsafYAx6xZmZA3Al+Q=;
        b=0ZsgGwdFDEMiUWK48ZHuxs677daVdSMvg0lrrvmzoPdQZNCp0A8q95gup4b+ONxxUK
         qvz1e7hMnrOmo8HX4LK/R1TwpCHoxQQB52ZwWd3cj6sijXdsKnYfC6d2plYewGTVo3tG
         TPnotuWntPIXYHHdFS4vZjjcCNs4L9kejY4RRPuq+iN71QatEBeZJIDlJjnjPlQE7GJ9
         CH7wIl8B2sU6IIb8y5E9IgcdNmZi3m2oaapdu9lnfKcYpcCLFNMKl7riqY7SpwdclW7B
         dvX5QwQHL7zfSYgFdDDfweWqNJReJ4Z6UosPO/KWBLoxSksF3SGeiVXIggXJCeLqj8Hm
         EapQ==
X-Gm-Message-State: ACgBeo2v4XixIwHi/gDDT4ZI4tKVk78Ggilry+Chv8WJXKGlAMsSoYYx
        mHAL/3hZJGAuviam/m21J1ngMCmPjKg=
X-Google-Smtp-Source: AA6agR6RdxrpkBItcav4v63NNIfn3SkQKsyzu5OnlV4DLwLjllSFZY/7Wq5HJUbKSKe4/n96PPFBrA==
X-Received: by 2002:a05:6830:910:b0:637:18dd:7743 with SMTP id v16-20020a056830091000b0063718dd7743mr8252968ott.226.1660683887590;
        Tue, 16 Aug 2022 14:04:47 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id m24-20020a4ae3d8000000b00425678b9c4bsm2599653oov.0.2022.08.16.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:04:46 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v13 0/3] adc-joystick: add poll-interval
Date:   Tue, 16 Aug 2022 16:04:37 -0500
Message-Id: <20220816210440.14260-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support to the existing adc-joystick driver to support polling
rather than relying on triggered buffers. This is useful for devices
that do not offer triggered buffers in hardware. Code adapted from
changes made by Maya Matuszczyk <maccraft123mc@gmail.com>.

Changes from V12:
 - Refactor for 6.0 kernel. This required changing the return routine
   slightly for the probe function as the input device registration
   has moved.
 - Modified error handling for checking the "poll-interval" property.

Changes from V11:
 - Remove additional unnecessary line breaks.

Changes from V10:
 - Removed two unnecessary line breaks.

Changes from V9:
 - Simplified skipping of channel checking logic.
 - Simplified return logic for driver probe.

Changes from V8:
 - Changed logic for checking channels to skip checking of storagebits.
 - Changed comment format to comply with Linux style rules.

Changes from V7:
 - Dropped acks from adc-joystick.c changes, as it has been altered
   somewhat since v7.
 - Improved checking value of poll-interval to ensure explicit error
   handling in the event of malformed values.
 - Adjusted logic to not check for storagebits if polling is in use,
   which allows adc-joystick to work in polling mode for devices that
   utilize a mux (such as the Odroid Go Super and the Anbernic RG353).
 - Changed error message and channel size comparison logic slightly to
   ensure code can fit within 80 character column width.

Changes from V6:
 - Reverted back to "poll-interval" after mailing list discussion.
 - Referenced input.yaml for definition of poll-interval in adc-joystick
   documentation.

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
  dt-bindings: adc-joystick: add poll-interval
  input: adc-joystick - Add polled input device support
  arm64: dts: rockchip: Update joystick to polled for OG2

 .../bindings/input/adc-joystick.yaml          |  5 ++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  1 +
 drivers/input/joystick/adc-joystick.c         | 48 +++++++++++++++++--
 3 files changed, 51 insertions(+), 3 deletions(-)

-- 
2.25.1

