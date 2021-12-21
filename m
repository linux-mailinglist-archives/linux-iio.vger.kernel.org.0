Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B2B47BB98
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhLUIRN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 03:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhLUIRM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Dec 2021 03:17:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F057C061574
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 00:17:12 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r138so11672286pgr.13
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 00:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRify4V8vT0KGWGetZDy9/dHEzN+APIJ4WSTI6YZM+0=;
        b=im/gBXb2g/Yf2sf5orPe4XRaFd5fh+dzCCuycTNnaDhns4fKjXAI++HZBgPvbFfv2o
         M+orgjQ7nZ33KgDnnJ+kqhyqvcTXsXGWxBYVgumTYaEa6LMF5ldCpCsJW+xmi9VaNEFg
         pmjwqaAnLYNqKZ35Iwn5Dgf0fCEZVUJ4lveqpWUj/zleA9/G2opolPcM/jlElTIz2Lch
         IwtKU281/C1oaE6LoZXKmqLMZLYckkGjTGl56SedCwWLkujXvtYKne97WauYEvAFn6+S
         1kIvM5RZ/TMCsezsKkj7vg1WoRboXFBDXHlTEOCiEhK4Gixzm29dZ/knSVJrOJHXJxiR
         R0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRify4V8vT0KGWGetZDy9/dHEzN+APIJ4WSTI6YZM+0=;
        b=ZbkFR7PtpKTudqUB83e0Gex+j3rmvmV3Jsd/07w4+aAF5FEWttEtridSeXP3W3gpRq
         lzFTHmROdS/yA0qyVIA0esRqJai6pARz4AZK6deVdCDDhV3h4no45T2YxlA8axCd7L6H
         r1gQAvdb5qjmI9bQlVLoe0ygvgpRdSDX53+F1g8uMLn8qH/ATuawmLGxOdtaE7lyi7QD
         3cJilxbPypyIK7+CR2RNQlKKi3jKRRn3BfwKPznViT0qbOj4VCMM+U1+uf4sMWZ4I0x0
         gxwIvaCoj7oUpEDOgOm/QoJif2Ioq/SJC6Q/XyeBNiicsL+He+iMV5nTEdkSd+W7hAz7
         a4cQ==
X-Gm-Message-State: AOAM5305uOUY0HDCK4/JzPYhGcj20GKapknTYS8+rhUdwqeKQW4NE/U3
        Rv1Zitbg0x56R4ZdFiZ8ENk=
X-Google-Smtp-Source: ABdhPJyiCkttDpoz7tsCU3UkqUg0cmyy1BRl/U6l+JGWL3vK2u/EOh3BkjuqBvbGIq6TO5ZFXTZFIg==
X-Received: by 2002:a05:6a00:892:b0:4ba:12d5:1d4 with SMTP id q18-20020a056a00089200b004ba12d501d4mr2113787pfj.46.1640074632005;
        Tue, 21 Dec 2021 00:17:12 -0800 (PST)
Received: from localhost.localdomain ([37.120.154.44])
        by smtp.gmail.com with ESMTPSA id b6sm21196890pfm.170.2021.12.21.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 00:17:11 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/3] counter: ti-eqep: Use container_of instead of struct counter_device::priv
Date:   Tue, 21 Dec 2021 17:16:47 +0900
Message-Id: <4bde7cbd9e43a5909208102094444219d3154466.1640072891.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640072890.git.vilhelm.gray@gmail.com>
References: <cover.1640072890.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Using counter->priv is a memory read and so more expensive than
container_of which is only an addition. (In this case even a noop
because the offset is 0.)

So container_of is expected to be a tad faster, it's type-safe, and
produces smaller code (ARCH=arm allmodconfig):

	$ source/scripts/bloat-o-meter drivers/counter/ti-eqep.o-pre drivers/counter/ti-eqep.o
	add/remove: 0/0 grow/shrink: 0/9 up/down: 0/-108 (-108)
	Function                                     old     new   delta
	ti_eqep_position_enable_write                132     120     -12
	ti_eqep_position_enable_read                 260     248     -12
	ti_eqep_position_ceiling_write               132     120     -12
	ti_eqep_position_ceiling_read                236     224     -12
	ti_eqep_function_write                       220     208     -12
	ti_eqep_function_read                        372     360     -12
	ti_eqep_count_write                          312     300     -12
	ti_eqep_count_read                           236     224     -12
	ti_eqep_action_read                          664     652     -12
	Total: Before=4598, After=4490, chg -2.35%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/ti-eqep.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 09817c953f9a..9e0e46bca4c2 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -87,10 +87,15 @@ struct ti_eqep_cnt {
 	struct regmap *regmap16;
 };
 
+static struct ti_eqep_cnt *ti_eqep_count_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct ti_eqep_cnt, counter);
+}
+
 static int ti_eqep_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap32, QPOSCNT, &cnt);
@@ -102,7 +107,7 @@ static int ti_eqep_count_read(struct counter_device *counter,
 static int ti_eqep_count_write(struct counter_device *counter,
 			       struct counter_count *count, u64 val)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 max;
 
 	regmap_read(priv->regmap32, QPOSMAX, &max);
@@ -116,7 +121,7 @@ static int ti_eqep_function_read(struct counter_device *counter,
 				 struct counter_count *count,
 				 enum counter_function *function)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 qdecctl;
 
 	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
@@ -143,7 +148,7 @@ static int ti_eqep_function_write(struct counter_device *counter,
 				  struct counter_count *count,
 				  enum counter_function function)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	enum ti_eqep_count_func qsrc;
 
 	switch (function) {
@@ -173,7 +178,7 @@ static int ti_eqep_action_read(struct counter_device *counter,
 			       struct counter_synapse *synapse,
 			       enum counter_synapse_action *action)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	enum counter_function function;
 	u32 qdecctl;
 	int err;
@@ -245,7 +250,7 @@ static int ti_eqep_position_ceiling_read(struct counter_device *counter,
 					 struct counter_count *count,
 					 u64 *ceiling)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 qposmax;
 
 	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
@@ -259,7 +264,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 					  struct counter_count *count,
 					  u64 ceiling)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 
 	if (ceiling != (u32)ceiling)
 		return -ERANGE;
@@ -272,7 +277,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 static int ti_eqep_position_enable_read(struct counter_device *counter,
 					struct counter_count *count, u8 *enable)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 qepctl;
 
 	regmap_read(priv->regmap16, QEPCTL, &qepctl);
@@ -285,7 +290,7 @@ static int ti_eqep_position_enable_read(struct counter_device *counter,
 static int ti_eqep_position_enable_write(struct counter_device *counter,
 					 struct counter_count *count, u8 enable)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 
 	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
 
-- 
2.33.1

