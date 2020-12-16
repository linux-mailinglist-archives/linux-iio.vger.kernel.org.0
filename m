Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D78E2DBFEE
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 12:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgLPL6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 06:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPL6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 06:58:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5181DC06179C
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 03:58:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b73so24480244edf.13
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 03:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=799gjF3kfd0/ELRYkWUEqk7uvzh98PIirwX1/XxWeFc=;
        b=S/FYqoGzlERnodrbSyoyvIo5dH0x4fVf6Z6CK2ZTQJ6FBOpGIsT+WE6ZxDeCWte+mi
         feCAgaX/hhaQ24wb0V7Ie8JIV50VZHbUMZ09WnL1SO3LpnVl14Tg40VBphO3iiTsphNn
         Wy5Q7oxfxzWn58jUNPSin0bs+PkdGIqCBPkBrdAPJJxGw+OZ2YVZAKETc8ZbCNYSc30+
         ojYokpcjJfzLkVS+3kInlQeLPRKHf/wc4q7E2EpEa+gYJ8kOpMw/DN7Np4TZqlNsW2tH
         LmkCghuyXoWIAe1XCXzKXQUZkOR343khhc43PziEPsKMRG2oKnCfDfxdm+YPt3Hp0tXM
         CQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=799gjF3kfd0/ELRYkWUEqk7uvzh98PIirwX1/XxWeFc=;
        b=CAAEvsjP7xoHNhlHn5U4lMCYAPEmWOEEKIBRMSGYuThKskez6Wlm1MvsXT/YiZ6IbC
         9uUuAhuVkvqgRnpRAKLu5ts1ct8xuE60jew8Z2+Dg3i4r0g6lguV2YVa5DJ5VwpNs3GN
         Xux2FvTL457j1/qz5xB/SIIF/S3P1mETr6KsYYd5NyRDpTp+N1u74TD5f3/AJ5OLtRsY
         hQs63SGECUCaqcx6cYHShIAMArcUohRjVr02tos2m5eYKX+/2cendPZ49LY/XHsHtBAE
         dd465Jh8B8vu9YIVJ/g7NJndG9zdB4CMFWgjS3DgDynF8U8TcWXoCfh70Axnmm5xradq
         rU8w==
X-Gm-Message-State: AOAM531dbJrQJp8T3yH54/rbNY6NPlc+jOc6FM+3iy9HOkD0LH7an0Vd
        40DIs5kEPpYW8nm3bdACcMyHLw==
X-Google-Smtp-Source: ABdhPJwSPRPJBAFiX/BEH9gSxxnbm346Pox2GNemrGnWjFs391/dCDT0E4t6wtwwxaYiKOU18sqbhQ==
X-Received: by 2002:a50:b742:: with SMTP id g60mr32887378ede.113.1608119882033;
        Wed, 16 Dec 2020 03:58:02 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id b7sm1237433ejz.4.2020.12.16.03.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 03:58:01 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        lars@metafoo.de, Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH v5 0/1] Add delay after the addressed reset command in mlx90632.c
Date:   Wed, 16 Dec 2020 13:57:19 +0200
Message-Id: <20201216115720.12404-1-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The MLX90632 needs some time to reset properly after an I2C addressed reset
command. Thus a delay is added in the mlx90632.c.

v2 adds comments as advised by Andy Shevchenko.

v3 changes the comments style so that it matches the preferred style
for multi-line comments as suggested by Lars-Peter Clausen.

v4 fixes the comments style and it uses the appropriate usleep_range() 
as suggested by Lars-Peter Clausen.

v5 Commit message and comments stylefixing as suggested by 
Andy Shevchenko.

Slaveyko Slaveykov (1):
  drivers: iio: temperature: Add delay after the addressed reset command
    in mlx90632.c

 drivers/iio/temperature/mlx90632.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.16.2.windows.1

