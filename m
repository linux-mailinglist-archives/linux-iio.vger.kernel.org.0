Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B94460803
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbhK1RZh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:25:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35830 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbhK1RXg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:23:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E69EB80D25
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22334C53FC1;
        Sun, 28 Nov 2021 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638120018;
        bh=/z2ylpSTcG9wpjujMqzaEGms/pLYcqdQlxLGhPpw5Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EkfLzufaKn9KLa2nZeam09Xo/N3DwKA9S/wNZZ7F6WCGrbO4HzVJ/MIUBrlcRrE1P
         XG4akx2W1LoFcPNnRRUli0eM87rxi2UzELrnsj6F6rGcMkhnR4t4h5p3gWxzJMMEii
         Vx7b82XXG3OaP/ZXJH5vQ3h7xh4zdh8R0co/cjEqwNLY9Ro0tPfLRDn7JpNs5ROkkH
         kxOfYtgJx5y2B08OJXv/XJdkerH8h5z1HhcgdvNNvEXf3Kpog0Tqr/h2Zx+G88gPaR
         KwzulMUZCfJiUT3r8Bxn6k4Hd1MYxmEy2Om27jxOybclfy8IcInL4Tr3WXGn+hHvUw
         Xq4lqgwOny0Jw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 12/12] iio:accel:kxcjk-1013: Mark struct __maybe_unused to avoid warning.
Date:   Sun, 28 Nov 2021 17:24:45 +0000
Message-Id: <20211128172445.2616166-13-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This structure is only used in PM ops, so may not be used depending
on build configuration.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/kxcjk-1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 88cf0c276893..460b1a89d575 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -315,7 +315,7 @@ static const char *const kxtf9_samp_freq_avail =
 	"25 50 100 200 400 800";
 
 /* Refer to section 4 of the specification */
-static const struct {
+static __maybe_unused const struct {
 	int odr_bits;
 	int usec;
 } odr_start_up_times[KX_MAX_CHIPS][12] = {
-- 
2.34.1

