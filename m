Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CB22931C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGVIJJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 04:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGVIJJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 04:09:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5FC0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 01:09:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so932285edb.13
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2r4EVwOLjp+Mkv/qbd4pbL+CjidWx+URntvu11Ex9s=;
        b=kcSZVv3S8vtgO7bubSPtYiGvYQIqSLr6wX6KXekergY4ZeN34dUPe8y+uB33d0uM96
         cAkjeenLrNeE6rwNGcmcAYwQ+mcwNrRKQUBXSMx/iRmEBX53wRPOMd0xbxyCwb9Bu37P
         y5BcNvweLJ42FWD2XHVi+zq/857uPBaAiACt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2r4EVwOLjp+Mkv/qbd4pbL+CjidWx+URntvu11Ex9s=;
        b=SGIBHJzLfQvR9plHe4ay3KfdLxI3v0R4YnQGPkojeHFeSb1CusDA0wmbkLT3aQSWDJ
         nzEweFKc1/ncLGMWU8FpKAyCXBDUphPAmM8E0F5PzeP2UkHHSmmPK29P6oxpx6U+uoj2
         tJ0+iV5kETfapZEnTZm3bQv15ydZHpkQ9P1rSIR/ooDqQdvpprny7nFsESa9ESiWZYkf
         gbXHb4By71nJPeGl48KCH+R0qvAkzJqw1yKStvBb6IKBK/96NBwkMpKXCO0GxLms1r1V
         FsbIaT8zIe80jgomrgTEcLHRFi5/y+Pyc06N6BcyOuG54Hj3Aew1kol+NFV+BHsLEdvF
         A5cg==
X-Gm-Message-State: AOAM530djj9yY3y+hywToUjvA+Yy3sJXCT65DuY2gjLiIq5VO8ktmeQP
        rQ19uMU1sNhrw7Ot5FQYFhv9zg==
X-Google-Smtp-Source: ABdhPJwFCVEeTtmvKu+HtY+pmIAUnF3PRhPfzp0fg4y1KEOql0jEa/6Ce9VpsOM+J3LgepplWBEqnQ==
X-Received: by 2002:a05:6402:31ad:: with SMTP id dj13mr29608003edb.88.1595405347600;
        Wed, 22 Jul 2020 01:09:07 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id k15sm18061581eji.49.2020.07.22.01.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 01:09:07 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: chemical: atlas-ezo-sensor: switch character replacement to memmove
Date:   Wed, 22 Jul 2020 11:09:04 +0300
Message-Id: <20200722080904.30819-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index 7f8c641b8e93..60a0c752fbc5 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -83,8 +83,7 @@ static void atlas_ezo_sanitize(char *buf)
 	if (!ptr)
 		return;
 
-	for (; *ptr; ptr++)
-		*ptr = *(ptr + 1);
+	memmove(ptr, ptr + 1, strlen(ptr));
 }
 
 static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
-- 
2.20.1

