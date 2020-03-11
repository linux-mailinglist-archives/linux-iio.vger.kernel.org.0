Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542861818CB
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgCKMwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 08:52:25 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46018 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgCKMwZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Mar 2020 08:52:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id v19so1719027oic.12
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2020 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seas-upenn-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LejFn6yYVLckCZa01sKnIbyhEF1keVyA7WsR3125o7Q=;
        b=SqCFtrphR3rdM0GNUg+J+c0F2cMwD3mADTdqUeLF53sAZCC6bM+znFHrvP59UYbkXg
         A4E/4QKfIV3e+pZZBUVO2RccLEqxqBgPkyrHaB3deq06rKLjg4hrkn6ynP0CyOgNEV95
         qN1h3OsbTNsDu71LP/smfUb+04HlerRRYNPJLcQMn2Wggxr0IwBwFUMXftzh7+SJABgv
         zJe16rhD82OpN2vY9ONAkItBxkznsEyE/E8K36yEq9q4fpvXx5ixKW/ZPo05TYrmDwrx
         iHjeHYFaOvt5lxttbmJUjXSdAaRoKACIHzw1iPcErqTVBYtTaSRWwjyD2Krg1yf3hKgd
         Ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LejFn6yYVLckCZa01sKnIbyhEF1keVyA7WsR3125o7Q=;
        b=hEKvjeDt1I9wJh+2e1ZDruQeRos0jD4cSnkXhrwPV7LBFpa7JI9+sXAnNsYJh+/j3b
         30PHR+At8nf/Jfs5/5W+3ghK+uMDOvQo51DWZKPvkLVW8f9WEVEuNooGBpgGcUjK7XXq
         BgsY7FX0Y7DlB59A7YjGphFzjs+P41ZL1DqFIlssfH/HTd9mOrTEe0Q551dhuOmd1FTv
         9CNWjWYaONL+N7enqXiu5jsVwtzBcLzFfauC9AtfMP+8ahrsEN+0cLoTJbDR2pEiwrdP
         JwkCVwPXbUS5IoVKuzefTicZMn48VdiOC+BJXCqaaZyeC7gAAv1mw+r0bP022B3VYBrF
         /g7Q==
X-Gm-Message-State: ANhLgQ2t/mBcyXsmWomQySrnBEON0ewnTtT363lxoKkiK9jT8tqVk47S
        aEbRxJGX12t0FT7R0BRqm+7DqQ==
X-Google-Smtp-Source: ADFU+vuTEsYdUO4enXfGQhSe6Gib9TNV9JCuKFuONVqgjUjuZWkvTmtfEDekFBF2IZZdxtfrCz5SRg==
X-Received: by 2002:aca:ab4b:: with SMTP id u72mr1832777oie.97.1583931144064;
        Wed, 11 Mar 2020 05:52:24 -0700 (PDT)
Received: from evX1 ([2806:106e:1f:1211:ccea:c45e:83e9:af6e])
        by smtp.gmail.com with ESMTPSA id f2sm612143oto.35.2020.03.11.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:52:23 -0700 (PDT)
Date:   Wed, 11 Mar 2020 06:52:22 -0600
From:   Enrique Vargas <jevargas@seas.upenn.edu>
To:     Chas Williams <3chas3@gmail.com>, linux-iio@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] remove unnecessary newline for brace
Message-ID: <20200311125222.GA9239@evX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

put brace at the end of line following coding conventions

Signed-off-by: Enrique Vargas <jevargas@seas.upenn.edu>
---
 drivers/atm/adummy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/atm/adummy.c b/drivers/atm/adummy.c
index 8157925af824..6eeaa1b21f3b 100644
--- a/drivers/atm/adummy.c
+++ b/drivers/atm/adummy.c
@@ -131,8 +131,7 @@ adummy_proc_read(struct atm_dev *dev, loff_t *pos, char *page)
 	return 0;
 }
 
-static const struct atmdev_ops adummy_ops =
-{
+static const struct atmdev_ops adummy_ops = {
 	.open =		adummy_open,
 	.close =	adummy_close,	
 	.send =		adummy_send,
-- 
2.17.1

