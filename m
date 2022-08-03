Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B675891AB
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiHCRpT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiHCRpS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:45:18 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A1538A2;
        Wed,  3 Aug 2022 10:45:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id h188so20282756oia.13;
        Wed, 03 Aug 2022 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=U33QEtAVFZ9WBONCAogNuxS0ce9xhnWPOzdyVsxH0x0=;
        b=bcQobBJHeJBiCxoKffg10mMWAFy9RSuBGGJZNSQ+JpafpLjB9fdCz64Wyst2uOLPHD
         RlxG9duCb+2DU2lFHTF3Nooa+VoQWzWy15fVemQw/L48eM99QysYIbfD+DMpVxwsP0Ag
         wiUWrkxs3aDiXHMpivDZ4MOusAlE8a3/sUlL94hXB2D9Wub63267//g+0U0wiPay+IFC
         fLsronpM2quhKPd+SB91yw/zGl/013UWj/9xLP+KbzwowoXjb0xetwZf+cbr4iaIEYAC
         BNx/fZuzJaETuv8fgkD2tSbCPmNP68xRHSaEqiY3n9oDQWC9m0jLN615V+rWS6mf2Lgq
         ameg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=U33QEtAVFZ9WBONCAogNuxS0ce9xhnWPOzdyVsxH0x0=;
        b=KufzwYlAKLxCWiCUORDtuwqD1BO7wqc8dZ8SO0ahPYQe9ibTVjk2EXYxrh/mHxyuBE
         kgJXVTZcWrd3XM89PemVe4N/oFUGj0l7igB38UStGZtJ18sn71KcnX0F7aRDmqO4TnkN
         sKLrdFOfmcQWHEWjBvHXGm7EIx7SJPLr7wwIyO7TLHWVYfzcWAfi946eaRqCA9mM3Re8
         ar+4ZgnqME7fx4jKPBIxKdkK9QpG1m3wD+F1tgCACBEgUOlqldeJuD1zPbD9I3PoQjno
         IQIRGw+ICuWbXgxGHWQ2C37JwDUdT6rWttI3l9+drsGC4+izTi7fRvx4p1Iy6fXklv9u
         z6oA==
X-Gm-Message-State: ACgBeo2/JMlItmx5dnWMPVtX7BKEAGd+hqdfsjVcdNJ9yNh7hAc4Pyor
        QPmE1P0bIdO5aqZeSfJ7K+ITsS/mV24=
X-Google-Smtp-Source: AA6agR7XSMv89AxS2gmLUCvLhx/+m+uLOWwy80DBaa+xTe5Y+IhSdWrIFliawaRa1/vV440UbHgwdA==
X-Received: by 2002:a05:6808:14c7:b0:33b:3146:3475 with SMTP id f7-20020a05680814c700b0033b31463475mr2095714oiw.198.1659548715191;
        Wed, 03 Aug 2022 10:45:15 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id bx6-20020a0568081b0600b0033a6bfdc5adsm3551893oib.36.2022.08.03.10.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:45:14 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v10 0/3] dt-bindings: adc-joystick: add poll-interval
Date:   Wed,  3 Aug 2022 12:45:02 -0500
Message-Id: <20220803174505.21420-1-macroalpha82@gmail.com>
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
 drivers/input/joystick/adc-joystick.c         | 53 ++++++++++++++++---
 3 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.25.1

