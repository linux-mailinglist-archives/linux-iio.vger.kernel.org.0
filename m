Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A082224AB
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgGPOAt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgGPN76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE8C08C5C0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so7137621wrs.11
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SUhdNLbgzPAWgw1RQZwdPTaqr6bugMt+fbr6rtma0A=;
        b=ZAvEsaeFkwq5GcgDYK+/9rJcCLF1cuHMRI3FgfRAhfFpy2lSpeAOVYuwnpiWnp0j/u
         sodd9cME6J+7QQLoK5/xcLsLofod4oprz+mrBGP59qMiTR052FLl2aEyPlxrSmqz2H/Z
         7evmx8t3cXfDTu2Zib3ya9hwIeg8ndWeLJ0UcSwl8wB+vZHcD/ePhbibd7Bs+Bq0gdcx
         9w0dFgkWDfV3gxs9rw0mDHIKpZd7wYTXUiXE1P6DYVjJbfWxQrJo6nGgDMWd4cSHsfh4
         W460RnonrWkqaNjrv7vciSSLANEpDQCyy9BjJE/VYE2Oa7rRev585J4xrIiecbtPLnHU
         dqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SUhdNLbgzPAWgw1RQZwdPTaqr6bugMt+fbr6rtma0A=;
        b=EAeSIgP3N2AELxL7m1EwrKY56+g9IGw778FCXjnfJZRTnxhkLQboKZoAxBgbTHmvhs
         c/NFeylrrtcTiscvTYN9g9HocMuOjPh+prnZiAEiYTn2xuYEFVeZGVYmurnvnveEZ/hU
         mgP2eQepp+sPWyZhxTR47YhUy853c/Jvl9yrl4nGHW4Yt+X+1IPMzv4qlnBKCuVv4+z9
         JWXc4Nhd2fMonUbhYydR9599T3SJJHlOAjZ5Mvxwk6BL+zTd9Vn7lkasKQtHcPQGc++8
         KFVlMMWANLvBXzVgg8WR15WnSxrdKGwDcmqEvEsQkcWf8MRiGechHir85AVVqfWTw1Dx
         XV0A==
X-Gm-Message-State: AOAM533v40ckS0uepWWSHlF8lGnHs6k4bGDLOi9E45Y8hnxLsn0H98CN
        h/JoIeUzmiRyJcp/uDaixIEY+A==
X-Google-Smtp-Source: ABdhPJzmqEBOwvn53W4FP2sjwDCd5ej/MlGX+VNRjOmTyGRQcbKaLe3I4Ls1WV4amb5DWzEuFZxDGQ==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr5010385wrs.4.1594907997025;
        Thu, 16 Jul 2020 06:59:57 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 20/30] iio: dac: ad5446: Complete 'struct ad5446_state' doc and demote unworthy kerneldocs
Date:   Thu, 16 Jul 2020 14:59:18 +0100
Message-Id: <20200716135928.1456727-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'dev' not described in 'ad5446_state'
 drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'cached_val' not described in 'ad5446_state'
 drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'pwr_down_mode' not described in 'ad5446_state'
 drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'pwr_down' not described in 'ad5446_state'
 drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'lock' not described in 'ad5446_state'
 drivers/iio/dac/ad5446.c:323: warning: cannot understand function prototype: 'enum ad5446_supported_spi_device_ids '
 drivers/iio/dac/ad5446.c:545: warning: cannot understand function prototype: 'enum ad5446_supported_i2c_device_ids '

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5446.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 8f8afc8999bc7..15c314f08a007 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -29,11 +29,14 @@
 
 /**
  * struct ad5446_state - driver instance specific data
- * @spi:		spi_device
+ * @dev:		this device
  * @chip_info:		chip model specific constants, available modes etc
  * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
- * @lock		lock to protect the data buffer during write ops
+ * @cached_val:		store/retrieve values during power down
+ * @pwr_down_mode:	power down mode (1k, 100k or tristate)
+ * @pwr_down:		true if the device is in power down
+ * @lock:		lock to protect the data buffer during write ops
  */
 
 struct ad5446_state {
@@ -313,7 +316,7 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
 	return spi_write(spi, data, sizeof(data));
 }
 
-/**
+/*
  * ad5446_supported_spi_device_ids:
  * The AD5620/40/60 parts are available in different fixed internal reference
  * voltage options. The actual part numbers may look differently
@@ -535,7 +538,7 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
 	return i2c_master_send(client, (char *)&data, sizeof(data));
 }
 
-/**
+/*
  * ad5446_supported_i2c_device_ids:
  * The AD5620/40/60 parts are available in different fixed internal reference
  * voltage options. The actual part numbers may look differently
-- 
2.25.1

