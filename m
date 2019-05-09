Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255401942E
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfEIVOD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:14:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47094 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfEIVOD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so1937487pfm.13
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9AsCRlkOOmYTXd62VCE+TLaRBh2EP8zJGBIvpPdv+s=;
        b=PuAzQQMz7nwC9LEZewasSekHzr0gzavO/OiUWtrEjI2oRvWoSOlhf23dIs2YNuL8+I
         hjQzfRQubWGAS97DozJVYiZkX1o6rwy8U0L2nQVVJXC4iTo4kh7mrNxL0WxOE6XUBMaL
         AFAb1N/SveVKB8LKCd3n40EJH9pcpBSkZtzcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9AsCRlkOOmYTXd62VCE+TLaRBh2EP8zJGBIvpPdv+s=;
        b=DpgnF4MVnA0neaZJ8wEY1o51GBkXB4t5IddGQUXcNe8gaMyhEVie0Q7DJnszBctKRW
         UUbeGYQIFlHmDQvus3IGIBwlpJr+XWoP+Q5oUzbfD+szLVPapez05tPwMtW3YPf17CTs
         +FusHAjHkULm01KMGx7VXB7fLToUdkZML8u9R1d7X46W7ggU3bOLVey/g7C9xyh+Z5w6
         fphjyS/FM64tdKK21x+Gl8aBeyCAuUmVBqzQnX6HBu9yeMfSs7hGP/a/8Y4U4HPlnbfg
         2hJg83Ck47KzMH/HdS2QoMBFV0OlygWqEY5Key6XFUVAzmJiMyOYRopMvLpm3MSiPoL1
         L5yQ==
X-Gm-Message-State: APjAAAXHdCDa8vkv/SoU0fB4k2LxsKVvN5dqTDPi7cwRjEND+GCU22I9
        iv8SnPfjdcTjxyCjXkx/JdcKPg==
X-Google-Smtp-Source: APXvYqzOA+ux6Z4uGST2w2ScerR1nnAkn72owRHC1ECieOpbdEaZoJNeaELR4m34RLFLexWgNiS4ow==
X-Received: by 2002:a63:3190:: with SMTP id x138mr8583878pgx.402.1557436442056;
        Thu, 09 May 2019 14:14:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id r8sm4162245pfn.11.2019.05.09.14.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:00 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 00/30] Update cros_ec_commands.h
Date:   Thu,  9 May 2019 14:13:23 -0700
Message-Id: <20190509211353.213194-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interface between CrosEC embedded controller and the host,
described by cros_ec_commands.h, as diverged from what the embedded
controller really support.

The source of thruth is at
https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h

That include file is converted to remove ACPI and Embedded only code.

From now on, cros_ec_commands.h will be automatically generated from
the file above, do not modify directly.

Fell free to squash the commits below.

Changes in v3:
- Rebase after commit 81888d8ab1532 ("mfd: cros_ec: Update the EC feature codes")
- Add Acked-by: Benson Leung <bleung@chromium.org>

Changes in v2:
- Move I2S changes at the end of the patchset, squashed with change in
  sound/soc/codecs/cros_ec_codec.c to match new interface.
- Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Gwendal Grignou (30):
  mfd: cros_ec: Update license term
  mfd: cros_ec: Zero BUILD_ macro
  mfd: cros_ec: set comments properly
  mfd: cros_ec: add ec_align macros
  mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
  mfd: cros_ec: use BIT macro
  mfd: cros_ec: Update ACPI interface definition
  mfd: cros_ec: move HDMI CEC API definition
  mfd: cros_ec: Remove zero-size structs
  mfd: cros_ec: Add Flash V2 commands API
  mfd: cros_ec: Add PWM_SET_DUTY API
  mfd: cros_ec: Add lightbar v2 API
  mfd: cros_ec: Expand hash API
  mfd: cros_ec: Add EC transport protocol v4
  mfd: cros_ec: Complete MEMS sensor API
  mfd: cros_ec: Fix event processing API
  mfd: cros_ec: Add fingerprint API
  mfd: cros_ec: Fix temperature API
  mfd: cros_ec: Complete Power and USB PD API
  mfd: cros_ec: Add API for keyboard testing
  mfd: cros_ec: Add Hibernate API
  mfd: cros_ec: Add Smart Battery Firmware update API
  mfd: cros_ec: Add I2C passthru protection API
  mfd: cros_ec: Add API for EC-EC communication
  mfd: cros_ec: Add API for Touchpad support
  mfd: cros_ec: Add API for Fingerprint support
  mfd: cros_ec: Add API for rwsig
  mfd: cros_ec: Add SKU ID and Secure storage API
  mfd: cros_ec: Add Management API entry points
  mfd: cros_ec: Update I2S API

 include/linux/mfd/cros_ec_commands.h | 3658 ++++++++++++++++++++------
 sound/soc/codecs/cros_ec_codec.c     |    8 +-
 2 files changed, 2915 insertions(+), 751 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

