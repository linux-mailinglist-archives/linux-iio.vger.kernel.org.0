Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB02A3326AB
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCINVd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhCINVY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:24 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2CDC06174A;
        Tue,  9 Mar 2021 05:21:24 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t9so880170pjl.5;
        Tue, 09 Mar 2021 05:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMXw7mJLvmbOCLGtZkacbJfdNcshHDOykbRbagCdG6s=;
        b=dS5t11yTimmAgWJ/VyICyJwpRHriakfanzUCa8NwNNgvjVV+OGrPXIiYtW0Ce4opoj
         rYPFyJDZvTANqOGxcWde7x9EbxGjgYr0F4jX5zctNvALNAqyNnOMOM0QLHzURiv0A0YZ
         T5710qgW8E/37FOATqErMkbQdmEqgjmUQfVHaTEwtExaO4o/oSs3f+Qh2j2MU0hQnBLX
         Rb1i2KdWdYNFjby3VInHJSZvRbjDMr6ghHAw18IbicCLbq+MQ1m97oQzgjKucim0ZBXE
         YRcJGy1mmKRRtRGnf+2HPZr70tPqUd9+tIReg3e0KnviRS2tRAyDCLZlgmV78FIT0EM6
         VWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMXw7mJLvmbOCLGtZkacbJfdNcshHDOykbRbagCdG6s=;
        b=EwYVu6UszulHaBIJr0TiBXM6WGobReJd6oA+U04ooPyLRHOkQMQCcHeYUzs1scsQSP
         ZW0e+0pvw0+vv+RvR1jazR8LyvwXyrykxMMsAbYvbeBWesbKuWZNIfzeCUGS5z0DBltl
         yY56voJng4c67HkFdMKIQIvphIQL2tStvSQjO0bRWfb5r/h+6Zwjcm/Q7ttaIkO+3yDP
         Ztt+DV/3FjOyCNXee5exOEKHrR3xlWLYrqPQLMp0JAOWxmY2px2c1eFSt4/oHNTe6mD4
         cbBDigyStDwA/lpYr/Y4hFaN26NZ/zLOPjtZ6YZtITneN+VT5ngGwJ/BRjKOd2Eg35QS
         Ehng==
X-Gm-Message-State: AOAM531lAyzu7iZetKRi1oIeGPTOjpuxY8ebG4RblScmZDJAFFhSbTXH
        dgO1SZsK5XAknhq33Gl1LO0=
X-Google-Smtp-Source: ABdhPJxoxzQivWDNyZ9YM3b54AMuzlgre0Fcfw0AmJmmILw6QJPteZGZXZjWn8Dhf1/XZN5tsVsGDg==
X-Received: by 2002:a17:90a:ea91:: with SMTP id h17mr4726826pjz.66.1615296084435;
        Tue, 09 Mar 2021 05:21:24 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:24 -0800 (PST)
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
Subject: [PATCH v9 14/33] counter: interrupt-cnt: Add const qualifier for actions_list array
Date:   Tue,  9 Mar 2021 22:19:27 +0900
Message-Id: <0cad0b85e28f558e4774f02ca267c32a6ac03b6d.1615293276.git.vilhelm.gray@gmail.com>
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
interrupt_cnt_synapse_actionss to match actions_list.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/interrupt-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 827d785e19b4..0e07607f2cd3 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -77,7 +77,7 @@ static const struct counter_count_ext interrupt_cnt_ext[] = {
 	},
 };
 
-static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
+static const enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
 	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 };
 
-- 
2.30.1

