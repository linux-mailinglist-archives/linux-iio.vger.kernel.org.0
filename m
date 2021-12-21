Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E83F47BB97
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 09:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhLUIRK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 03:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhLUIRJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Dec 2021 03:17:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D70AC061574
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 00:17:09 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r138so11672214pgr.13
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aRLeyWGQmaBIGWQYdaMGRPHT7zgXBAkrj+tRLFqqHo=;
        b=Exv7CVPLc3Ol0D/FD20r5qL3WzVs1zpkuZ3t7XE5xevhCCp3kjv3VPwaG7ApU2/crz
         z9q58+4cX7QsaKPAAFB/UlPRJdQgt8zlMGVUwwcsKUdAwx0tSlAI+DMg4O0G/EBCU7Fz
         Ra+iEWxZQDX50pVmIAt1j/ylRBKL4FBIi7TPral7jrarQnwntWI8x7FL8NBVKAzqB/d2
         ujYI1HCaa4oM05llgIfHgmXBIy8coMXi0GxMsz+I3vks/svM9T1DTsFSc+X0Pmu0Kxnu
         DC/I7sOqeCaylay38XxQOxliZyUEOMsdJhm3FT2yyCO7+SBNq9A8ubyUJ2CMyBsxxE16
         ImOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aRLeyWGQmaBIGWQYdaMGRPHT7zgXBAkrj+tRLFqqHo=;
        b=e+Z+2W/bRXD/1nQ+sG40QPTz71efH+LjVfKwp5L/3UEc4BVnDi5/yxzVf+86aJNExE
         1Ky2ZG/wEhYaQhCt2dJYP74GSjr1w0rw/pw8Fa+VqiO8LzFGB0/Suxg8gDtpBShItitr
         1KQ+BKTtblYoMgzACG7tBHwB48G6eCr7LfFLu8StUrJif3a6e0/tULMe0zGYz6d6t7nk
         hayD2hf3d23p11WRE2rzit6HkryYzs+QlylEE4zYJCaD/eRfsa3Wkd6cOFITfMwvnhx1
         iBMrNjKjP2RJLZtufzhXGux7hCLYyHV32JhrN8HFGQdjXGmqA2RBqi+VbwHfr0wh6k87
         Nmsg==
X-Gm-Message-State: AOAM533GtSnMIkuZ7sLl3wJTbtCOcVcz2/xWOXfUVjjagjFzJ7CxEDu9
        Izo3UMcLzCsRlcaHfRtx0sM=
X-Google-Smtp-Source: ABdhPJzDHgVhxjgqgMa0Unc8HDx7qLqsx3OSfbQ9DC5SFtHewIV6c6qHVeM/FWXwuoMhQ2ANKdQZhA==
X-Received: by 2002:a05:6a00:8cf:b0:4ba:4647:51bc with SMTP id s15-20020a056a0008cf00b004ba464751bcmr2037673pfu.18.1640074629149;
        Tue, 21 Dec 2021 00:17:09 -0800 (PST)
Received: from localhost.localdomain ([37.120.154.44])
        by smtp.gmail.com with ESMTPSA id b6sm21196890pfm.170.2021.12.21.00.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 00:17:08 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        Yanteng Si <siyanteng01@gmail.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 1/3] counter: Add the necessary colons and indents to the comments of counter_compi
Date:   Tue, 21 Dec 2021 17:16:46 +0900
Message-Id: <26011e814d6eca02c7ebdbb92f171a49928a7e89.1640072891.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640072890.git.vilhelm.gray@gmail.com>
References: <cover.1640072890.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Yanteng Si <siyanteng01@gmail.com>

Since commit aaec1a0f76ec ("counter: Internalize sysfs interface code")
introduce a warning as:

linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/counter.h:43: WARNING: Unexpected indentation.
linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/counter.h:45: WARNING: Block quote ends without a blank line; unexpected unindent.

