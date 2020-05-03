Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C478B1C2AF0
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgECJc2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgECJcY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 05:32:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31434C061A0C;
        Sun,  3 May 2020 02:32:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h9so6902625wrt.0;
        Sun, 03 May 2020 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/mmHt22K1/kkx3UEk6NpFmo2AhOraXdCBC9rYucPjU=;
        b=BpbK/XA5SEb/BHwOC5qEqRitO3A1TcTCKOeZ6samXTQq9zG4G4KRkBEPgCg4oh8YAv
         /4CFZMSnFbBfJrl/YcG8rQwlvEoco/JBIj73pzEkxlu2xbx9DrUp5K033aUcBhSd1uE1
         OCjQ7+S/X5nt4cYdIz2OiCSOe+3J3NirrF+GUKSkodPryLZm/B18jK855q2MXpRE8CYB
         TmNcjJIzO6S+MGOnyFKugZVIdBzBqHsN8QAkfSvuNDR2pgbZ9VfesEPDlzgiIbJnCUkl
         R7BddwUFWAzXB1Awie1eVAdsUja6lvUdk6BnwEhnxbZriiXRD8sqmxXb+enyw6p+EWxj
         gnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/mmHt22K1/kkx3UEk6NpFmo2AhOraXdCBC9rYucPjU=;
        b=PF59aIswhmMeQePUsKE7qgvLCdMecQ47Rnhpvii85mhRCVtKwfvy47/N2Jp9SUuYSg
         H7mfo3qermWwPrud3EYJhyL2LJwD1MrAFNb6JWP5mBrZ7M3yHOFbSs2P4PDeRkWwmWT8
         6VDoa1QypsHTUpxYSnYzBMWiMbSDf8r1nr7HiDv5MH2GFQlQCTAsSdnLi4qBL6zFT2CO
         zujiQP+oA8UNNVOcrfPN0+R6haalVJd1H6B+XRazc2CAQC29rXB9rDdmrdd2oiENqg+p
         sYLqsUGpG3cW3lVYW9foXrpTSpPGCzwGw5+ux5Kzn9jWu+/gPtR4n1u7aUEkmVZewkqV
         +3Tw==
X-Gm-Message-State: AGi0PuaURefYJWP7iUvF3m+YybJLMrBFFu021XAD48O+/eElMJlN8Lrp
        k2IMLAFSjSRsqf1TuH0cx7k=
X-Google-Smtp-Source: APiQypKXLFowYZptnJJ3uIrCi1n098XwkSSiMR1lPfeDrcQuULs0O0i3gVFLSalVvtbuj3+E2rg5Uw==
X-Received: by 2002:adf:d091:: with SMTP id y17mr12755777wrh.418.1588498341742;
        Sun, 03 May 2020 02:32:21 -0700 (PDT)
Received: from meru.home ([2a01:cb18:832e:5f00:1cf0:acc0:9003:83d6])
        by smtp.gmail.com with ESMTPSA id e17sm10086963wrr.32.2020.05.03.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:32:21 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v7 2/5] iio: vcnl4000: Factorize data reading and writing.
Date:   Sun,  3 May 2020 11:29:56 +0200
Message-Id: <20200503092959.8806-3-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200503092959.8806-1-m.othacehe@gmail.com>
References: <20200503092959.8806-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Factorize data reading in vcnl4000_measure into a vcnl4000_read_data
function. Also add a vcnl4000_write_data function.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e5f86bd00fb0..b976e29f2fda 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -215,6 +215,27 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	return 0;
 };
 
+static int vcnl4000_read_data(struct vcnl4000_data *data, u8 data_reg, int *val)
+{
+	s32 ret;
+
+	ret = i2c_smbus_read_word_swapped(data->client, data_reg);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return 0;
+}
+
+static int vcnl4000_write_data(struct vcnl4000_data *data, u8 data_reg, int val)
+{
+	if (val > U16_MAX)
+		return -ERANGE;
+
+	return i2c_smbus_write_word_swapped(data->client, data_reg, val);
+}
+
+
 static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 				u8 rdy_mask, u8 data_reg, int *val)
 {
@@ -245,12 +266,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 		goto fail;
 	}
 
-	ret = i2c_smbus_read_word_swapped(data->client, data_reg);
+	ret = vcnl4000_read_data(data, data_reg, val);
 	if (ret < 0)
 		goto fail;
 
 	mutex_unlock(&data->vcnl4000_lock);
-	*val = ret;
 
 	return 0;
 
-- 
2.26.0

