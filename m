Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A0775B711
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGTSuC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 14:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGTSuB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 14:50:01 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D591705
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2023 11:49:59 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-79969c14964so417880241.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2023 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689878999; x=1690483799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6XfvdHY9gNi/Uu7IhnorruW0FyEO0Ku4CqZNScjR64=;
        b=sCSCkSppg3ENYqk0iHc3Cj82UbMlQfniH3E6jeIUP1xhmA3KjIJHhehiAtfqi9Jr1R
         CwkBmkI5eSYsCoYqMN3DmyAUg67w9DovMExgDHLFIn693HxRbz35DO+g/MbVOSOetVRt
         As6/FCxqmc9QWKQ9Hlc29xLgHHIwpalk5QLc+ueXNSKCo4pa8rVgppMEzMbAhJrd6V0y
         IidGHVDuQuF7GLG6VnOFyIUxoOOhYS2dvYboyz9gnKB6TqrH+VBctmtjuQo92qcYumZe
         IdJ1bQ0ek9tRYkPW67a1iH9c/rNOLXv4iBSFL+gpJbknxZqkRRl0CY/BPOt1/UwXQ3wm
         lXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689878999; x=1690483799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6XfvdHY9gNi/Uu7IhnorruW0FyEO0Ku4CqZNScjR64=;
        b=cNsCK8U4VEgXhJKEU34FfjplaAU3za6eKpJadS/bzrLTXjO5KKfE5thonKVR25WLe8
         3u5H99aPvPRgO/lhITHDmUu3TJZFfyZEi7GMMBp30ax37A6PUieNZ2Wh4a6Fgdi/AXTQ
         dbl08/KgbBe+4/OfMNZaZN7oK/V7JjDG0wRgfJwRn9i18sS8drMsr5ophyfLmLWcYMdh
         Lrpsgsr+xnjsWJJoRcG0z7Jd5g/XxkprfLmW0twmtRbOr3yG0/l1S7t8MZElKqZIzK4D
         JNBoybr02vPkTuVeFxFJTIg/ItXP76arm673cRQQ+GDtHPr4NU8dqPyyBoc9RPrIoHAx
         qDTw==
X-Gm-Message-State: ABy/qLbjR65qMeV6ANjWDiB2v7soFgG7vKLhvoFP9hKh2e3qWHfmvwj+
        fyImW7arqahYGvcaEcdXHgUYQw==
X-Google-Smtp-Source: APBJJlFXNrDD+BDKRVp5y3572+pBNtZ7kjydIFkYPkh3VrwiFhXSiKhjb2aWCrnry9e4XSxmh+snwg==
X-Received: by 2002:a1f:ed81:0:b0:481:719a:23f6 with SMTP id l123-20020a1fed81000000b00481719a23f6mr3856382vkh.14.1689878998936;
        Thu, 20 Jul 2023 11:49:58 -0700 (PDT)
Received: from localhost.localdomain (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id h7-20020a0561220b6700b0047dbd48bc44sm238059vkf.17.2023.07.20.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 11:49:58 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [RESEND PATCH 0/2] Add Intel 8254 Counter support
Date:   Thu, 20 Jul 2023 14:49:42 -0400
Message-ID: <cover.1689878150.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Intel 8254 PIT first appeared in the early 1980s and was used
initially in IBM PC compatibles. The popularity of the original Intel
825x family of chips led to many subsequent variants and clones of the
interface in various chips and integrated circuits. Although still
popular, interfaces compatible with the Intel 8254 PIT are nowdays
typically found embedded in larger VLSI processing chips and FPGA
components rather than as discrete ICs.

A library providing support for interfaces compatible with the venerable
Intel 8254 Programmable Interval Timer (PIT) was merged in commit
d428487471ba ("counter: i8254: Introduce the Intel 8254 interface
library module").

Now that the necessary dependencies have been merged, this patchset adds
support for the i8254 in two respective follow-up patches for the
104-dio-48e driver and stx104 driver whose devices feature i8254
compatible interfaces. The two patches are independent and may be taken
each separately in their respective subsystem tree.

William Breathitt Gray (2):
  gpio: 104-dio-48e: Add Counter/Timer support
  iio: addac: stx104: Add 8254 Counter/Timer support

 drivers/gpio/Kconfig            |   1 +
 drivers/gpio/gpio-104-dio-48e.c | 127 ++++++++++++++++++++++++++++----
 drivers/iio/addac/Kconfig       |   1 +
 drivers/iio/addac/stx104.c      |  61 ++++++++++++++-
 4 files changed, 172 insertions(+), 18 deletions(-)

-- 
2.41.0

