Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49A4CFFF2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Mar 2022 14:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiCGN1C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Mar 2022 08:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCGN1B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2022 08:27:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6DA8A328;
        Mon,  7 Mar 2022 05:26:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i66so9166233wma.5;
        Mon, 07 Mar 2022 05:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OitVX9DAaNlroauyFMcBr/uj8TTgZYNkoujJpxXQGEU=;
        b=ZJZoMK3O/e8Eukz/MSC2p9dHh0lEuOCMNLhPZEB2P0PoROk4P/RoT3n2PpJ27RL27Q
         SFnDzrKKdeneEGqQJt78EQMe6Qh4Y2jfpZe4oZJvHj1HAa4hbd9f+zTsZQHez0N4I70w
         Fs+oKZ9o4eKXi1mJHEEodPYK3wCyuYEja15PBvJVQhjdo28NMj03l6GliJcuQywZZaeS
         sdAbmSj4APHPUgx+rBuSs5Q4fnn5BNzB3Mj7CFqCtN2Mu4k8UmY0kp4drRur9ynDMga7
         9wPOBaUVwWVPWiWo3a22JHHwO8dtrQ2uAereDXS2Wipk5iG9bo2/NtVr/hwfc10dQ2uH
         gnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OitVX9DAaNlroauyFMcBr/uj8TTgZYNkoujJpxXQGEU=;
        b=fqpQ08viZ6dmzMyZdKdVpQxuXJ/GsbU0terRBqS2EZ8YR3e/ofqQhGWnhmMLjbs4Ft
         M9J309+7dh+uvmmaHCMBR3dHmAja/ir/erQ4F7nnj4iWpSQbfunSMIAIJ/IiRg9I5oWm
         DTpMJBYxiBwvryMvBrKLnr7ZzIwcNOEa8ZtlDtfrEQyc3rDDNRgjg2+yPnsxW1NsmFjo
         1mUunMo/Qz/rKUQy1EkUUVpEC2IiXcdUOAkZp8It/ydmc8vkIxv+1lJgYIQ7X0zTyMzg
         0n4z4aOIHmFNSLzXHkwr5sPOchqYDtgGw/QG17yskTrIRBfO9Cu4tKIZrUUBb4AlDhdg
         se3Q==
X-Gm-Message-State: AOAM5326q5IBY+wnyu1x5VHUILOYG1FUJJTtH/ArCH6PXMwanQt3flqp
        6+JksYQHza16r4DgZjGf0bM=
X-Google-Smtp-Source: ABdhPJzbFLfOreGlr5m0cOp9NZMsfe9sOBZzqVPAa9apzdx2H8H/Ut8SN46Jo/asHW+3ep8VGBCLgQ==
X-Received: by 2002:a1c:ed18:0:b0:37e:7a1d:a507 with SMTP id l24-20020a1ced18000000b0037e7a1da507mr18265821wmh.187.1646659563412;
        Mon, 07 Mar 2022 05:26:03 -0800 (PST)
Received: from tpt440p.steeds.sam ([41.84.249.145])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b001f0485057c4sm11524965wrw.74.2022.03.07.05.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:26:02 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        maemo-leste@lists.dyne.org, "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v3 0/3] Support LIS302DL in st_accel
Date:   Mon,  7 Mar 2022 15:24:59 +0200
Message-Id: <20220307132502.73854-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

The ST Microelectronics LIS302DL is currently only supported in the
evdev framework driver in drivers/misc/lis3lv02d. This series enables
support for it in the iio framework.

Regards,
Sicelo



Sicelo A. Mhlongo (3):
  dt-bindings: iio: st,st-sensors add LIS302DL
  iio: accel: Remove unused enum in st_accel
  iio: accel: add support for LIS302DL variant

 .../bindings/iio/st,st-sensors.yaml           |  1 +
 drivers/iio/accel/st_accel.h                  | 26 +------------------
 drivers/iio/accel/st_accel_core.c             |  1 +
 drivers/iio/accel/st_accel_i2c.c              |  5 ++++
 drivers/iio/accel/st_accel_spi.c              |  5 ++++
 5 files changed, 13 insertions(+), 25 deletions(-)

-- 
2.35.1

