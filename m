Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05B7341ABC
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhCSLCU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhCSLB7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA9C06174A;
        Fri, 19 Mar 2021 04:01:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y5so5629489pfn.1;
        Fri, 19 Mar 2021 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2r+hb4QLBinjqUWBtvalv2ZNlSEWr0t8LgbnD3rkGXY=;
        b=H51BuvBk+d+VrafWjiNmYuhXP7SH4yFn00mnwg8b97GELTFmQGDRHkiyl3cFn2Du8H
         iWdGT8w0g9J31DJ5Cediv47FGjuMnN0brALAyV5qutKgiyTRrWt6cnr9K9P4qAvY42uS
         odgf7DXOOTPORiEcmIVEiNWzL3LvvJC042qtOR3WoPClXPiC05+8SR3a4hrhbJYM8U58
         /FTBmCjxLdoE6ydhBNWZrIBpCJya8vha05aBc/bGwLcFXv0PBKDhRXj28uaYVv3GGi9r
         90btPv0mGImHFMNNFp7ji6CM7sjqsxsmaok6UU7JjI9WyGPunAhcRIowDks2smDYvJHP
         vmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2r+hb4QLBinjqUWBtvalv2ZNlSEWr0t8LgbnD3rkGXY=;
        b=eeUj4T0SWRHhmldcMf3B2IMa3ANCrT9b8wvEf+NKTPxl4CZgXLi+bZmObO5Y+X6YJS
         l17JoMwW/KNah0eJuQ7eFW5FWPN+csZD00AwdVWqG9pwFB7Ez5G4igozjdn592I0pyIC
         qO1zKsfErOk9ewMUsG7WRrtIbcRNlcusKH4ytbxuEo3PEFg6DMa8qORhz/rjYPU3Wylo
         l+pvm6yBlbeTAGmQm/AMnyZpxwMvhAxScdGGagNeePss+40iTizbeTDINKTKQV5Od802
         IYCL+MfzTLjJIRdS0/KGKz2dJ5XlqepjLK5MTktASpSpqZfSFNxB0Z0LYA8iJw1zTcOO
         CCwg==
X-Gm-Message-State: AOAM531IUqSVx3+w5v6VX3N4iTu/3iknTlkgtGgy0LQ8NjeHLwrJzJLm
        zXhYb1HEXhMPU48rlo0iZ/4=
X-Google-Smtp-Source: ABdhPJy7/4zKHODKQrPCYa79oyG0kmHaS2DclyVozWj+lMVQ0xUggA++2YKGb1mbTv1owgD153DeBQ==
X-Received: by 2002:a62:3384:0:b029:202:ee3:f83b with SMTP id z126-20020a6233840000b02902020ee3f83bmr8759016pfz.77.1616151718601;
        Fri, 19 Mar 2021 04:01:58 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:58 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v10 11/33] counter: stm32-timer-cnt: Add const qualifier for functions_list array
Date:   Fri, 19 Mar 2021 20:00:30 +0900
Message-Id: <b1baf33d515a911664650f006c035784c4d79eb2.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
stm32_count_functions to match functions_list.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 75bc401fdd18..0c18573a7837 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -50,7 +50,7 @@ enum stm32_count_function {
 	STM32_COUNT_ENCODER_MODE_3,
 };
 
-static enum counter_count_function stm32_count_functions[] = {
+static const enum counter_count_function stm32_count_functions[] = {
 	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
 	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-- 
2.30.2

