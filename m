Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297B27689AC
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jul 2023 03:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGaBp0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jul 2023 21:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGaBp0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jul 2023 21:45:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FF7E59
        for <linux-iio@vger.kernel.org>; Sun, 30 Jul 2023 18:45:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76571dae5feso338322685a.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Jul 2023 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690767924; x=1691372724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pn4weG6Y5i7gerI+k04YQwCownL4+8awy6E3to2R1SI=;
        b=ci02DAEYs27EryA4sSGbc10JH58miu0Po+CZeT2WfGoYd4ERftHkXdQmv5IGY+ifG/
         uURmQpWoPVoW9jiTCc2xlc8S/toSKf/IKlg5r5Li1CrbBHzQpd7HScCad+GkEQnP9Vyg
         BlCZiUuzFgMbIqNlJDXFdem6X9Fiqc2GrQ7xJuqCL8KZRfV6FRSdcnjjNRy2u2y922GT
         /x42h3rbdxykY2xCKKaqokKqgPvf+ybz9E2hznnQmMLgMHmj387twHcaR6JalUqZAQfg
         sftpueOY7iBk4TsoIX2UT7uR8SCMxEKPAVaWmWg7JLdl1gPqPJlGL9cGUXY7OAYk3TAA
         +wQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690767924; x=1691372724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pn4weG6Y5i7gerI+k04YQwCownL4+8awy6E3to2R1SI=;
        b=VSN7+HCjIt0FiQP4RimjKidnV9kSsNKjFMihzJG1wBj+4Bm7io1FPOQooOQhmVCtD8
         gKo8iJXB1ihRhq4QHzI+lWDuZV1r7mnDaqeYFnnoW/tJRPCXRGeDmAbz0LPYeL5TkUMe
         puy2Cs8SozvApp/aB0zxC61P/Ecfq5OevdaImJZnpe8XeY5ALhKtzw25R6d18iyDku8Q
         U/yVvkISQDtinrV8OMoTDZvcoF3IM8CyIuyqvPZrHX+nXybmgGLCv/E3nlV7at47CkH5
         cvoYRprkkhtnKI/ri5hZBWEHOa63huKbLWbv6Xcv1yEjiJWMSiXw9HlF7SImvSfeoj2L
         BRaQ==
X-Gm-Message-State: ABy/qLY31aTaD4gUW3P/40iqDyUmXI+/IXJevpbXWHUuL90a83FgsW35
        EyxKHNS/R8MELjUt/QKSV5s=
X-Google-Smtp-Source: APBJJlF/FYscW2kRo+EobwWTLlSEAarUAx7jxav57ZA3pGSbgtDGrmX4A52anGLpuMck6AuHXE6qHA==
X-Received: by 2002:ae9:c108:0:b0:767:26d:1142 with SMTP id z8-20020ae9c108000000b00767026d1142mr9035502qki.21.1690767924015;
        Sun, 30 Jul 2023 18:45:24 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:f50b:8f24:acc4:e5c])
        by smtp.gmail.com with ESMTPSA id q20-20020a62ae14000000b00672ea40b8a9sm6593135pff.170.2023.07.30.18.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 18:45:23 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     cosmin.tanislav@analog.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] iio: accel: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
Date:   Sun, 30 Jul 2023 18:44:06 -0700
Message-Id: <20230731014406.22810-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replacing zero-length arrays with C99 flexible-array
members since they are obsolete.
Use the new DECLARE_FLEX_ARRAY() auxiliary macro instead
of defining a zero-length array.

This fixes warnings such as:
./drivers/iio/accel/adxl367_spi.c:38:6-17: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/iio/accel/adxl367_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
index 118c894015a5..9dc61cb45fc5 100644
--- a/drivers/iio/accel/adxl367_spi.c
+++ b/drivers/iio/accel/adxl367_spi.c
@@ -35,7 +35,7 @@ struct adxl367_spi_state {
 	 */
 	u8			reg_write_tx_buf[1] __aligned(IIO_DMA_MINALIGN);
 	u8			reg_read_tx_buf[2];
-	u8			fifo_tx_buf[1];
+	DECLARE_FLEX_ARRAY(u8,			fifo_tx_buf);
 };
 
 static int adxl367_read_fifo(void *context, __be16 *fifo_buf,
-- 
2.34.1

