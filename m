Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1788428021
	for <lists+linux-iio@lfdr.de>; Sun, 10 Oct 2021 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhJJJOe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Oct 2021 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhJJJOe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Oct 2021 05:14:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E50C061570;
        Sun, 10 Oct 2021 02:12:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x130so3145921pfd.6;
        Sun, 10 Oct 2021 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Sv9Ksnrv6f8AsM7joTeVhFY2ovJdnSPF2uih/YjPrM=;
        b=J+Hvm63H6y/kRR1Bv5kq+m4vNdB61M+NMkMhOIRq87+l0/xEtN2HYKsRQpBIiheyv0
         t2q4+52Fb/XM0Z+Lh6k/hH/LZ1FWCy9BNK/X1BnOTyvBU+XT+MrCRCXoBSFp4w0GeAZx
         I3QADnh0tuX7D+ytW1EK/ajI76J8PUQ26mpExbDrw8zNW035ziz15kuxznt+b3+mWMHv
         oUbUA+iXN5/Yc7ZK+adpPVVd2/xP/AnbNnch4Y0f3Mcxan+/Z0xMerd1xtH0PZTNI8iF
         M/QWVlSBFF4+/f+RDfBfPUn8ygrWrZjPlcXeAhYEduonHR1sjc5qjYbTIgkn32EsR3qK
         mDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Sv9Ksnrv6f8AsM7joTeVhFY2ovJdnSPF2uih/YjPrM=;
        b=a190T0BrWxcLcSXBQaVf/Vt4z5r4YoDCJoJW53Fck1G1OiFwIXW82PWI+QIryj3oin
         OLg4eqb9+zcwGtOHWd89J5kS8XlBVF/N3E6ou2NaT/hXiIppHkNiMMPA27CifzuVPiXG
         QmgxVVGM2JecrpP8z7OwAJhDaXJKJiq/apWZqIDXheDX/U6W1jjBhu91mfIKN/CucWGf
         cky8x3wCT4Ctj4bJ0XVHHHiw6zrRgUFWw8Upa/aHBEvpNfzIJL8z0U/ZZ5w0aLBs6HSL
         895wXetKFARZNuQQlpD//8e84aZKzm3WnGQ0/2HvINNVk7GNKXYsm8ZKZQ7Qfio2Kf1q
         MRHQ==
X-Gm-Message-State: AOAM530peLe+iiYFOGzXkjLkeh3fm6SEUrvqT5FpX1l9q37YdY5Rslbi
        DGacxdOAl9uM2HuYhh+JXSc=
X-Google-Smtp-Source: ABdhPJxYrhpvwo4tLscQ7DlSzJ9wvYcvtxUIKGFBibLZenvSepvyZ4FHDjst7l1SksGCbuxssEfekQ==
X-Received: by 2002:a62:5215:0:b0:44c:d170:ed7b with SMTP id g21-20020a625215000000b0044cd170ed7bmr15332622pfb.61.1633857155031;
        Sun, 10 Oct 2021 02:12:35 -0700 (PDT)
Received: from localhost ([166.111.139.106])
        by smtp.gmail.com with ESMTPSA id w8sm4272467pfd.4.2021.10.10.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 02:12:34 -0700 (PDT)
From:   Teng Qi <starmiku1207184332@gmail.com>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        islituo@gmail.com, baijiaju1990@gmail.com,
        Teng Qi <starmiku1207184332@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] iio: imu: st_lsm6dsx: Fix an array overflow in st_lsm6dsx_set_odr()
Date:   Sun, 10 Oct 2021 17:12:30 +0800
Message-Id: <20211010091230.895549-1-starmiku1207184332@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The length of hw->settings->odr_table is 2 and ref_sensor->id is an enum
variable whose value is between 0 and 5.
However, the value ST_LSM6DSX_ID_MAX (i.e. 5) is not catched properly in
 switch (sensor->id) {

If ref_sensor->id is ST_LSM6DSX_ID_MAX, an array overflow will ocurrs in
function st_lsm6dsx_check_odr():
  odr_table = &sensor->hw->settings->odr_table[sensor->id];

and in function st_lsm6dsx_set_odr():
  reg = &hw->settings->odr_table[ref_sensor->id].reg;

To fix this possible array overflow, ref_sensor->id should be checked 
first. If it is greater than or equal to 2, the function
st_lsm6dsx_set_odr() returns -EINVAL.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index db45f1fc0b81..edf5d33dd256 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1308,6 +1308,10 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
 		break;
 	}
 
+	if (ref_sensor->id >= 2) {
+		return -EINVAL;
+	}
+
 	if (req_odr > 0) {
 		err = st_lsm6dsx_check_odr(ref_sensor, req_odr, &val);
 		if (err < 0)
-- 
2.25.1

