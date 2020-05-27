Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DBB1E46F9
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbgE0PGN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbgE0PGM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 11:06:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737DC05BD1E;
        Wed, 27 May 2020 08:06:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n15so11950678pfd.0;
        Wed, 27 May 2020 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGrZKBWfZ9CzbVCqf0bzxeml/dCqTei6g4aLYiJ/QE4=;
        b=MTxj59cROwN+53QYo4SSPVrpTjgGU1PkLYOSYGSCHQQSuo3EKGDjduRBdIVJd4yeUO
         ykpuutiv1VYJx00VQ2a0UB6AVWfP/+CYxxDEsPAqb5HvAR9ZBNjI6okRkfJ1TXCNVsaq
         q78/VzeQuwhteET3ohKSKEdMKpGa3Ky5nFYl3lwYs6aPP+NFRgA+0ozbwzryXYls1ayk
         K1gNz+Tc8zZ2d1NYOrs1IRErPxA9uqksG2lhwYelhbmXm3+e8k7xvNtRW7+Bdl51fFnT
         riWMwTbbtelwf8qBZPB6nQNr0W/iuIETaQtPDmDRxX28+OHSATPtH9CIIJ8iLVk1mbNU
         sfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGrZKBWfZ9CzbVCqf0bzxeml/dCqTei6g4aLYiJ/QE4=;
        b=XsC3eRBLpGnwnPo1cDSO59GdCTnN9o969ivzDRUTfwJH1Jf5EO8YmgbJ91N3saBZBR
         R4tc3KNg/PTsqlXQ5tu3LC4CY1pFcITuRF3Udh+bOnsfwmHDeru7s7xz1Mpl0+iGWvaH
         ehBcZikOM+yhrrp6vkFK5ajZsSHW9tVpOgoKs5p6Ltcot9+OZdwVm70EQe5WXNLF3pMJ
         pTPmKQnKf0osn/+7DxMnRRZPeejz/vaY6DSyFtV/Cgd4St0jJj5jaknVD9KlIi6kOEDH
         OJdZOWPHJT3RUAFxsS2S+NGnt9OAq/H/UeNDQmR/A8iSCKdw6Gsyhjbo1p8s4RwRCn2s
         Xwkw==
X-Gm-Message-State: AOAM533wVpH9YjHW5cMir0Xei5Yxofb2b+EPyrf2t5VWAB2dkabOC9Rt
        7iY1vyZJ120vr3D8LElDz8Q=
X-Google-Smtp-Source: ABdhPJx3z3qhHGI+z7lJTwJvKQ2pu9i5uE84i3LTWORyi9fzKV/Z1COWfzuoUQvUU5eziD6lGe6gmA==
X-Received: by 2002:a05:6a00:1490:: with SMTP id v16mr4235765pfu.173.1590591972237;
        Wed, 27 May 2020 08:06:12 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id q18sm2214682pgt.74.2020.05.27.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:06:11 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: mma8452: add missed iio_device_unregister in probe failure
Date:   Wed, 27 May 2020 23:06:06 +0800
Message-Id: <20200527150606.539130-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mma8452_probe() calls iio_device_register() but misses to call
iio_device_unregister() when probe fails.
Add the missed call in error handler to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/iio/accel/mma8452.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 00e100fc845a..813bca7cfc3e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1685,10 +1685,13 @@ static int mma8452_probe(struct i2c_client *client,
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto unregister_device;
 
 	return 0;
 
+unregister_device:
+	iio_device_unregister(indio_dev);
+
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 
-- 
2.26.2

