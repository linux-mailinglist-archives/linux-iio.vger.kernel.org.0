Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB85E60CF
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIVLVN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIVLVL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 07:21:11 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A012E05D0
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:21:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b23so5987141qtr.13
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0ZXgd4exJNTyvkxxDXTFhzNyH0tchu3XwlHAtC/qfIw=;
        b=wdBQtq4VtIQnXtCezkfTQgTVOKNPYE2wfSbiClXxCedegL9Kfg3UnAPcPYaSXS3mYH
         P2rXY01P5rokWK6198ZVkjfZmSViZwNh9w77zhp4QvZrvwKgOZiq3UF3PuAv81IQBBKu
         EGtQyhzuoikLdG40iPBqTYVi1CgVFy1fQ4xbJ4w/L4/dAlTcQpjq0Ehrri2KFT/22JnO
         GyAHkZpt61zGOXHeziMthzb/1dSTAM2dNVl3FAhmUg1U78IMyV9LIQKsCfmxWn5uT4+b
         7+02BEhUEIPy7xsYKHgY0CLE6SLz07sG/1GEMXnQfSFnQmgoy4KQzpvhBg/4fkWXqBd9
         IMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0ZXgd4exJNTyvkxxDXTFhzNyH0tchu3XwlHAtC/qfIw=;
        b=gs3nKcyHoIn/RfSqdlMDKc92yKe1oEuzl6v1mlpI1Jh8U6U4iZybTXa/m20uX/7xx8
         ksAMB7nwUcB6ew1vzfKkBrnmLr+a4y37OdZoWdOqyD29ou+JNVAmywoRtrb7IQHt5F0Z
         lpGudzGmBzkv4c5pMvr7VRyXmaz0PDYkGlvs4CR2m2fbQcIShtcYIhxaO4HtGmggcDqp
         JPiVjZgRiXy7M53Rb8QEH28M0PDU6LCQkNmPNpbEioAEmv5ptfkk8ajzuYYea6olnLDU
         OnaDvoxqwZZmlV+ZvGSSgqypOfo6vVdqYmjmNJ88l0ScQc7svErTNV1/TmAhTVAyVXxf
         Qv/w==
X-Gm-Message-State: ACrzQf2pTEqWC1AvoH6Erv4mnvsyfES52LU0dn2lzLaDfUFPBfMOYsg+
        SUj2NefdJHw1+ffUW4tiLiDWgbcMLhLQaw==
X-Google-Smtp-Source: AMsMyM5SMDYqfdYVcKNoUBdOp54Z4j7nbsjjmBfvUSojEFd7nO8BVrIhPVLH8zsjEjRvli86PikYDg==
X-Received: by 2002:ac8:5887:0:b0:35b:b700:8990 with SMTP id t7-20020ac85887000000b0035bb7008990mr2240505qta.450.1663845669318;
        Thu, 22 Sep 2022 04:21:09 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f39-20020a05622a1a2700b0035cf31005e2sm3487115qtb.73.2022.09.22.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:21:09 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH 2/2] counter: Realign counter_comp comment block to 80 characters
Date:   Thu, 22 Sep 2022 07:20:57 -0400
Message-Id: <8294b04153c33602e9c3dd21ac90c1e99bd0fdaf.1663844776.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663844776.git.william.gray@linaro.org>
References: <cover.1663844776.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The member documentation comment lines for struct counter_comp extend
past the 80-characters column boundary due to extra identation at the
start of each section. This patch realigns the comment block within the
80-characters boundary by removing these superfluous indents.

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
Link: https://lore.kernel.org/r/20220902120839.4260-1-william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 include/linux/counter.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index 1fe17f5adb09..a81234bc8ea8 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -38,64 +38,64 @@ enum counter_comp_type {
  * @type:		Counter component data type
  * @name:		device-specific component name
  * @priv:		component-relevant data
- * @action_read:		Synapse action mode read callback. The read value of the
+ * @action_read:	Synapse action mode read callback. The read value of the
  *			respective Synapse action mode should be passed back via
  *			the action parameter.
