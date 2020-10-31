Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCE32A17F2
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgJaNpR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727461AbgJaNpP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2020 09:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604151914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=814PgqQ2GaNYFANqzidfDl9rSrDeF/edtDaTRQDpiQw=;
        b=P2alRR+IiPzztd2I7gY3SYlXKy5e19E/oprQR+RPTqnkkHrqrjaCpJyvnT9YI4NYGxCJ1I
        T5EvmLI5Icuq7bAEoFdI/Ik9dSKwT7DOS3qs7Q7YIOl+9EIK8LLH2kCJrFuSm1SGiGQzHH
        lchbJ8A7WePlpPp3Gho2pZYkksB3fFo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-fMpXboNsOJCcC9oBP3XFSA-1; Sat, 31 Oct 2020 09:45:12 -0400
X-MC-Unique: fMpXboNsOJCcC9oBP3XFSA-1
Received: by mail-ot1-f71.google.com with SMTP id 5so3778885oti.20
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2020 06:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=814PgqQ2GaNYFANqzidfDl9rSrDeF/edtDaTRQDpiQw=;
        b=Nw5dvlEvisAT44SVnQVygsDaZxiv8JETKwfNFoUNRMJag8Wxgmc2TgFAPTP286wN3r
         RNmRSDxWWuoS/wN8lnQ2yeW/hxhWs9VcJfszL/thLIlNaysPmO88Y8CW639isOlhxsx3
         PSi6JtvllPm4hpy0yHI/Z1JV4Cxmciw+LAX8StZHAUU7fh2Z+gHQtrbcgZxQV71uyUzV
         rPH/lRmz4cm7m6kn3WXvBs5ZvaeBaYuurqzjllYZV6CH1Rtzh1S/dpYx89Mc7ZyL+ULd
         bOtIcuKCbTN77eUmgkw76qkFezMZQ79GYovoHl8z3qqHJZzfTjRbcRAQO1JtXhZtaztV
         SI+A==
X-Gm-Message-State: AOAM531AFSs52BQMWx1+C72wePA4eg/GNQaSYR6vE9EwUqdGanEiRZ7a
        kawN+Oow9OqN/DRRi2j1proLU2YmLlpd5n89VrhkniuPngVekPFq8ZBTIGzPqZclQZPT40WTbwk
        WXetPlfZ9AeMdFR4It7LZ
X-Received: by 2002:a9d:4f15:: with SMTP id d21mr5349079otl.166.1604151911281;
        Sat, 31 Oct 2020 06:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNGYuiT8MQi6phj/4hR76hzlOqYTMJ0W/2+FDiH5m1ZtjDgTkddbT/43RAQikP9pzjidHtEg==
X-Received: by 2002:a9d:4f15:: with SMTP id d21mr5349070otl.166.1604151911094;
        Sat, 31 Oct 2020 06:45:11 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m65sm2182844otc.36.2020.10.31.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:45:10 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: pressure: bmp280: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 06:45:06 -0700
Message-Id: <20201031134506.2134698-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/pressure/bmp280-regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index 08c00ac32bda..da136dbadc8f 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -13,7 +13,7 @@ static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool bmp180_is_volatile_reg(struct device *dev, unsigned int reg)
@@ -51,7 +51,7 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.18.1

