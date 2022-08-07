Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB658BB4F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiHGOoq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiHGOoo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 10:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2D99FF9
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 07:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D20860F1D
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 14:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA4FC433D7;
        Sun,  7 Aug 2022 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659883482;
        bh=rBnfxeJCOY1ECv8hxk5mqJPG/ErPPWyKnVyhj/IQLA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A229qwMWrXJnGISIqRa5cfeEFPGUNVUKmX7dhZEF5FnNv6Hy7xwO/dK8RD2duuMXv
         QjpvuzR5yj321KP1FZUIgpGqLmq/bCfO7aJQpBJRuK/CR2D6jL3ZJ69sFnkL0AeeDe
         D1DWyA2Oe4ZBIhouEVuAGBxz7OABEnj+wP70paTPOFd0W4EJQp+n++Atzpu+TGcbjE
         Go5r92qr55I4ooUqfkKjcl9Lpg/ta1gH3Y7q/yCFIBCyc518/PRht+EXNPQG7NA1i6
         z6a+oiuoRApvJb3dp0BL3oq2yrTE7AH9dKh/Hr0zs9vwaEhGcwvwO/P0dKzEX/4WrB
         pk9jEtEI9xptw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 1/2] iio: test: Mark file local structure arrays static.
Date:   Sun,  7 Aug 2022 15:54:56 +0100
Message-Id: <20220807145457.646062-2-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807145457.646062-1-jic23@kernel.org>
References: <20220807145457.646062-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Warning cleanup:
  drivers/iio/test/iio-test-rescale.c:32:30: warning: symbol 'scale_cases' was not declared. Should it be static?
  drivers/iio/test/iio-test-rescale.c:480:30: warning: symbol 'offset_cases' was not declared. Should it be static?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/test/iio-test-rescale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index cc782ccff880..31ee55a6faed 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -29,7 +29,7 @@ struct rescale_tc_data {
 	const char *expected_off;
 };
 
-const struct rescale_tc_data scale_cases[] = {
+static const struct rescale_tc_data scale_cases[] = {
 	/*
 	 * Typical use cases
 	 */
@@ -477,7 +477,7 @@ const struct rescale_tc_data scale_cases[] = {
 	},
 };
 
-const struct rescale_tc_data offset_cases[] = {
+static const struct rescale_tc_data offset_cases[] = {
 	/*
 	 * Typical use cases
 	 */
-- 
2.37.1

