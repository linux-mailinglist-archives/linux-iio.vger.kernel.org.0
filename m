Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC681AFEE2
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 01:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSX2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 19:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSX2z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 19:28:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB6C061A0C
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2020 16:28:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w145so6390877lff.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2020 16:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4+vr8+9TgBkYPVM2P+sDjYNtgtH50PQzg4RN2xn9fY=;
        b=Nxl86tTYqy/RCOitgqJlqTMN4ItVBBZKF2dlgLBbxxFIEOCvaK//khDrAivjwR4u2n
         0pUa6VWc0V+w+dbu3ZAq0IDZ0hzOHSmI+iz914UVeeoloRpbSazlgqYWS3akVcIXHzYm
         yAtik9EGJ6z/NyHDsc/4Iu8cIn8lex4wJSbGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4+vr8+9TgBkYPVM2P+sDjYNtgtH50PQzg4RN2xn9fY=;
        b=D6ih2+1MNc93pVDEQ7JHXtHl3ymGhDgMTnlk64fOkFuNIP0aXtLwGPQlMOojvFH6dy
         B7mnJ9wTOT45d6uKCWESX26yhm1F+6txmw9ygaUxD0Koa2KJEiJSQqATAqAjPWTAXiDo
         zBPHkt5Q4KGl5HWTFeAC86IWBMlibpwJF4X6PaWFW4KCMUqlzyEzb9Mvrbxs2JuB+Kmw
         9lqpPqo9+EHgXrWfPiqSG0lxhu6mgEVfiGA135JtPtlsGcwrHs7T7WjXe11zz7H7tb/S
         XDMd21kd527L2CXbXG6zDJkwAxMeE0erE/PdjgvZ8PHUlR8u4g8RHPyoDEvloEtGIlcg
         +SQQ==
X-Gm-Message-State: AGi0PuZJvqG7jfxJr5UjF74XjJBisp1VLLB3vM4IoNldz13K32H/jP+k
        l8qp53402CkCSMrmJIQZ+cjZ9hltdmn2Ig==
X-Google-Smtp-Source: APiQypI5mUJ7Pejtqm0qGk3jim0u75MSuEm5ayuNbyjUlL9SBUlvAgfEf2EsQWOK5n05lN0KL/yKxA==
X-Received: by 2002:a05:6512:695:: with SMTP id t21mr8724049lfe.158.1587338932115;
        Sun, 19 Apr 2020 16:28:52 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id s7sm7376147ljm.58.2020.04.19.16.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 16:28:51 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: chemical: atlas-sensor: correct DO-SM channels
Date:   Mon, 20 Apr 2020 02:28:47 +0300
Message-Id: <20200419232847.32206-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO_CONCENTRATION channel for the DO-SM shouldn't be indexed as
there isn't more than one, and also ATLAS_CONCENTRATION_CHANNEL
macro scan_index define steps on the IIO_TIMESTAMP channel.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 82d470561ad3..7b199ce16ecf 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -194,7 +194,19 @@ static const struct iio_chan_spec atlas_orp_channels[] = {
 };
 
 static const struct iio_chan_spec atlas_do_channels[] = {
-	ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_DO_DATA),
+	{
+		.type = IIO_CONCENTRATION,
+		.address = ATLAS_REG_DO_DATA,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_BE,
+		},
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 	{
 		.type = IIO_TEMP,
-- 
2.20.1

