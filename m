Return-Path: <linux-iio+bounces-16387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F058A4EB35
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 19:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA0E16EAC2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09EE293B4A;
	Tue,  4 Mar 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCHsERT6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490F281531;
	Tue,  4 Mar 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111272; cv=none; b=hpWDQFH8X8/WaWBJ60WoQIB27P5YOeJm3kFAIWmnoAbB7bjbIxNGji7sh3MiiH1b1ll8wGbpOfc6hr/MvswJtBMtNZs2kjRqDSp1EA9RN5i3JRBZrbFJWlLT38qI5bj+3HXzk8vi59F+KFSGylDZOjlzmw/jkOOfVrU0gW/ybmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111272; c=relaxed/simple;
	bh=uHz2D9vwBSSfNiaD7C/6f+GYpSsHbZqyMaGGRV/8JYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fWTxk2OlYFfDsIkgI688P+BFCnde6TxsPckHRyc0T82TyltlgC7HhM4HkZ70RzU6YPXyUBmpK7sS3UcOn+G0lfRirnIj8OwtGo3jyhh+aXbiCeaA8f5h8Yjj/gE4F/q/sp2tXgDx7hCSju7hn6slieKRRrqbZULL+4veKlTBsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCHsERT6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223a7065ff8so69214235ad.0;
        Tue, 04 Mar 2025 10:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741111269; x=1741716069; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7QEF4E9SF8fQ+Fv3EJ6+335X7efWCx4ogrP9mj0h2o=;
        b=DCHsERT66xiqVA0KMDR9azSmiS7Sp0eMRcp/3HRUg2gzAg6qRXYAQj3LPOprd1ynIc
         z4SVixeeO3VI56D1epVqbEbm0p3nu+i7xnvyQpqPHjO2XKdAMjV+PjJ1Zqrbm/zWhOrp
         tJ+aO8wmr02VPZ9s3E5SA8JRN/xZST0LKjkewDqCL7J8Ib3rsm5Wnk51uzGq/ZlN7WdY
         k0ENwG0zWelRdez0Bk24LmjH1xqczYX1P8ThlBH+t9BW+zD9RQKXeOylpfySVJt3uHWC
         MzYpPXXdUP/zwM0p8E06uhnYcwtJI6A1dCnvy6Sf3Gmh4OIfkTG15DRoPIXjauSVCpU9
         5hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111269; x=1741716069;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7QEF4E9SF8fQ+Fv3EJ6+335X7efWCx4ogrP9mj0h2o=;
        b=S5MXAXthcF1nDckqz6MK9jb2JpQkfactdAZZnWd8MvHPNSJ6wUefX2bGrlBUTmchLL
         seHjoQVTEFOHxuVWZ59/Njjh4+vxPqfLfoHJAp3X+TidfoaR5Lrt/yGdKXEmcMeZzHWq
         BVSurfwTGCXqcSl8V/+S25lH9dEHYxrSQ+Tu5fqXfg683SA+ySiRvNGV9zTNwSGcS1yq
         dpu5GDbIIYQur4S5pXRPbVSa1+KjjCVvObNT6X0+TGecXn/Fa85qfUL4LHmx9FisgatJ
         0JZYdSrvArftxeRvvsXF1t7+arAnrZDNtGB4DLTiYs2G0ZyVg9/cSsFp6AaXsZM1KRhi
         kzOA==
X-Forwarded-Encrypted: i=1; AJvYcCWjxqXkesMUE/xVDNeN1QByiL1xMm6ETgAUE58c8Mwck5etZwVGJy6JKfcWucamMZGtnn27doSsofLfni8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNfP+KFq31LfgH7reRffMJen0yJb0+cMaqwstHoHXNYvCZaHw
	R5pEVjaqpi6Ju7t1YzsR23CEMcpO+n/KAHBRUtJGZkf0UmAyVpqd
