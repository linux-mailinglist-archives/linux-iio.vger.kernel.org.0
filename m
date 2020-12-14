Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA692DA0AF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 20:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502447AbgLNTiH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 14:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgLNTiH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 14:38:07 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35300C061794
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 11:37:27 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so16343828wmf.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 11:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mxVMFZof5qa/YeCWJQrA31ltyLT9SuKZlABcRnYhXU4=;
        b=I4vMcENwMRAaOhK5tWUjGJ/nNSDqMYWnzzg5YF/vARRXxWI+ZqH1RnFjYK1fQEWqGI
         gb3SD+h6K3zU2m4QTT/ThOtOhdFZv0z/kowWIl9KqT0eAsnIp5TMxX1uZg1h+XcIgu6z
         LcoXUVdYT7fTQkZH/1ZldPUhgAV+g2hF7FOgu2w3+gKhXU7vWLTKNN93a1V10YCFCuys
         aWLTffAUC/GgQJwktTk8aIVeGj2PE3a2du3Q4xETLuoR3iW9B3g2xY9TsZixng/qx2GO
         TlYyu/FFX/aTDBRRnEbuZlDrkKPckD8fH10DaJOgaXZcsofQ5MCaQgDMqyzZINrooM1A
         JOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mxVMFZof5qa/YeCWJQrA31ltyLT9SuKZlABcRnYhXU4=;
        b=eeHSbTXtGU88x8HkgA7WGVLwHxzrwH/jknyEelFwNzb/k41kKEGH5MNkITwO44tDGA
         gdUq271IAOxeu0Hcs62e1kbdlUs68f52/RTzGpG1sAHx1/RK7lcjHzwLWdiZjVb/PRal
         sie6qyG0gsfJmX8vrJ/RKo4aln66F/lrfdYIz9O8tkcGaQTheyjgWg4vakufGqk/7FRz
         GvTyc4wUzuRR8uKru5TKs2/RhxlbMBQeitCn+pi5EilV2Dkmen13eGlo4pboLa6OjKYQ
         Beln68r1nJpA6K5XBhh7xa37Mpf7nAfFXi1MYfPoUtKmu2YL01oP22H4/ixz99DY637T
         ZfGw==
X-Gm-Message-State: AOAM530BJC+SCMuun9PdcEs9p7KCPWZNCDEc+E2Lkf7TPByQjzoUVCct
        IXqsxs74K420g+OXT8XbVwDG+ZEhkgajhnee
X-Google-Smtp-Source: ABdhPJy2KEATAh4rZysIzs5WeU7KOE+U/G3+VsifYpk9oK+SBBHq3+INP5gtQf5+xkHjZjlez0Hx4w==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr29608801wmc.117.1607974646001;
        Mon, 14 Dec 2020 11:37:26 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id j9sm21343631wrc.63.2020.12.14.11.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 11:37:25 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH v2 1/1] drivers: iio: temperature: Add delay after the addressed reset command in mlx90632.c
Date:   Mon, 14 Dec 2020 21:37:11 +0200
Message-Id: <20201214193711.12592-2-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
In-Reply-To: <20201214193711.12592-1-sis@melexis.com>
References: <20201214193711.12592-1-sis@melexis.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After an I2C reset command, the mlx90632 needs some time before
responding to other I2C commands. Without that delay, there is a chance
that the I2C command(s) after the reset will not be accepted

Signed-off-by: Slaveyko Slaveykov <sis@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 503fe54a0bb9..f0eaadec11eb 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -247,6 +247,8 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
 	ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
 	if (ret < 0)
 		return ret;
+	usleep(150, 200);	//give the mlx90632 some time to reset properly before sending a new I2C command
+										//if this is not done, the following I2C command(s) will not be accepted
 
 	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
 				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
-- 
2.16.2.windows.1

