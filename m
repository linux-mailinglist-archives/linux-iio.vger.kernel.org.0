Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9825E18A036
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 17:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCRQL6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 12:11:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38305 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRQL6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 12:11:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so13947099pgh.5;
        Wed, 18 Mar 2020 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=LWuGqqiVZStjA49iRqkB2ECGeP11khRAviVxRIQYens=;
        b=hJ7/AnymbJqEL9fDuUD1UXa4a8M+PhkAlkiJxpd/HpgvsQN9ycgElBYdD2wF6KqzQi
         9l4eprE+HBCuCqsilh4rJEN/+DOAhV7icJNaBCoFdX9BLt5s6C9ogqCVmb1jnojQ+NfE
         oK52vugCG2BeY3o4AR0/dwv0PmmCzV9RhSpYUg0gmAAYnQijiFUck2kqJdGA4jQ7iKtW
         S0riliFEbzOm5WuHnyI/o9Et9bnZhBB/+/3ZPNYyfhgyhEpTudH6rQJm7WlE3651vlx5
         93Sb5qubnCm9StZFeETTMrg7ytES7wN5+ZNy/S+XWwc3+32R7lbZKDMXZm0WhJYBRG12
         kKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=LWuGqqiVZStjA49iRqkB2ECGeP11khRAviVxRIQYens=;
        b=pObCP0KvNXY+c8FOOmD5KFr8Y1K7+BDeMXC5nXO3/DyMe+JOu2YJeKZgbpf+zlC16Z
         kHyUQRIaxkOyw8SemHz1XslIBDas2/yYB3KLTGW1H1ard8njyF5NlY0K4NEr9n3Un392
         Ex+aUrssHSkXV09LdE0xUWV0ScAAsEIqr3RyhkkZgzdo6o3jGVhuKQZdsYk1xR8mY3cI
         Ml2zURscZzMc8p//4nEbjPcvf8XU1UJeQFT9BL16yNI8bnzZTdFsiKxLeXREo52jyjDx
         6yXyoejdgV3ctWRt0ek172rX18zc2wwIjfmycX6zLSnIJ+rTfo91HUbo6+aWK277GzZ9
         ptkQ==
X-Gm-Message-State: ANhLgQ0xesU/dZ/uEw3hp9rrz7dD9MhOfjpv9+pjibMTXV67hUE0cFRi
        UpiygJ9tw5csH6xgzNP1Bdwf5hvjMoA=
X-Google-Smtp-Source: ADFU+vsO9tap4oeyRWVuzA9XlsiET4/dRMS4Pk/tQwU5/YnV0jOhKwCBCopromTwiUxlYpEq3zes6A==
X-Received: by 2002:a63:7c02:: with SMTP id x2mr5576113pgc.236.1584547916442;
        Wed, 18 Mar 2020 09:11:56 -0700 (PDT)
Received: from SARKAR ([43.224.157.42])
        by smtp.gmail.com with ESMTPSA id f19sm6356308pgf.33.2020.03.18.09.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:11:55 -0700 (PDT)
Message-ID: <5e72484b.1c69fb81.53f77.5a16@mx.google.com>
X-Google-Original-Message-ID: <20200318161151.GA31012@rohitsarkar5398@gmail.com>
Date:   Wed, 18 Mar 2020 21:41:51 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: core: Make mlock internal to the iio core
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"mlock" should ideally only be used by the iio core. The mlock
implementation may change in the future which means that no driver
should be explicitly using mlock.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index eed58ed2f368..e975020abaa6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -492,7 +492,7 @@ struct iio_buffer_setup_ops {
  * @buffer:		[DRIVER] any buffer present
  * @buffer_list:	[INTERN] list of all buffers currently attached
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
- * @mlock:		[DRIVER] lock used to prevent simultaneous device state
+ * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
  * @masklength:		[INTERN] the length of the mask established from
-- 
2.23.0.385.gbc12974a89

