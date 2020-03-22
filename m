Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF46418EC0B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 20:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgCVTzV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 15:55:21 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55923 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgCVTzV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 15:55:21 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so5091047pjb.5
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b77TY7UrsoyS49ONmyF7UHFxsAFfpAPqrIo/6B6TxU0=;
        b=HNR9ytwS/mNQzGAhFGdfGUQ+2Lur4oNAxLxbX1JqrDl19h+OSBlnCnU4q2bkk0TG8m
         efZIxBd6jAwHpdiDGjY5eg8US8ekWegGXYsrUApMt6feCxupW8rCjtVHnhDUSHTb04dI
         a8A66bqw/DV25P6t4A6CfAEmk7VvIBJz5f23D9qYdkYlD0lI6NVmA1MC9grq9+zWJBsm
         cc/zAQl733Iz0JL0v9BBSZOSq1TbzL69qlVikRy195hN5JR6Nb2x+o4yGMxsLKYPXfcW
         /EJnRWaAzCE/DmU3fA/vR1xT+pJUWY9JmcNSJTJVr+VsyrHTc0ncs+DA4Ifnno8OrH4i
         VRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b77TY7UrsoyS49ONmyF7UHFxsAFfpAPqrIo/6B6TxU0=;
        b=IK7hZ8giOrqzJiqjBqny80XREDo5x7mfTgPBsV5Vv6+296HFyYndjEPeTMwGjkPabP
         A9vfpEaGcc/nQ7SS0YiNzDpuLbVwP1MVBnyD7YbWNZhXGbBxZLkPZAMRNvvAxMmAoU0/
         Gmc6RvphfjVBT8YzSa9gozmgAtk5Z/IMrE1RE/eRnPLfAj1967k3n1fTVSuBA1LFIRwj
         yJy+7Nfx70jJpyL8MxD3Ofzw9lo97OJ8C7Nkcf6/E17f+0fSeQi0gRReAm3f8HGybNrC
         Y3ymoJHWWVGLJnSjWt0r0X0s+EyF/xiUCAzagq4+loGE0Ia/4Z5C5/bZlBak8FmDii4J
         L2jA==
X-Gm-Message-State: ANhLgQ2xpw5MJ/tqtgCkWL/i8q03Rt06QT8TatuXFrbNNxu6mc+aylRX
        44hSp2Ag7KrD33nCjJsXtJQnQpSx
X-Google-Smtp-Source: ADFU+vthU5tbIGElCB9/zrwolWrs4hrOM3Y57KsN0W3kpEVcRoX7FmWY9danB/B3ZMwqPOF9RT/8ng==
X-Received: by 2002:a17:902:728d:: with SMTP id d13mr18445214pll.92.1584906919637;
        Sun, 22 Mar 2020 12:55:19 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id c128sm11043761pfa.11.2020.03.22.12.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 12:55:19 -0700 (PDT)
Date:   Mon, 23 Mar 2020 01:25:13 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 2/4] staging: iio: adc: ad7192: Correct macro names from
 SYNC to SINC
Message-ID: <a5aea6836da9aa2f950449225892ee18f10e217c.1584904896.git.mh12gx2825@gmail.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584904896.git.mh12gx2825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Three macros include SYNC in their names which is a typo. Update those
names to SINC.
Fixes: 77f6a23092c0 ("staging: iio: adc: ad7192: Add low_pass_3db_filter_frequency")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>

---

Changes since v2:
	- None. Version increment to follow patch series versioning.

Changes since v1:
	- None. Patch added in v2 version as suggested by Stefano.


 drivers/iio/adc/ad7192.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 02981f3d1794..d9a220d4217f 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -144,9 +144,9 @@
 #define AD7192_EXT_FREQ_MHZ_MAX	5120000
 #define AD7192_INT_FREQ_MHZ	4915200
 
-#define AD7192_NO_SYNC_FILTER	1
-#define AD7192_SYNC3_FILTER	3
-#define AD7192_SYNC4_FILTER	4
+#define AD7192_NO_SINC_FILTER	1
+#define AD7192_SINC3_FILTER	3
+#define AD7192_SINC4_FILTER	4
 
 /* NOTE:
  * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
@@ -367,7 +367,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	st->conf &= ~AD7192_CONF_CHOP;
-	st->f_order = AD7192_NO_SYNC_FILTER;
+	st->f_order = AD7192_NO_SINC_FILTER;
 
 	buf_en = of_property_read_bool(np, "adi,buffer-enable");
 	if (buf_en)
@@ -484,11 +484,11 @@ static void ad7192_get_available_filter_freq(struct ad7192_state *st,
 
 	/* Formulas for filter at page 25 of the datasheet */
 	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
+				 AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
 	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
+				 AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode));
 	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
@@ -576,25 +576,25 @@ static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
 
 	switch (idx) {
 	case 0:
-		st->f_order = AD7192_SYNC4_FILTER;
+		st->f_order = AD7192_SINC4_FILTER;
 		st->mode &= ~AD7192_MODE_SINC3;
 
 		st->conf |= AD7192_CONF_CHOP;
 		break;
 	case 1:
-		st->f_order = AD7192_SYNC3_FILTER;
+		st->f_order = AD7192_SINC3_FILTER;
 		st->mode |= AD7192_MODE_SINC3;
 
 		st->conf |= AD7192_CONF_CHOP;
 		break;
 	case 2:
-		st->f_order = AD7192_NO_SYNC_FILTER;
+		st->f_order = AD7192_NO_SINC_FILTER;
 		st->mode &= ~AD7192_MODE_SINC3;
 
 		st->conf &= ~AD7192_CONF_CHOP;
 		break;
 	case 3:
-		st->f_order = AD7192_NO_SYNC_FILTER;
+		st->f_order = AD7192_NO_SINC_FILTER;
 		st->mode |= AD7192_MODE_SINC3;
 
 		st->conf &= ~AD7192_CONF_CHOP;
-- 
2.17.1

