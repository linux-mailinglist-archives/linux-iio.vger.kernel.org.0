Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA50B25C8A4
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICSTk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 14:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICSTi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Sep 2020 14:19:38 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7C42098B;
        Thu,  3 Sep 2020 18:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599157178;
        bh=PuwI5qkGR9nMvKd4MSfOQjk/ekbhzZ0WpF41MfePSy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/AQizdh/9jFtiEV8+JTQ5nu8xgZMX7F5pMKCgfLPhtfBr6j6gJoR1n91eaDuouQL
         i+0uj/Q+Q3F68xWdb/l6RJ5VGr5fZ/w3Rlrya48tPDYd4kZXejHSvt6rJ2i0B4xqNh
         wuFbhG6cUclFqUXNjIVsA8DYkvSjPusv8a2KcHLE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 2/2] MAINTAINERS: Move Hartmut Knaack to Credits
Date:   Thu,  3 Sep 2020 20:19:26 +0200
Message-Id: <20200903181926.5606-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903181926.5606-1-krzk@kernel.org>
References: <20200903181926.5606-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hartmut Knaack was an active reviewer and contributor to the IIO
subsystem and drivers.  However his last message on LKML is from
October 2015.

In thanks for Hartmut's effort, move him name to the Credits.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Changes since v1:
1. Fix order in CREDITS
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 32ee70a7562e..c741455498a4 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1942,6 +1942,10 @@ S: Post Office Box 611311
 S: San Jose, California 95161-1311
 S: USA
 
+N: Hartmut Knaack
+E: knaack.h@gmx.de
+D: IIO subsystem and drivers
+
 N: Thorsten Knabe
 E: Thorsten Knabe <tek@rbg.informatik.tu-darmstadt.de>
 E: Thorsten Knabe <tek01@hrzpub.tu-darmstadt.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 4a120aec90a2..c585449b9084 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8488,7 +8488,6 @@ F:	drivers/iio/multiplexer/iio-mux.c
 
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
-R:	Hartmut Knaack <knaack.h@gmx.de>
 R:	Lars-Peter Clausen <lars@metafoo.de>
 R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