X-Gm-Gg: ASbGncv8aZ4eg2rC8DoYlWq6oXZmWdXo9mpRds9+LCMrBXZkgpWCunhKegA4tF4/A6C
	QlOEot/xeP25kg7VIJm09UbEfVhE9YjlV8HDGtQqV5AB21gXCpl3vQVrck+V63wx/vQ+wadNyeg
	5rYGBrYBPp1RJLE1SR7wDHwEaCpnRF9lCTBKNiCPVtWiBKFnBn4LnNZBK49hdr1JbyHWQVdn2wW
	5YUfTK3Y8zFlUrsfZtCiJ9VZfMWIwFgS7AVMkjXenxZkMwgMZCj3cAzgT6ivVf2IIagD7R+fb4W
	3c1iHY0f5MNAxxDEUSoFa2aY6MCOhpJHsvUR3Kp/Il+khIncjwr4f8o=
X-Google-Smtp-Source: AGHT+IG/avUXdpKOLV2637uweX1OoZYG6m9rmhvu8w/r39McWj7cIeo+60BYHhaLU8CVMiatF8y/wg==
X-Received: by 2002:a17:903:32ca:b0:220:c178:b2e with SMTP id d9443c01a7336-223f1c93a2emr1681755ad.17.1741111269168;
        Tue, 04 Mar 2025 10:01:09 -0800 (PST)
Received: from [192.168.0.110] ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235053308bsm98763125ad.239.2025.03.04.10.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:01:08 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Tue, 04 Mar 2025 15:01:02 -0300
Subject: [PATCH] iio: imu: bmi270: fix initial sampling frequency
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bmi270-odr-fix-v1-1-384dbcd699fb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN4/x2cC/x2MywqAIBAAf0X23MJmD6NfiQ6Wa+0hDYUIon9PO
 s7AzAOZk3CGUT2Q+JIsMRSoKwXrbsPGKK4waNIdNdTicog2hNEl9HJjr4mNH5y1xkKJzsRF/8N
 pft8P0ZgN6GAAAAA=
X-Change-ID: 20250304-bmi270-odr-fix-620e7f8daa7a
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741111266; l=1870;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=uHz2D9vwBSSfNiaD7C/6f+GYpSsHbZqyMaGGRV/8JYc=;
 b=pvLiGZO7jzdl4hWFkFCBTS8inUG9Pny72Jbu07ejhvlqpxbJAgIoetvyfMBRYBmunWW0rDhGN
 DS9XJlVmUz9B2hpIQB7mBYNWXv8AdD0HLQO4PDjx0wbKBqeOIZ4dz8u
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

In the bmi270_configure_imu() function, the accelerometer and gyroscope
configuration registers are incorrectly written with the mask
BMI270_PWR_CONF_ADV_PWR_SAVE_MSK, which is unrelated to these registers.

As a result, the accelerometer's sampling frequency is set to 200 Hz
instead of the intended 100 Hz.

Remove the mask to ensure the correct bits are set in the configuration
registers.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..2e4469f30d538ca3e9eb9ef8bbc6eaa8b6a144b8 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -918,8 +918,7 @@ static int bmi270_configure_imu(struct bmi270_data *data)
 			      FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
 					 BMI270_ACC_CONF_ODR_100HZ) |
 			      FIELD_PREP(BMI270_ACC_CONF_BWP_MSK,
-					 BMI270_ACC_CONF_BWP_NORMAL_MODE) |
-			      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
+					 BMI270_ACC_CONF_BWP_NORMAL_MODE));
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to configure accelerometer");
 
@@ -927,8 +926,7 @@ static int bmi270_configure_imu(struct bmi270_data *data)
 			      FIELD_PREP(BMI270_GYR_CONF_ODR_MSK,
 					 BMI270_GYR_CONF_ODR_200HZ) |
 			      FIELD_PREP(BMI270_GYR_CONF_BWP_MSK,
-					 BMI270_GYR_CONF_BWP_NORMAL_MODE) |
-			      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
+					 BMI270_GYR_CONF_BWP_NORMAL_MODE));
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to configure gyroscope");
 

---
base-commit: 8cca9edca867350e5f8dc65b71e7a6ef4157981e
change-id: 20250304-bmi270-odr-fix-620e7f8daa7a

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


