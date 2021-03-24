Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7214347847
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 13:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCXMVA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhCXMUx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 08:20:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C837C061763
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:20:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so1057739wmf.5
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oTi0KjQtDPT0Svo3x3SXvpQdEim6M78DQA+FMedrSQg=;
        b=ie4W0LpV7bi4NzFDSE30QCoc1M5MIFpoRTG4XPu6HJWLpFvg6rPzupzmkEUZkcapU8
         3lWDAVxmiRdIf7dsxWpkSp7BKz77cKYTFanzYT/1mxT9iYO1QqqoV9prGroXDhXIyk6S
         YYdzTMV2holLXdn02ICJ1jg2CqQi0PCbNf1Mpl1iHjvC2McwgB6uu9kbOqsSK0FC/srV
         Gx4vDxopJChdJJrmarbDYEAhprUD3raCmfsi3XKOtnGxVjFgP5T1nD1wei8hag7Eujbt
         GrK4NRnaaAEfm+G3TYDUfryc8HnvHHzcc/ukfD1KCejNvX9QgntQVuTlxOCE6QU+hQRF
         AwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oTi0KjQtDPT0Svo3x3SXvpQdEim6M78DQA+FMedrSQg=;
        b=W7D2vbcEx0K68jQZEvWdECUdFbPx4/+pM2+5Nnq/GdYDTJoD1glkM9+mZPSBcSsg1i
         joktgd+vw/Rnu16G+7ALoTa+NWnAjjL83HMdVvlNJK1wLLlTMyp+ocMy5NtoLfkdJIjA
         2kW8wQ6sUN6j7EiwbmeO4axOp8wf6pMk0JlBsLvSIHwHVmbR4mgWRv69tA6ZzYCylTV/
         dFFe54t3E2VViIBNoKxs3y9+10XtgXl361WRIdtv/PY/26dVN3UMSlMrvLg6iDRHO2sl
         goky1wf3sjT13JwVQuw4KT1QbIYH881lqK5V/whYzYqjO5xpx0w78NS2Ec55mm2OOi1W
         6d6g==
X-Gm-Message-State: AOAM532FT3UpygxytltjUYQeUav0iKXJde9uUenONJt73AulPUzax1iF
        ps6CIyVVDGZbYlEluI4RkLg=
X-Google-Smtp-Source: ABdhPJxYATGci+cSRDYABKQpUBAFUzVOVWK38OpC96+enX3BWOnMw2dDCgWhSOvmNict1fDSlb182g==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr2714666wmc.51.1616588451919;
        Wed, 24 Mar 2021 05:20:51 -0700 (PDT)
Received: from kernel-dev ([46.11.141.4])
        by smtp.gmail.com with ESMTPSA id w22sm2254013wmi.22.2021.03.24.05.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:20:51 -0700 (PDT)
Date:   Wed, 24 Mar 2021 13:20:50 +0100
From:   Swen Kalski <kalski.swen@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] Add early return to Method because the else can be ignored.
Message-ID: <20210324122050.GA28987@kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

---
 drivers/staging/comedi/comedi_buf.c | 56 ++++++++++++++---------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/comedi/comedi_buf.c b/drivers/staging/comedi/comedi_buf.c
index 3ef3ddabf139..05927fb321ba 100644
--- a/drivers/staging/comedi/comedi_buf.c
+++ b/drivers/staging/comedi/comedi_buf.c
@@ -366,42 +366,42 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 				     unsigned int num_bytes)
 {
 	struct comedi_async *async = s->async;
-	unsigned int count = 0;
 	const unsigned int num_sample_bytes = comedi_bytes_per_sample(s);
+	unsigned int count = 0;
 
 	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
 		async->munge_count += num_bytes;
-		count = num_bytes;
-	} else {
-		/* don't munge partial samples */
-		num_bytes -= num_bytes % num_sample_bytes;
-		while (count < num_bytes) {
-			int block_size = num_bytes - count;
-			unsigned int buf_end;
+		return num_bytes;
+	}
 
-			buf_end = async->prealloc_bufsz - async->munge_ptr;
-			if (block_size > buf_end)
-				block_size = buf_end;
+	/* don't munge partial samples */
+	num_bytes -= num_bytes % num_sample_bytes;
+	while (count < num_bytes) {
+		int block_size = num_bytes - count;
+		unsigned int buf_end;
 
-			s->munge(s->device, s,
-				 async->prealloc_buf + async->munge_ptr,
-				 block_size, async->munge_chan);
+		buf_end = async->prealloc_bufsz - async->munge_ptr;
+		if (block_size > buf_end)
+			block_size = buf_end;
 
-			/*
-			 * ensure data is munged in buffer before the
-			 * async buffer munge_count is incremented
-			 */
-			smp_wmb();
-
-			async->munge_chan += block_size / num_sample_bytes;
-			async->munge_chan %= async->cmd.chanlist_len;
-			async->munge_count += block_size;
-			async->munge_ptr += block_size;
-			async->munge_ptr %= async->prealloc_bufsz;
-			count += block_size;
-		}
-	}
+		s->munge(s->device, s,
+			 async->prealloc_buf + async->munge_ptr,
+			 block_size, async->munge_chan);
 
+		/*
+		 * ensure data is munged in buffer before the
+		 * async buffer munge_count is incremented
+		 */
+		smp_wmb();
+
+		async->munge_chan += block_size / num_sample_bytes;
+		async->munge_chan %= async->cmd.chanlist_len;
+		async->munge_count += block_size;
+		async->munge_ptr += block_size;
+		async->munge_ptr %= async->prealloc_bufsz;
+		count += block_size;
+	}
+	
 	return count;
 }
 
-- 
2.17.1

