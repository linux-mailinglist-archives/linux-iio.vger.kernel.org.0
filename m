Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8055EDB1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 21:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiF1TP1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbiF1TPG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 15:15:06 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E4B43;
        Tue, 28 Jun 2022 12:15:04 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l24so13815358ion.13;
        Tue, 28 Jun 2022 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9m4gexQ2D/itAcXABfaZwLk5xD720dscMb3Rc9hC+8Q=;
        b=LY6poTGT0ha65RVxskighJJdbYeUv+sRZhjqF5S7cEdJg5EWG1oj+LvThX0nrcpjDc
         08dK5lwhfzcrRHda7iUmqphoGB6WkNOjkOwEKIm5UObRADJ3OFL+WdR9Iz5RIfrHaPbd
         YsufQ5++r/iUUvRfX4x6uaLGvb6FxQszxEzXYYWylljK6UUzQPm3R39gCrioCt58/4CV
         MCLHzwmfdDt/r8tnTGSslKKWkoCDEuuufsZAgMykLRt8VyseSfnRXHt388yuXcm1epQw
         2SlU8Xjnw1eI8+uZ6twDb59nch1jv6+oSSraAWe/daKwK1bLiPcSgsI3mW9acbMM6InB
         n26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9m4gexQ2D/itAcXABfaZwLk5xD720dscMb3Rc9hC+8Q=;
        b=L+BajRNl1kxK7OUIyQVKo+3nfGvYjpJoPbzEg71IG6xrrw9C4V+akCKyOIKGWjWpVG
         35UqQn0QHvJrZkDipHeA+IFFVowHEtc/1y1cVLYo/FGL2d687lcal6zi4JSw8YEGA8YV
         VywAt5rlxZhPJFlDMIDNOXAuY7MwCxnDnuICuvkHEbJfpXbdB6Avh9r2e7cgy7pS+VLS
         UjDYtohMelt2W3swjDW1AWF1XX6pqq0EW3k+VU2VCe7JHfsdk3IiSWEIamfXPZme/eVy
         nqTKGdJuqWhX+gbflHMm8WwVxRq+vEAH18AVjJ/N0k+jkZGpxomNiKCyVZ6LvYYCw8Zv
         McBg==
X-Gm-Message-State: AJIora8h9+IdsRB0eAN4CT6nFUpIZETZk33/CAHveNV1mtsvd3uvJ5jn
        MHPiUtWa3lpcSd8qhXaiA7qqoysuHVQ=
X-Google-Smtp-Source: AGRyM1vqpsGuJgGKcokmS4JL3ptJlrC/Xk2mFhkhADIj5B3AXccvg9/P4u4PA6V4OdoQMccV5EPCQg==
X-Received: by 2002:a05:6602:3417:b0:65e:2fae:b371 with SMTP id n23-20020a056602341700b0065e2faeb371mr9920541ioz.98.1656443703729;
        Tue, 28 Jun 2022 12:15:03 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:5448:c223:9fa4:5f87])
        by smtp.gmail.com with ESMTPSA id c97-20020a02966a000000b0032b74686763sm6396009jai.76.2022.06.28.12.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:15:03 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Subject: [PATCH v5 0/3] adc-joystick: Add polled support
Date:   Tue, 28 Jun 2022 14:14:57 -0500
Message-Id: <20220628191500.69831-1-macroalpha82@gmail.com>
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

 .../bindings/input/adc-joystick.yaml          |  6 +++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  1 +
 drivers/input/joystick/adc-joystick.c         | 51 +++++++++++++++----
 3 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.34.1

