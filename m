Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA562240E4
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGQQ4M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgGQQ4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0246CC0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so18193551wmi.4
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYRcY09U97CVxzwpsH08LkHk/eW62/WS+I9jHKij00E=;
        b=S9lD2Fgc5UI10/qScFay1KtnmHz3np9XzTgCMLkNWXkkHSEUblJu5387F4Amn6iIwy
         6Xo5Ixfr4lMmOoDZ4iinaU70w0+tcHGMflhwfBixXPjyprx4xfBtHrKs3nEbQ2A3I6ba
         PH9h+zF6K4gmX8i97SRg/00OkGBSw/v7S59w0j3GUhBvDhegdC/XVKBrLXCScupMj3a0
         qaCf+F3g1vYRFDRPqBt+2oebbS7YTGjCzxT8dTeXOlB8TMUxtUmkYX0qtGx6xn2eFKl/
         bsrIyOak559L1U3wXrbod/rH63Uu/+NP9ZD2bcK/7HiEhpJYvharcDRcBUaZxzyjCERC
         VvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYRcY09U97CVxzwpsH08LkHk/eW62/WS+I9jHKij00E=;
        b=CwMOhGxuM/NiknhL1ntxc6UfE8ajMfUD0wNLa+ooacLJmOGRN7Kt4FxO1zOjmoRNRA
         SDFr9M1QLzTeKUZANauYH3YziGcmY+nDG9KmmWLKNnP3HL+KmndQXZOkKS9kFjJBeQ5/
         nP1pb/wrQu4KV+kkuzCuct1q5QlH62+atJ8QPiME6z14SONgFpGAt2NDZg7cuZmvtJQK
         nabqq+Y0wFBW0yHIrZX+iYxglGu9u6xdgaykJNCkmTs0v/ymSPglWxufslM15d+cQ2Im
         GLMvnIqJzisL5kZWc2TvvGB5hK4KCJgq06Orq6ebxv0Or3Nmo+jJaoidgEWVbMZULZct
         8AyQ==
X-Gm-Message-State: AOAM533f3FXlqjfh0/RtERTo903ywDwuBomdilzgndxAYSgSOXLrQdRk
        ChIcLBCY9vBm3W7LI0Zh9wMw3bfrKUbfjw==
X-Google-Smtp-Source: ABdhPJwM2SKJU6PP5MTF4FYuwv93umVSuD72RMLXGtklHukYXUTZ51NU5+N+dxBdDALw+BaMxkAJhA==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr9977983wmg.131.1595004969731;
        Fri, 17 Jul 2020 09:56:09 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 10/30] iio: light: us5182d: Fix formatting in kerneldoc function block
Date:   Fri, 17 Jul 2020 17:55:18 +0100
Message-Id: <20200717165538.3275050-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/light/us5182d.c:457: warning: Function parameter or member 'data' not described in 'us5182d_update_dark_th'
 drivers/iio/light/us5182d.c:457: warning: Function parameter or member 'index' not described in 'us5182d_update_dark_th'
 drivers/iio/light/us5182d.c:479: warning: Function parameter or member 'data' not described in 'us5182d_apply_scale'
 drivers/iio/light/us5182d.c:479: warning: Function parameter or member 'index' not described in 'us5182d_apply_scale'

Cc: Adriana Reus <adriana.reus@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/light/us5182d.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index b995f21a33479..24843597beba5 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -446,8 +446,8 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
 
 /**
  * us5182d_update_dark_th - update Darh_Th registers
- * @data	us5182d_data structure
- * @index	index in us5182d_dark_ths array to use for the updated value
+ * @data:	us5182d_data structure
+ * @index:	index in us5182d_dark_ths array to use for the updated value
  *
  * Function needs to be called with a lock held because it needs two i2c write
  * byte operations as these registers (0x27 0x28) don't work in word mode
@@ -469,8 +469,8 @@ static int us5182d_update_dark_th(struct us5182d_data *data, int index)
 
 /**
  * us5182d_apply_scale - update the ALS scale
- * @data	us5182d_data structure
- * @index	index in us5182d_scales array to use for the updated value
+ * @data:	us5182d_data structure
+ * @index:	index in us5182d_scales array to use for the updated value
  *
  * Function needs to be called with a lock held as we're having more than one
  * i2c operation.
-- 
2.25.1