Add the necessary colons and indents.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Fixes: aaec1a0f76ec ("counter: Internalize sysfs interface code")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/linux/counter.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index b7d0a00a61cf..dfbde2808998 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -38,64 +38,64 @@ enum counter_comp_type {
  * @type:		Counter component data type
  * @name:		device-specific component name
  * @priv:		component-relevant data
- * @action_read		Synapse action mode read callback. The read value of the
+ * @action_read:		Synapse action mode read callback. The read value of the
  *			respective Synapse action mode should be passed back via
  *			the action parameter.
- * @device_u8_read	Device u8 component read callback. The read value of the
+ * @device_u8_read:		Device u8 component read callback. The read value of the
  *			respective Device u8 component should be passed back via
  *			the val parameter.
- * @count_u8_read	Count u8 component read callback. The read value of the
+ * @count_u8_read:		Count u8 component read callback. The read value of the
  *			respective Count u8 component should be passed back via
  *			the val parameter.
- * @signal_u8_read	Signal u8 component read callback. The read value of the
+ * @signal_u8_read:		Signal u8 component read callback. The read value of the
  *			respective Signal u8 component should be passed back via
  *			the val parameter.
- * @device_u32_read	Device u32 component read callback. The read value of
+ * @device_u32_read:		Device u32 component read callback. The read value of
  *			the respective Device u32 component should be passed
  *			back via the val parameter.
- * @count_u32_read	Count u32 component read callback. The read value of the
+ * @count_u32_read:		Count u32 component read callback. The read value of the
  *			respective Count u32 component should be passed back via
  *			the val parameter.
- * @signal_u32_read	Signal u32 component read callback. The read value of
+ * @signal_u32_read:		Signal u32 component read callback. The read value of
  *			the respective Signal u32 component should be passed
  *			back via the val parameter.
- * @device_u64_read	Device u64 component read callback. The read value of
+ * @device_u64_read:		Device u64 component read callback. The read value of
  *			the respective Device u64 component should be passed
  *			back via the val parameter.
- * @count_u64_read	Count u64 component read callback. The read value of the
+ * @count_u64_read:		Count u64 component read callback. The read value of the
  *			respective Count u64 component should be passed back via
  *			the val parameter.
- * @signal_u64_read	Signal u64 component read callback. The read value of
+ * @signal_u64_read:		Signal u64 component read callback. The read value of
  *			the respective Signal u64 component should be passed
  *			back via the val parameter.
- * @action_write	Synapse action mode write callback. The write value of
+ * @action_write:		Synapse action mode write callback. The write value of
  *			the respective Synapse action mode is passed via the
  *			action parameter.
- * @device_u8_write	Device u8 component write callback. The write value of
+ * @device_u8_write:		Device u8 component write callback. The write value of
  *			the respective Device u8 component is passed via the val
  *			parameter.
- * @count_u8_write	Count u8 component write callback. The write value of
+ * @count_u8_write:		Count u8 component write callback. The write value of
  *			the respective Count u8 component is passed via the val
  *			parameter.
- * @signal_u8_write	Signal u8 component write callback. The write value of
+ * @signal_u8_write:		Signal u8 component write callback. The write value of
  *			the respective Signal u8 component is passed via the val
  *			parameter.
- * @device_u32_write	Device u32 component write callback. The write value of
+ * @device_u32_write:		Device u32 component write callback. The write value of
  *			the respective Device u32 component is passed via the
  *			val parameter.
- * @count_u32_write	Count u32 component write callback. The write value of
+ * @count_u32_write:		Count u32 component write callback. The write value of
  *			the respective Count u32 component is passed via the val
  *			parameter.
- * @signal_u32_write	Signal u32 component write callback. The write value of
+ * @signal_u32_write:		Signal u32 component write callback. The write value of
  *			the respective Signal u32 component is passed via the
  *			val parameter.
- * @device_u64_write	Device u64 component write callback. The write value of
+ * @device_u64_write:		Device u64 component write callback. The write value of
  *			the respective Device u64 component is passed via the
  *			val parameter.
- * @count_u64_write	Count u64 component write callback. The write value of
+ * @count_u64_write:		Count u64 component write callback. The write value of
  *			the respective Count u64 component is passed via the val
  *			parameter.
- * @signal_u64_write	Signal u64 component write callback. The write value of
+ * @signal_u64_write:		Signal u64 component write callback. The write value of
  *			the respective Signal u64 component is passed via the
  *			val parameter.
  */
-- 
2.33.1

