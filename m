Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30C44643D
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfFNQdE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 12:33:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33798 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNQdD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2019 12:33:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so3210221wrl.1;
        Fri, 14 Jun 2019 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8wdXxU4tFwUoWKvXvo7dS/CRtSW8huyMcBERdfUB8k=;
        b=Yl+QfPgKpr+w0DEtuQQNPcyl2qeLjOBYDIKp7qPHRYTQ2Liqly1IWx6TPG9HZGj5C/
         kzHtRmn3uQ8RfnpiHyhiBAvq9b+p5U01g64vn3NOHFIIWqC75V9gfDdJm+DsV7tRgM++
         StaP/9lRzyvgwUGCHgDrTsvEWx1SHHg9+SD8y1LA5acWvJj+cTyGvZVtsPLw0ty78FTF
         /GcJGyxhLkQLXyX/53RIz61bmYj3W6MSNaihi4DbW5RAG+UFGzcPaQjBct4quzL4fzgr
         Qdj50s+hsQvSM9jXCyxoWxtLvyUSr6mhifh7cn9uxsJPJQ3CZ7IznZCSejysmb9FVAyS
         0Gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8wdXxU4tFwUoWKvXvo7dS/CRtSW8huyMcBERdfUB8k=;
        b=GRJ/z9s6B+5amioAeXIQr/KLXiPboHLo9PdFiJnYWecdZwdnG3kIAFwEEpFKXVpmKh
         Vp35Z6siSPOiWGrp+aZiT5R2bBdNc+E1iz6YhKvSRkEYoDNRstrOzc7i7XmJJZfRWVG4
         BLFuBC6tzDdwxJv00pc4rRe+nJ60/N+I8cA9En70GcBIWlXPAJd7EpVdhpSZBQIhpYbP
         T228AgXfCWwJwwOzSX6O0DKSGhpoAkgWspVhq6GYbCpT7w72yA+87blncjHbufX75/lp
         A3I7k3Ihcx8w0hwAfcqYf4ghwmLGA52a2hx3Y+M62AHkDsevTlsMXZMKxNwT7pxHF1sW
         ejDA==
X-Gm-Message-State: APjAAAVhO+Hu28p6hXeOpC/tTHzMQFXc4kA+XjjQccaP/PPD+UEX33vh
        oak5x0rq9Rum4DWfzNxSRdY=
X-Google-Smtp-Source: APXvYqwgLGKA3ee1Gvw/tmD9xSuiS937SeFYyksGqPMuYPhYWpwerSjlNLOWmZxpMK+aJLOYh/ebOQ==
X-Received: by 2002:a5d:5491:: with SMTP id h17mr6626926wrv.182.1560529982167;
        Fri, 14 Jun 2019 09:33:02 -0700 (PDT)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
        by smtp.gmail.com with ESMTPSA id d10sm5126806wrp.74.2019.06.14.09.33.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:33:01 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:32:54 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 2/3] staging: iio: ad7150: simplify i2c SMBus return
 treatment
Message-ID: <90e8a25eca0825878d55fe0a9e760906b4689035.1560529045.git.melissa.srw@gmail.com>
References: <cover.1560529045.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560529045.git.melissa.srw@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since i2c_smbus_write_byte_data returns no-positive value, this commit
making the treatment of its return value less verbose.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 091aa33589d7..7d56f10a19ed 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -202,16 +202,11 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 	ret = i2c_smbus_write_byte_data(chip->client,
 					ad7150_addresses[chan][4],
 					sens);
-	if (ret < 0)
+	if (ret)
 		return ret;
-
-	ret = i2c_smbus_write_byte_data(chip->client,
+	return i2c_smbus_write_byte_data(chip->client,
 					ad7150_addresses[chan][5],
 					timeout);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
 static int ad7150_write_event_config(struct iio_dev *indio_dev,
-- 
2.20.1

