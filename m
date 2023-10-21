Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA17D1B75
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJUHJu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Oct 2023 03:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHJt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2023 03:09:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD792E4
        for <linux-iio@vger.kernel.org>; Sat, 21 Oct 2023 00:09:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so1487971b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Oct 2023 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697872187; x=1698476987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSMhDe+LxH3wAuYObkBVKyRRu618WWmreBStOhcSOS8=;
        b=CJu4xGGtW3EpX62fTyRDGQyB/e50G6WWuU985gt/rYTfGXY7zTl+ZX/PffHhJdrtFe
         2rZgJQMi4py0EUu1Q8QY58TlwWrxL1kMX3GAlPgU/E5WhCaPK01izFVwG/2OBUEnJCII
         7e1X7perdxZny8gRhiL69h1SLwdPUeQUiTvSItv0lDtn8Tt8CYsdMQyLqx3L9rnuLiF4
         ga99D4byOjMG37oyJuQ/fbnacdHcSYPlVMsBo+lZQWayLvCNe1EQimKle4ML1gUCO3Tl
         GcaHzueNHe18bSoyWsYoEDP2fCHAGfUiHB4J04DVBx+Da+TcirbIBafhDfYljJb2C44v
         2W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697872187; x=1698476987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSMhDe+LxH3wAuYObkBVKyRRu618WWmreBStOhcSOS8=;
        b=KMtsrJAux0K0FLISGOWkDsvSQtviJ84j1v/xrSPv2dd9qVzS7PudU7iUjhE06gtrw5
         /yVHQZ1hX/LStn60zf4hfPE3lCtjwBo/c+KxlBMvkncVHXmNTFU0/r2nqdj2bXJn3hwM
         /kVBx+xUtchOJbyMZ70XB95/ClhD/POZzkseRH+ERGc779tX0Rn+jneuWw6wcVjlBnhk
         fZHR40b5OzRKeKJC/kSdQz8o34aaXhSXxb+qsfdKLiNB86z6o5u+8/1eXp0ZfWQOgHl6
         /BsasEoqSvckKXTp/gJn9gihKuubDP+XSv0n2H+Jt6LGwu6EnwWzHKISASDT89QtZLn1
         OW/w==
X-Gm-Message-State: AOJu0YwfMB/vVxvkPCPTSr0t3ay9c4I0e1q86QqflZRK3g1TzsBb5F4+
        q73vgB042omfYangclCDf2c=
X-Google-Smtp-Source: AGHT+IHJeya81fzPKQaIz5yRZxIDfsGrWTzw2rXgXdBCGMCG4h1fh/wepKny9/0pbVYthbyUWNkuQQ==
X-Received: by 2002:a05:6a00:b4f:b0:6be:2081:f66d with SMTP id p15-20020a056a000b4f00b006be2081f66dmr4264547pfo.27.1697872187009;
        Sat, 21 Oct 2023 00:09:47 -0700 (PDT)
Received: from dawn-Aspire-A715-74G.. ([183.198.110.105])
        by smtp.gmail.com with ESMTPSA id z21-20020aa785d5000000b006979f70fdd5sm2604717pfn.219.2023.10.21.00.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 00:09:46 -0700 (PDT)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Li peiyu <579lpy@gmail.com>
Subject: [PATCH] iio: pressure:  fix some word spelling errors
Date:   Sat, 21 Oct 2023 15:09:03 +0800
Message-Id: <20231021070903.6051-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

They are appear to be spelling mistakes,
drivers/iio/pressure/bmp280.h:413        endianess->endianness
drivers/iio/pressure/bmp280-core.c:923   dregrees->degrees
drivers/iio/pressure/bmp280-core.c:1388  reescale->rescale
drivers/iio/pressure/bmp280-core.c:1415  reescale->rescale

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 6 +++---
 drivers/iio/pressure/bmp280.h      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index a2ef1373a274..4c493db7db96 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -920,7 +920,7 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
 }
 
 /*
- * Returns temperature in Celsius dregrees, resolution is 0.01º C. Output value of
+ * Returns temperature in Celsius degrees, resolution is 0.01º C. Output value of
  * "5123" equals 51.2º C. t_fine carries fine temperature as global value.
  *
  * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
@@ -1385,7 +1385,7 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 	/*
 	 * Temperature is returned in Celsius degrees in fractional
-	 * form down 2^16. We reescale by x1000 to return milli Celsius
+	 * form down 2^16. We rescale by x1000 to return milli Celsius
 	 * to respect IIO ABI.
 	 */
 	*val = raw_temp * 1000;
@@ -1412,7 +1412,7 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
 	}
 	/*
 	 * Pressure is returned in Pascals in fractional form down 2^16.
-	 * We reescale /1000 to convert to kilopascal to respect IIO ABI.
+	 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
 	 */
 	*val = raw_press;
 	*val2 = 64000; /* 2^6 * 1000 */
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5c0563ce7572..9d9f4ce2baa6 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -410,7 +410,7 @@ struct bmp280_data {
 		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
 		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
-		/* Miscellaneous, endianess-aware data buffers */
+		/* Miscellaneous, endianness-aware data buffers */
 		__le16 le16;
 		__be16 be16;
 	} __aligned(IIO_DMA_MINALIGN);
-- 
2.34.1

