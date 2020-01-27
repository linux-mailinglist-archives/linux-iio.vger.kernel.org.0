Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29914A374
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2020 13:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgA0MEP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jan 2020 07:04:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43122 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgA0MEP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jan 2020 07:04:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id p23so3668752plq.10;
        Mon, 27 Jan 2020 04:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mbGosBGsyuv+lmcdBTGzW/Sctu3s1c7RllqCHsUWLtE=;
        b=cI98Ast4BM6oCG197UHLAKlLPa9AATMLdDvUczPi3/aWkMZF2BfUS0YsZ9ozStgo/I
         fgrOhvWGI8TlHnjph9PJeW/+pWB7CaFc1arfq1QGYCH3/quq9OLulT+LDw9mY96trTIV
         H5YEhUQZKETi2Ix8DvB8kqDhr88SRRH+9PSpXCgfXeSgeGSQ/ijIZicENUfsO0dEfi3d
         48VLE2MiBmVDj9T1lUtBeiy0ecpAQhIKiLI/rXJ9zr34PEWGiJcmTVBW6uMGZvdCgQXj
         oDbmdGXbElHUFivlXivkWENlA5+q7jaCLD8cNUOLXfYe75/iYi5K53cnQp7dTIW+8Ufk
         qGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mbGosBGsyuv+lmcdBTGzW/Sctu3s1c7RllqCHsUWLtE=;
        b=PB+dpwVY0W1tzK3MAv1+eeA84MGJ/MkKG3cbjAnSsx4pOm9eD6JvQF5wbIXDXkvRun
         POj757h+3EjQ/7wkAElnH6EKHsjag6H1Ol2wLPXO1Yp+fWhI6GQ1P/8p6F26l7ftLJl3
         8erP5L0BCq3H8qc2xBSoZ6f0K+Xi70E5bB9K3qsivjgsxmoYd4GXKA99NkIZKJcod4vQ
         8XhXd72lBpWdxSTZW/4RkAPKmFMr0VVPd+2HJnalP5jQhzPXG56mveicr5TdK57ZcgEC
         ZgIOxOFpB/7nlVY3RcD8mL/GtHGg+1P1EMnPQTVYrWfrwzm6Jb8Dp/00/IAa/In6iCzl
         FV6w==
X-Gm-Message-State: APjAAAWXtlAVlqq+v1HecRw6SpdBKiqwv+jVdJL3z2WnlilUTkmoGk2k
        D7t25q/c5UtebJU2T+OudcJyNJhI6xA=
X-Google-Smtp-Source: APXvYqyH5yGQA4JteZYp6k8qa92vWNERBII0FVJ57uJbXRMeoj9ODohNngv0VvCFWgwHKM38I26C9w==
X-Received: by 2002:a17:902:d918:: with SMTP id c24mr17574054plz.167.1580126654908;
        Mon, 27 Jan 2020 04:04:14 -0800 (PST)
Received: from localhost.localdomain ([116.126.226.81])
        by smtp.googlemail.com with ESMTPSA id u18sm16857352pgn.9.2020.01.27.04.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 04:04:14 -0800 (PST)
From:   JieunKim <jieun.kim4758@gmail.com>
To:     lorenzo.bianconi83@gmail.com
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        JieunKim <jieun.kim4758@gmail.com>
Subject: [PATCH] iio: imu: st_lsm6dsx: Fix mismatched comments
Date:   Mon, 27 Jan 2020 21:03:59 +0900
Message-Id: <20200127120359.3955-1-jieun.kim4758@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

odr to odr_table
gain to fs_table

'gain' is actually in 'st_lsm6dsx_fs' structure of 'fs_table'

Signed-off-by: JieunKim <jieun.kim4758@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 9c3486a8134f..f2113a63721a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -230,8 +230,8 @@ enum st_lsm6dsx_ext_sensor_id {
  * @i2c_addr: I2c slave address list.
  * @wai: Wai address info.
  * @id: external sensor id.
- * @odr: Output data rate of the sensor [Hz].
- * @gain: Configured sensor sensitivity.
+ * @odr_table: Output data rate of the sensor [Hz].
+ * @fs_table: Configured sensor sensitivity table depending on full scale.
  * @temp_comp: Temperature compensation register info (addr + mask).
  * @pwr_table: Power on register info (addr + mask).
  * @off_canc: Offset cancellation register info (addr + mask).
-- 
2.17.1

