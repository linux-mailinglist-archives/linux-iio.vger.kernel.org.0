Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54602460802
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbhK1RZd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:25:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56380 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbhK1RXd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:23:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351556103F
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373BCC004E1;
        Sun, 28 Nov 2021 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638120016;
        bh=KPaicMjrlpGor07drBAYhtzSDLARBN3cPeLRzhrRnRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmAvlCWYBk4mJpOCtreD8EZ4X3Xqic44Fl+oZTte8Pb0VKcqa0Qwl0lntuX7Klf5l
         zKyZXUPPhygYpeZyblyOJ6hYUFFd+PVycMEDl2njGIXEZrcWcsmtqs5QxF82wdFdGD
         ZXNEBJQyu2PfvonbX1p0lG47G3TWy5cOMlbfbcy/6/bR1LJ6MirHDa3uyfqzyOarVH
         t8mxHg+c1LAbekPr4N7x9g6n5MdZm8ADFhqFlVRxWpw/wKKbd8iVPwxLd19u2vaLVm
         qhJkR/f2qQPCZtSFzmeGzQH33Ozsus7MOOEkCEX0bMJpcnFkFQxtAyqwBeLPv8OZ0K
         26YL7GnAmy42g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 11/12] iio:accel:bmc150: Mark structure __maybe_unused as only needed with for pm ops.
Date:   Sun, 28 Nov 2021 17:24:44 +0000
Message-Id: <20211128172445.2616166-12-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If CONFIG_PM not set then clang warns this structure is unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/bmc150-accel-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index b0678c351e82..e6081dd0a880 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -170,7 +170,7 @@ static const struct {
 				     {1000, 0, 0x0E},
 				     {2000, 0, 0x0F} };
 
-static const struct {
+static __maybe_unused const struct {
 	int bw_bits;
 	int msec;
 } bmc150_accel_sample_upd_time[] = { {0x08, 64},
-- 
2.34.1

