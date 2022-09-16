Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4945BABDA
	for <lists+linux-iio@lfdr.de>; Fri, 16 Sep 2022 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiIPK7k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Sep 2022 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiIPK6r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Sep 2022 06:58:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4DBB72BB
        for <linux-iio@vger.kernel.org>; Fri, 16 Sep 2022 03:46:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kr11so2421785ejc.8
        for <linux-iio@vger.kernel.org>; Fri, 16 Sep 2022 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2woE7qGhu5XZvBsvA65FmG95p8Vjop1O1RfajPi17so=;
        b=CJsgnRZy4ibGp/qVozAYH9YQGUi0GqZo6jXKicrm/J2EfkbytaolZ4qicOmkggVQVx
         5r0+ImXbwTjrZ7XzdkUDc+OToUw/D7A1xFVey5hMSunj7WXGnBnetm4XTneW95dnE03z
         jeJt54N0GkBHtDiOAaP3xx1JiopECadgT7pJFLDbtgFFEANKJTxyEGFRBiQTqtgXr2lC
         hIO5/vNaOggqC8gTV851ENeimBKxFjggijeFZUX3WWpObPH8Ycbf0XJZXr4VAUgNLZ4m
         psDIImKIQCCKAwNwBZnJxyiU0jrTTTqQhU7wpTO4mp6GlpVjY2YOaFWc4vPBexOAvBPd
         0W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2woE7qGhu5XZvBsvA65FmG95p8Vjop1O1RfajPi17so=;
        b=X3YOJWhHb7DKqtXuY5qboc5vJd3pUHqaxox0u9G483RiFsFatDWmVaBmWcrphctHtH
         ywWIVxHS2AO06WnSTu4vdrG1ftw7LJeIzgxEYlKmqvv7CzUBqsex/mpJOeJ9F4eOW2dX
         lXVcbxoIEevfGWdzqIYQNJJDJTzPsUfB7eeh7/KjY1I26mv5MY5qRI9Euu8Zg7BK2wHO
         8Sk5czPgs8msSxuKigdnYxvMS1Rv0f50PmBr+r0l6FBnv2FkZsquTBfX68Rqb851xBh9
         IuCT/hwmLopwBEQtJzEtkSKzf+Y5AbGrIVTEwb9IA8D5ChtS+0bTTXeIWYZaIzChsVZr
         YsJQ==
X-Gm-Message-State: ACrzQf1CZIRdG/dmU1EDl8GhAJrIfZKC+nO0bFxGGNLlqdaogLQ9tWKn
        YAwhieVbFIeUDpsy+YTAAhnYGQ==
X-Google-Smtp-Source: AMsMyM7pt8z4iegjlU5zDlSEhSgDb5SGHgbYGRaGNvAYBizxWdg+NHp0ErlcQLU8n9tXtZUpZ5ZHtw==
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id 22-20020a170906021600b00711f6238bb0mr3246379ejd.174.1663325181425;
        Fri, 16 Sep 2022 03:46:21 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3vvunoijj2gi1k.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cef1:93b4:727b:dd58])
        by smtp.gmail.com with ESMTPSA id fi24-20020a1709073ad800b0072af4af2f46sm10148434ejc.74.2022.09.16.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 03:46:20 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v4 3/3] iio: temperature: mlx90632 Change return value of sensor measurement channel
Date:   Fri, 16 Sep 2022 12:45:52 +0200
Message-Id: <65031a769afcb494665bfa6b528cf4fc30a30c8d.1663324968.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663324968.git.cmo@melexis.com>
References: <cover.1663324968.git.cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

The current EINVAL value is more applicable to embedded library, where
user can actually put the fixed value to the sensor. In case of the
driver if the value of the channel is invalid it is better in inform
userspace that Channel was out of range as that implies more to internal
driver error than invalid input. It also makes for easier debugging of
where the error comes from during the development.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index e7946e3ed4fb..262b42883fcc 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -435,7 +435,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
 		*channel_old = 1;
 		break;
 	default:
-		return -EINVAL;
+		return -ECHRNG;
 	}
 
 	return 0;
-- 
2.34.1

