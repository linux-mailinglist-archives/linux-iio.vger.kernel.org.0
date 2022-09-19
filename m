Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B265BC4A5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiISIsq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 04:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiISIsn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 04:48:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B79FBE36
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 01:48:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc7so62895462ejb.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KfvECBL+S/JPrWMvitZCT4r906w4Xvb7QinxUzGg82I=;
        b=jKdOCXbmaRn4fuTRvg00cqA3G/aKJd9B/0PwqwJ+PwA3ee+ne5DF+Kf2phz6tlWyA+
         8Ut9E5+F6pTR5+SJTS4//V/jBCEKAbTEYbjJhe4vuHPmx3O1CLzC4TRVmxfI/WSpYB/k
         1D4+bzjStSxReou/eL4Ohzq2TGeYEFtZfeIzMWaYvRqbBXX8zf8SJYQ6k7xRFo5vFlrQ
         BybX2j59IveBietAczpHGBZRsFvpR3OxiU8VI3VPBgEWjnAfLF55di0BFL+4rJP2Urpa
         +FG8DvgvosRF/dtP7WhwKau9JvuCLKtEjAuLGrR9g6GPNph8kAr8DlfBpz3q+MPj+115
         IbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KfvECBL+S/JPrWMvitZCT4r906w4Xvb7QinxUzGg82I=;
        b=YkH28QeFf9znG8hxY30lRWoSPyM7H6a4iXYgr8hP1Hf2oct3KrWfL1fA3DF20R0zuM
         kyk8Bka/OaM+/ve9jjhwxwX1aOwSfr1BHuxkn9hGj3TwIhyNwNqrYBRyHAWZtjIvaMPY
         fCbMEAXZSe2FkFuUWBfyjGDOnnD4E7o+rbBfnlYthHjg+p2Z6dBAKq63+Ory/X8xoN7T
         NV2POz4RBGXwt+iYoPHHvj7VAldaiMopltblN9Y4BLTMPyaZROl2jXr4+nLJWSEzHnoI
         c8d7zFW7wLYG8i1hyxj03IHSHcPK/hq/z2TTg6CckJPCZX0osz5GgDE8Nj7nB4/jow9M
         Zfcw==
X-Gm-Message-State: ACrzQf3vSTOpDTyHeQAXNd6ejXkZ08pbS3LUyh4Ved7Z8Lnpw9Ud3dAa
        Z0sLlMwI+X96R8fEdg9UesDc4w==
X-Google-Smtp-Source: AMsMyM5gqUd37DVKb2j+wDYtot7DdSm8vTzT+7NXNW8PGrfky/vyoarZWbs1Tb8GiPpUzk0CsqcM3Q==
X-Received: by 2002:a17:906:ee81:b0:77e:829a:76e9 with SMTP id wt1-20020a170906ee8100b0077e829a76e9mr12685424ejb.207.1663577321662;
        Mon, 19 Sep 2022 01:48:41 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3vyam57ypepalv.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:d368:146c:ce83:b3f3])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7d594000000b0044e9a3690e0sm20081326edq.9.2022.09.19.01.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:48:41 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v5 3/3] iio: temperature: mlx90632 Change return value of sensor measurement channel
Date:   Mon, 19 Sep 2022 10:48:18 +0200
Message-Id: <7f99e81b31a5584b4f0d2f7d689026f6e47a2d12.1663577091.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663577091.git.cmo@melexis.com>
References: <cover.1663577091.git.cmo@melexis.com>
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
index c0bf385ebd6c..daaffe84b617 100644
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

