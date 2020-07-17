Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271B62240F8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGQQ4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgGQQ4b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FBAC0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so11908660wrw.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTJcvgjzl2WbUv1DoWCwg8M9V9xkPx+Mjqd/3WwERQw=;
        b=wQ7Ugx06tN6cTgqiNlaXBffnekPJRqU00QjgzCQhxWIuL8gije7a+9CvJopiZdwZ42
         xmMMHVYjRR60uIgrUXKgsDqI1foEG7CnSP7PS9zLvjjojE/rjZOpW8zzjbcaij+tlV8x
         T0+OM7uBOO5sfstYeewTYjBpnRLiovsAJX2rfupkih7IJ3CQ2attrMSvO36KpUBPS/6T
         BieP8fbRrmubmFrQ8inIjB8jD3eMRxeCinYdPucssXC+TdUu7xCR6ZHXdWir6gZ6hgvG
         MQOacYTHPIh60MZnd0vTVCNrG22ZZvv7f9EdTv4NCCJ/VRlqPjNZPWqESJbKG5FVFZc7
         0tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTJcvgjzl2WbUv1DoWCwg8M9V9xkPx+Mjqd/3WwERQw=;
        b=q68zNc0h5cPkKmSyI20VbIu5auRks/73LE+rEtTsurqSIus1Z1zTEBRPNV8w7q3wF9
         whY4Dee13/5zVEkDdMlqsznEDIjfkx3+P1ONTqvc+iBtGIga28/EoJuBsuasIlcWi/jC
         otuTxgguVCxIo+a+dpNDhPcQsYfVR10VQ3FsxaL84oksdjJmp0TXuRC97t5+7AZfn3dJ
         26ChLr4/bXmkPegAhndaGMjUGTNO7NsTsIuO7jhOxQhnSMY97bmWUWKK3qcNz8L4j19P
         vqD9OMjiQoP3YIlOqQQW37WVTXWInWzg2FsfcIENevQGrCZri4Fw11Zst8AAOYdJ5Npl
         k4oA==
X-Gm-Message-State: AOAM533ogD/blw0WzievQQZ203aQ4Xlaop6t5FuPWeqNU0LPn7lFrpHH
        yFffY48UKMYTB+fI55mHgHzIvKH+eKENNQ==
X-Google-Smtp-Source: ABdhPJynhOgEH/VlqaCMSOVSk5ppB3HKEr8nqE5CqXXyCcH8EMQR2+Bp2CW+mJfmtbUrFUJezl8plA==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr12019425wrm.71.1595004989278;
        Fri, 17 Jul 2020 09:56:29 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH 28/30] iio: imu: st_lsm6dsx: st_lsm6dsx_shub: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri, 17 Jul 2020 17:55:36 +0100
Message-Id: <20200717165538.3275050-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:174: warning: Function parameter or member 'hw' not described in 'st_lsm6dsx_shub_read_output'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:174: warning: Function parameter or member 'data' not described in 'st_lsm6dsx_shub_read_output'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:174: warning: Function parameter or member 'len' not described in 'st_lsm6dsx_shub_read_output'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:205: warning: Function parameter or member 'hw' not described in 'st_lsm6dsx_shub_write_reg'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:205: warning: Function parameter or member 'addr' not described in 'st_lsm6dsx_shub_write_reg'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:205: warning: Function parameter or member 'data' not described in 'st_lsm6dsx_shub_write_reg'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:205: warning: Function parameter or member 'len' not described in 'st_lsm6dsx_shub_write_reg'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:285: warning: Function parameter or member 'sensor' not described in 'st_lsm6dsx_shub_read'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:285: warning: Function parameter or member 'addr' not described in 'st_lsm6dsx_shub_read'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:285: warning: Function parameter or member 'data' not described in 'st_lsm6dsx_shub_read'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:285: warning: Function parameter or member 'len' not described in 'st_lsm6dsx_shub_read'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:335: warning: Function parameter or member 'sensor' not described in 'st_lsm6dsx_shub_write'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:335: warning: Function parameter or member 'addr' not described in 'st_lsm6dsx_shub_write'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:335: warning: Function parameter or member 'data' not described in 'st_lsm6dsx_shub_write'
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:335: warning: Function parameter or member 'len' not described in 'st_lsm6dsx_shub_write'

Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index c1f83fe0d8dad..9a14dde4795da 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -163,7 +163,7 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
 	msleep((2000000U / odr) + 1);
 }
 
-/**
+/*
  * st_lsm6dsx_shub_read_output - read i2c controller register
  *
  * Read st_lsm6dsx i2c controller register
@@ -195,7 +195,7 @@ st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data,
 	return err;
 }
 
-/**
+/*
  * st_lsm6dsx_shub_write_reg - write i2c controller register
  *
  * Write st_lsm6dsx i2c controller register
@@ -273,7 +273,7 @@ static int st_lsm6dsx_shub_master_enable(struct st_lsm6dsx_sensor *sensor,
 	return err;
 }
 
-/**
+/*
  * st_lsm6dsx_shub_read - read data from slave device register
  *
  * Read data from slave device register. SLV0 is used for
@@ -323,7 +323,7 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
 					 sizeof(config));
 }
 
-/**
+/*
  * st_lsm6dsx_shub_write - write data to slave device register
  *
  * Write data from slave device register. SLV0 is used for
-- 
2.25.1

