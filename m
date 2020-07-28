Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC2230D3E
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgG1PN3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbgG1PN0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:13:26 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FC3C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:26 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so5870813iow.11
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4C6kJxgm5TBz1yf5mhnYEeohqRErvGcIOy3qqF9KZw=;
        b=G8Xb29dOpciFEH1QxLsaCP0CK3QhkLCqoNwroDxUt1QwT67vhhcnxP2xOcNKh2k6f9
         D4I1UJ+Y7gfLEA7S8wXT7BCy6GrCZIMnE9yHzCmpkOH78+K7vy+Z5IzNpGYi+WZCrZP2
         QgbUZcUFNsbSbI+PXxBnJYunr0HV/PoG0q+fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4C6kJxgm5TBz1yf5mhnYEeohqRErvGcIOy3qqF9KZw=;
        b=JXZu5O07gOjkE5m9DZBjdd1iPfvkL/4ViVYXWp3wR6BT0qXEXg4drg5R7mRtMY3+gl
         O4HpFgYbfUJ2l0NGGuZ0lN4FS/b/hB4Cg8srwLlN+wFbs7nuQTcK2K9x2pNzhHdvUFlO
         CY1A4yggAAPbHDnmndTbwHtkT83319lwCPpZns2kPOCOKUdouwbvWgVa9sR2yXb0tCHe
         b+OH+d2hNcWM5kW7L8WBrZoDBdAFTBBlmBq1TUyENpzmaDiysJHGqxr7kdymM3Ya0l60
         mBS7czLR9JVE0PHRmY2VwWpZk44r5ekUoD+7qVqnRaDvRANpqVMtxbhoVXXPxBmUdHuz
         XR6Q==
X-Gm-Message-State: AOAM532qVSCQi80b43lxEXsGspzeGqV3avM2jBZ2eeNOPDNHEcKM/jV4
        WFML+Cc5J5mW6zMapshkOryqUg==
X-Google-Smtp-Source: ABdhPJxLFcoirM9ExI4o/TWJASWDKBlTJxgvvCrz9oB1hPwME+urF+MA+TXSGe245uOxHGkQ6qsBBA==
X-Received: by 2002:a02:5883:: with SMTP id f125mr994489jab.50.1595949206066;
        Tue, 28 Jul 2020 08:13:26 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:25 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 14/15] iio: sx9310: Drop channel_users[]
Date:   Tue, 28 Jul 2020 09:12:57 -0600
Message-Id: <20200728091057.14.I687e37031ecdd9e21078adf8d290c48b6d9d9a1e@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
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
---

 drivers/iio/proximity/sx9310.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 4553ee83a016a3..202018b726e32f 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -131,7 +131,6 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned long chan_read;
 	unsigned long chan_event;
-	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

