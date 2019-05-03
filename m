Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A631355A
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfECWPj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:15:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46693 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECWPj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:15:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id i31so8488515qti.13;
        Fri, 03 May 2019 15:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SAG93eFHh+qaETzoOcFQNdt8rlclJfMfJCEB5tyPneU=;
        b=cxRMJufioKVdvfnJKfWHBXy6aUljGfxrLWnsauz+050JKcWB0haJPWdy0XJ3iBvW+Y
         svO5sSi08Sbc+rOJkObJqDwPph9vSPQoyflUwSt0ZOcbeJH+atKZxoZ98zBxY2qN5IOv
         hucZoLfhj7xtykRJhiwXWK0vJ/5+0weq/mTzoE3Ge591qXyOnsAZVAjWOmD+bN7/2Edf
         UmPQZ2hQLydG6WVM6AoQUCqxxX0MAMCzsLSVBTjh9qgRM5CEjzfi1eWBTauTms96wQDO
         QmL0grDYx7346Ad4PNAtBT/X4o4OIyE5ifb0K7zHfKV3qGvKn280hfiVDyQ5Sz7TWpy1
         j4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SAG93eFHh+qaETzoOcFQNdt8rlclJfMfJCEB5tyPneU=;
        b=FUc0vbkkYd+HbHIXpJajzCHgJ0uyFdUt9iMRO+55azxgFpWb9loAA4lJHkmhvinalB
         d28VQn8bDMx4RCr38VApmhhlCp8DNQycd2YyZ0pQeORmc7CDKm8GKlems3g4k+M+rnI8
         aQltGCKyUiVgd3Xlg/k+8Ofdz2TYdzYgxyQf53cGFFFPURVvYbvMB/ke7M9B7QyJjzhZ
         y46ncjdYtI3pg1cj0T+PiIVNC9B5BP5eFZ9r7Njp8kC0dgiSY77QCC8T1jJ7sNrT3LKp
         RzYxYHMYxYcft77W1/fUHD7Mtvw3v2eqh4SzbMWw08q12djQQdXk0rObXLsmtHr/DNZH
         +rjA==
X-Gm-Message-State: APjAAAUgSN36s81bADPjO8hz94DK+M6TGYojs+d3uFmlfCwErALhPZ56
        boJdEydhrZIISG3vumfLBHM=
X-Google-Smtp-Source: APXvYqwN3xXPr46LsBvXQoeM3xNHTgtquMHHKh1QvdRhT3+X053Z7iIDcWI/TfvRozWj41FcfVP6LA==
X-Received: by 2002:a0c:92af:: with SMTP id b44mr4193122qvb.141.1556921738622;
        Fri, 03 May 2019 15:15:38 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id t26sm1807490qkm.82.2019.05.03.15.15.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 15:15:37 -0700 (PDT)
Date:   Fri, 3 May 2019 19:15:25 -0300
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
Subject: [PATCH 3/4] staging: iio: ad7150: simplify i2c SMBus return treatment
Message-ID: <18725f7ddc3ac42b1c781b1848b05fabd4bd8320.1556919363.git.melissa.srw@gmail.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556919363.git.melissa.srw@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since i2c_smbus_write_byte_data returns no-positive value, this commit
making the treatment of its return value less verbose.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 4ba46fb6ac02..3a4572a9e5ec 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -201,16 +201,12 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 	ret = i2c_smbus_write_byte_data(chip->client,
 					ad7150_addresses[chan][4],
 					sens);
-	if (ret < 0)
+	if (ret)
 		return ret;
-
-	ret = i2c_smbus_write_byte_data(chip->client,
+	else
+		return i2c_smbus_write_byte_data(chip->client,
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

