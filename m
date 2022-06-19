Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10105550CA0
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiFSS73 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiFSS7D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7FBC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06C05B80D8B
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A735FC34114;
        Sun, 19 Jun 2022 18:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665138;
        bh=rC0Q/DB7iSL7pOMSqlFhsAHLKPylUGh7pkAr4L1dAZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2P0jTqR+JoncpBfAWGhN22mDTJWUA3BZlifguzQak5JN8FyVabUbJPVRXjhEVKHm
         VswggFpxb/iKWfwR7Yze9caLn78nkBPJqspkPfIWZbBaVcelxt/fmRazUGxHXMLpZq
         xdSckRcOfmSNtpn5TJ6fgfCXhNmVN+Fml9joDxFToObxtzr92nt8miYg36VYEJBmEE
         OuR+vVYtyw3XuIlvbDNVtp/RdCDSsxGbyH3mJ+hek8yaAao6q2jrRKip48XEysEuSJ
         JUBG24/ylu8NvMeuBnvT/huhhN9euZ5zJ5msAFWvuV2Z+nd2gFxiL4vYa9P1k8zAC5
         SQTjTY7uJKhNg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 02/17] iio: ABI: Fix wrong format of differential capacitance channel ABI.
Date:   Sun, 19 Jun 2022 19:58:24 +0100
Message-Id: <20220619185839.1363503-3-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
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

in_ only occurs once in these attributes.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3e00d7f7ee22..d3a0c0ef8948 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -193,7 +193,7 @@ Description:
 		Raw capacitance measurement from channel Y. Units after
 		application of scale and offset are nanofarads.
 
-What:		/sys/.../iio:deviceX/in_capacitanceY-in_capacitanceZ_raw
+What:		/sys/.../iio:deviceX/in_capacitanceY-capacitanceZ_raw
 KernelVersion:	3.2
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.36.1

