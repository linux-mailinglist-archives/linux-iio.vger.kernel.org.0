Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3234337766B
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhEILin (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhEILim (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07BC2613EE;
        Sun,  9 May 2021 11:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560260;
        bh=M0IMqKdFCid+M1KBfS16bbhW1sSjpLh6tdQvUW00caM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cA1bRg/nqdYFbnD2403Pph5/oMhirkCaeMfaztfI1NVTZF/DkrTQ3pP319rbZt+fA
         yNliBJShOu/R0iY6nRKmcNF3LuZ1ESO02cjzQ3ZES4Exoh/spAIVNMvAcNkf6Xy2zg
         ZNfCGNsKj2zEnFz4Z/JJ3VoT27/sEKtRRLMy/PdZdP2JnAhclLdXgj0jUc0IHk7GlZ
         7y6+5ODGOHclqCERzDfawp9kp1Fxh1LK5lKJX3ZH7tl6wYjlZaDyS7rkFvnXhLwYi0
         h4cuodMtjcdSHCRN/85uU6RSFGHJx7Hf/0aIILp+ajYxNospjxjg+9pk3puuiM7QG/
         5ufV0k6f3IDeQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 22/28] iio: light: vcnl4035: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:48 +0100
Message-Id: <20210509113354.660190-23-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found using coccicheck script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Parthiban Nallathambi <pn@denx.de>
---
 drivers/iio/light/vcnl4035.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 691a54b763e1..fd2f181b16db 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -144,9 +144,7 @@ static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
 	struct device *dev = &data->client->dev;
 
 	if (on) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0)
-			pm_runtime_put_noidle(dev);
+		ret = pm_runtime_resume_and_get(dev);
 	} else {
 		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
-- 
2.31.1

