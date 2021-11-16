Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59796453BC1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 22:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhKPVlM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 16:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhKPVlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 16:41:10 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB30C061570
        for <linux-iio@vger.kernel.org>; Tue, 16 Nov 2021 13:38:12 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 13so1355867ljj.11
        for <linux-iio@vger.kernel.org>; Tue, 16 Nov 2021 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QK/HBJoNn9A858BQwrMFI9bZbu+eIWfoU563AteNURQ=;
        b=QCmnHAVxTHVnhOUWdlyVy+i8aUhC4cFA98NSaPKOaI6FHz6DUTfmlVbZCpI12+bS08
         h5pevirWrRFeLuu9IUQbZFM8V2+6nK9fmAfKwg8KG3TILHV5YPeXgO+7znFaJrfL2MvI
         CxZUh6pzwwqtJXvqcaDvCZzhnysts3WBTqm5E4tkCe6yBDUghURewOt1XyvojvlzOUja
         m8q9T6iW5TwJV2UucdTbpa+8t83+BkclPmuNjlm0K3tKRx2Yzwlgatu+HFp92/HDMCHf
         Ghr0xPP0XFs86fxsxpsSdgFM1bfV4pjnSYxjDzUWXBpv7wl72vQIfH2Hdm7k/bXGhV7Y
         kNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QK/HBJoNn9A858BQwrMFI9bZbu+eIWfoU563AteNURQ=;
        b=ijAdb+eLnVPS90rrJloqeWzpOhgd6mrladmX0J+JcVzgCfUs8/iK4rCXUHVgCVDr7g
         2S/F/zq1MbmeSqP9LJ9ipU9za6dElptxl3NAd+71XxyDZzm/E/AYzTyjLjb/M9PHyLGq
         12LZ4817BP3T+b0YcgmuNhHw2IYSIeAgucrF/TpZ5j0WMMF0CB5/59rJcTqEEZ/LKXh8
         0Bt1QUHuHeZPeF5UkGVJVv1FXJjZ++Q+WRALXnm0/V3x32d4ucbJB29rzJGNeqx5Qwmd
         Q6akF4fbYhOn9uXrOsIUYgJclL1gyfSGzFYFaQpyQNeHxz4cjlH/2KYTLzUA+2FDVgkv
         8RRw==
X-Gm-Message-State: AOAM533U9QZTa/wxhluNrLbtzPNSg8rgq5GKwf1KZGiv2LIZuOpsBQhf
        fS37mKCHndPxD01cbnPeYxFjzDqu9nggEg==
X-Google-Smtp-Source: ABdhPJxswovBwnyQs0LKl8NWxW9ijGyjyIgs//aMFl82LSxO2PbyVqRktTz6a0wNMDuYDmCXpEwwZg==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr2426062ljn.385.1637098690518;
        Tue, 16 Nov 2021 13:38:10 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.gmail.com with ESMTPSA id j15sm1889247lfg.167.2021.11.16.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:38:09 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     linux-iio@vger.kernel.org
Cc:     Evgeny Boger <boger@wirenboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2] iio: adc: axp20x_adc: fix charging current reporting on AXP22x
Date:   Wed, 17 Nov 2021 00:37:46 +0300
Message-Id: <20211116213746.264378-1-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Both the charging and discharging currents on AXP22x are stored as
12-bit integers, in accordance with the datasheet.
It's also confirmed by vendor BSP (axp20x_adc.c:axp22_icharge_to_mA).

The scale factor of 0.5 is never mentioned in datasheet, nor in the
vendor source code. I think it was here to compensate for
erroneous addition bit in register width.

Tested on custom A40i+AXP221s board with external ammeter as
a reference.

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---

Notes:
    Changes from v1:
      - return scale factor of 1 as IIO_VAL_INT, not IIO_VAL_INT_PLUS_MICRO
      - get rid of unused variable

 drivers/iio/adc/axp20x_adc.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 3e0c0233b431..df99f1365c39 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -251,19 +251,8 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
-	int size;
 
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
 
@@ -386,9 +375,8 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_CURRENT:
-		*val = 0;
-		*val2 = 500000;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = 1;
+		return IIO_VAL_INT;
 
 	case IIO_TEMP:
 		*val = 100;
-- 
2.25.1

