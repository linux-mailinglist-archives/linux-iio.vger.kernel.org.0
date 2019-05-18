Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042742255F
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfERW1o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:27:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46271 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfERW1n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:27:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id a132so6603077qkb.13;
        Sat, 18 May 2019 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=hy5p245u/hqfnBo05YVJIyRfP8Rg4GNqhBJE2ChmnFU=;
        b=S8YmYgYEIqWloUrBR/fwQpYB01cQKqEWJ52gGf0snm/GKFZGEet2pUE6m6NVS6vTl+
         iJcby4aq70fMsKx/JUjQvZPz6beLW92ERuI90JAtMKFzONo5Hrl88oXLkySDxgS43QqE
         i6MvqcU6eJnhb3WQi2cgqha03yfeFRqqcc8NYax4E3Q876WDD9HIv9KOuCHLVfPdA5Dg
         vRdAMcRhptxZJkP92pRjNQWJJhLbhmQ0Qa1TsLjueSAjCag7KVf6y52nZ4qcrPUatFXU
         M8LCidr1j3mtksIS66hvDdgpQkgqqWWxMuqnJ5Mf1AD1dCN3FhJ06xG4wfkf6P9opDGh
         mH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=hy5p245u/hqfnBo05YVJIyRfP8Rg4GNqhBJE2ChmnFU=;
        b=VRFOjX0YNJVACOjCmD/9WuEY1MVuQfsm6fZaJQ5ZTjPCfevNTM1GnFRolmRhNtiL01
         AVx/iK1nCpQ7hSmdwOeWveSNQ4lte9rm5UUpoV870Sg02tOqiR7xEVi1cYwmkfv8HG+H
         L7YWSVjcT5beL7fqVIx/o+wTcv/t95dPWwpPslLGcC8LUrtlfP8PL1i4hETAOvPRyYyC
         qmh8+jTN5DbSC7qrEq08PG4RX+Ag+Z/yOnponqhKL9050tDUhOCJ0rvEt+7rkfPe38hu
         0pUFNKgboAvEze292mfWpU5plc7vumFR50PBqrARs6TGY6gFZ05H1PgJUKJ1q8opIisQ
         E97A==
X-Gm-Message-State: APjAAAWXFr3OZ/gYo5Z97q94POGl7EM0Db5WsPkjenpHXMpsKILEQQzr
        /z684opamFCxCo8JXyS1tnw=
X-Google-Smtp-Source: APXvYqwbh0b5G7fQ/Je9ThH/GFzks8ivtZyyrVjHAZyJWdBrSA2GNyTILBkZKch71UD4lhHvnemmWQ==
X-Received: by 2002:ae9:ed45:: with SMTP id c66mr49545224qkg.86.1558218462666;
        Sat, 18 May 2019 15:27:42 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x3sm7201145qtk.75.2019.05.18.15.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 15:27:42 -0700 (PDT)
Date:   Sat, 18 May 2019 19:27:33 -0300
From:   =?utf-8?B?Sm/Do28=?= Seckler <joaoseckler@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ad7746: add device tree support
Message-ID: <20190518222733.2ttcgvy7fct4awra@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a of_device_id struct variable and subsequent call to
MODULE_DEVICE_TABLE macro to support device tree.

Signed-off-by: João Seckler <joaoseckler@gmail.com>
Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Co-developed-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 47610d863908..21527d84f940 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -748,9 +748,19 @@ static const struct i2c_device_id ad7746_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, ad7746_id);
 
+static const struct of_device_id ad7746_of_match[] = {
+	{ .compatible = "adi,ad7745" },
+	{ .compatible = "adi,ad7746" },
+	{ .compatible = "adi,ad7747" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, ad7746_of_match);
+
 static struct i2c_driver ad7746_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.of_match_table = ad7746_of_match,
 	},
 	.probe = ad7746_probe,
 	.id_table = ad7746_id,
-- 
2.11.0

