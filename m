Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D6557D1D8
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jul 2022 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiGUQqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jul 2022 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUQqM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2022 12:46:12 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E519387C00;
        Thu, 21 Jul 2022 09:46:10 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s188so2718731oie.0;
        Thu, 21 Jul 2022 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LF+4BEXgeX20FEYKll0oCoEu58JRyVpVfKo7D5sSEx8=;
        b=QaJVkk9hcWFTkEtwG/+eBy62Q04xBPngYZTh76RhgRj65YcIAaKuMwc8vKuAefHP/a
         Em67U2P6yMh7KLoVWlTC4JLy1YwJahm6I8SwmkgR29DBG/V5nA+tQgS2n9hK2OJWXZFY
         3IU+XgpUxX+MmdqE4c9ONFuqU17McZ3i6FQciajwuc+LhztcbGGmpBHfmoiswW2kiMe9
         lyvbBgsH0PENFzy1q3KsSWlbJlTO2mQUqbZF80c0v2oIvvxBgqMu/NcsGETM7st4ri8n
         +6vop45LBFeT+BzF5L6cXAeW80mXY46EPBQZF1K2ONtANhHzS4P5qR5LSZ4C75q9D7D1
         7mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LF+4BEXgeX20FEYKll0oCoEu58JRyVpVfKo7D5sSEx8=;
        b=z/ZRUC/zhCGWH4r0LPmwj53Wd8JcM/GMbxQUiqbp54NlfWqA840EQGchAFA5zFXssR
         eGGaKKOH/uK3LVeQEo57VZ+rOfIhvs30nbNJWvq6Q7wpXqTdXZmM76zrt7VeCUvmNvCG
         bJkWTqZXlwR2neSDXzMMAIE4IdGC05fuVc2RkI0O17kZ/2K9Jh+WhsI82ShsSMHLAwtr
         acD+fNrpXaqlTJu6hjv51L+q5sbEXYoe7MlSoAvThTidZH1vJu/VWMyFhqzaw8If1s94
         VsI0rnIzOu2Y97emZqX7/jWvnqN6u+ZgsHfVcrf3ecOIVmhIaMTOpSuJRaG/qMX2opvo
         j+gQ==
X-Gm-Message-State: AJIora8ODlbJClVaVWnXCoV1WHImf6vyET0TbUsPWaaelIVuO1f+6T+N
        w1Xzw5gPsAMx7ubH9sUFHTQnttBsRdU=
X-Google-Smtp-Source: AGRyM1sMhCFTUel0nZbimwZ5NIBDdcSf55m/zvlssEXpf9MpUwKfPSxogCGIG/aiw/gR31eCq+auUQ==
X-Received: by 2002:a05:6808:1585:b0:33a:653b:8812 with SMTP id t5-20020a056808158500b0033a653b8812mr4843650oiw.69.1658421969927;
        Thu, 21 Jul 2022 09:46:09 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id f189-20020aca38c6000000b0033a45705cb2sm831512oia.8.2022.07.21.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:46:09 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        contact@artur-rojek.eu, jic23@kernel.org, paul@crapouillou.net,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v8 0/3] dt-bindings: adc-joystick: add poll-interval
Date:   Thu, 21 Jul 2022 11:46:00 -0500
Message-Id: <20220721164603.13534-1-macroalpha82@gmail.com>
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
 drivers/input/joystick/adc-joystick.c         | 82 ++++++++++++++-----
 3 files changed, 68 insertions(+), 20 deletions(-)

-- 
2.25.1

