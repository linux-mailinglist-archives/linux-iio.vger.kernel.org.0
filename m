Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595C358BCAB
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 21:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiHGTK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHGTK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 15:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC49E9;
        Sun,  7 Aug 2022 12:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 623126106B;
        Sun,  7 Aug 2022 19:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46BAC43140;
        Sun,  7 Aug 2022 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659899425;
        bh=QTLLlefCz5Z9OfH0nMDPg+o3+GK31K/bzh/ApDlfM6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DneIk8fBikzhBbedqT34anNO+pffCZtTbxi28swwo7b3iatEUjqed+WyhmDv1ivXr
         wi5t2+o84pC0bNnKnuouoqMOBXO/kuV0O6p9IZs2Z6bxHkXq1Y7q4UMwLDKLjNe0QO
         zk+8RAoQk/FqGwZTehmqjAqDw6JdoN3OCoFSggo4mfkIUYv7qmkF+Vr74JiNnm3LEs
         pEa3zv1rnV6Y24ZvaDYDq/vMgBuCBetTNGqQ3rzNSFMz/yGg8FN+RJPrwBmXxcfW7L
         cKN/n9oyzhPSbTdl4Ee492M5of0xHGhSnYBeFfv5WYZq4Sn8KvAWU/2uhAN4UWN0eR
         xJ7ZjE8EcBaAA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/5] PM: core: Add EXPORT_NS_GPL_DEV_PM_OPS to avoid drivers rolling own.
Date:   Sun,  7 Aug 2022 20:20:34 +0100
Message-Id: <20220807192038.1039771-2-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807192038.1039771-1-jic23@kernel.org>
References: <20220807192038.1039771-1-jic23@kernel.org>
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

A driver wishing to export a struct dev_pm_ops with both suspend and
runtime ops provided could use _EXPORT_DEV_PM_OPS() directly but
that macro is not intended for use in drivers and requires non
intuitive aspect such as passing "_gpl" as one parameter and the
namespace as a string.  As such just provide a macro to cover
the GPL and NS case in a fashion that is in line with similar macros.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 871c9c49ec9d..18856e0d23ac 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -407,6 +407,11 @@ static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
 #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
 	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", #ns)
 
+#define EXPORT_NS_GPL_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
+			   runtime_resume_fn, idle_fn, ns) \
+	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
+			   runtime_resume_fn, idle_fn, "_gpl", #ns)
+
 /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
 const struct dev_pm_ops __maybe_unused name = { \
-- 
2.37.1

