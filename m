Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE25323FF9E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgHIR4B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:56:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37631 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbgHIR4A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Aug 2020 13:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596995759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kb4As6QnUipHSR9EGfDVMrFaM6W9OhoAZ0L2Q4XubgE=;
        b=Pa7lvSpCzkAvMCY14oUEuyBHls5aChEemAwqFjkkeJpuwvWQZ0e5yjegkGxZ4cwSQ45SYv
        pOMy++UHGlhg+9IYQ5vnM22IumJPNb7qHSq72OHUR0x/VbiCssq2ZTqkcb+rbw72/P0LKD
        U6sbHLj+LF9ze/N+KNRxzZWtLz/rR10=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-MkM8U7E7PjWTUieoX0v-uQ-1; Sun, 09 Aug 2020 13:55:57 -0400
X-MC-Unique: MkM8U7E7PjWTUieoX0v-uQ-1
Received: by mail-qk1-f197.google.com with SMTP id c191so5601879qkb.4
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2020 10:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kb4As6QnUipHSR9EGfDVMrFaM6W9OhoAZ0L2Q4XubgE=;
        b=C756i9C8JrLiDHIolXG7xrURNl0t/N9Mh8UnvyuNvBfMMLZ39q806A/5iStMT+fQFL
         6mhEuG1joeS7HPWiZ0uQyE3YwKeXAgNt2apnVaVU46kZa2JJIcTgitraw5JY7QmdUclC
         Hq8eA/42jOO8vTPbeFhKw2hHwjkmpuF5NxKLMGcWcCKiq9uJkNmFsmM5mjnW++HwQGJS
         pxVqZgSb5YnrzSWzaImqvHyckjxtFeVxaw4BajB1VnPz8J2275hwLRJjq3rhvXe1WJ7h
         JNKg2olwnrWAEnLlT2EbtqCp9hM7KwrkrviBGUx3f3wIz4jaUu29izDq/YuvZffhEdEF
         pmdg==
X-Gm-Message-State: AOAM530uky6yr8UfQFDoKzt27YdKhUEmfoFiuK0p95i/B/4WPiPz/9m2
        cKbWgxj08Y48BVnUw40Assj/naZFQRR+KVzlpJtl6ECGNMQIKSv82NIrkoobgPR9NOZuhZX+qXM
        vZ041g/wbcJWspckL8Az5
X-Received: by 2002:a05:6214:1454:: with SMTP id b20mr24186760qvy.35.1596995757065;
        Sun, 09 Aug 2020 10:55:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypmVs8T4/JUVZH5FRUjEF6IWonIJRDAHozvFIxE/LMFPndjZIaLJZu9ATTeB+HcLxWKFofkw==
X-Received: by 2002:a05:6214:1454:: with SMTP id b20mr24186747qvy.35.1596995756845;
        Sun, 09 Aug 2020 10:55:56 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w2sm11832536qkf.6.2020.08.09.10.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 10:55:56 -0700 (PDT)
From:   trix@redhat.com
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: imu: st_lsm6dsx: check st_lsm6dsx_shub_read_output return
Date:   Sun,  9 Aug 2020 10:55:51 -0700
Message-Id: <20200809175551.6794-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this represenative problem

st_lsm6dsx_shub.c:540:8: warning: Assigned value is garbage or undefined
        *val = (s16)le16_to_cpu(*((__le16 *)data));
             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

data is set with

	err = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
	if (err < 0)
		return err;

The problem with st_lsm6dsx_shub_read() is this statement

	err = st_lsm6dsx_shub_read_output(hw, data,
					  len & ST_LS6DSX_READ_OP_MASK);

The err value is never checked.
So check err.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index ed83471dc7dd..8c8d8870ca07 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -313,6 +313,8 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
 
 	err = st_lsm6dsx_shub_read_output(hw, data,
 					  len & ST_LS6DSX_READ_OP_MASK);
+	if (err < 0)
+		return err;
 
 	st_lsm6dsx_shub_master_enable(sensor, false);
 
-- 
2.18.1

