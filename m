Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D029E468AF6
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 14:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhLENNG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 08:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhLENNG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 08:13:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CAAC061714;
        Sun,  5 Dec 2021 05:09:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i12so7593130pfd.6;
        Sun, 05 Dec 2021 05:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NaqU+Ioj6BvrVFh/LEwm0vIhxF9+0aODUByX7IbOzks=;
        b=YqLM46NuyWowrqCekDD5ydizNRlyxESf3DDWC3iHnXmzXI1WhhNW2tQJb5tHhknn5y
         u0zM6Nx3cg9g2TnsgvjiXzv6kjEeJNb2iVouyOlhDiJS2VP8CdO+M3sbfMlJZh6qFVC/
         0j3N9jJ3C6UefMDwcH6+aoA73R8re7Idim8dGo5D5T3jy5/Hw3YNh4HoOAKb3VDnQHUF
         rsm6EQ+GdOEr8Nxmt7tkmkv1BT38OMVRGN9s/snZbjnhEZogMIdw5WjxXMLWzz+kBWDu
         owtZsRKsMiVD0otabzjyVibJAlihLGxB4Uvz8LlerNNXUvlVByGpYOfzRt6bZojwAutT
         0KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NaqU+Ioj6BvrVFh/LEwm0vIhxF9+0aODUByX7IbOzks=;
        b=dsymSdWTUHmAOyYLhyQZoy7LWIjyyTo2b20qw5FmgUyOyl5Qk+vJL5eYM0qu5MexBE
         Zf3BdP7XNysXF7Z9dwsPY59Hu8y6cz6Z2UlBjJSFuCe7K/NgWBWbIdZPjv5Ha4oDktNz
         hJfmqgyKyArtoOxKEAnPHK7CpF6BXPcPWA0r/WiukEV4PktvBGXz0pm9K9689R8mCqjF
         eq4HlurTZgPxOgiS6rKciNLaQXqvgqRfiWLKTEBsQsn0jVW2gS8J02gVqtWgdH2C9Uhd
         sGuQc9LxuFS32S7pCV6BzoNuvzqJQNqbssAlsvsR6KnXovK6aryRYNRZ9Xp4qSnvOcjD
         NOzg==
X-Gm-Message-State: AOAM531pJQrLHyNzO55mrxpEJ3HUO5LAUK089ZKc+i9Fapsv/9lUTSPB
        OGfAq5uEo4hrH5sVwojwoOWk8L6SA+RCtw==
X-Google-Smtp-Source: ABdhPJzpdyI+vsSX0MSAr4ta1ORdWwGrg31E6VkhUxX/maZHxBKvpXdQqT11irE8RMiJlZ9mkbRORQ==
X-Received: by 2002:a05:6a00:2444:b0:4ab:15b9:20e5 with SMTP id d4-20020a056a00244400b004ab15b920e5mr15582878pfj.0.1638709778420;
        Sun, 05 Dec 2021 05:09:38 -0800 (PST)
Received: from localhost.localdomain ([8.26.182.175])
        by smtp.gmail.com with ESMTPSA id n16sm7367189pja.46.2021.12.05.05.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:09:37 -0800 (PST)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     vilhelm.gray@gmail.com
Cc:     corbet@lwn.net, chenhuacai@kernel.org, linux-doc@vger.kernel.org,
        linux-iio@vger.kernel.org, siyanteng01@gmail.com,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH] counter: Add the necessary colons and indents to the comments of counter_compi
Date:   Sun,  5 Dec 2021 21:08:16 +0800
Message-Id: <20211205130816.4121898-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix warning as:

linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/counter.h:43: WARNING: Unexpected indentation.
linux-next/Documentation/driver-api/generic-counter:234: ./include/linux/counter.h:45: WARNING: Block quote ends without a blank line; unexpected unindent.

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

