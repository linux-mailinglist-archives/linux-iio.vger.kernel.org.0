Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411BBB5E5F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfIRHxn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:53:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39026 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRHxn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 03:53:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6so1249382plv.6;
        Wed, 18 Sep 2019 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJG4R+fWj0sM0gBzRDWpk4Qq46V/CmHI+1H6OVyYxow=;
        b=LPLquoAAfdRTAHtbCvmLo89FOddl3kLcmoKcvwkZ0Aw07CYrKMn+rFIQ2SMea735AQ
         AhnhBuxblGpnPuo+csACqsv4/PROmfKoa5EOp8kW373rASStMsZzdD+2vvLXcKZJcyxi
         2ImXKEAbpcXEmkfMjE0o+4eZnp8Xd6U5kObCj+vhHZLUxNrHqO3Fb2vGNuc4KjPolu9a
         eNwCsdLN6k8bFLCyXjsqYRR6Fs0KdBq96+GkBgYg897380aPwILuaA9ey3/ifpesPQLU
         w68JEyzljbnOCXit4ZJLKveLJOqxOvOZIgwQR0ydrTc51rSAGBZehoceinBxXYmxAzwE
         T+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJG4R+fWj0sM0gBzRDWpk4Qq46V/CmHI+1H6OVyYxow=;
        b=ZduD4i692kStDB8WozUCW/CZgMpkrEhojxXQgPgXpS4yCtO3n+KYX1HD7OC/B3Os8M
         s04ZHxF475Z2wqgMqwrG+mhNu1b/Y9FU39cSshN12CBCPNsiKPbsrcuhVj12E7b3IZEr
         tfUtJZ/csAxvUaelLOnWlgd7Hp+AUO0bV0o52DlQFCcJD9t2bPMBP9Z78i3C0455fHWe
         E/dFNQsLhXkLtU632NwQYLXswzEC52wrNzSIy/dS5IjlHh95ZeWcV9iXtS1KlmCSuCX/
         rDe4nsJ14mVzVcJE3hlm0Xw5bB5wMc1ivBovJV3UGHG7O5tzsLIrYcxXtXblMoL9QRTV
         iWoQ==
X-Gm-Message-State: APjAAAV9DFRA3VBxInBe9FHq5RpQPgyGhUY7MYq1wC6V/MRghX5mNMV9
        prMaNPbZqlhpjs2YJsm2d2I=
X-Google-Smtp-Source: APXvYqwvA2Z/8K4t3M3bEg5QWzJdOEqfLT2DZsU8W/BmRASwQDwnmEUZ8gxHBxKvOMXGNHlizN8Mqg==
X-Received: by 2002:a17:902:8d87:: with SMTP id v7mr2716294plo.229.1568793222048;
        Wed, 18 Sep 2019 00:53:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c147:d9df:f819:e399:825f:f2dc])
        by smtp.gmail.com with ESMTPSA id h8sm5580715pfo.64.2019.09.18.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:53:41 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 6/7] counter: stm32-lptimer-cnt: Update count_read callback
Date:   Wed, 18 Sep 2019 16:52:47 +0900
Message-Id: <d8c0acde9e5de3930397cb184fd97c1e1372642a.1568792697.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568792697.git.vilhelm.gray@gmail.com>
References: <cover.1568792697.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The count_read callback passes unsigned long now.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index bbc930a5962c..73bb773f5e6d 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -377,8 +377,7 @@ static enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
 };
 
 static int stm32_lptim_cnt_read(struct counter_device *counter,
-				struct counter_count *count,
-				struct counter_count_read_value *val)
+				struct counter_count *count, unsigned long *val)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 	u32 cnt;
@@ -388,7 +387,7 @@ static int stm32_lptim_cnt_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cnt);
+	*val = cnt;
 
 	return 0;
 }
-- 
2.23.0

