Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61748437EEE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Oct 2021 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhJVT7g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Oct 2021 15:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234314AbhJVT73 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Oct 2021 15:59:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A67060F12;
        Fri, 22 Oct 2021 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634932631;
        bh=tztV518ojLRtlutbEnCzM1wsjUZFOmK8O5ObqyQpukM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZnfGmuzDa/YU3Ti7bxy5KWj1upSvP1jlrFOH1IOO+uoe4B/6GzZvt7qgi8Vv07WgG
         wASIq98UScX4R/xHHi3eHgnT9TS5RLDImylnKMgf0eiF80vp4EVwH8dSeI5tILfCh9
         csr4oHpOYN8u2KXZrOceKxpPYPY6rdUpcKlxE3A10C51qrvejuJh4+Xt+uycZfm5vj
         L0lRytNfIsMJw7EnCjyd5a7/VaW1fucOdYVSUf9JmWeiQI2DL30A7/cYAnHDR47KcC
         t+8ncAxqg7O5oSD+UtJW0a1/q7NHbqSlvBHoHB75EIcOUbYMr12x/I9Y+U3xhwuWZ2
         sicSE8VPt14mA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] iio: frequency: adrf6780: Fix adrf6780_spi_{read,write}()
Date:   Fri, 22 Oct 2021 12:56:56 -0700
Message-Id: <20211022195656.1513147-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.1.637.gf443b226ca
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Clang warns:

drivers/iio/frequency/adrf6780.c:117:1: error: all paths through this
function will call itself [-Werror,-Winfinite-recursion]
{
^
drivers/iio/frequency/adrf6780.c:138:1: error: all paths through this
function will call itself [-Werror,-Winfinite-recursion]
{
^
2 errors generated.

The underscore variants should be used here.

Fixes: 63aaf6d06d87 ("iio: frequency: adrf6780: add support for ADRF6780")
Link: https://github.com/ClangBuiltLinux/linux/issues/1490
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/frequency/adrf6780.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index abe8b30fceca..8255ffd174f6 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -118,7 +118,7 @@ static int adrf6780_spi_read(struct adrf6780_state *st, unsigned int reg,
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = adrf6780_spi_read(st, reg, val);
+	ret = __adrf6780_spi_read(st, reg, val);
 	mutex_unlock(&st->lock);
 
 	return ret;
@@ -139,7 +139,7 @@ static int adrf6780_spi_write(struct adrf6780_state *st, unsigned int reg,
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = adrf6780_spi_write(st, reg, val);
+	ret = __adrf6780_spi_write(st, reg, val);
 	mutex_unlock(&st->lock);
 
 	return ret;

base-commit: 77af145dc7eadcb78d38912b67d6a68050d21a9b
-- 
2.33.1.637.gf443b226ca

