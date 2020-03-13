Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93218465F
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 13:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCMMCV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 08:02:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36529 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMMCV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Mar 2020 08:02:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so5126533pfe.3;
        Fri, 13 Mar 2020 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rqZCr5O2knv3aL7ZNtX8r2mBVRi0LMR1FaqngmkfMJQ=;
        b=FPtKLdwxpxKxgBSw0iLe9hQY+9YBYCC+tfTvScmCEbdJOHJsBYYHuAl+k90PNga5QY
         lZzS7M8BrvUJfElR5CzaQHih5TtBsLkO5VjcDyJ39SW/+hUKnro0R/6v+9gO02XfJ36y
         bdFB4oiab+yez9lnislkboKg9Sa1gmmDA3BfwX4YR7bpwOGaspOj/7ZoItr2tABEHTsb
         zCcslmDndpKJY9UVCCexfe56WDKdtEc4vR6DXkU00Q2MSk/roP9rFqqXm5Thy0czpKUw
         cxKxYrSt2ZD7fw8i75yxcLyG0uT0w4/beJEIgVUhBVEE7pVZ5fsvc0DYnFRAyYunYu+z
         A0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rqZCr5O2knv3aL7ZNtX8r2mBVRi0LMR1FaqngmkfMJQ=;
        b=iD0I8pFKkNsdJmVBTRVVNrFC3Qnwv2tr+dm5zHgrFgcrWjzdRvGBYhPuxuWlOnMB6s
         wOa3bRTBbioeY07UY50LUtfw7YXufA96yVEJj1ATtjaIY4wZYd/6c8FnERV72h+Ayz5U
         Il1Y1F4ohSuKB1Tj52h8NbV7Ukf+brCaJf1KVfZV61ny8CRJ1tw4g8M1jGHnrVb3p994
         vvOw1MWrSgyHgb2Pe05AFdYT8yG2gI/xuCJtvYzjxA5MOEP5XAq82wwwEnAmIxqWwiOB
         Dwwam4KJ7RMwK8/zaSw4Ece8Wbx9+qZVkJ+RIaWrkHkTt+f+N3CcpkokjhZ/f8Dg6YHm
         /BMg==
X-Gm-Message-State: ANhLgQ1fIEKtx+z3RnZiX1dui3J0B9mFpow8t3X8sQmUCh6g26Cr/sTd
        y5pqduVpl2qjoGPUivVx7h0=
X-Google-Smtp-Source: ADFU+vv5/FxeZwFsfAreMfeCIP6NjJg9aQZfQhnafovcCtB4i0WwjD+KjHrLRS8iNqfBsFIfRPtq3w==
X-Received: by 2002:a62:1b05:: with SMTP id b5mr11349432pfb.281.1584100940257;
        Fri, 13 Mar 2020 05:02:20 -0700 (PDT)
Received: from syed ([117.97.245.141])
        by smtp.gmail.com with ESMTPSA id 3sm12178433pjg.27.2020.03.13.05.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:02:19 -0700 (PDT)
Date:   Fri, 13 Mar 2020 17:32:13 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] counter: 104-quad-8: Add lock guards - filter clock
 prescaler
Message-ID: <20200313120213.GA17855@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add lock protection from race conditions in the 104-quad-8 counter
driver for filter clock prescaler related changes. There is no IRQ
handling so used spin_lock calls for protection.

Fixes: 9b74dddf79be ("counter: 104-quad-8: Support Filter Clock Prescaler")

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v4:
 - Shift review-comments section so that it is not in commit message.

 drivers/counter/104-quad-8.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9dab190..58615e4 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1230,6 +1230,8 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
+	spin_lock(&priv->lock);
+
 	priv->fck_prescaler[channel_id] = prescaler;
 
 	/* Reset Byte Pointer */
@@ -1240,6 +1242,8 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
 	     base_offset + 1);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
-- 
2.7.4

