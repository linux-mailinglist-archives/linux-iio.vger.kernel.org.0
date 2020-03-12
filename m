Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F79182F16
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 12:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCLL0F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 07:26:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41769 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCLL0E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 07:26:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so2546215plr.8;
        Thu, 12 Mar 2020 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hCHUtum807cKX3xslDRMcG8mu6VO9rXiNzUSRhB+hEo=;
        b=HGx8U17OPOy4dfSA8M7JE2HX4PnapDtKokLj3HRXNIVSlxYUHDY7LSMcDsEceVkUKY
         y+dzO5/zCLeNDOiJwo37Ja/GW1VzOJqaNlXvXJVi0XlP3vRROAu79sLV/CsDX6jgzaVm
         wEkud6VGKIXscsmWmibvlcCsYOzxfCK+vwiGAM/pmm2L8lddYq8ocLixyfNT5DQ6razi
         BZNIqXPuBQzTif0M8qgOzw28AtY44fa30TtAebrRYfqS0qU1ECqEddkIAOTW3LdSp3qC
         ptXXDlA9FiQG2OnCuSd2xRiJZQNkYHFBeT0DPIkW691MigcJH9Dsq3hjTytvIygOxBEV
         agNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hCHUtum807cKX3xslDRMcG8mu6VO9rXiNzUSRhB+hEo=;
        b=FupObyigwJ5UwBP8A31URHxOISrWzK8ANRXQaIC7geBqRSPXVtBVDvq3OTGcopQ6HR
         t3IS4TSFKzrMeHczYbOvER/yhWTzlLAWw1T8uo35y7Cv4vmBzbitJzySM84wWgyExRyn
         c4jaAhseBMBSInRIHybURlHZzcnTSbs7xjbr3lLznS/3MqM5R3VArPH6Z0IUImPY3qQd
         Qc3ByRnT20TpRyyQPaFZ/3aveRmtaL2+3UoMsWbN84g24xPIOd3xL4VWfaVG4KgO7ajO
         HcHx6QOLMdqQZE/QH7XWgyKDQTruPcMlZywM5yLluEjbB20vus7sksZtRD21ZOaA70y6
         nlnA==
X-Gm-Message-State: ANhLgQ1zziiiIVX3EUKR/iUpbUyOEnoiER43aJqB5fE0+ITcqMoi336x
        PpibEGIBFBkM32VzCBwDMQg=
X-Google-Smtp-Source: ADFU+vs/Dph0h7M0maecFLJAixil9yCmF6RNBuW31PTLglUAiEHErZ13ynxqRVrmIWRV4O14yKD1fg==
X-Received: by 2002:a17:90a:a10f:: with SMTP id s15mr3647162pjp.40.1584012362234;
        Thu, 12 Mar 2020 04:26:02 -0700 (PDT)
Received: from syed ([106.210.44.120])
        by smtp.gmail.com with ESMTPSA id h2sm8372011pjc.7.2020.03.12.04.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:26:01 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:55:52 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] counter: 104-quad-8: Add lock guards for filter clock
 prescaler
Message-ID: <20200312112552.GA32509@syed>
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

Fixes: 9b74dddf79be ("counter: 104-quad-8: Support Filter Clock
Prescaler")

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Split the patch from generic interface and differential encoder cable
status changes. Also, include more code statements for protection using
spin_lock calls and remove protection from few code statements which are
unnecessary.
---
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

