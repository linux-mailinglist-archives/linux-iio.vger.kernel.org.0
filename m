Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571ED7496D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbfGYIzF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 04:55:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34075 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388546AbfGYIzF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Jul 2019 04:55:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so22407253pfo.1;
        Thu, 25 Jul 2019 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7zuXq+B8emJm/vwCEOOJ6LOcGUENqYhRqQbLruFnYI=;
        b=iG6/G3YJLE4ZZGea2kup1qrO4DItBBydDovywo+tTg9ZRIZaHFUrYsuegRP7lJrc7k
         VZ4jAT1mjtpHJQePHzpgvOtTTBzRVPZ43OGnzNVa5buz/pFO/HmNBtICgAN93710KKZ5
         f71WgNGqQGuZ3MURp6lOSgpJZjg9GcWvpv18G0vBuXv/emNyVFYXZ9yU222fp/PxOGtQ
         d0mb1NrQ/f7f+POT0jZRdPGrjNnrGFIJ915kXms5D9TWUR0QjpT/07T9cE9zfMiO+yxC
         81+eWCF9RLYhVSX9FAwAoQ11nuIp93bpJn03UpE7/cnIOfa48GE4YaVAVdRCYJ9tn0rF
         qFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7zuXq+B8emJm/vwCEOOJ6LOcGUENqYhRqQbLruFnYI=;
        b=G3Wlo0rEIujAn9Q8R92pDFM9QFdMGziXgXgpax8fuEBQaj2cRsNxRp5TFq57OF3wKm
         msn9xb20TvqOJQeSEQasO946eNjht5aZ8GtBOMemPBdmshrVgjiO0c/s1+cf23tih66Q
         fJabRUh8ojjuzX03ER/uQaADj9kHtuaa9JCe0XUnZ/aT53Y2dcrp3xkPzkM+KbX1C2ic
         jtBu1liRx/sHdO+wpuFkWfTYCi/PpaIsLqlG6xVrCiRpcG6SN4MkZq8wx9+8J7G4RnbY
         lpD1gTXeDxygh+eGkXQkxv/SS6EO+SGRpXinTxT4ju2u9D4PZ8dIHf8ANpiC6+1iiF09
         nPXw==
X-Gm-Message-State: APjAAAV5/eI7L+Gw4l5WFR97iKTYM6KYJt8gYSAD/J9MwBeoBSOJ4QD5
        BaN4nv7MCtxtj4bOrzmYRc9N7JAAa+k=
X-Google-Smtp-Source: APXvYqyROMZ1snJL0IyvlReyvkUAmYeODq5nc1+cHMd9O8CtOIrT16U0ipbSGzDixJiDjpCVFvTUfA==
X-Received: by 2002:aa7:8b55:: with SMTP id i21mr15598222pfd.155.1564044904544;
        Thu, 25 Jul 2019 01:55:04 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id e11sm61474201pfm.35.2019.07.25.01.55.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 01:55:03 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] counter/ftm-quaddec: Use device-managed registration API
Date:   Thu, 25 Jul 2019 16:54:58 +0800
Message-Id: <20190725085458.21838-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of devm_counter_register.
Then we can remove redundant unregistration API
usage to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/counter/ftm-quaddec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 68a9b7393457..bccbca8681b6 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -317,7 +317,7 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 
 	ftm_quaddec_init(ftm);
 
-	ret = counter_register(&ftm->counter);
+	ret = devm_counter_register(&pdev->dev, &ftm->counter);
 	if (ret)
 		ftm_quaddec_disable(ftm);
 
@@ -328,8 +328,6 @@ static int ftm_quaddec_remove(struct platform_device *pdev)
 {
 	struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
 
-	counter_unregister(&ftm->counter);
-
 	ftm_quaddec_disable(ftm);
 
 	return 0;
-- 
2.20.1

