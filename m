Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCC229E500
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgJ2Huj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730126AbgJ2Hui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:50:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB3FC0613CF;
        Thu, 29 Oct 2020 00:50:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so1645073pfa.10;
        Thu, 29 Oct 2020 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNkrPLHHXzo4JBLzUlG/Xlp9ujrQPLyDKmRRIViMZxw=;
        b=EqNKppbchCHnNqjZHCpqKABSI72qxA4koIl2Oq/QLMFnMkFcJtFUiyLkpPABrqYVQO
         WPH+L6QNE/KVyUyAhbHKmNsHl+AsLhdynKUY7K0IhFBavUlCBM1Yz2S1/Sqj6OS2PhVh
         tHZFRVNI/x5kG9C46aOidkBTwwAzccEovXllVDlHZF8Myk1hqHICapKPDyKhw4Izous/
         a6KLzeIupQaUwYN/AAL3aajGV+/jYpRYgo6a/Ry5IRaou00bR4VaV6XHKLgjhTxfQydV
         plCvbA+zd0C/sckoWE2YNmLgr3lUMB2jto86K9txmvtRELHJQ5DsLbbAqMIpS1iqf+Oz
         tLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNkrPLHHXzo4JBLzUlG/Xlp9ujrQPLyDKmRRIViMZxw=;
        b=XFijORMUkR+peTYLmqK+1gtzgo9IXpuHCPX3S1XnpMtG7w5slWeWyLjTQ+rbK6NeAw
         GJFVaiy8LX5/LJPRaI1AFZEYTMi1l0syOmQCvXPA9NfxrbRoQ9fAQWmjz/blRhs5ZDPp
         IX7p/JffXX8mnVHndUtY9iPEqzYlpZo40ELhRA26/Xgym9+TFiyAVq6Y9Tt9J99/wuBK
         0Dp62lMWjiuvGLh6j42t+c86izF91TpcJ/CVgsRB4IXzQ4d0FFM/yqnpYCLvv1FRuiYs
         5qEp6jW9+kpTAl3M9J/0S2n9GUek9KV5NVP+Wh1+CpLW0UXFATWtOemeDL0jy9SRYPRx
         +cCA==
X-Gm-Message-State: AOAM532eQQ1Ec+ye74QE2MdmOY8W1y3SVjC+PR0p7ZFDA7ttEEEyV/eh
        R5PbTHuKZWy7l4DSPqcHTZTDrzKwVcfjtfqi
X-Google-Smtp-Source: ABdhPJylhPTzKe1LDDOJVqfk6e/THY7opAzLju4MJ/0WvsA0RzzQfJ0qRVTMuV/IWlFEE2HaQPAfwA==
X-Received: by 2002:aa7:808a:0:b029:160:167d:d332 with SMTP id v10-20020aa7808a0000b0290160167dd332mr3081335pff.1.1603957837209;
        Thu, 29 Oct 2020 00:50:37 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id md11sm1935891pjb.18.2020.10.29.00.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:50:36 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:01 +0800
Message-Id: <20201029074910.227859-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/accel/dmard10.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 90206f015857..64a15dea2a82 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -224,7 +224,6 @@ static int dmard10_remove(struct i2c_client *client)
 	return dmard10_shutdown(client);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dmard10_suspend(struct device *dev)
 {
 	return dmard10_shutdown(to_i2c_client(dev));
@@ -234,7 +233,6 @@ static int dmard10_resume(struct device *dev)
 {
 	return dmard10_reset(to_i2c_client(dev));
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend, dmard10_resume);
 
-- 
2.28.0

