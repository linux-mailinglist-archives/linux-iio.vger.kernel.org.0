Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026CC55D0AE
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbiF0WOy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242401AbiF0WOy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:14:54 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76060DC;
        Mon, 27 Jun 2022 15:14:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p69so11085284iod.10;
        Mon, 27 Jun 2022 15:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8YqZKMnu5wFfAYg9KKwPbiYeb43yaP+RoJqTw94+ew=;
        b=o7yff7z0RiTZCe4SsxtEJUGOsiujoqFc8vkFuA7GehOJF+MNt6m8mQNYV7nGH9hhcU
         wodNt2xbZ7D6U+pteGrRRSDjwUdfGTi22C2sJ9k2k0eDANpC2+zAWb4FVNHFdE/ZVOQ0
         WUCLoBpL5R3A7A+bQjU9EQkKZCopyTphNAholVNTXOe1v7eVQyVlhHu7YGANnWooRNis
         7/Mip94mOIvlZgERChobMJNRTMw7E1P7W6uAQsg94iQDKB2aAUe+4ULxAeCr8Gt2KPgv
         +wXuj/t2zfiD6z52GaFLDCziLDmkQjUEKJFnoodXH7MEK8WwCynpW+yBLzI+1q8MaFwu
         U1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8YqZKMnu5wFfAYg9KKwPbiYeb43yaP+RoJqTw94+ew=;
        b=cEe1db0UCDelmQitsq+VpPIqB7S5YZgmLGGixdahzFXLJ0KUYhxFgenXwY0m1ddReH
         chMq/GV4WeuJ4xnMNtKNJW8eCXXMeE75Fn6e8JvStX6xRePLpzuxMpltWcHeXGulChUd
         vqg8+T9/dWZ1UbymGrLZ1oYwOFyd5O6qRZ1VNu05k6AlTtl0EM+cmV8wwmDWcHN8yoTL
         VI2Fuh3VHkMrjgRJPuqSzLjq6jmENPdpmxIpoii0N91/SSfL1in+eCsEZJpTJErS5SBM
         uJmAebJqi/xZUiKC2dpY0CP6jzem6nLPS+FkyysWbvaKMp9wAueG6vGl524K0+pfvDBk
         fNew==
X-Gm-Message-State: AJIora8dXwlFZKrodZ3xu5UE9AkxJPZ6lBLtV3Zl/94eBSXPfg+7xlYc
        hSRMosIX5dwFDLjYumVejg3Y4NN1o/o=
X-Google-Smtp-Source: AGRyM1smQ8WKzL9VAmB83IiGVy7A50zr1UpQGf81NWwuE/kN7d0OEPeGmRJo1rm9GQ719TG0bp1UiA==
X-Received: by 2002:a05:6638:1354:b0:33a:cc7a:d0b3 with SMTP id u20-20020a056638135400b0033acc7ad0b3mr9259829jad.163.1656368091920;
        Mon, 27 Jun 2022 15:14:51 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:7a85:cf35:f4b3:542f])
        by smtp.gmail.com with ESMTPSA id p7-20020a02b007000000b00339dd3976absm5255589jah.110.2022.06.27.15.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:14:51 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Subject: [PATCH v4 0/3] adc-joystick: Add polled support
Date:   Mon, 27 Jun 2022 17:14:41 -0500
Message-Id: <20220627221444.3638-1-macroalpha82@gmail.com>
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
  arm64: dts: rockchip: Update joystick to polled for Odroid-Go2

 .../bindings/input/adc-joystick.yaml          |  6 +++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  1 +
 drivers/input/joystick/adc-joystick.c         | 49 ++++++++++++++-----
 3 files changed, 45 insertions(+), 11 deletions(-)

-- 
2.34.1

