Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93C958AEA7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Aug 2022 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiHERK1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Aug 2022 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiHERK0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2022 13:10:26 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08CEE31;
        Fri,  5 Aug 2022 10:10:24 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l188so3315661oia.4;
        Fri, 05 Aug 2022 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=J2aqAhHaLkW3Qx5BaYjMFMBdw4pFhmtZO1kkyQm6rsY=;
        b=lyE4ZS4kcn7b5RhF+tqSVmuyD5YPHUnoN0W5wCU45vH0LJLAn/95l4lco2SCR8BMmD
         adAWFYTRSu6hkTRwqdT0Zxf0jJEvoJ57hrQ7Sc+tv3A94js/W6ayb809Ertbogwyyw7c
         eosIlNXWDjgkcgtv5zwU3SzObj4hYXjeYBq4LMITQ5LZ5g2/axBRXS8D6S+F7jviLVpF
         tHvZGtBiNbSeO5lzoH2s5kU1uHVN6d9MdDzUjY8BMkXc4YCbOj/o9MSX+qrEZEDNatHe
         6pTBd4Ns4UioP0CwE7hZHSj9BQHQ/XYjCqAZ2j1ieGWeaBhF7i4GWY1zzVqiXij+NiMc
         baUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=J2aqAhHaLkW3Qx5BaYjMFMBdw4pFhmtZO1kkyQm6rsY=;
        b=kEEWeMbNJpzPB6C99s0WBkActzthaWh+LkexQHS3RGJCWaa+cbYIf8ci4VA8pTufeX
         18x0GzZZmFgTEYQRR2/s1FRumuZtWTbJC6+rkc7SrhOEchKWAy6/pRiPYttzdvYq/hZU
         5GK91hXjY0O7aHTN0vzeRcpNpeZuXNevMz4rZOegwg3n3O7Iv+pF6Z7ab09Z5IfNWETm
         Sva+cSbJRPOg3tsTrDcHE5DQNe5fidfHsADoQ7gQsbRSyH80WQrY30iKLsuxq7sj+DHu
         7u7gbPbxWbGJbpKhOkxhlAqfhla//UBXIlD5ZtIBzMP/dnkjfq88uCRW5lufREeVFUnn
         9y3A==
X-Gm-Message-State: ACgBeo362QSMB4VoPfzuMGXcNSSwg+qs4/EpmDQ3gS8T2pfnOZqKBIC+
        P/ry4VTx9PqdjB0dWjaSKNWfgX/Zl3I=
X-Google-Smtp-Source: AA6agR4SC0GZpeyHkezGqib65Pn8NEFnAbJCZkPfReYSnoeNbCqg1Zr6VVEcq1PQzZWpU8xc/JMrLw==
X-Received: by 2002:a05:6808:142:b0:342:c8da:2643 with SMTP id h2-20020a056808014200b00342c8da2643mr991166oie.298.1659719423970;
        Fri, 05 Aug 2022 10:10:23 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r32-20020a056870e9a000b0010e046491f8sm794126oao.57.2022.08.05.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:10:23 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v12 0/3] dt-bindings: adc-joystick: add poll-interval
Date:   Fri,  5 Aug 2022 12:10:13 -0500
Message-Id: <20220805171016.21217-1-macroalpha82@gmail.com>
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

 .../bindings/input/adc-joystick.yaml          |  5 +++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  1 +
 drivers/input/joystick/adc-joystick.c         | 44 +++++++++++++++++--
 3 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.25.1

