Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D998929745B
	for <lists+linux-iio@lfdr.de>; Fri, 23 Oct 2020 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465755AbgJWQfw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Oct 2020 12:35:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751860AbgJWQdu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 837EF246C9;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=CFD9agG4O1WhsONhP0KshMjoSKcBO579lS+Ug8kmG4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdyI7BX5QQ4ff+KAGnsryHVgKJMZbfTB2gqwkaFgMeXrYnPZn3lzESa1tvxAsVAVh
         IoMOGjclTiezIwFaPjm8xPIQ9yrSLWKZTTF9CH5bbfw5RILK0dHqDAP7pAGNZQvroc
         KNoQkSlWpQuT03s7CHBPkV/+K6ODPPdcjgoRT6mw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002AxO-GB; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 45/56] iio: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:32 +0200
Message-Id: <46622c3bdcffb76e79719f0fe5011c2952960b32.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/iio/trigger.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index cad8325903f9..f930c4ccf378 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -97,7 +97,7 @@ static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *trig)
 }
 
 /**
- * iio_device_set_drvdata() - Set trigger driver data
+ * iio_trigger_set_drvdata() - Set trigger driver data
  * @trig: IIO trigger structure
  * @data: Driver specific data
  *
-- 
2.26.2

