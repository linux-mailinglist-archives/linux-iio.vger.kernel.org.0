Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D814F36B774
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhDZRFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235187AbhDZRFD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:05:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 091B161026;
        Mon, 26 Apr 2021 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456661;
        bh=V5sTDjK/t7jLtwqrpye9zTN4n7r5WYjm9L+qXcoRY0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAReStBu/jUeb/y8Bh5/QLK2tOy/Acy3hAZBO5nL42mVjNhgzAhjIjLQkjKNCQshM
         dLsz6c4mYaSkyGlIiUX41fSdbq2mwdjNKByHM0sja/dvbfj8flEImGlwprESBfytM1
         5OPNuBrbZW7Qe1qTdcbpTZ07KEb690tkOoVdrZbcQR5ITBYONQBBMdhFe0L1L5AUHo
         aHyUW/cy45o6JjZIxCA5WwM1XOaQygbbBwE4iZhlKhiC4VAb0r706JAzDE9ivRNLDE
         7g8fMomQh8p05q1HEYZIl/rrRTDyLJ0xX9ReOf0mvSvymGt/YfIKqA4Q1V72nxVMS0
         w5qmAi243gusw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugene Zaikonnikov <ez@norphonic.com>
Subject: [PATCH 6/8] iio: humidity: hdc2010: Drop duplicate setting of iio_dev.dev.parent
Date:   Mon, 26 Apr 2021 18:02:49 +0100
Message-Id: <20210426170251.351957-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
References: <20210426170251.351957-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Already set to same value in devm_iio_device_alloc()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eugene Zaikonnikov <ez@norphonic.com>
---
 drivers/iio/humidity/hdc2010.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc2010.c b/drivers/iio/humidity/hdc2010.c
index 83f5b9f60780..1381df46187c 100644
--- a/drivers/iio/humidity/hdc2010.c
+++ b/drivers/iio/humidity/hdc2010.c
@@ -272,7 +272,6 @@ static int hdc2010_probe(struct i2c_client *client,
 	data->client = client;
 	mutex_init(&data->lock);
 
-	indio_dev->dev.parent = &client->dev;
 	/*
 	 * As DEVICE ID register does not differentiate between
 	 * HDC2010 and HDC2080, we have the name hardcoded
-- 
2.31.1

