Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A06245291
	for <lists+linux-iio@lfdr.de>; Sat, 15 Aug 2020 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgHOVxD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Aug 2020 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgHOVwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2020 17:52:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECEEC0F26EF;
        Sat, 15 Aug 2020 11:14:18 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w17so9177833edt.8;
        Sat, 15 Aug 2020 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uINicZ+DHLLF2gMCG0S676L3/FxAXJzjhmV0ZOtqSWw=;
        b=Gdr6dMreL94m8umOuQw9Gnk6ALyI4bOz2J1jkX35OCYz3vZKzzenUPY7Ou4pt7B8ef
         YJsst3uPEBlvpkwDPyewbZgJgOjgiNwSsczgytdaT+7aoMkT41HAqp+y/SVjxqTuRE0K
         w2TcKieWe9IP4o56pK8MOrDoPjfJdTjQtaivDkmWUJGgNvm0ieiOkqHu6StyMDfph4qN
         xpF8wCfpRrbEf5ADtrMk6uvpQsPpO2jlcaUdvc4fRSxf2A3KkfZICjMcQYaL5SYfqSsq
         ZDtY2tMvamx8CHjoldemO2Qx+I3oPj8zYp0ulm/kGNiz+45hySJIQTTeji3rPUIAUdo/
         r05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uINicZ+DHLLF2gMCG0S676L3/FxAXJzjhmV0ZOtqSWw=;
        b=Az7zTCM8OdH5h+J79ksAyUfw1C6mQkKyx+SlJbKnbH0cgxNMEFZAB229dTOM+8f3t6
         QbezhudbIY5J/JuOYSTf43wE/MCJmiwIQDxvOeuScxPwPav6wZsMeYvj3bWD/eYh9kSz
         6Y9bIRKE3Zbh6PIhpe3o8efm54F1+uM3/EoEWnqym/drm6UMrgdMTMN6xH9g0sII9mQ/
         uBg7ZcCFHLq7MIcnWQIOmqnByndo6ZFvgED1/u5E+cFuY47BxLBLTSNUjLrnNQx0NMvo
         IOxOpp+C2fL/LTSXHUHzaZvrqEGrVspjZ/rgnBwfSaBK2fHkM+lingMn+Xo9V9nHPe45
         NcqQ==
X-Gm-Message-State: AOAM532JlT0yrTvbYizwv2m0u23R37susDScHf9MUuUtCdvgGDGUdpHa
        3majkpuTt6soIOEzVKYUV4Q=
X-Google-Smtp-Source: ABdhPJwUM4wX2FiiLD7s/Ocw/648bw8oWRk3tLISpQebRyQQAOcj3KJ3d7OnMxtmXJxUG4ZpOd+/8w==
X-Received: by 2002:aa7:de13:: with SMTP id h19mr7587769edv.322.1597515257318;
        Sat, 15 Aug 2020 11:14:17 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371a97000000000000000fcc.dip0.t-ipconnect.de. [2003:f1:371a:9700::fcc])
        by smtp.googlemail.com with ESMTPSA id u13sm10353549eje.9.2020.08.15.11.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 11:14:16 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     knaack.h@gmx.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH for-5.9] iio: adc: meson-saradc: Use the parent device to look up the calib data
Date:   Sat, 15 Aug 2020 20:13:55 +0200
Message-Id: <20200815181355.407034-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On the older-gen 32-bit SoCs the meson-saradc driver is used to read the
SoC temperature. This requires reading calibration data from the eFuse.

Looking up the calibration data nvmem-cell requires the OF device_node
pointer to be available in the struct device which is passed to
devm_nvmem_cell_get(). This however got lost with commit 8cb631ccbb1952
("iio: Remove superfluous of_node assignments") from indio_dev->dev. As
devm_nvmem_cell_get() is called in the initialization phase the
device_node is not yet available because the NVMEM cell is looked up
before iio_device_register() is called (which would then set the
device_node automatically).
Use the parent device to look up the NVMEM cell instead to fix this
issue.

Fixes: 8cb631ccbb1952 ("iio: Remove superfluous of_node assignments")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 93c2252c0b89..1a9189ba69ae 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -707,7 +707,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 	size_t read_len;
 	int ret;
 
-	temperature_calib = devm_nvmem_cell_get(&indio_dev->dev,
+	temperature_calib = devm_nvmem_cell_get(indio_dev->dev.parent,
 						"temperature_calib");
 	if (IS_ERR(temperature_calib)) {
 		ret = PTR_ERR(temperature_calib);
-- 
2.28.0

