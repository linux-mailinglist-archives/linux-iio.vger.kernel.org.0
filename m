Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2B32FE0F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 00:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhCFXxx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 18:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCFXxM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Mar 2021 18:53:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A995C06174A
        for <linux-iio@vger.kernel.org>; Sat,  6 Mar 2021 15:53:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x4so6392140lfu.7
        for <linux-iio@vger.kernel.org>; Sat, 06 Mar 2021 15:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zKlfacpIejW2lVsxvqvq7lYCG1AMrv/VTrbl2b68RbU=;
        b=mmzQtaTsPL3zSV+mjD4eza2AUyWKEaDBez25mmFVTaeU6ZZRHf3Blmfm7deKKe/xWl
         mJRZCW4RPJEQpQD2nCfYV/ML5wR+W/kpyI1zTUrxVQ5duh+LmBG5hum0drvLLD2Ufe1q
         esTma/bTLuXraZj05flmCrWyKKU4V9eU5lMcPYMLDxe/I9fYH1h+kri7WgP2rDT/rOAV
         r73elfo1Yz7bRJOHGQWd/w/xqWeVVt6pGgAratN6JlhB9PF41et27u0G4EN0fhxJHuxM
         B+Vl/9hlrT8CcdSGoMIhCS3M6beDQCRKsUA7ugM7wVOBPLDHgBPZbbQgtWHFra1Ucbeb
         o9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zKlfacpIejW2lVsxvqvq7lYCG1AMrv/VTrbl2b68RbU=;
        b=anvruG2V/jwnA/LcnfM1WwrrKRifm6VG/daYNX2Br2zfTDE9dKOBeALvgVbgEj5i90
         HerbVnQlyXtyaLIfQW3/bPCVr3fwu7go2oU4w340pfSjYPlYsqdK0J6cJW8r1iy0cm66
         IYYkwjU6Ejgt22yLZ9IfV08exQCWspnDuUYoT3xojYk83Vqs2Gedn/vzEjFz2xekyCC3
         CCyOH+biMct0OxXlF2AbjS1vRFHuzecFBdxvsY43uQFRiBM+bDmvymwSZWTL4MG3h3ID
         5WQa7Zi1GqozIXPQYNwCIvq44QM9Uv+EZowHXqzWNlIx+dyPX+lW36zEymBhsSUYqqL9
         4/xw==
X-Gm-Message-State: AOAM533qMZIG1eyovJ5cyLN8c/cUY6+fXGDFmmmRbHAZNJO2kz2VhLAO
        OVNx7fBg+xJ/fs9yPmh0+4ELLacVndICdgqG
X-Google-Smtp-Source: ABdhPJz+phs9Yn9s9ze7A57VUUosksTg9aVU9Cm4LD8OgrhXVyh0Ep80Lr7padKB4EAplN7ygr1PMw==
X-Received: by 2002:a05:6512:1094:: with SMTP id j20mr10390435lfg.442.1615074789596;
        Sat, 06 Mar 2021 15:53:09 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.6.dhcp.mipt-telecom.ru. [81.5.99.6])
        by smtp.gmail.com with ESMTPSA id u6sm806344lfm.56.2021.03.06.15.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 15:53:08 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Evgeny Boger <boger@wirenboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH] iio: adc: axp20x_adc: fix charging current reporting on AXP22x
Date:   Sun,  7 Mar 2021 02:52:38 +0300
Message-Id: <20210306235238.30379-1-boger@wirenboard.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Both the charging and discharging currents on AXP22x are stored as
12-bit integers, in accordance with the datasheet.
It's also confirmed by vendor BSP (axp20x_adc.c:axp22_icharge_to_mA).

The scale factor of 0.5 is never mentioned in datasheet, nor in the
vendor source code. I think it was here to compensate for
erroneous additional bit in register width.

Tested on custom A40i+AXP221s board with external ammeter as
a reference.

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 drivers/iio/adc/axp20x_adc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 3e0c0233b431..8db6699c20c3 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -253,17 +253,7 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
 	int size;
 
-	/*
-	 * N.B.: Unlike the Chinese datasheets tell, the charging current is
-	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
-	 * bits.
-	 */
-	if (chan->type == IIO_CURRENT && chan->channel == AXP22X_BATT_DISCHRG_I)
-		size = 13;
-	else
-		size = 12;
-
-	*val = axp20x_read_variable_width(info->regmap, chan->address, size);
+	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
 	if (*val < 0)
 		return *val;
 
@@ -387,7 +377,7 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
 
 	case IIO_CURRENT:
 		*val = 0;
-		*val2 = 500000;
+		*val2 = 1000000;
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_TEMP:
-- 
2.17.1

