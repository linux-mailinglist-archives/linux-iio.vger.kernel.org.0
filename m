Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D2254FF9
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 22:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgH0UZE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 16:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0UZD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 16:25:03 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED3420786;
        Thu, 27 Aug 2020 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598559903;
        bh=Z2v3nWCgo9XCVbOjcjRlIv4qntJnZTCMqd2Bs+YDMXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lDkqedzbyTC46kIrqkNyiRRckninnKreIolfuop1Uv7l6RgG+VpfKw+HjRAeQ//QP
         AAnnaF5QXtiKShaeQw0AYXlSotpb0VsjPrnNNo8Svv0xyxL3EYH+wuFJRyE8t0jlKK
         Zi+zT1QydaT+lfsvaTu9gD12vLNhc7utoKJ3wsSs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH] MAINTAINERS: Move Hartmut Knaack to Credits
Date:   Thu, 27 Aug 2020 22:24:52 +0200
Message-Id: <20200827202452.27714-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hartmut Knaack was an active reviewer and contributor to the IIO
subsystem and drivers.  However last message on LKML from him was sent
in October 2015.

In thanks for Hartmut's effort, move him name to the Credits.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 32ee70a7562e..edb81e3159b1 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1953,6 +1953,10 @@ S: Am Bergfried 10
 S: 63225 Langen
 S: Germany
 
+N: Hartmut Knaack
+E: knaack.h@gmx.de
+D: IIO subsystem and drivers
+
 N: Alain L. Knaff
 E: Alain.Knaff@lll.lu
 D: floppy driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 523ac1602b62..1276833532c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8532,7 +8532,6 @@ F:	drivers/iio/multiplexer/iio-mux.c
 
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
-R:	Hartmut Knaack <knaack.h@gmx.de>
 R:	Lars-Peter Clausen <lars@metafoo.de>
 R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

