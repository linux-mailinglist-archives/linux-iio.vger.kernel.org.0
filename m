Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3323FF24
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 17:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIP7s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 11:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbgHIP7r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Aug 2020 11:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596988784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xG+8uieNrMAP0UGTh1w832zRGIBKTtCxlShJe5RBqBY=;
        b=dxBNrcTa6ohjcTdxtSU3u/KqS2oh4TwuGdGJ4BaHXyBNURZQ9XBny0isOVWIIRNGc1jTqW
        C+hB+dBip1+mXlW326TKj9GKlQwT1phAo+o7k8vUeDzze85ely+8hAR//INedhLTQWPSM8
        vNDDS8Andd1gsdEtKnYnkrDsoW5kl+0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-B1gTnhZjPCOqTS5jnsp74g-1; Sun, 09 Aug 2020 11:59:42 -0400
X-MC-Unique: B1gTnhZjPCOqTS5jnsp74g-1
Received: by mail-qt1-f199.google.com with SMTP id q7so5817606qtd.1
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2020 08:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xG+8uieNrMAP0UGTh1w832zRGIBKTtCxlShJe5RBqBY=;
        b=bLyyuNzxk/9uDOgcGvEzyw7AegrPY2MXNgS0yb/dyqE8ARCmiRDrbLu7GdTRbiYA7x
         CPb9LTVyzKdVyXAV6TCBN0icH2kpMwSAQvT+h8+Ev58imnDtUu9lSthNUC1z9hDfwfle
         NKWq+CnZ0hjM+uJ01CWmpTR1vdj8N+cSptJHtXxxlmkQ6sM8SfRXGXCTcep1hObpnLoG
         Q9Xgqby1eIqh5x4BYrFO851FtN37GJtGfES3k/vVAfYF2JSvUFSRL1sMFDHkiepyRLad
         TZFuxUvfkH8eXn7OPR7i131T1FVl7Mk1/UwZSJkTQgJLKrrvCTHwocazrCKimdYDlLpe
         z0Bg==
X-Gm-Message-State: AOAM532/LuHkSduxV2w50JxZCYFLRNzXXW6dENuzYqjjgquro9HY23ox
        nxjYH2SPxdv7Xoq+bYa1eq4K6ni7XQyz0vdYcyaVQNABSCSdyi2DKel9jgq9AKcEzqUqQLEQppo
        ZoRKYFXNLbpjZzC8zwDPt
X-Received: by 2002:a05:620a:676:: with SMTP id a22mr22806363qkh.8.1596988782402;
        Sun, 09 Aug 2020 08:59:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzek1KpoZ0Rpa2MTqiHLJFcD8g4Cwdl2ExzIA00XyXHgllNcIpXqt/H9tlORP5vMgXoeqUj/w==
X-Received: by 2002:a05:620a:676:: with SMTP id a22mr22806349qkh.8.1596988782146;
        Sun, 09 Aug 2020 08:59:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k48sm14978268qtk.44.2020.08.09.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 08:59:41 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, jmaneyrol@invensense.com,
        mirq-linux@rere.qmqm.pl, lee.jones@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: imu: inv_mpu6050: check for temp_fifo_enable
Date:   Sun,  9 Aug 2020 08:59:36 -0700
Message-Id: <20200809155936.16898-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

inv_mpu_ring.c:181:18: warning: Division by zero
        nb = fifo_count / bytes_per_datum;
             ~~~~~~~~~~~^~~~~~~~~~~~~~~~~

This is a false positive.
Dividing by 0 is protected by this check

	if (!(st->chip_config.accl_fifo_enable |
		st->chip_config.gyro_fifo_enable |
		st->chip_config.magn_fifo_enable))
		goto end_session;
	bytes_per_datum = 0;

But there is another fifo, temp_fifo

	if (st->chip_config.temp_fifo_enable)
		bytes_per_datum += INV_MPU6050_BYTES_PER_TEMP_SENSOR;

Which would be skipped if it was the only enabled fifo.
So add to the check.

Fixes: 2e4c0a5e2576 ("iio: imu: inv_mpu6050: add fifo temperature data support")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index b533fa2dad0a..5240a400dcb4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -141,6 +141,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable |
+		st->chip_config.temp_fifo_enable |
 		st->chip_config.magn_fifo_enable))
 		goto end_session;
 	bytes_per_datum = 0;
-- 
2.18.1

