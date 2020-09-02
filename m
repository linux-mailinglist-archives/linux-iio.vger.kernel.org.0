Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F091125AE2B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgIBPAL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 11:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgIBPAH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Sep 2020 11:00:07 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BC62087D;
        Wed,  2 Sep 2020 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599058807;
        bh=FUElcGoCh8MVrhlx2sOneakaehau9/YLSKtASFYEWlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNHPIuSjx+nnAho8lk7xpWj45550wq0k7g3ePG1VBb15VJGXwZeXvlUDXArhZuV57
         W0Xdcbj7YioscD6Ke6vAYOgplWCDCOhAA8Li0r1vD6OjHzrlTfXHVi8vXMv+C1muhT
         7ojgbpHVP7ZP2Qv6Vnh0z53AYshayuysllEzCaQ4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/2] MAINTAINERS: Move Hartmut Knaack to Credits
Date:   Wed,  2 Sep 2020 16:59:57 +0200
Message-Id: <20200902145957.13861-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902145957.13861-1-krzk@kernel.org>
References: <20200902145957.13861-1-krzk@kernel.org>
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
index facffcf7b1d1..94dda8ae202c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8489,7 +8489,6 @@ F:	drivers/iio/multiplexer/iio-mux.c
 
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
-R:	Hartmut Knaack <knaack.h@gmx.de>
 R:	Lars-Peter Clausen <lars@metafoo.de>
 R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

