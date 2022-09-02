Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3094B5AB23B
	for <lists+linux-iio@lfdr.de>; Fri,  2 Sep 2022 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiIBNyF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Sep 2022 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiIBNxO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2022 09:53:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBAC21E2E
        for <linux-iio@vger.kernel.org>; Fri,  2 Sep 2022 06:27:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lx1so3825263ejb.12
        for <linux-iio@vger.kernel.org>; Fri, 02 Sep 2022 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zz4sNoMS97lmRdGv4iOWUprIP1Nj2KXZnhQThJIzUvQ=;
        b=IKn3bzQ6mCrmI5JYBH7OCs8QzZtwc2yQtUC9qDaVzlIPmhTxOcbqQqF/KsWVxnVng4
         Uy7Qi1U7UWbeFS2S+z391yCXmIsHd4YXRGyzEGnsijY+bhdd9ncRopXQZ6VQE3bP/Juv
         SmIL9tJpapqtJkx75KhRvxUo/kRGJgTjeEfdWO/MQUnOY38BBs08tUjvsiOz4aoCLiSY
         nFzy1WmBM9orVNECaGJLgD/MSUzwakg0bcrCceufpRgFBGcOshcRRoHxiHg69Dvj2FQt
         KsEvpkl78lpWstRgXuQYTXi/UfYnoGeXacwTAqnDACiPHTnd2iFgSZYMI0ro3ZWx2NuA
         WBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zz4sNoMS97lmRdGv4iOWUprIP1Nj2KXZnhQThJIzUvQ=;
        b=Zm25oMCF0JG+U0V3KlJvf01QNoskgImWtDi4wkvsIUCzznyrn8hKQh40LHGnPUE2CD
         FFTBIMgzlo3wCNscCFSgw5x9pr8gCKbQY4nfbFf2Z9w89lV16dQFQZE+8Z5aHArt4T+y
         PN+5jQhX2zMHzkpHmicCkpjqSLvPjX1tfJHjUGizYQ2Z2DYL47iV7SNNIob8jvU7tjIb
         RGbQ2iTmeqaj4oGePcDmxpI/PbtAYW2fonut39kDzRkay5J29IBqaSV4LPa9BeHj9HrH
         tcvYewmcFg4ejkRL5Bf4c2sMXZ5KChVyhMwwCuX2/no5KDiHJV6UB517+3809RekAoEr
         gXQQ==
X-Gm-Message-State: ACgBeo3skeWN43t6/RPvAuG20Y93CGKgbvcbpHzZp2PcJxBTN3344cbe
        tHWUsQ4bBedz9XvqVU9P7dKPtEPK1k2Q2w==
X-Google-Smtp-Source: AA6agR4EGVo4h+PgI/jqb8iUfMuqcHI09FJLTpCi3OTYu7NkT4PBtllx5VKDjfKxbtFIx49XP8bTTg==
X-Received: by 2002:a17:907:a40f:b0:730:c4ce:631c with SMTP id sg15-20020a170907a40f00b00730c4ce631cmr26229483ejc.362.1662124425294;
        Fri, 02 Sep 2022 06:13:45 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b007477ee86946sm1239119ejh.87.2022.09.02.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:13:44 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 3/3] iio: temperature: mlx90632 Change return value of sensor measurement channel
Date:   Fri,  2 Sep 2022 15:13:40 +0200
Message-Id: <20220902131340.3316479-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 63b19ac1484c..031aaa5493e8 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -439,7 +439,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
 		*channel_old = 1;
 		break;
 	default:
-		return -EINVAL;
+		return -ECHRNG;
 	}
 
 	return 0;
-- 
2.34.1

