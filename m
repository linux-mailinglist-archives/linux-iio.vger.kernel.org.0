Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82CE917E735
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 19:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCISbk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 14:31:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33851 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgCISbk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 14:31:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so5110591pgn.1;
        Mon, 09 Mar 2020 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=yraj5Tql8oxf5l1BCisk3gPL3avSiKpNGBiD85oy6HA=;
        b=M/TrsNVgPNpqgyAPSWaNXD5hrsdsZxFeSdnV64e+3tLbA1TWaTVO5EJoIkxWXIz4KE
         +o4+T96PihjHLUpyj7w4RAV6dlqc2FPV1pTlUZUbpbm38h4silLYEMqkqz58WHbzVK6f
         K8Pv2bGCfUj4MRvy1w9MuBNt23qpm+cd+14rII5BK8OxLizOqca2C2p2eZeAQwYpmS1d
         ECCKz4lagim+MXgx5CDw3Il8D2F/87olefzBymt3/Dk3sraVsQJkgEdLYeC/fXUt7RBt
         r6OduFNhJrUXvV5SjVqP48ec+qxFHK2S1x404YQ4R6GbBpA9YLPoN2rDy8Xab++A0rM0
         9HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=yraj5Tql8oxf5l1BCisk3gPL3avSiKpNGBiD85oy6HA=;
        b=NTtUIgjwpezZQnCd4atRXY+I6DuFX3bfMgiEVq1CviG8RQ1EHpCz/8L6c0Y1zQ2z00
         gWPNiXRuQgyDsLD41hKLX9PSuSWz0WpyABOekN5I2YMp7MrYnrpTFMdnIUxTLN1tuJ40
         wXG3eOQt99V17ncQ8BkJaoDdjmLCisw5k0U+8rNli/O83oqw2lGKAkvvPimfdKDkPElT
         fLckJiQKPP/oohjEMP+mVL+F+Sjrj3TLRMKpLuuC0gqFT/gavzh3LpBZaU1hG4JJGvPg
         QdCgDHHXFg6dYNG3kIm5MHLOnPnFY38zQxPnXdkO81sd7TbMmrJJvqPC10TRYwKBDPp/
         pCBw==
X-Gm-Message-State: ANhLgQ1wTq9c7yT32Zz9K1v4RoaWlY/3ql/a3wYOqCEzztI6SwVe5ahe
        GDRwN7ncjBU+SNMahkLYaHL9aTG1gB6sqA==
X-Google-Smtp-Source: ADFU+vugVGkRBGTZ4VQ53YA3Ds23WcnxrMGybWKnDU78AmFeAvxhZZWq+awgdEndikah94nMvfDGiQ==
X-Received: by 2002:a62:f84e:: with SMTP id c14mr18455462pfm.6.1583778698671;
        Mon, 09 Mar 2020 11:31:38 -0700 (PDT)
Received: from SARKAR ([2401:4900:330b:b8fc:399a:a833:fab3:83b])
        by smtp.gmail.com with ESMTPSA id mr7sm246643pjb.12.2020.03.09.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:31:37 -0700 (PDT)
Message-ID: <5e668b89.1c69fb81.d7e4f.0f61@mx.google.com>
X-Google-Original-Message-ID: <20200309183128.GA21734@rohitsarkar5398@gmail.com>
Date:   Tue, 10 Mar 2020 00:01:28 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, matt.ranostay@konsulko.com
Subject: [PATCH] iio: health: max30100: remove mlock usage
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use local lock instead of indio_dev's mlock.
The mlock was being used to protect local driver state thus using the
local lock is a better option here.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/iio/health/max30100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 84010501762d..8ddc4649547d 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -388,7 +388,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
 		 * Temperature reading can only be acquired while engine
 		 * is running
 		 */
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&data->lock);
 
 		if (!iio_buffer_enabled(indio_dev))
 			ret = -EAGAIN;
@@ -399,7 +399,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
 
 		}
 
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&data->lock);
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1;  /* 0.0625 */
-- 
2.23.0.385.gbc12974a89

