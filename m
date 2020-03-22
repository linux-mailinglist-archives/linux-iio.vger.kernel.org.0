Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79A518EBB5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 19:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVSyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 14:54:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45065 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVSyD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 14:54:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id m15so5971488pgv.12
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GzAdrrDgmXF04zvOwecqKqiHvp5ekxd5xXJLLEjB6Pk=;
        b=DQ3s9pItU2cD3Vi2u2L5WP64TX1tEmq+m28estfLzLEDHgLWcn6UgWrjjvh2pHM0pd
         Sat6tnL3iZ7es2wmtbAl4QB3zHo/cMSUWTnAI61pQlcbRz17TLTqG8WPEBZj1KArlIGq
         FeqgpL7Md+fZqPQ1MoKXH+TkeVMGnPlwhZp8b9/eX5F+bIXNDJYVpzIesSgOPqLJreEe
         zQPuc7kb3xCraF1/6/i9GUo836wI02dyM2IHFgssLCfFJ1mhZtVTkPwxXumscOKHI8Xr
         q5HSZzuUESHhMKjwjZmoEN4hTIXH4rHDt72cY4PSw7xKoEaD6V2wD4rxqf3eSAQlbnqR
         rcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GzAdrrDgmXF04zvOwecqKqiHvp5ekxd5xXJLLEjB6Pk=;
        b=Iuev0mwcYFC2b+KOeeWjEIbgToY00qMrDm+ej/yPhrrhQMxMVSGXf7FhoWFoTZ3Ovs
         cv4ue6elH80rKKgIkz6O8PKk7yLtsniHEUkATZHRqQjnENv2Jy/+/He+FTXH6lvXqC3p
         58Azgd7OxMBsu/ldvuNLrAeVC9hzPQRDI//u0+KndTfYtRXUKnaOXWdtTAKqsKXP0dZr
         uTS5powJ9RfpTOm04Rt9zF7U8IzjxdKNJaM8BmK41bCaUC1utcX4eky1lHHTwmSB2SIb
         tN09STEZ3pgwcPTEn1hY/SLVOsHo8Npvc2O1vP5iT32mZLdhsYbsZTCgaISSwQ2Z6Q/8
         HQkA==
X-Gm-Message-State: ANhLgQ2oZC1MUd52818qoRUlNM90S4dUnxBlyxpFQrsCjklbsf+r7lxr
        EfvnU0BUv2LiDXYtx7krJ1s=
X-Google-Smtp-Source: ADFU+vt9pGlCMvShNhtKCW5QaDQjvn8Hcy/xM6Kvbw2JH5hTZMX6dH+KvVZLfRqyeXqOVEsndXRovA==
X-Received: by 2002:aa7:9a01:: with SMTP id w1mr20405287pfj.256.1584903240771;
        Sun, 22 Mar 2020 11:54:00 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id a2sm10046555pjq.20.2020.03.22.11.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 11:54:00 -0700 (PDT)
Date:   Mon, 23 Mar 2020 00:23:54 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2] media: staging/intel-ipu3: Reformat pointer initialization
Message-ID: <20200322185350.GA12377@deeUbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reformat pointer initialization to make it more readable as per the
coding standards. Problem detected by checkpatch.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---

Changes since v1:
    - Correct commit message and description as advised vy Stefano. Its
      pointer initialization and not declaration as mentioned earlier.
    
 drivers/staging/media/ipu3/ipu3-v4l2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 569e27b824c8..52826fad6f42 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -485,7 +485,6 @@ static int imgu_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (r < 0)
 		goto fail_return_bufs;
 
-
 	if (!imgu_all_nodes_streaming(imgu, node))
 		return 0;
 
@@ -1013,8 +1012,9 @@ static const struct v4l2_ioctl_ops imgu_v4l2_meta_ioctl_ops = {
 
 static int imgu_sd_s_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct imgu_v4l2_subdev *imgu_sd =
-		container_of(ctrl->handler, struct imgu_v4l2_subdev, ctrl_handler);
+	struct imgu_v4l2_subdev *imgu_sd = container_of(ctrl->handler,
+							struct imgu_v4l2_subdev,
+							ctrl_handler);
 	struct imgu_device *imgu = v4l2_get_subdevdata(&imgu_sd->subdev);
 	struct device *dev = &imgu->pci_dev->dev;
 
-- 
2.17.1

