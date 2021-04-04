Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB8353A0F
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 00:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhDDWY5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Apr 2021 18:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhDDWYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Apr 2021 18:24:54 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B5C061756;
        Sun,  4 Apr 2021 15:24:48 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so9336136otr.9;
        Sun, 04 Apr 2021 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=7mopXWBi2wijSGKa4AiTjRSanyVNKQw/ECdzYkzyHBg=;
        b=TVG60R2H4bKieRfyglnQsIBgGK4c5WjLKncENtq0PCeTqi0D6q5ytdppV9OrFrcyfW
         HHH8bCRos+sm+98LPMbzfw9UHqsTBBg7s/QkgB1moRZ5iouugI0y+vNhwmbhAePnOB4i
         UHm7CwCPhCx4Va+74vAKzs/MYhDMCYVVJk5Niwvy5dk5Tb+bSMDd87VQEozlro4dyDG6
         AmPXEEKsjQqXG482qICSickkZGyHeqV/iHIPo8n5z2ogNCNr7F4BNBGtqg0y29ni41l5
         KgrHtAzgpk6axHm7eaSh7ZnahfnCXCwIhxpCHE4w7O1ko7h6Z3DhSzbH48qD+o6iYVPk
         2dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=7mopXWBi2wijSGKa4AiTjRSanyVNKQw/ECdzYkzyHBg=;
        b=rIWl+jIxj/IhA12XX+4AccCP9SnWgPhKTPu5+r11PNWstEFAAMfCVMc4+lNeZxk1bh
         Eea7ZGtC8fgBKuTYqZWVO4Yo1zCo2FcrTmZmv4E3IFUGzXvHcfrvI4Tarsbr4PgMFvBn
         YubJkZ1DRU2TAdSr00ZN9NzxCaqbd0GPtH79CrFKk2jGjGg8T0u1V5jnFxLeV0ABgCxt
         wXE/bkZmA1eQHj+xKxQejz4E+qAAEM3fkMnni4jXidhBRTP6Ww8CufGh1RCEFYmyp6AX
         7nBDkQxfRfjgKGHabGSGsH1eSw/ctz4tQxmqaKkFFgTHkdOziKEiLydXPsYK8hMcKfTm
         gZ0A==
X-Gm-Message-State: AOAM532wqmUs0qTVtwpQjXR5cT1lmoSa5+XAt9X3nAxeUL6icu61my8q
        /DpDWv1hWWDhpNvq/9xF90U=
X-Google-Smtp-Source: ABdhPJxD6prBgFyahJBLuz/JwVFWQaAr1RfWSibZEFa/57wziYI+4OJwVB+xK+3mf1B5TIarlh4DHQ==
X-Received: by 2002:a9d:2e1:: with SMTP id 88mr19725255otl.120.1617575088397;
        Sun, 04 Apr 2021 15:24:48 -0700 (PDT)
Received: from fedora ([2806:2f0:7000:86b1:c1bc:6875:f962:d652])
        by smtp.gmail.com with ESMTPSA id h59sm3528290otb.29.2021.04.04.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 15:24:48 -0700 (PDT)
Date:   Sun, 4 Apr 2021 17:24:43 -0500
From:   David Villasana =?iso-8859-1?Q?Jim=E9nez?= 
        <davidvillasana14@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: iio: cdc: remove repeated word
Message-ID: <YGo8q4R5dqgtDMlg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix checkpatch warning:
WARNING: Possible repeated word: 'from'

Signed-off-by: David Villasana Jiménez <davidvillasana14@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 48132ab157ef..1be214512ff8 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -57,7 +57,7 @@
  * @threshold: thresholds for simple capacitance value events
  * @thresh_sensitivity: threshold for simple capacitance offset
  *	from 'average' value.
- * @mag_sensitity: threshold for magnitude of capacitance offset from
+ * @mag_sensitity: threshold for magnitude of capacitance offset
  *	from 'average' value.
  * @thresh_timeout: a timeout, in samples from the moment an
  *	adaptive threshold event occurs to when the average
-- 
2.30.2