- * @device_u8_read:		Device u8 component read callback. The read value of the
+ * @device_u8_read:	Device u8 component read callback. The read value of the
  *			respective Device u8 component should be passed back via
  *			the val parameter.
- * @count_u8_read:		Count u8 component read callback. The read value of the
+ * @count_u8_read:	Count u8 component read callback. The read value of the
  *			respective Count u8 component should be passed back via
  *			the val parameter.
- * @signal_u8_read:		Signal u8 component read callback. The read value of the
+ * @signal_u8_read:	Signal u8 component read callback. The read value of the
  *			respective Signal u8 component should be passed back via
  *			the val parameter.
- * @device_u32_read:		Device u32 component read callback. The read value of
+ * @device_u32_read:	Device u32 component read callback. The read value of
  *			the respective Device u32 component should be passed
  *			back via the val parameter.
- * @count_u32_read:		Count u32 component read callback. The read value of the
+ * @count_u32_read:	Count u32 component read callback. The read value of the
  *			respective Count u32 component should be passed back via
  *			the val parameter.
- * @signal_u32_read:		Signal u32 component read callback. The read value of
+ * @signal_u32_read:	Signal u32 component read callback. The read value of
  *			the respective Signal u32 component should be passed
  *			back via the val parameter.
- * @device_u64_read:		Device u64 component read callback. The read value of
+ * @device_u64_read:	Device u64 component read callback. The read value of
  *			the respective Device u64 component should be passed
  *			back via the val parameter.
- * @count_u64_read:		Count u64 component read callback. The read value of the
+ * @count_u64_read:	Count u64 component read callback. The read value of the
  *			respective Count u64 component should be passed back via
  *			the val parameter.
- * @signal_u64_read:		Signal u64 component read callback. The read value of
+ * @signal_u64_read:	Signal u64 component read callback. The read value of
  *			the respective Signal u64 component should be passed
  *			back via the val parameter.
- * @action_write:		Synapse action mode write callback. The write value of
+ * @action_write:	Synapse action mode write callback. The write value of
  *			the respective Synapse action mode is passed via the
  *			action parameter.
- * @device_u8_write:		Device u8 component write callback. The write value of
+ * @device_u8_write:	Device u8 component write callback. The write value of
  *			the respective Device u8 component is passed via the val
  *			parameter.
- * @count_u8_write:		Count u8 component write callback. The write value of
+ * @count_u8_write:	Count u8 component write callback. The write value of
  *			the respective Count u8 component is passed via the val
  *			parameter.
- * @signal_u8_write:		Signal u8 component write callback. The write value of
+ * @signal_u8_write:	Signal u8 component write callback. The write value of
  *			the respective Signal u8 component is passed via the val
  *			parameter.
- * @device_u32_write:		Device u32 component write callback. The write value of
+ * @device_u32_write:	Device u32 component write callback. The write value of
  *			the respective Device u32 component is passed via the
  *			val parameter.
- * @count_u32_write:		Count u32 component write callback. The write value of
+ * @count_u32_write:	Count u32 component write callback. The write value of
  *			the respective Count u32 component is passed via the val
  *			parameter.
- * @signal_u32_write:		Signal u32 component write callback. The write value of
+ * @signal_u32_write:	Signal u32 component write callback. The write value of
  *			the respective Signal u32 component is passed via the
  *			val parameter.
- * @device_u64_write:		Device u64 component write callback. The write value of
+ * @device_u64_write:	Device u64 component write callback. The write value of
  *			the respective Device u64 component is passed via the
  *			val parameter.
- * @count_u64_write:		Count u64 component write callback. The write value of
+ * @count_u64_write:	Count u64 component write callback. The write value of
  *			the respective Count u64 component is passed via the val
  *			parameter.
- * @signal_u64_write:		Signal u64 component write callback. The write value of
+ * @signal_u64_write:	Signal u64 component write callback. The write value of
  *			the respective Signal u64 component is passed via the
  *			val parameter.
  */
-- 
2.37.3

