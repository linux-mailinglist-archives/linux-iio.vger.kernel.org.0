Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F312D7483
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390682AbgLKLPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 06:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390637AbgLKLPO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 06:15:14 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A10C0613CF
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2020 03:14:34 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so8212423wme.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2020 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sXNffeq0Nv9J6k2CqRjGfE5I3pGZ+ZTcObB2fYhvzaA=;
        b=l5wtEBaTCacJ9H3K/CWTQm9FV0+w1/YCIup1cQkQMNcqMOFJkBpUsTPc6zKTDEsvRn
         wNsyfgMXOi3zeBiC+LWNNEJnmX8njW3L6CFcCmPEnPbChGEsq2iHls5vv1jqZpQQdCUI
         zLjrGx3N7/+jl0bvw2nxMa+1WoJwSxMWphRK91zwDH9NBFy2+N8TnQVCriIUp4komwid
         w05W82fJJBg5LerjlwqugVfh856mg4K44I1AJeDOmQUAbbxrlueMiqHTrGQS8vRiiGfz
         lGG9TvIdsPhl+G/fbHVmzR64atUGQf9sBH8H2QFJTCYvnxHhI31U3PBToslsaOKk/dEp
         I9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sXNffeq0Nv9J6k2CqRjGfE5I3pGZ+ZTcObB2fYhvzaA=;
        b=hWBVGt8djHzDJUdkgVtVYgshg8R5Q+3H2j64E6fAKMLJhTMqT+vwsMo1liMgFZKn63
         ZSrxYm/DQPHeYYXbQKFmTPrz+IQRZl8lZBIndWnY/iw2Q9F45Jr2kA6hGAf7cmhtkmEX
         RdiK2MnTIYPKitDvyds9hPEulDS6pjiS2Npqeiy5HWCF/LMnjpLGdU5aWGkU2Ryd8q8U
         QxKCAGht9mw+OxkGhkYasfi7EiIkX6c9zlA4GctcGjhcAMmfk/s7kzsrN/M2WjUrgeT4
         w9KybUURbWZXncIRjTIXx6Ejl51fcbgyq0DYPZ9a0pSkyaHYopDVUTA2YzUEuDnFKaQ2
         6D+Q==
X-Gm-Message-State: AOAM530F4pXoNRydFuY7kelad8t9FVz04FYlMAJF/ommoZxWQlMty5qS
        g5P9C5biDyTslPj6DYPMuScOER54a81y3sdP8+M=
X-Google-Smtp-Source: ABdhPJxzOmPmkdNH2A33n10a/0SjKSBXSBX3DjqLf1yF7RYNC4AWRzvg6Fac3qr6R4fVCWZjkzYOAg==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr5174800wme.23.1607685272975;
        Fri, 11 Dec 2020 03:14:32 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id e15sm10949741wrx.86.2020.12.11.03.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 03:14:32 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH] drivers: iio: temperature: Add delay after the addressed reset command in mlx90632.c
Date:   Fri, 11 Dec 2020 13:12:54 +0200
Message-Id: <20201211111254.9376-1-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After an I2C reset command, the mlx90632 needs some time before
responding to other I2C commands. Without that delay, there is a chance
that the I2C command(s) after the reset will not be accepted

Signed-off-by: Slaveyko Slaveykov <sis@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 503fe54a0bb9..ee50f61e496a 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -247,6 +247,7 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
 	ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
 	if (ret < 0)
 		return ret;
+	usleep(150, 200);
 
 	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
 				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
-- 
2.16.2.windows.1

