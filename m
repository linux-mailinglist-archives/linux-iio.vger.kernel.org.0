Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493F458A0B9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 20:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiHDSq6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Aug 2022 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiHDSq4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2022 14:46:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4AB13D4D;
        Thu,  4 Aug 2022 11:46:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id h188so332962oia.13;
        Thu, 04 Aug 2022 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6kg5bbf+yuKwDqZS1i2LU6a4y1uhs2MkX9kilJ8lqVI=;
        b=j07/0MhrHdnmxyOHAFjVnLeURQ+kbU5oE6TijHRWz5RBZXG4g13XyvpK7vKUY2Yf+Q
         Bg1JKdxd3SUNbVP+qOgisy+6tElUZz9ZZRYBRURimCLybyX3LUIew/b7CI1gqAxQeqYw
         CxFsqTtaYozkHF5pmOf9+dNwOwXfHWf0deICDCdGo/02zlJlJb46Nq/DVzlonY6ZmDxb
         y5/e9HjVMKV5oQCtmXW5KYwQrF0L3di8IiBMGbrDDVs8PpehOAvQonGY7z9vNCKdVisQ
         aznW+PszOz+OKl9Bx7d+xV1Sf4XowuFB3Abf+EBOUrVDthUZGhATUjVOY/H8WCJFHZxv
         Tgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6kg5bbf+yuKwDqZS1i2LU6a4y1uhs2MkX9kilJ8lqVI=;
        b=v4DUee/kklaZ7E2uIVxq4YOEwUSHOVpEleVYFRIw2wWOD20wYF3juKijFHzXADQrnQ
         Jkb2TGDBfZmcXltKY2iSKDHwq+77b3lWVThX8g48exNk4E8yyMK5Jm7cv5HJhzqtPOeB
         JnDNfB/lvSfY0LOQ7FsPTR7qGG2oWrfNAsC0tWV97QXeOCr3+K1a9YI40NnTatGXonJZ
         H2QlI3y+SCQmZLWpOg8chTYpDbfbICmFGUE6+nvUzxKRCC74t5Ug7nDebze3kMoJOX+5
         aatr05E2MIXQDDsMbLYsBpFXyrB//bWdGYVIOVBmv/0Jufog88kRmRfqjagK4RtfVBtv
         XZPA==
X-Gm-Message-State: ACgBeo3hQxMaATJBxNmeV2h5CAiYe1eyKLEY2i1lTd7H8clEYTIzsliM
        6aFPWCcrF3ivghBBnNeOAYmGTj4sWUw=
X-Google-Smtp-Source: AA6agR4EDfMQhiSlYvN91Qsw8ua32+Uao3CIBtgkt+lwtyhsQqR7TfmnlZI9mE2cou0k8KM6xcSCyw==
X-Received: by 2002:a05:6808:4ca:b0:33a:7280:b90 with SMTP id a10-20020a05680804ca00b0033a72800b90mr4700570oie.248.1659638811317;
        Thu, 04 Aug 2022 11:46:51 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id p17-20020a9d76d1000000b00636a8dafdc9sm87945otl.2.2022.08.04.11.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:46:50 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v11 0/3] dt-bindings: adc-joystick: add poll-interval
Date:   Thu,  4 Aug 2022 13:46:41 -0500
Message-Id: <20220804184644.20710-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
  Input: adc-joystick - Add polled input device support
  arm64: dts: rockchip: Update joystick to polled for OG2

 .../bindings/input/adc-joystick.yaml          |  5 ++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  1 +
 drivers/input/joystick/adc-joystick.c         | 47 +++++++++++++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.25.1

