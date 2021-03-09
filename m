Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3133269E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhCINV1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCINU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:59 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A7C06174A;
        Tue,  9 Mar 2021 05:20:59 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 16so7950639pfn.5;
        Tue, 09 Mar 2021 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1nrq/4ri+fE+Ilcjx/mmcch8pXzmb2SwjOeRT4IcXw=;
        b=iJuGBvTig6gCxoRWZAjYZwOCL5LUQ+ojN2NsJSGSpHX02kW872JtXtqDU0lJSNUPbZ
         ptci+vytxDskqoPNo503TEwxh6zqvcjfQVZQE1K0zmre42auTZocUWwaFangkldy0/Wq
         tu09zItvH6d2oFp6RXYVaObaKyITOnRG1aWPxK57gg2oHlqKNydkW+BCXkA4z2kTnGRJ
         RrXJ+UtzNk6rlzul4h94FAwt50kNvvSqPXVCMdMlzSiz3tOCzb7vuhjUs471pCcUDFW1
         Mn4NJMLXKlp3bky/QRCA6DbuZWfB3ZYrWqcVGblv+/kwnvX485xZbYzxvQy4e0vsWF2j
         Y9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1nrq/4ri+fE+Ilcjx/mmcch8pXzmb2SwjOeRT4IcXw=;
        b=AQPzV6AbTmLDEnQFI8CGkq1oSkmhbdxmGNgXBjAR+jBgq7h3yDE6NWK1RgqcP6/7Ao
         Qer8ihFBYP+GwMB7Z+2jLpD8LxawqxXJmjHhOCkTmBqNDY8290cVp17zGr0JtK6OqKAW
         ufEnMgi1WYnluHtKcqTO8aBh1D2XJUscU6IcAKFD0Bp1mlnvZ+/bu4wqa/IupDw7ifmm
         bGknXVS1XJ0wTdNzwNkES820rrnt11U9WcqhYYe2+qDC++4OkDNUyUcCoRSm7XYowVt4
         UgOxqbKgZATo6mb+Jaol/UOQqx1oxM37y047YyVIQHXaaFI/8mH5tsBfUR9CE6yXnf/d
         erPQ==
X-Gm-Message-State: AOAM533LU7GBgeUUn21/7Gfnh57YzcQyP93fzPpAfzDBwsiDLjPvEiIZ
        TLBt7eWrZrEiWs1lueoHEFA=
X-Google-Smtp-Source: ABdhPJxBiCwRlmZ1ZVaN9w8ZTI3BTyAsztf03NSnBCbgzsKnmm+LmB45p6bpfilnxSSPdBV6BRoI+g==
X-Received: by 2002:a63:d40b:: with SMTP id a11mr3171412pgh.192.1615296058721;
        Tue, 09 Mar 2021 05:20:58 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:58 -0800 (PST)
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
Subject: [PATCH v9 09/33] counter: microchip-tcb-capture: Add const qualifier for functions_list array
Date:   Tue,  9 Mar 2021 22:19:22 +0900
Message-Id: <06801459f7fa7fa47ec973c1278df70181a48cd1.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
mchp_tc_count_functions to match functions_list.

Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 710acc0a3704..cabcfebfc799 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -37,7 +37,7 @@ enum mchp_tc_count_function {
 	MCHP_TC_FUNCTION_QUADRATURE,
 };
 
-static enum counter_count_function mchp_tc_count_functions[] = {
+static const enum counter_count_function mchp_tc_count_functions[] = {
 	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
-- 
2.30.1

