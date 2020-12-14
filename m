Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFF2DA0AE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 20:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502368AbgLNTh6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 14:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgLNTh5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 14:37:57 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ADAC061793
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 11:37:16 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 190so4600817wmz.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 11:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yB+KLVdzyQMUcT+dHDlPRhwaV/ue6iqR4CWr5nJaiHc=;
        b=lQ4HCiRq1ZfKlRsquFG27PHbYtjJcOsQ2teC08bxuUks2ZP6G9vQYVsIbcY8alO+sl
         u5kZy9sx4Ayv2DMAd8gQ0V3TiggiIa52ZAOUv9AisWbNHHkCl7SSAvKZYLVLKuze/fj2
         2VRoFUHwfdvrp6i5TNBy8JX7HpZOaMox6BxIZKn6JyrxCCV6UoiBtjsZQQWzhT2ZDMdu
         yBN4NPWyeYEnPvGgiSaa+6WAKZmcGoIp6esMQv9xx9Jp6L6PeOxwixpA+HwK8K2AsVQO
         jfIrDMKNKNpyxNrb9Af4Gxex0UbmxmsCsGop+lDyS4845rqCADQTbBuj5Y/buOaRlgTS
         lHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yB+KLVdzyQMUcT+dHDlPRhwaV/ue6iqR4CWr5nJaiHc=;
        b=L365LGBpUUjrXm1mGlTPHqQ1MbOB7h+lsWcI5Yc70IrXb+MSZnKxX6mT0KhVe89AAK
         c4eVK8YcHiXErSUXWbW9aj2lYVNQQ5AgNNe31ucO2QvMavPDTC9yqDkV+iY1LmKyCZX8
         GHivOQbMkihSQuqSdPZBzoka0Lq1ZDd4z9zotpZSem3RqXhnYZqNv078GdBmts3zXwgt
         FB/85xFAoQPGM3EXo+QYqjMUjvjbHRM8gUC7050Osum+6oq0mSSmfH4SoEEl0Edpljtg
         yonNj9kKKcwgSZvKMm+GmggtT+P4ZJbN21oY4DFqJkldpBNycZYae2XKGYkWBIVqy+VO
         pLBA==
X-Gm-Message-State: AOAM5339zRdVbXUSjX+tdcgfIaXUcswJwi4fyCtPMA9zEzy27GUUeE3D
        3j6x+rsZQ84cn076/fRhaDT7yA==
X-Google-Smtp-Source: ABdhPJxVj60sXGuxHfLRqPtfcHarTRxG3IscgaT98mzkNhPr9exfufgUIg2kRU7OF/j7TrB7jdU5sA==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr28753318wms.111.1607974635709;
        Mon, 14 Dec 2020 11:37:15 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id v189sm33794031wmg.14.2020.12.14.11.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 11:37:14 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH v2 0/1] Add delay after the addressed reset command in mlx90632.c
Date:   Mon, 14 Dec 2020 21:37:10 +0200
Message-Id: <20201214193711.12592-1-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The only change in version 2 of the patch is adding a comment
in the code to explain why the delay is needed as advised 
by Andy Shevchenko <andy.shevchenko@gmail.com>.

Slaveyko Slaveykov (1):
  drivers: iio: temperature: Add delay after the addressed reset command
    in mlx90632.c

 drivers/iio/temperature/mlx90632.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.16.2.windows.1

