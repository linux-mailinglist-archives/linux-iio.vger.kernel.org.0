Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7EF4713B2
	for <lists+linux-iio@lfdr.de>; Sat, 11 Dec 2021 12:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhLKLyt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Dec 2021 06:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhLKLyt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Dec 2021 06:54:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF6C061714;
        Sat, 11 Dec 2021 03:54:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id o14so7978021plg.5;
        Sat, 11 Dec 2021 03:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbt5HpG41uBqwm/1z5chIvatbagPJqMGnhqv78XByqc=;
        b=oQz70V+DTXXgt+UHx060bt8JXRFQU5BYFOiQLrG4pAzK/IvIGgMgnCZac098E6Qxpy
         olCZfq8A6SehLXtWgyAbgZeGrKmnIDl80f7eAWtaHoisG3JUg48TSfjpzSYa4cK783Cr
         IFHefwud5fmam1eYF+c7jZMaQLS/EOPJdRnUeJSxVSp97xA1vYYLHHp/aue1p9hkE3EC
         UAp29gXUsYJT2ZCbb2xQKJ5lw297tjFKFu/WV8xA0JeulDe6sQ/Bfug6P++lybTedYvq
         FSS5JfdTc4xhqdg1N5kS8Fzrrv06EjxGchobPzpfYZlO36hooPwNlVE2NbOTIY/IBi6m
         Hu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbt5HpG41uBqwm/1z5chIvatbagPJqMGnhqv78XByqc=;
        b=Cr9+qRvINLBGOYf9+fREVVbHSM30NYnVmtqz2kY24GuGJv3FJYafvu3Kqkt6hTvSFN
         x9QzmPbu5PFFMv6jBBH6qpBHrIt0yEhV8KW6Ggf3eVhIE3ShEz84P/GoRfJwwlW4gqNo
         HcmozW9MejGjJLCTLlJZSgzuNb73P39akhsWeZtXxttWfXKAMxOuYUOvMsay+0YZzMGb
         X6LcVPgrTs7MJJu5o3Lm2YPW5r7xg/F99A/4OXYM6vmMcXjsywF3vykVGOMQIvqstZyd
         ZpPhVf61Jw5LMSVz7d1CHL7RGOLm4Scp+THx53hMYYArDJuiXJD7NiJ6ylzJpeicM1x9
         JAFA==
X-Gm-Message-State: AOAM532lSEctxCEESYSK6dBU4h7ktPAmXV0w3dGw8e7/wkYuppPe1JG/
        8I72wvHSmzsLdJnYwzJWAkmUlYEAItuNSGtk
X-Google-Smtp-Source: ABdhPJzNHpBZqWQ1bxTiQ0IUEU1Vua2lA+bIxFsVVH6Msp1nUNd/o+z2tkKCFlxlU5bn70D/44xROQ==
X-Received: by 2002:a17:902:654d:b0:141:7df3:b94 with SMTP id d13-20020a170902654d00b001417df30b94mr80648796pln.60.1639223688571;
        Sat, 11 Dec 2021 03:54:48 -0800 (PST)
Received: from localhost.localdomain ([8.26.182.60])
        by smtp.gmail.com with ESMTPSA id v1sm6157812pfg.169.2021.12.11.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 03:54:47 -0800 (PST)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     vilhelm.gray@gmail.com
Cc:     Yanteng Si <siyanteng01@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
        chenhuacai@kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH v2] counter: Add the necessary colons and indents to the comments of counter_compi
Date:   Sat, 11 Dec 2021 19:53:15 +0800
Message-Id: <20211211115315.2255384-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Yanteng Si <siyanteng01@gmail.com>

Since aaec1a0f76ec ("counter: Internalize sysfs interface code") introduce a warning as:

linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/counter.h:43: WARNING: Unexpected indentation.
linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/counter.h:45: WARNING: Block quote ends without a blank line; unexpected unindent.

Add the necessary colons and indents.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
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
2.27.0

