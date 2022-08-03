Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD25890E6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiHCRB5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiHCRB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:01:57 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBA44C613;
        Wed,  3 Aug 2022 10:01:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso12601394otg.1;
        Wed, 03 Aug 2022 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=iJl4X36HtyTkZD+c4eijIYBpyLNoW0JsRAFNsCQPmJg=;
        b=nMeEaGjycSRgB+mLK/tZKvkmtwy39GWdUsihWxNA53RUzktrH4XkuF4xfQU5s0XieG
         EATnMcw32cpbGLDwAcWqK0E/uHv1Jf9hi715EPKPYQSDxZ+nf+dh6I4y2h3CY8/4qzVJ
         MOXMxYqYeRK3wqgylomwSlgh3/I3nuSJhxe06B/5+V1f6PtIXQaZHGi/Q72ExGE891XW
         18Q8kqf8VyrvxLOMAZzWnivC6v2V1IFwTKF6b9zuLPBH9xH5rxF73aQm9MN0ROUsGUhD
         ddX5mAgWSpWkpGu26I3l+LtI8XDjT0W4MJ+xr0K3eWGO5zxQH4o0Ol8L4+z+RmZysud5
         XR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=iJl4X36HtyTkZD+c4eijIYBpyLNoW0JsRAFNsCQPmJg=;
        b=6jyNEX6hGWbrSc2aUr4K2l6xvlzs8iKJf6ls6B0gqoIrxNf19b4EIkyzYhJIw10PMB
         CA/kPT+jRlLW5cSGez1njumOrCm95tmSaGPce4b5PG7qiZcR/EUOl+OAvIm7PTkX3RiJ
         8j0blMqXxeRyUuZZLivtS6/elFtLbAs2icVoSMSAGEl4Rv0IhpAl49TRIrPoo9z9u6o9
         6JVwWIVwEzg1eDcdXVF3nCdG6Q4SkjWnCpAuDIhCDc9u5iQRAthif3lKbCWeX+KmCcA/
         I08DMdx3+dCor0Ej1qNFofHuSo61PDEvRqGo/FARkh1qyh/tlQ+cWgkeYmBX59yFMryc
         Tjpw==
X-Gm-Message-State: AJIora8Jm6nIidWhatQD+KdulNegowk0Lw677jtqYiQ0blwYf79nHMjZ
        ROvMoQwBaKjyatR5xGwl6bgsSwBJ6eU=
X-Google-Smtp-Source: AGRyM1sGS+6qsZVYTzjiopcDzAOwALCbVGCVlrFqObFuEDvdmTVbJxYDZjRCQ3aJMK6x7+rZomgGfw==
X-Received: by 2002:a05:6830:310c:b0:61c:c2c2:f9c7 with SMTP id b12-20020a056830310c00b0061cc2c2f9c7mr9725428ots.61.1659546112605;
        Wed, 03 Aug 2022 10:01:52 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id q16-20020a05683033d000b0061c29a38b3bsm4088453ott.33.2022.08.03.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:01:51 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v9 0/3] dt-bindings: adc-joystick: add poll-interval
Date:   Wed,  3 Aug 2022 12:01:42 -0500
Message-Id: <20220803170145.16186-1-macroalpha82@gmail.com>
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
 drivers/input/joystick/adc-joystick.c         | 69 +++++++++++++++----
 3 files changed, 60 insertions(+), 15 deletions(-)

-- 
2.25.1

