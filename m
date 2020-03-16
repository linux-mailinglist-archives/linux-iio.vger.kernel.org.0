Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFE186B6A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 13:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbgCPMuM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 08:50:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40053 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbgCPMuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 08:50:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so9696868pgj.7;
        Mon, 16 Mar 2020 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yQQRBR3UCe1qFAx8WTjG74chuD0+CqzV1dqAc0ruQoA=;
        b=BIgHvYmlSE6AOKfBu9BXFcE/GbdLe5qPUTNF7It4xxB7VJ3yOfWCFmZ4EQIuqykMdX
         Wp/wojkEkcSsF5KmMCLYoiJaSqEnQaAPxehCyF+dod/K9ulofLfsaMZHQP8TeULL/7iT
         M51UUcMgH8TUWXrNR8mW0AlRRBluT5y0LE5zkKWJ0GKG1PVHMDjhwlBhp4DPkeFw4F3Q
         K9x7qOMM7y6tXrXeqI/vEv/i/qmldjytstAz5zZGcIIRBfumb4S8hWcMML/MiKlPYumV
         +nYOQnkEr3uCFFlwjy6wx60iHwnaCNG61uKXePEQ7k0Px4W9gNhEQKUWaQp1uxf7nO/G
         U7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yQQRBR3UCe1qFAx8WTjG74chuD0+CqzV1dqAc0ruQoA=;
        b=uM32O9hqR3AG61poIlpTynWWQ1sDvXt+v4c/KCW5srr7hbdL/l2Zy/9p06F8ny7vbk
         zttSP/rrLaS4/87uJRCBWfBhxirwBg7JNymMH/yEIlmxzYEbooRwJ4yLD1VQyXhf1SEE
         sS34fR97cFwxWkvOMf9eU29FWy3KXYf+HjtB2QlIUj/dS+pZ+oluBuscNe6SsA4TQv0K
         L89qPMUbmxjHlik4Gkeglic0BMrOY4yodWuXY3Rp5DJMqI1NTju2fsbsS8aSHg3SP9Tb
         PTvxorSDaTsm1WliUKLpWpWEntNPnWnV0+ou3Pi6WOEzmqDUiywj89SDsCc+rYmg6HGn
         KDlw==
X-Gm-Message-State: ANhLgQ0Kr0NVlzKvbkZsXpjA75ouf8ssnZtHTpAx7EaA2g6+q8jsxZ9q
        vwt3llmLlWiBawIg46gC2i8=
X-Google-Smtp-Source: ADFU+vtvHKaZuwCfss780zR+3XbBpQD+Epnuh5nt9MyiUc0PzY16d5ELEBghO9Cr/SzGtJzKK+CoFw==
X-Received: by 2002:a63:2:: with SMTP id 2mr26113109pga.102.1584363011205;
        Mon, 16 Mar 2020 05:50:11 -0700 (PDT)
Received: from syed.domain.name ([103.201.127.108])
        by smtp.gmail.com with ESMTPSA id x18sm55976328pfo.148.2020.03.16.05.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 05:50:10 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:20:06 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] counter: 104-quad-8: Add lock guards - differential
 encoder
Message-ID: <20200316125006.GA415@syed.domain.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add lock protection from race conditions to 104-quad-8 counter driver
for differential encoder status code changes. Mutex lock calls used for
protection.

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
Changes in v5:
 - Change spin lock calls to mutex lock calls.
 - Modify the title description.

 drivers/counter/104-quad-8.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9dab190..21b2e3e 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1151,18 +1151,26 @@ static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
 					     struct counter_signal *signal,
 					     void *private, char *buf)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
-	const bool disabled = !(priv->cable_fault_enable & BIT(channel_id));
+	bool disabled;
 	unsigned int status;
 	unsigned int fault;
 
-	if (disabled)
+	mutex_lock(&priv->lock);
+
+	disabled = !(priv->cable_fault_enable & BIT(channel_id));
+
+	if (disabled) {
+		mutex_unlock(&priv->lock);
 		return -EINVAL;
+	}
 
 	/* Logic 0 = cable fault */
 	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
+	mutex_unlock(&priv->lock);
+
 	/* Mask respective channel and invert logic */
 	fault = !(status & BIT(channel_id));
 
@@ -1194,6 +1202,8 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 	if (ret)
 		return ret;
 
+	mutex_lock(&priv->lock);
+
 	if (enable)
 		priv->cable_fault_enable |= BIT(channel_id);
 	else
@@ -1204,6 +1214,8 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 
 	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
+	mutex_unlock(&priv->lock);
+
 	return len;
 }
 
-- 
2.7.4

