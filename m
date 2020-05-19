Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8D1D968D
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgESMoe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgESMod (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 08:44:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1CC08C5C2;
        Tue, 19 May 2020 05:44:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so15753770wrn.6;
        Tue, 19 May 2020 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nt3Mx2nCd5A0j6CNOFkJnbMZZLSJU9VkhbQdru91GsY=;
        b=Y080PQs6bwsIcu4HcdRx24Qw2UShJDwEQIqKYzbkbPjo65gQQ8Gcs055FfA2NVyVX1
         cYeLYHLL3iKIkhyvuJV+bVANlvxv1jfBNXyqX1PdR/pNoK6VlOfTcShflRbxqMQDrZqD
         wJuRPg4+iuEpuo5c6npIQqLt2+WPEBJAQddBVTac3CbQ6gwx/17PN+JR2OqvCSqB/wm0
         Fjn/6sl1jr/kKZ+cY8XNnWdxu26rFoDLF6IZdcG0Fk2WwkRZtErDzaFEdOTn/QBaqYVv
         du1gk3fXNVQFOykTT9jFhaHzRD+Qqx37svkHL+WqD4oJxUYcTRf8hD5bW0k0Y57YTMJ/
         4eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nt3Mx2nCd5A0j6CNOFkJnbMZZLSJU9VkhbQdru91GsY=;
        b=VZD+Z9YXZZmCmqWE+jt9RXX7cqPB7PqzzB/ITSKo2oSWVPQfhsw+wRWRUl3mLhNpIE
         nLEiPSeIdIfXh+JQGAdiWZF193K1hQtHmKtW9oyxr3vAQFGIhMxbhk4ZP0fX1b8vJRKl
         zAwbhrGzgXQOAiQpnmur0SpMPYgy8JRumJlICFqw+g/Yr8Z/ZGhYqTvPjMk3Jm59Ohu6
         9zoExmgNnaZdNj4Q2ZEX44C3Jb+j3yDYdrE0y3kbdiVDJCXrq+Drm8/KEjraE+bmO+ZM
         76YeXRc+oo9FcFQgJ6OViIQINR2cRq2vN8MuQUT5jQnu5EFGjy02ZhvnCba3KnV6SEK3
         uSPQ==
X-Gm-Message-State: AOAM5336SB09nXiFMK37Z1/YrJsoulhLiAcuC8hs0ZM9zxys6NvJ5zQ+
        clbUxPp9EcSEWSdMl5RUuxCnflm609gjhA==
X-Google-Smtp-Source: ABdhPJw47dp67aFXdWNdXrhCMDXNnNem0viHkXBIHfdN4yPk3oPZ0WiMaImFUJbcQBgHgpmx5+R8hQ==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr27649709wrs.276.1589892270220;
        Tue, 19 May 2020 05:44:30 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id b12sm3953870wmj.0.2020.05.19.05.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:44:29 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 3/4] iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
Date:   Tue, 19 May 2020 14:43:53 +0200
Message-Id: <20200519124402.26076-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minor comment style edits.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 3c881541ae72..fd368455cd7b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -385,9 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
 		return ret;
 	}
 	/*
-	 * According to the datasheet the power supply rise time i 200us
+	 * According to the datasheet the power supply rise time is 200us
 	 * and the minimum wait time before mode setting is 100us, in
-	 * total 300 us. Add some margin and say minimum 500us here.
+	 * total 300us. Add some margin and say minimum 500us here.
 	 */
 	usleep_range(500, 1000);
 	return 0;
-- 
2.17.1

