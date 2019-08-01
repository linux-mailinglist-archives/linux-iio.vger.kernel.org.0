Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174127D667
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHAHgE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 03:36:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38478 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHAHgE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 03:36:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so33542312pfn.5;
        Thu, 01 Aug 2019 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=597pY9Kj5buXouikKKcPGi6CbrKSQkJ/79MmJjTSgIc=;
        b=GazRMYuiUG6jfbiu9xtaR/nAmPosdElzAPRrMgo0PeB3sVkZmtZmawRo964S/f3IJw
         T5V0yytJEo62VgwA2kxCfVsO4espuJlumlFYNhmHmSiKgwUMv1Rv8lOS47d1LMze5CnK
         hDUzlKuppcPHS9CPzTeaCNDhP7fp1t6Gbk6pPdmqai6E1gmQBTzwQrt5+A0WEYa2HroH
         EDLrOtJZ+tQ/avhroiKLab+nRVyIiSnNgBsSIrtQDe+BgXiY5Qkbx4SrJ9v+azzdywAc
         KEs8gXXNZLSJwYIzA67+9mbm4zsf23DqjG7do5jP2Le2wsfHU17m+/P4ZwjMJ4WonaMr
         uTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=597pY9Kj5buXouikKKcPGi6CbrKSQkJ/79MmJjTSgIc=;
        b=EYfmQxbdNP5NNWhvVFd/Wq8hfsPovBGsSDsjuBdcDzGRwMHyvD+lG3UFCS62r64CHz
         hWIsYUbfZ9leVZIn3ZPmcQFuu6OvHhi8WlJeVahVIxpTcCVcPIB7UYzO73GiGi0vAg+5
         TEjY7yV91XE3kmX9cf1TC2yzmK//kTye4MZ1fVRibQIrAkycahWVjt3JH2uLjYzHAzgE
         Ec/+4+wg8iqb6+ZZDXH+I8xbpDaKUGC+pUinjLwfNkwzm71DWh5jv3p6oIE72VHtkjXr
         pfMjKVSIx6TQhypTHu9CWYeQY1Qrn4NLB/WQlE/dUw4JQ0k4UV2FR4jaiBWsPCMNTKh2
         DeXQ==
X-Gm-Message-State: APjAAAWFGRDCiF2HJP4NsHVrLOhubMcik6ihdcCEWOGspnXKLOjk9gwY
        wyw8ELmRfoNjtV5OvCQsgpo=
X-Google-Smtp-Source: APXvYqxqyW4nnGI/FudfI2dJfNy9z6omFHUN1l/3nOWQ16bOZV/E2/92mI2cwI0Nk1QsddPgT9pdQQ==
X-Received: by 2002:a62:5253:: with SMTP id g80mr51416327pfb.179.1564644964064;
        Thu, 01 Aug 2019 00:36:04 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 81sm64899993pfa.86.2019.08.01.00.36.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 00:36:03 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 1/4] iio: tsl2772: Use devm_add_action_or_reset
Date:   Thu,  1 Aug 2019 15:35:57 +0800
Message-Id: <20190801073557.9578-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_add_action_or_reset to remove the call to
tsl2772_disable_regulators_action to simplify the error path.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v4:
  - Split v3 into three patches.
  - Revise description to make it more precise.

 drivers/iio/light/tsl2772.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 83cece921843..29cfd8ae2700 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1807,10 +1807,10 @@ static int tsl2772_probe(struct i2c_client *clientp,
 		return PTR_ERR(chip->vdd_supply);
 	}
 
-	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
-			      chip);
+	ret = devm_add_action_or_reset(&clientp->dev,
+					tsl2772_disable_regulators_action,
+					chip);
 	if (ret < 0) {
-		tsl2772_disable_regulators_action(chip);
 		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
 			ret);
 		return ret;
-- 
2.20.1

