Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5318465B
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 13:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCMMBn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 08:01:43 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53476 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgCMMBm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Mar 2020 08:01:42 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so4058806pjb.3;
        Fri, 13 Mar 2020 05:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QJI0Bdftwo0kfKfBxvcXSd5Z7Cf8rsBckFWxQ/WB9Js=;
        b=AmPJ1XnT7a0Axk4GYGnIeAg10a2x9h24rjUCCpz765a17lXYcocZrtxC97DjaMLEPj
         GA9Q9QaJTfZRM3CoP9lORv+K5P7TPRitYQ9E3FmYaqwoLFWASiASX/LWFjlvZGGw0eHg
         z0lSJalNrMiR+7Rv+zga/c725y06dcDtjgSTqLhFZPMzWgC9Oh1mD+Ytjl6wurOc8Is8
         XVy9lwyjHMMTa/1s+OL9zQOnqGP4+FCcsovyAqs4U2uuZg4lxsyz2J4m5UJguH5iQM7W
         yeoEw0/SekGPXP1tsmGPkP3LblXCZSwwILd+V/lVNapiJ1UUUPolJ6gEc50tFyOpm2yf
         P3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QJI0Bdftwo0kfKfBxvcXSd5Z7Cf8rsBckFWxQ/WB9Js=;
        b=CaK5fbRK+KLmmOp4Be5G33XRiFKWV/EZxbK2Y2QvG52LuomIIMK2wN4daG78duy6L6
         TIAfNUP7t5J5h7daxjn92UR03bx7rdJXL1uwTTdarg5iZoFUwLY5LgrwkDP487d+SiYo
         EpyYoEQy+hWE97Hw1X092HLvefBjR8z5odJdRgLLHb4pKiBSufVi+f1pVKWZI7nlzk1c
         yy6qvGrQDD6ujw8dpXUHoVgmzTQYm3N5B5U/8b5QBBTjh1llFBG6D7j+SCAC1LmoSy6w
         no7akR3iR0N4EeMlMBEK2nz8dRPDTXsEIoyPvil4KhY3ee8or87HTj5lYOnnnYGe/Nyh
         RK9A==
X-Gm-Message-State: ANhLgQ2E4mT0R2yT24DCgR2lKEjKqJwSq8w/7SHVTXj5xABaCUugVpcT
        Ukoe9uy6/68pC4p/0uozHR4=
X-Google-Smtp-Source: ADFU+vvfdobXfVncHmVaft5t2AMCmMWORH4rqZtx4/fBFSxLc0eqw/CukXmlJygEWIUeaOKIc8lvyQ==
X-Received: by 2002:a17:902:9b95:: with SMTP id y21mr12961971plp.101.1584100899951;
        Fri, 13 Mar 2020 05:01:39 -0700 (PDT)
Received: from syed ([117.97.245.141])
        by smtp.gmail.com with ESMTPSA id k14sm12006265pje.3.2020.03.13.05.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:01:39 -0700 (PDT)
Date:   Fri, 13 Mar 2020 17:31:33 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] counter: 104-quad-8: Add lock guards - differential
 encoder cable
Message-ID: <20200313120133.GA17830@syed>
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
handling so use spin_lock calls for protection.

Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential Encoder Cable Status")

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
Changes in v4:
 - Shift review-comments section so that it is not saved in commit message.
 - Add spin_unlock calls for deadlock avoidance.
 - Few changes related to casting.

 drivers/counter/104-quad-8.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9dab190..c9e227f 100644
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
+	spin_lock(&priv->lock);
+
+	disabled = !(priv->cable_fault_enable & BIT(channel_id));
+
+	if (disabled) {
+		spin_unlock(&priv->lock);
 		return -EINVAL;
+	}
 
 	/* Logic 0 = cable fault */
 	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
+	spin_unlock(&priv->lock);
+
 	/* Mask respective channel and invert logic */
 	fault = !(status & BIT(channel_id));
 
@@ -1194,6 +1202,8 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 	if (ret)
 		return ret;
 
+	spin_lock(&priv->lock);
+
 	if (enable)
 		priv->cable_fault_enable |= BIT(channel_id);
 	else
@@ -1204,6 +1214,8 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 
 	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
-- 
2.7.4

