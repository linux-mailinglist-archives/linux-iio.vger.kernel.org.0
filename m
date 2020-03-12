Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8D182F14
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 12:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCLLZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 07:25:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41735 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCLLZa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 07:25:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so2545708plr.8;
        Thu, 12 Mar 2020 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=A+UyqCpk3ehSt3fATLD0YEXeimmgtg13K4AzSgQmvuk=;
        b=dV6uNS3On5Y7E6b8hIAPmZsRMN/v1Wv8qa1ree/XxcdVVojFZQXywk8QPUsvwNpTwd
         DOphPAdwQNK/w4zKmPtFyeo8TRc8tv8DQlWJIj7AnnBrDgQveuAiw19Cq2rNe6MoaS3A
         QW8vM/251xCi2WGieVQAc0nrqH0d4zpLWIPOxhb3qYpeRJ2HakLYFc6XgmK7zYlLBWNv
         TkuzI/gY+VEPlb6hS8FN9r1QN4WylYkvULTbEvJXslj62QLUVSyU4XQXU6oYnEK+PhbN
         bY65hYM5Epw6m2T7XTwKZcg75l/ISsAR87lqOFVyxQkTCNO7H5J1ujlYImo2BhfRn0/Q
         WIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=A+UyqCpk3ehSt3fATLD0YEXeimmgtg13K4AzSgQmvuk=;
        b=Ky2oLzHe9bXmGqGJ1yI0ig91zUTyO56Ar1DiQOgvV6IMnwK/TrLGI0qYWe9+s2i/vI
         Gg61o3UuSnAAm1UlHlgLTXaXZlXpkOMlCD3daa4JT3XpE2jmEZ6bEKPbBXN60ucfay+o
         UGNa92Gfc7hjBZPKGjU4ScQqalalzJUVwg16vKwD0aGYBcaCbeOkTbQmXDBfyPbUJ2uh
         A+k+03dYQvHuXGBjufHg8CCrzCcV7QW/MXcF6XIyuolPlnFj4YguXQZZQtg1n3ghD/Aa
         aGMsIJLaex/1jXxYp59ihi94hkb+CKn418ryKwS79T0rptk7Q21vAn1332tX3+uvXqm4
         gG8w==
X-Gm-Message-State: ANhLgQ3ZV4fuKKq5XfPu5Ne/ATxtQz6boXz9b9r3eABETlUHXSoGFu9s
        D4QsalAysZjiLoHI/3f/msE=
X-Google-Smtp-Source: ADFU+vvz8DO2LJ23vZGb7Yw7eNHy58G4VO4Va3+ox889JM4DlHq95+LtqS2DorpMTan5OBvzpSsHhQ==
X-Received: by 2002:a17:90a:9501:: with SMTP id t1mr3758101pjo.108.1584012329040;
        Thu, 12 Mar 2020 04:25:29 -0700 (PDT)
Received: from syed ([106.210.44.120])
        by smtp.gmail.com with ESMTPSA id e30sm54230818pga.6.2020.03.12.04.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:25:28 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:55:17 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] counter: 104-quad-8: Add lock guards - differential
 encoder cable
Message-ID: <20200312112517.GA32485@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add lock protection from race conditions in the 104-quad-8 counter
driver for differential encoder cable status changes. There is no IRQ
handling so spin_lock calls are used for protection.

Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential Encoder
Cable Status")

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Split the patch from generic driver interface and clock prescaler
related code changes. Also, include more code statements for protection
using spin_lock calls and remove protection from few code statements as
they are unnecessary.
---
 drivers/counter/104-quad-8.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9dab190..1ce9660 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1153,16 +1153,22 @@ static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
-	const bool disabled = !(priv->cable_fault_enable & BIT(channel_id));
+	bool disabled;
 	unsigned int status;
 	unsigned int fault;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
+	disabled = !(priv->cable_fault_enable & BIT(channel_id));
+
 	if (disabled)
 		return -EINVAL;
 
 	/* Logic 0 = cable fault */
 	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	/* Mask respective channel and invert logic */
 	fault = !(status & BIT(channel_id));
 
@@ -1194,6 +1200,8 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 	if (ret)
 		return ret;
 
+	spin_lock(&priv->lock);
+
 	if (enable)
 		priv->cable_fault_enable |= BIT(channel_id);
 	else
@@ -1204,6 +1212,8 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 
 	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
-- 
2.7.4

