Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15ED3326A6
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCINVa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhCINVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:14 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DCC06174A;
        Tue,  9 Mar 2021 05:21:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id p21so8752153pgl.12;
        Tue, 09 Mar 2021 05:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWre/5BlgKXL1iyhEnRSRabCNrSj07MKqwX9rpON0N0=;
        b=EPzgiswKRcoUeRnTBjq6Tx6uWKKDlWfj9SXcpEIGX2skUnRDOEjyOUn+jjyGxouEEv
         YMCtoqmhuTgfDRjRy1NYIHZVORxf4YhW8Kz4z8O5QQ8NEDV5RfsFvfs5pzaVEOoTjMDJ
         8s2C1k8e7ZHi/cDyYDaAuNjVNgUzNKTI5Z/RUdmDiRyMkvBsJSI7l9tcffOce9RNxK/h
         gMy9LgWYczmXXhK+QOos5Wb/c35vxbnrxV1oHjrVYv6NK//hd1qMDrXIWg3i/rN5ljJw
         sjdOGduippNTDY+jLvalvicHZymCaCWQnU0RBGfdcjx+nYIjZzu/qE/SKH5exRTqg0i7
         iAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWre/5BlgKXL1iyhEnRSRabCNrSj07MKqwX9rpON0N0=;
        b=WVV3Xic25hRh78ytu19ijt94w/nE5LiRFKCacLBZ/fMnVRZ7g4kEVqMA6HH1OvBYLz
         XSlrjUiqKkf99dTsTO/AFX1JiL/mNmGeJnhiK38p1/rBMfh8moNjqFhEV5I4meKxtL+x
         LyEyLCBTwiucKQsu8T0zv2xQH+PWxc5OtT5Dl0cjmUvJo7hSJLffCv/CGTCoV+Gxko8M
         h5WOY1/+Ur4Jrggq/ZJFcvYARQA/2wuwWB4SrsOzerQRlWoWdI5XY5gPER+IildimfCh
         Bwt7qdX4pyQI4KzgcMNg3bXzviBVr+d5JyTxLmA/12qbI/26+lfAm0hBY1ZOJZK98I8e
         2J5g==
X-Gm-Message-State: AOAM533GLkW+kM68fYD1Z/rHyPQCjDr8hqnK5WE2DjUbzFLhPGBhRBGj
        d3WzDUh0eptvbBdIT42WkIk=
X-Google-Smtp-Source: ABdhPJx+4sNzc6b+jcn9nwYXMErpaUoVChItdCn/vQu7L4lcitioJp3OEfACaGLCYqRp1bdW5bK69A==
X-Received: by 2002:a63:5014:: with SMTP id e20mr24895866pgb.152.1615296073915;
        Tue, 09 Mar 2021 05:21:13 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:13 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 12/33] counter: 104-quad-8: Add const qualifier for actions_list array
Date:   Tue,  9 Mar 2021 22:19:25 +0900
Message-Id: <fcfbb9a605bf094e11a3ae436257e11c5186ef44.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch adds the const qualifier to the
quad8_index_actions_list and quad8_synapse_actions_list to match
actions_list.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index ae89ad7a91c6..09d779544969 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -305,12 +305,12 @@ enum quad8_synapse_action {
 	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
 };
 
-static enum counter_synapse_action quad8_index_actions_list[] = {
+static const enum counter_synapse_action quad8_index_actions_list[] = {
 	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE
 };
 
-static enum counter_synapse_action quad8_synapse_actions_list[] = {
+static const enum counter_synapse_action quad8_synapse_actions_list[] = {
 	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-- 
2.30.1

