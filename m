Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC43234989
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgGaQtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733270AbgGaQtL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:49:11 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73999C0617A9
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a5so17040892ioa.13
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNO8JDVb/SFk+MZRQqz5iQK8yjAhcQOAAqpSPIcW0Ic=;
        b=C+UdcSQ0iy59AKiSH7cnKdOWjWflQPoNxLtMMYkz74eaK+aBTfCoFNCUH/f1m1HoY6
         r+Jgcgg29/0TPKYe3rZJiTqbMrWU1H0MJn/wsYZX2PrjVP1dv/XokPV0BfD5Z56Ub8qk
         mzgQmXKBCWymJwXPDZJFs0upDNEoaulOSUfPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNO8JDVb/SFk+MZRQqz5iQK8yjAhcQOAAqpSPIcW0Ic=;
        b=LutkatmnaslpP97cFZC5YSnyynbgQ1F3ornPHi5Ye52F1bJWq2OGLe1rHPyS4o/IEA
         1DrZclGG6yy+IJGnHntnIESi13eXllKBh3NzB139Zxykjngs/ahsjz0CHmsrfN7d13MY
         JvwiWRJFH7Pp4FlcyQBQAs/IdibeqbgWB4p9d1QOHHrlfWqzXfW+zLD2soGMVVeYKpfS
         maJmymPFiU/O++17joR3M/c/zKZ7nisbf7qiaopkyEweyqMLkOhoL4Q0RPc7/EJyFyIG
         3YgS+M2a5bBnDhK9EdKxpoJuzPZieAJZwxmMSiYZukC3ZCqM9EM3HpQjo9Eg52iNB3oI
         kYgw==
X-Gm-Message-State: AOAM530scxBvGm8ieABzNa+vU+tB/pUGOCHxyHu5o2JlWp9BGECLX2/H
        12VEc+S/FDunqB7+bx51tPKDiw==
X-Google-Smtp-Source: ABdhPJyDHx/DoVZfetBIrsHM9jFPgEOZ4dOXkmAYl7/UibvQxkW79QxjrjhXFar/WE+tm5T1r0xFJQ==
X-Received: by 2002:a05:6602:1587:: with SMTP id e7mr4442835iow.203.1596214150868;
        Fri, 31 Jul 2020 09:49:10 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:10 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 13/15] iio: sx9310: Drop channel_users[]
Date:   Fri, 31 Jul 2020 10:48:50 -0600
Message-Id: <20200731104555.v3.13.Ia5c5fdbdfff576ab5d034cde46c25cc66a4baf50@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

This struct member isn't used. Drop it.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Campello <campello@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 886fcbd52703c5..aa21f6f1a58e3c 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -136,7 +136,6 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned long chan_read;
 	unsigned long chan_event;
-	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
 
-- 
2.28.0.163.g6104cc2f0b6-goog

