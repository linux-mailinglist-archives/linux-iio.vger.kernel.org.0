Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED0333A6F9
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhCNQtT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234672AbhCNQtJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4905864E7C;
        Sun, 14 Mar 2021 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740549;
        bh=HoxW6wThxv+y1k2anG1pVqG9lZRroDxpSKTo5lC/0Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7uDrTEY+IqC1DfwecFrTTVNQbMmjKR6jl+Gg1G6OWgaaioqV4KCCt5ri6/nrB2t8
         gEL/Ui1DJiDvVG0EE5a6DjnrukqqHfe+ZYnqy5nDTe7H4xroOe4DA+ACgS9cLMO+2F
         7cGqVPHoIXmufPgFFbkGC9H/WC6biohgWjeKydWePoxrHSS547fGjo9UyUEkUMQfVZ
         f00vd4QdYcc8ocaM9KnR76ZpENeVdI228XBHUL50vvHflE7TO+2xsrFSZBb1rfJKL7
         Zsi2LaSQejMetbo3DjnuigD5EQh+IhccR7zaO1YGs3/9PLXqmPPzK9uR0D0DO5JrJF
         tgLa6VuuUlGSw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH 3/8] iio: dac: ad5770r: kernel-doc fix case of letter R wrong in structure name
Date:   Sun, 14 Mar 2021 16:46:50 +0000
Message-Id: <20210314164655.408461-4-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
References: <20210314164655.408461-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Nothing useful to add beyond this causing a warning with W=1

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/dac/ad5770r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 84dcf149261f..4e7a8ed83cc1 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -118,7 +118,7 @@ struct ad5770r_out_range {
 };
 
 /**
- * struct ad5770R_state - driver instance specific data
+ * struct ad5770r_state - driver instance specific data
  * @spi:		spi_device
  * @regmap:		regmap
  * @vref_reg:		fixed regulator for reference configuration
-- 
2.30.2

