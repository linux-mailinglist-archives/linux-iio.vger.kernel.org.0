Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0753F189E5C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCROzh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 10:55:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36134 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCROzg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 10:55:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so8783724plo.3;
        Wed, 18 Mar 2020 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=K/Y339cjUVl/X/gAfLYDhApN5kiIl0QX/F4UwUPxkPo=;
        b=dkLLYf1XuBtBB0cr+RAmVC2P30NOhT0B9wQTmx6gLUZ4ZIW+fqxffEdI5wtPsMvN6b
         LarULhRV2iou62gQ+/KsPgVjNk4bjRk4JOojhfToE7utMecARpXRCwKn/QEIABAVApec
         GlEtyWd3fk9lUrDZIOXgZcjXF2Kc/LfC6KLyFqk8nT0FZ9nj5Jbmw+US1n4zNJGoDTVK
         dKUH9/8XmdPgQKro0Ad9203CL52+lh/zb9o9BlpEmv+CMiO+KhwuESVFyiVzsWbrrHqA
         58HLZVpeaOIqZzWbzrfbiWvmzPzM97DZynJTXNueLTZx96bDrjUJFZslhr+6Cf4rI9qg
         XGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=K/Y339cjUVl/X/gAfLYDhApN5kiIl0QX/F4UwUPxkPo=;
        b=gjbLY20ycW+hW2Cwbvstt0K8llSLByijJwM1+p33CXpMlWGb+roegy6/LAQl77ngAE
         lk3VcWrfdf0S1Dl7QaRwlD6qdRZvLK4/pwFIO9rbiwyPdG++pZh+QJ9sJv5w1BwPCajD
         dOaD3zQ/siYzRptv8lRmOwlKJWCRNyX+HB8/UzfQlcgBc/w8A2KioFXQHrmNusw7lKZ9
         YvuWvZUmLIff7TxeqLbWbI8KSPSI6GauObfjNnqvnnNV1dZ8LbysGkrulUGlGnXQMAQQ
         GGXn2q3pMmCuxN33zOhW9FPCJalKLtkviIAsapAZsHEwopwx/t3CEoOYbD4R086oyqn7
         CGZw==
X-Gm-Message-State: ANhLgQ3khnwFhkNxjq+lmY6QWuHcGaFFmCPsJZfDDCG/H2M9TIojdDj+
        qsTrg6g1cbmRQz0MjqZN4n4=
X-Google-Smtp-Source: ADFU+vvEiYfnwlDKHhp+F7QPB5wCfOW2vxUzhH1bpBEv4VpKvvSLT2X3ZJj2LES6gmmfXqeif0E+7Q==
X-Received: by 2002:a17:90a:32d0:: with SMTP id l74mr5154984pjb.61.1584543335235;
        Wed, 18 Mar 2020 07:55:35 -0700 (PDT)
Received: from SARKAR ([43.224.157.42])
        by smtp.gmail.com with ESMTPSA id x16sm6532676pfn.42.2020.03.18.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 07:55:34 -0700 (PDT)
Message-ID: <5e723666.1c69fb81.3545b.79c3@mx.google.com>
X-Google-Original-Message-ID: <20200318145522.GA21528@rohitsarkar5398@gmail.com>
Date:   Wed, 18 Mar 2020 20:25:22 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, rohitsarkar5398@gmail.com,
        dragos.bogdan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Subject: [PATCH] iio: gyro: adis16136: use scnprintf instead of snprintf
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

scnprintf returns the actual number of bytes written into the buffer as
opposed to snprintf which returns the number of bytes that would have
been written if the buffer was big enough. Using the output of snprintf
may lead to difficult to detect bugs.

Thanks,
Rohit

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/iio/gyro/adis16136.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index a4c967a5fc5c..0a8bb02dc4b9 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -96,7 +96,7 @@ static ssize_t adis16136_show_serial(struct file *file,
 	if (ret)
 		return ret;
 
-	len = snprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
+	len = scnprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
 		lot3, serial);
 
 	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
-- 
2.23.0.385.gbc12974a89

