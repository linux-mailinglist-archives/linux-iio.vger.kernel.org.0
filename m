Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07702253F
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 23:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfERVfV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 17:35:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45331 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfERVfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 17:35:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id j1so6585462qkk.12
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HjafOF3we2ISgKmws+AAmSPCOfvoMlLfEcLpwFAOH20=;
        b=Idg02TPx+T27kQzFx9Ad4TKrU7/CmGjWW/b6QxPiELeEJUSNf5d6nEbVgI9Yi5u73m
         mCewTHJYaARQnQlcI1aeQ61mv7XycV4hgB0FNg8OHIra00wMr9gQ4PlqQkSAhwf1f9kY
         ZUFWKdEaalH2O5XCqUpLsbpctqZA10HyivfwI4uZFLNS3YQO7Z3LKqpD+n5gVBlXwBgr
         xHEMh+HvLFfqXpztEb5RYzij2RJFaKubjHwj2OYj+gWDcM9ZBMRUJ3vLGxUfv+dFBEKh
         Mb4OSvrD3inq42YG8glrYVLxQboENXg+BneK3twCKDcYw/MWHidL6XaQ8FRlpC3BFIOo
         8RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HjafOF3we2ISgKmws+AAmSPCOfvoMlLfEcLpwFAOH20=;
        b=Mkb2f4B7V7tszMmeVa1xWM56jy4IeDZ2/BmQXMQuyBlnUQrlZgWFWsSn7aXhmeZyPJ
         xt/M/ca0hgoFs7skgmySrlhmO1eeWd1rpw1oqLi9WEpdm28AMct/z7dSwyJ8wKKSD68V
         LJG7T2PlDRtaOtN/hlTltfl0zSfmBakGrogRTItLLVBG9/sSoBYsLdsOSk+KWFXIuKT7
         NwtpozwHcNAPlAaFbJ5+jWVoNmVjBrH3MC0hT/BfgmOFWMvfszcqU5qlS7OVQ4+qI9do
         Laj0VbHRiOLDxfAjt4EYXMn4XQepXE7tIWm2h2+j6aeJFjv5bENhp1srJLxe9b9hAaoS
         4aIQ==
X-Gm-Message-State: APjAAAUiXMwvWnLUuaHZYEUANfb/gKpsyB2hI+teggbR9Hgj+TSqDA53
        lP1u1eUI3MJ4bBJuWEx5REl2pjHvIDI=
X-Google-Smtp-Source: APXvYqyAj45jx+hMSMOodhJuwtgh30L2XYcgQYQHvPmVeJhWjh0veWlFmRlfmxfqlLtCVHTzBsMOvg==
X-Received: by 2002:ae9:de87:: with SMTP id s129mr50958449qkf.63.1558215319581;
        Sat, 18 May 2019 14:35:19 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e133sm3168333qkb.76.2019.05.18.14.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 14:35:19 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Melissa Wen <melissa.srw@gmail.com>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [PATCH 1/2] staging: iio: cdc: ad7150: create of_device_id array
Date:   Sat, 18 May 2019 18:35:10 -0300
Message-Id: <20190518213511.23253-2-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
In-Reply-To: <20190518213511.23253-1-barbara.fernandes@usp.br>
References: <20190518213511.23253-1-barbara.fernandes@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create structure of type of_device_id in order to register all devices
the driver is able to manage.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Co-developed-by: Melissa Wen <melissa.srw@gmail.com>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed-by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/cdc/ad7150.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 4b1c90e1b0ea..072094227e1b 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -655,11 +655,21 @@ static const struct i2c_device_id ad7150_id[] = {
 	{}
 };
 
+static const struct of_device_id ad7150_of_i2c_match[] = {
+	{ .compatible = "adi,ad7150" },
+	{ .compatible = "adi,ad7151" },
+	{ .compatible = "adi,ad7156" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ad7150_of_i2c_match);
+
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
 
 static struct i2c_driver ad7150_driver = {
 	.driver = {
 		.name = "ad7150",
+		.of_match_table = ad7150_of_i2c_match
 	},
 	.probe = ad7150_probe,
 	.id_table = ad7150_id,
-- 
2.22.0.rc0.1.g337bb99195.dirty

