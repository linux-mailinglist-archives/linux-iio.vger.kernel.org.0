Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67E3D26B9
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jul 2021 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhGVOyI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Jul 2021 10:54:08 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51586 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232599AbhGVOyH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Jul 2021 10:54:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 20D9B49E28;
        Thu, 22 Jul 2021 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1626968079; x=1628782480; bh=81Cj+FmRdrkIOmdD/yrwU8JJye1ofZY5tGc
        01O4yW2Q=; b=RYSkpD9N9cqUNlLNcFtC06jRoqGQqvxULmGHhWFVBGVcP7vdAIR
        u/A44Lf2pILTgky3BPhRFXdCNDbwkgk3Llr6rDUEq5grVM3BjF7YNHlxsg2gDuey
        WeNKh5XBiIgXVBhEejPNRZOwawS4RWGLRs+X+U1MF3KXvS3zNi4+vQas=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5veHgS7kkHIu; Thu, 22 Jul 2021 18:34:39 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 11BF449E47;
        Thu, 22 Jul 2021 18:34:39 +0300 (MSK)
Received: from fedora.bbmc.yadro.com (10.199.0.147) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 22 Jul 2021 18:34:36 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v5 1/3] iio: proximity: vcnl3020: add DMA safe buffer
Date:   Thu, 22 Jul 2021 18:44:18 +0300
Message-ID: <20210722154420.915082-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722154420.915082-1-i.mikhaylov@yadro.com>
References: <20210722154420.915082-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.147]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add DMA safe buffer for bulk transfers.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/iio/proximity/vcnl3020.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 43817f6b3086..c90f9c6e9e97 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -57,12 +57,14 @@ static const int vcnl3020_prox_sampling_frequency[][2] = {
  * @dev:	vcnl3020 device.
  * @rev:	revision id.
  * @lock:	lock for protecting access to device hardware registers.
+ * @buf:	DMA safe __be16 buffer.
  */
 struct vcnl3020_data {
 	struct regmap *regmap;
 	struct device *dev;
 	u8 rev;
 	struct mutex lock;
+	__be16 buf ____cacheline_aligned;
 };
 
 /**
@@ -144,7 +146,6 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
 {
 	int rc;
 	unsigned int reg;
-	__be16 res;
 
 	mutex_lock(&data->lock);
 
@@ -163,12 +164,12 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
 	}
 
 	/* high & low result bytes read */
-	rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &res,
-			      sizeof(res));
+	rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &data->buf,
+			      sizeof(data->buf));
 	if (rc)
 		goto err_unlock;
 
-	*val = be16_to_cpu(res);
+	*val = be16_to_cpu(data->buf);
 
 err_unlock:
 	mutex_unlock(&data->lock);
-- 
2.31.1

