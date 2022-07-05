Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07278567726
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jul 2022 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiGETEH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jul 2022 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiGETED (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2022 15:04:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB313E9B;
        Tue,  5 Jul 2022 12:04:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id u20so12005476iob.8;
        Tue, 05 Jul 2022 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bE5XBwBaUlDCGnXVs2nzLhFtfywgyruVY0VsAxP2lIk=;
        b=LjxAQ8lGVMo5FsqJ8NQU/tr5fdAsiUXWPIcLOydFT5+4oF1FTZ5CR+EvuX5JO42bpG
         nAqpzwLoNNvOQfXd4tj/BuymyFoQHKpWsWGpPNVpD3GZgAFoRVLIcSiOOBTcfW58D2gT
         uv2tXi0Mc2XHczl/CqchAx/03pFAacFvNpd3Zgv2lmwNfG3jSDmo+peU+5J/et1/b3pd
         tgCmyItRhXA0Uj153q2Abs1H8XG7Ip+iqQiUox3ZqeDd/ukf/Hd2VMEKYx4XoSjoBfou
         NWHYIoSdiPvr7gsHGNX3eQu14NJvAwU0B1BEdR4nHJMaFvWPOUfKObYT6bl5xA22YNK4
         AsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bE5XBwBaUlDCGnXVs2nzLhFtfywgyruVY0VsAxP2lIk=;
        b=DmhtDCiE31WAw/9QBl8PjuzfBUC0yGD7216QgB3yTFtLN131f7vvo9bEjSL7fu01EW
         7vu2ymZqWzIWRiusluO0AyqpGFOLWp4yymXSPAiA1kvgsZNhdgQH9hon2tvnd0FBotCM
         DTmMw3Byn4tz5zNoGBSE0/Odr0Ra5OBTMKTaUTBV3id1tO6TJ5O8cXbd7Dklx9bHMTuB
         kgGEYYqiICoHV70Kw4UdiGk5JKh9iynZKTlf3O+6jvvXzKM7p0SbeA5CAIQpJ+ff1Vfg
         aEDzN8PsGMbnUndswpwM8kO7atvzxpsBWx+ge0snu9bRx9qpvhrIC3UFkxq3EgO8rxAS
         UOag==
X-Gm-Message-State: AJIora8k0djFEYUkEmLngSFwiE3S+cV2z631N+uXFPFaCvhFfLip3x8Q
        x2jxy/duHjgXi9FNjdXA1HhZxmkQo08=
X-Google-Smtp-Source: AGRyM1s6zt8p23aX4BzTYowmkRQ8Xfa9qc8UtMN8YKEe8wuErmx7MF79Us7OxuAotW5km5abt6thkg==
X-Received: by 2002:a05:6638:2050:b0:33c:9bbb:82b6 with SMTP id t16-20020a056638205000b0033c9bbb82b6mr23191264jaj.147.1657047841257;
        Tue, 05 Jul 2022 12:04:01 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:a8dc:16da:96d1:2d19])
        by smtp.gmail.com with ESMTPSA id d93-20020a0285e6000000b0033efe01c20esm397762jai.42.2022.07.05.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:04:00 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
X-Google-Original-From: Chris Morgan <macromorgan@hotmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Subject: [PATCH v7 0/3] adc-joystick: Add polled support
Date:   Tue,  5 Jul 2022 14:03:51 -0500
Message-Id: <20220705190354.69263-1-macromorgan@hotmail.com>
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

From: Chris Morgan <macroalpha82@gmail.com>

Add support to the existing adc-joystick driver to support polling
rather than relying on triggered buffers. This is useful for devices
that do not offer triggered buffers in hardware. Code adapted from
changes made by Maya Matuszczyk <maccraft123mc@gmail.com>.

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
 drivers/input/joystick/adc-joystick.c         | 51 +++++++++++++++----
 3 files changed, 46 insertions(+), 11 deletions(-)

-- 
2.34.1

