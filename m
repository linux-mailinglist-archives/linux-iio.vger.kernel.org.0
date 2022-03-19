Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448F4DE9EA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Mar 2022 19:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiCSSIF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Mar 2022 14:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCSSIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Mar 2022 14:08:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0373EF3F
        for <linux-iio@vger.kernel.org>; Sat, 19 Mar 2022 11:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF842B80DA1
        for <linux-iio@vger.kernel.org>; Sat, 19 Mar 2022 18:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E89C340EC;
        Sat, 19 Mar 2022 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647713201;
        bh=t5X705RZJNG4LDvIwhJ7GU2OeF7RCyf+qUaePcvOYso=;
        h=From:To:Cc:Subject:Date:From;
        b=cf8cSqWGTSdRULd2kMn+yk+ig3YfFtwlStMImjNuV78YM7TIseMgsky+1+UC379TH
         iD4Q/fLt1HkcNYOOph0WoSm9EphNzAzsQ+cKgvwh+syqgxJZi9xUUU4L02LIY3LNAE
         E44aUh0v/zlRU7SP3uwkOuWF8rXh4ueD4A11ORF3VFy+7tfs/DFIdNyP9PU4hjlJMt
         Du3im5NWHChPmxXdd6Z77qeq4ruoheSgvLmSoXsARXt8kSejVhEhABDXlt2Gh0eBvo
         /W9Z7tgOOXIkJJMTz+VWS2+O9xRnjUf9kU18xNM5FQBDAFwiTEyxgRm4dVoOhs6vmE
         QuGkjcEw0O05A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: freq: admv1014: Fix warning about dubious x & !y and improve readability
Date:   Sat, 19 Mar 2022 18:14:01 +0000
Message-Id: <20220319181401.136810-1-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The warning comes from __BF_FIELD_CHECK()
specifically

BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
		 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
		 _pfx "value too large for the field"); \

The code was using !(enum value) which is not particularly easy to follow
so replace that with explicit matching and use of ? 0 : 1; or ? 1 : 0;
to improve readability.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1014.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index a7994f8e6b9b..802835efbec7 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -700,8 +700,10 @@ static int admv1014_init(struct admv1014_state *st)
 			 ADMV1014_DET_EN_MSK;
 
 	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK, st->p1db_comp ? 3 : 0) |
-		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st->input_mode)) |
-		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st->input_mode) |
+		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK,
+				(st->input_mode == ADMV1014_IQ_MODE) ? 0 : 1) |
+		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK,
+				(st->input_mode == ADMV1014_IQ_MODE) ? 1 : 0) |
 		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
 
 	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);
-- 
2.35.1

