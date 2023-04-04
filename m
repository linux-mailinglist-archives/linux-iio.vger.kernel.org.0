Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314566D64E1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjDDOMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Apr 2023 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjDDOML (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2023 10:12:11 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9EE4206
        for <linux-iio@vger.kernel.org>; Tue,  4 Apr 2023 07:12:08 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5463fa0c2bfso285263817b3.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2023 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680617527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntJEhFvPVyRwKjpX84wW6Nzwfs8RwaisnK/y3HB3QZI=;
        b=q4242DFwPstTgqf5Ui1GWU4QZfjJwo8dqlFgpBF1Y0R5XPVUd4yDM1Rzwf894WOFVJ
         6e1xj/rMw0ZCFRKA4dzd8FtEjKCAJKd6Qon1yqC1BVmUvacoqdHv7+1ZA50uPczq6yup
         ewQPrYZMCzQ5ARCh8e1iMvQevFSngbCEVU+5SyRPiku+75PNHrzPh1IojCQYIGqiqD1l
         qE+0Z/99iGSfJgZWPwC+IqgGydOYuLRrU7F8bV3EvVZweZ98dWmbWTfzDc6KRrzE+H82
         0MgfvhI9qRyAQ8Z5FZ5+0BxfvgWHFKYZ9SauqRu/mXORNcWHCWoWsxjG0+Wuz/1wEAAV
         eV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntJEhFvPVyRwKjpX84wW6Nzwfs8RwaisnK/y3HB3QZI=;
        b=0DSo1oHcgSy/FAKMH9nUBqlYeB1rMFncUTRBFTxiyv79cPKmMbbFwRsjv8nxL6MACU
         LM/YRuOvyyENKVXgyQlBiNAcGeUwazFX7hjE6n0vKebAhwGfYnij/YBE0X3liJVzTaz3
         gNUS9oJ2uuj8/wrhSHCX6G2tGbnbQ/dbIMRzdxM/EtaMa8BgYqcrRk9yoi6NarMXzO13
         o4RGSwmVMEduzJGs4bL5pLBL1ZmaoTxppzJgp10/O7l9GOaGii1ahZfPeTLTCPL5fhSS
         RHPx196ghZi/6C/u61PXumpLvJv8CzbgSb+QuHwSsGjwvuilreQpK+L64Y0SWxSVEM7W
         5g8g==
X-Gm-Message-State: AAQBX9fjFLFPA/34CgxhI/zPsnq6+ziNV/zq1vfRm0sPKRy16O8oduFq
        Kkzz32mjQyjGazPk5kJEZWw/xQ==
X-Google-Smtp-Source: AKy350Ydsp7NUvBJDlQJTdMtriZo5hMFkAr3fDz46ScNCXgyl5gdZJVc8UmA8llIPFg0FVx1L4dy0A==
X-Received: by 2002:a0d:d88d:0:b0:541:8909:eb5a with SMTP id a135-20020a0dd88d000000b005418909eb5amr2368089ywe.18.1680617527339;
        Tue, 04 Apr 2023 07:12:07 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d195-20020a811dcc000000b00545a08184d8sm3202750ywd.104.2023.04.04.07.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:12:06 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 2/5] iio: addac: stx104: Fix race condition when converting analog-to-digital
Date:   Tue,  4 Apr 2023 10:11:59 -0400
Message-Id: <2ae5e40eed5006ca735e4c12181a9ff5ced65547.1680564468.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680564468.git.william.gray@linaro.org>
References: <cover.1680564468.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC conversion procedure requires several device I/O operations
performed in a particular sequence. If stx104_read_raw() is called
concurrently, the ADC conversion procedure could be clobbered. Prevent
such a race condition by utilizing a mutex.

Fixes: 4075a283ae83 ("iio: stx104: Add IIO support for the ADC channels")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/addac/stx104.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 4239aafe42fc..8730b79e921c 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -117,6 +117,8 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
+		mutex_lock(&priv->lock);
+
 		/* select ADC channel */
 		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
 
@@ -127,6 +129,8 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 		while (ioread8(&reg->cir_asr) & BIT(7));
 
 		*val = ioread16(&reg->ssr_ad);
+
+		mutex_unlock(&priv->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-- 
2.39.2

