Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793DA3D9313
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhG1QWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1QWM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jul 2021 12:22:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F6BC061757;
        Wed, 28 Jul 2021 09:22:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso10870595pjq.2;
        Wed, 28 Jul 2021 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0V2k2Na18FcBV+BsH63ifuucHYEQEy28n8NPkKkmgbo=;
        b=Js1kEJ/0cn/vs8Jatu1KFmLm/rH7EpdhZ+Ekx7eXTD1jMYX4XAPKIUJ8UKsKsXRF1x
         5HqzIQhGUhPBkwOZKuaIoEHOAJRf4KGulmDNSRhvRd2YlIyCJBZ7AAVfIajce6qDYwaF
         FY8JxRIeA1VCi9BKgmmolOkL2nCl0mE4f2VNRy/oeXxYDKvToI72G4Um1r4+bYl3PTKX
         TOl2B14mQUtefH6FsevryNprtgEVcVFkcoQjobuSu8ACmaPMFIQoj8pNjsp9ufj7a1G8
         1RRNOwIW755AwTIhj/VePHUo+SRzeX+yWTntChpJ/yfcNKX+VqkeuXghU5kT1B4NTRGY
         eQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0V2k2Na18FcBV+BsH63ifuucHYEQEy28n8NPkKkmgbo=;
        b=RQQL3DmbJq4g/1U1mG98F0I/FpzA8X4qqZ17oi8OXzqw/veNmhLYP35cQEFmscq8Fm
         fXVuqcqfkkRn0TznX9g8x0hWY7TL/rV8sMxisWKbGzpcEpGK7MRYjEQHMaRI1AovfC1B
         MWQjfz39wDVbTfuPVqd7GkMEUfubxtvg6Xt4YedFAec8UixCTsQFu74KoXmJISErXVI5
         z8+cZhVEexHsAjzS0WVJAG6brBy+qhs3/YWA4+2uDbcxozkYabpcXRlhWcYXQzJcs7EE
         PpJXxWOO5wVo6tkgW6yraOWbA0o0lbA/0suOLnb7KiRsIvTWLESSU2GnGsPPU4Ir61Gv
         k7KQ==
X-Gm-Message-State: AOAM533UAka9fGtU9xM66zqL6Td471Uwbt1mtIdbAbmzfUZ4enM8WYU9
        dKaJJVsbbKer0bLeYUB9d/g=
X-Google-Smtp-Source: ABdhPJzrtL1UuAhv31tB/IB9aX3ZYjptbZvPQK7GRCAIzSmP3Q9At1zjpGbMesrZlAiukCCst5qkwQ==
X-Received: by 2002:a63:155c:: with SMTP id 28mr614831pgv.154.1627489329792;
        Wed, 28 Jul 2021 09:22:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:828b:a80e:e12:9310:6b88:a724])
        by smtp.gmail.com with ESMTPSA id j5sm214323pgg.41.2021.07.28.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:22:09 -0700 (PDT)
From:   Siddharth Manthan <siddharth.manthan@gmail.com>
To:     jic23@kernel.org
Cc:     robh+dt@kernel.org, nikita@trvn.ru, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ktsai@capellamicro.com, lars@metafoo.de,
        Siddharth Manthan <siddharth.manthan@gmail.com>
Subject: [PATCH 2/2] drivers: iio: light: cm3323: Add device tree support
Date:   Wed, 28 Jul 2021 16:30:48 +0530
Message-Id: <20210728110048.14593-2-siddharth.manthan@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728110048.14593-1-siddharth.manthan@gmail.com>
References: <20210728110048.14593-1-siddharth.manthan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Device Tree support for Capella cm3323 Ambient Light Sensor

Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
---
 drivers/iio/light/cm3323.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 6d1b0ffd144b..fd9a8c27de2e 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -256,9 +256,16 @@ static const struct i2c_device_id cm3323_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cm3323_id);
 
+static const struct of_device_id cm3323_of_match[] = {
+	{ .compatible = "capella,cm3323", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cm3323_of_match);
+
 static struct i2c_driver cm3323_driver = {
 	.driver = {
 		.name = CM3323_DRV_NAME,
+		.of_match_table = cm3323_of_match,
 	},
 	.probe		= cm3323_probe,
 	.id_table	= cm3323_id,
-- 
2.31.1

