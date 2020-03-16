Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBAA186B6C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 13:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgCPMuw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 08:50:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34613 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730919AbgCPMuw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 08:50:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so7977603plm.1;
        Mon, 16 Mar 2020 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZpMGbXXqa6m8v2kNHAjkP9KJ7pUf2Se2goyp9p1li6k=;
        b=NnXOaYWUoKo1njr2t55uW/zLpCKfUWwvjr3b+cokM1mR9fcQFQRpINqCBE8U1i5BQK
         zVdwbJPsBri/RXvJL3SEulKlFkZiQWBy83dxvT/IQVWbFERoFxFt+WFTX52Uwwv6h6E7
         eT1Gd8B9WV9ukU2/LorE2hsqhMxIVNx2X7HDTiBzMh2ZmSCB6MNsVxa0R3w4x6z5rb8I
         chO2G14Y1l4NvF4evo8hpkmHigA4IRUMtPkopNLMouvx2ygRbnCZCJnzKPLIcc30p+iL
         jx3XUmc3WYkSRLzfSfUOa8Iq0mOESfGQUS6vaJ8bCyr354blfoIQNpWKNPrYn39HtCQw
         446Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZpMGbXXqa6m8v2kNHAjkP9KJ7pUf2Se2goyp9p1li6k=;
        b=rlr+dMMu/P60ZmOrzwBF8h4D3wanJB5oOK1PmPkoMo+smLr2ZIomaB+a/WgvwVz5PZ
         ONHEe/RYQyiEylln1ZDsdzqKLOLK+/kG2Ex4MdWGdhbfC+QlEOAVPBFxZn3cRSs0ZUAK
         uhZmIASKV2B3wNNHQf6ZhaxHKd6P0/McBLH0yUrU3qj6EJjbI6y/I84PCbPCfkO+t0kR
         gzKRIP7YCgLpi5xyLRWUWw7r8seqhNYnwppm1w8VtE7SANWUHBsVesARJ5sfHvcLroqv
         mSai1G+ngbE+o2NZwl9c0FYKX9OU8agNk1MN3hEM8+moGvsgXOsO/OXd0cW1F2gnOAQ7
         cvsA==
X-Gm-Message-State: ANhLgQ3zND0UiMdFdJxNaWHDwqdG/TB/C5tgGBf5BlZEExVFfcHXiPzp
        3mvqDDzrl83KMZfEF78gxl36XuWk
X-Google-Smtp-Source: ADFU+vu/T0lBhYXxYtLJIVNw5uA6jj60DJQmEi8a7FlabEhKBO84KKPdVPI4bOmahLEeho6N0spV+Q==
X-Received: by 2002:a17:902:bc47:: with SMTP id t7mr27046019plz.47.1584363051640;
        Mon, 16 Mar 2020 05:50:51 -0700 (PDT)
Received: from syed.domain.name ([103.201.127.108])
        by smtp.gmail.com with ESMTPSA id e189sm61874290pfa.139.2020.03.16.05.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 05:50:51 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:20:46 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] counter: 104-quad-8: Add lock guards - filter clock
 prescaler
Message-ID: <20200316125046.GA447@syed.domain.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add lock protection from race conditions to the 104-quad-8 counter
driver for filter clock prescaler code changes. Mutex calls used for
protection.

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
Changes in v5:
 - Change spin lock calls to mutex lock calls.
 - Modify the title description.

 drivers/counter/104-quad-8.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9dab190..b268165 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1230,6 +1230,8 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
+	mutex_lock(&priv->lock);
+
 	priv->fck_prescaler[channel_id] = prescaler;
 
 	/* Reset Byte Pointer */
@@ -1240,6 +1242,8 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
 	     base_offset + 1);
 
+	mutex_unlock(&priv->lock);
+
 	return len;
 }
 
-- 
2.7.4

