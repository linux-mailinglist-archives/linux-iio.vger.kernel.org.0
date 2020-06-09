Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8A1F3273
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jun 2020 05:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgFIDB1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 23:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgFIDB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 23:01:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7B0C03E969
        for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2020 20:01:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so19579718wrc.7
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2020 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SmwDWkJ4stL4qv6js29DIgr2yazMzqUZLwr+w5ebWU=;
        b=Q/k0j6yD6ZU04LwWFDj/iiySIFrvvly2WoOzPeML0/16KKXsTGKjuWTCgzvKiJqI0F
         2HAnCOB7aOUYXUkLErqYiuBHb9NsaxYmkFep/fOmqkF5FOKD743skvuIytaYsq/w6MNy
         hwNyyzdixDSorUFU0+I+pI5WxRHq+aKlSlhdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SmwDWkJ4stL4qv6js29DIgr2yazMzqUZLwr+w5ebWU=;
        b=QlBlQEE0dnJKitow1Yzg9uZdOiU3V2W45CMXzbgkV8ciQeLs85CLJnzDTXkdEDNa1n
         Cz1+ahcB5xJOlti3AKQbdrNEM1Y6J3Pmkz2vE7AbyS7euBBwg0NY9zKlkeJGOHf5wo96
         B238ywgO0v48vNNjESuTbE3kcaJPnq/rMWdG4SnaKjBdfIGJ2yoF3y40fQKPiMxmkwNo
         5sUklWOkt6hLoc2vGgdRAe9O623kwf0Ae8AefFRYfMJUlfYgIvkupEgRfx9O7+KaggiQ
         ZJ5VtdHLnZxPO5/UeTaZDcAsIBpn7uHhPm4Jkb6oZF5FaHJSi35AwnU1fraf2D+dWuuK
         hl4w==
X-Gm-Message-State: AOAM530RuvCPzs1stC9/uG/aD7988sVJOLqmQVDoAiTbLYorZsaLndw9
        9gv1XweTYTVhDNl1tVBUfgSY+xMjoQA=
X-Google-Smtp-Source: ABdhPJzhtrvhSnDsRfU36JxmMOUHcTc3JAUIV3adMAPBiVsqsMhpFbUCQxX5p2XXyxVHki8mGDQ8qA==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr2043868wru.124.1591671683070;
        Mon, 08 Jun 2020 20:01:23 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id t8sm1615282wro.56.2020.06.08.20.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 20:01:22 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: core: add missing IIO_MOD_H2/ETHANOL string identifiers
Date:   Tue,  9 Jun 2020 06:01:16 +0300
Message-Id: <20200609030116.23013-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing strings to iio_modifier_names[] for proper modification
of channels.

Fixes: b170f7d48443d (iio: Add modifiers for ethanol and H2 gases)
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/industrialio-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1527f01a44f1..352533342702 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -130,6 +130,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM2P5] = "pm2p5",
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
+	[IIO_MOD_ETHANOL] = "ethanol",
+	[IIO_MOD_H2] = "h2",
 };
 
 /* relies on pairs of these shared then separate */
-- 
2.20.1

