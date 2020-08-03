Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F38823B114
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgHCXma (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgHCXmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:42:13 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BADC0617A1
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:42:12 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id u126so3080379iod.12
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TlOlrlXvKy/dxP8XanrvFTIVOHJ2xsZzzW4ZNNxbqnE=;
        b=SL4ZbGfufYoeiv5aV67FYPCP69iJJxf1kiGlEKyreAbc/PIQOChKSdcmC4ggJ9rFib
         ORIv7vnPS6aGFJyRJK17nsfXLtm74uFk/k/xf+ANBBvONcFSCEoBLD5ajgiJnsyv2Vmq
         4L0suo+5A4JwHYrFO4brtS0zQn8nwpp3PHaS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TlOlrlXvKy/dxP8XanrvFTIVOHJ2xsZzzW4ZNNxbqnE=;
        b=CnKdDcmpDBJw6sYBHYr77k8PYD2N03V8EZXnFxlJuCxSo3v4HRYQmmNwlCbLWMzy2W
         fIHBaYMqkQJEJHJNUNbQcKrqXZi/EBu0nf+ZMxeFjOQRyAH3oRjhgl3oHsSJkCmPWt/a
         z9NkyLjkg8HyALjTlUxIKbcu1NT6snDuNGGwbSH9SkQRCd6Wx6SQViLZU43tHjM811ag
         yasJG+oGZAAI/BDhC4a0yiS2ZUHjweI2LIblI7jdRAJvtmeOw9OT9jDkRJQSe9IPk/R7
         Hf/zRBhS2E93HNrNf5vSyYfCRitjrvN3WO1RV+zBK+42kT7VBIU+T3vqnqZe1kFbMvb7
         XnsA==
X-Gm-Message-State: AOAM530KVwyUSSGuhkrhrGkOV6f7sBILYwNd+6z7yRY0Ry0jwuYEFSvg
        ku8m5UP1ZvXqhuEYU8IKDwNKcA==
X-Google-Smtp-Source: ABdhPJxFvy1b82IWfcWuSV5sTLUIYinGrrp2h7y5igwOEByQAXV7GORiw6dMaomMLjMkY1d8Kx/jow==
X-Received: by 2002:a6b:8e8c:: with SMTP id q134mr2313383iod.147.1596498132308;
        Mon, 03 Aug 2020 16:42:12 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:11 -0700 (PDT)
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
Subject: [PATCH v4 13/15] iio: sx9310: Drop channel_users[]
Date:   Mon,  3 Aug 2020 17:41:52 -0600
Message-Id: <20200803131544.v4.13.Ia5c5fdbdfff576ab5d034cde46c25cc66a4baf50@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
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

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 6395f61b720658..2e0ea84dba2118 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -135,7 +135,6 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned long chan_read;
 	unsigned long chan_event;
-	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
 
-- 
2.28.0.163.g6104cc2f0b6-goog

