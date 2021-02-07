Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66573312592
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBGPua (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhBGPu0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CC1E64E66;
        Sun,  7 Feb 2021 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712958;
        bh=J1crtzcACihAIjr0lh/NEmAlqbIDCHdm1R8pyw+i0gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=caReAL5trO+QWVxKE+3bUzMLq3tVuHLRFcWUrKOVu55DpDf87eiM2qhyoMjbUvWn0
         3O/GjmevEGRB3ilKV52Vj4S+QxOjQFVwz7IbUQQia3EDihUY3QnG9Z89aQtvlzrTVe
         1XRFXay8ysjVd9zhyAfi8EGPuAZvfJ8ivGaaDvAj76smPjR5gJzY7EQ4F3bj/r6zpQ
         uppImwCB2e4oStBoDpdqRDjnI016go6loFmCX0z9npTpBaEE8I6SK7LWQQxQWe2ZOU
         4We+IWxIL7x6SgXTWH2XZtt36eKhbc3hJRvZw5wTMGvq0BMxPB5PB7mlH3fBN4/qM8
         nC/cqNRA7lloQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 23/24] staging:iio:cdc:ad7150: Add copyright notice given substantial changes.
Date:   Sun,  7 Feb 2021 15:46:22 +0000
Message-Id: <20210207154623.433442-24-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

It seems to me that the changes made to get this ready to move out of
staging are substantial enough to warant a copyright notice addition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 33c8a78c076f..9a6b55021fa7 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -3,6 +3,7 @@
  * AD7150 capacitive sensor driver supporting AD7150/1/6
  *
  * Copyright 2010-2011 Analog Devices Inc.
+ * Copyright 2021 Jonathan Cameron <Jonathan.Cameron@huawei.com>
  */
 
 #include <linux/bitfield.h>
-- 
2.30.0

