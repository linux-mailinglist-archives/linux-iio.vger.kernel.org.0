Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE132224112
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGQQ51 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgGQQ4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391DC0619D4
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so18257630wmh.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rc1gRiFLnICYkzZdrxG6wdBxb95IGqTfJLICTNXyrKU=;
        b=gaLDHhRpwR3ip7ByImygRyE6T8KMhCeOwINKf9nI53AuRbCKThVlZPnVDsTMqvNHJr
         6eHtvKSEeHZjAueJq6jCt0C+F6/cIB+tiCdInlV3ZF9xmO3wWYA0yy5/VwsJOPWe2/8q
         +VfSlqQz/dug0MDcHgCo/egx2F0DXeTGm0/phPlQlUgla81RscMXC/yUh0b7+1im/Y4A
         7LV1NJT/INVpyBK42/jJ4xS8iUBaMYfzX+LyFdTfCdoFBM/1K26iPwbzAFVnFpJin3l9
         xYMHogy8enMH8Ek2t1lbTVQxdDlwuYwKO9RREuiWNY0pTU7erHOC062a7K11ocyst6xX
         3/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rc1gRiFLnICYkzZdrxG6wdBxb95IGqTfJLICTNXyrKU=;
        b=MUBNFs8eL9kD8VLwKrJkMjys15LmDjuLPKbqiZZ0SUwuaC4kDkkVGOx1P6sL/e8UmD
         6qg6EEpnynQcrO6I2s/TFR5pTIY7wKRG202k8yGm3RPtiKE7bIB94U4ET3ny1FAAdkab
         GEC13SrVsP+WF0bTD1tPz4G8jKXcs5XmegHwDwRvhsBNfcIqC9bbdWZJ7o5ZUPyeOXjK
         YjG6PooYuzCiA3B4Bk5DeXKDmEOTInbT2sbV1ECVk0g0LekY9JSfYc2I8jldMBeALw01
         BT4kPZPtPE+XH6O49lbcGx5czPTN+XOUzPNVT27CWcXPiw355KN8+rUmnJSbkkuzwLfo
         +YEg==
X-Gm-Message-State: AOAM532MD/eADEq6BYKoEMYayEHoJzsTcEumRyDBEcfuMhiIh4Gbm8Db
        S/OihlQnB2r9LIJsnma5CAUiOg==
X-Google-Smtp-Source: ABdhPJw/s3gzHYxgswWOyt+xbyCAaW5RvtiZ/PHKOLabQjqpNF/+Uib5bhmOWwZTw4eLFK5k75RoBQ==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr10345994wmj.67.1595004976743;
        Fri, 17 Jul 2020 09:56:16 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 16/30] iio: accel: sca3000: Fix 2 misspellings and demote nonconforming kerneldocs
Date:   Fri, 17 Jul 2020 17:55:24 +0100
Message-Id: <20200717165538.3275050-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/accel/sca3000.c:210: warning: Function parameter or member 'mot_det_mult_xz' not described in 'sca3000_chip_info'
 drivers/iio/accel/sca3000.c:210: warning: Function parameter or member 'mot_det_mult_y' not described in 'sca3000_chip_info'
 drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'indio_dev' not described in 'sca3000_read_event_value'
 drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'chan' not described in 'sca3000_read_event_value'
 drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'type' not described in 'sca3000_read_event_value'
 drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'dir' not described in 'sca3000_read_event_value'
 drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'info' not described in 'sca3000_read_event_value'
 drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'val' not described in 'sca3000_read_event_value'
 drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'val2' not described in 'sca3000_read_event_value'
 drivers/iio/accel/sca3000.c:1110: warning: Function parameter or member 'indio_dev' not described in 'sca3000_read_event_config'
 drivers/iio/accel/sca3000.c:1110: warning: Function parameter or member 'chan' not described in 'sca3000_read_event_config'
 drivers/iio/accel/sca3000.c:1110: warning: Function parameter or member 'type' not described in 'sca3000_read_event_config'
 drivers/iio/accel/sca3000.c:1110: warning: Function parameter or member 'dir' not described in 'sca3000_read_event_config'

Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/accel/sca3000.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 6e429072e44a4..3952187166ffa 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -186,9 +186,9 @@ struct sca3000_state {
  * @option_mode_2_freq:		option mode 2 sampling frequency
  * @option_mode_2_3db_freq:	3db cutoff frequency of the low pass filter for
  * the second option mode.
- * @mod_det_mult_xz:		Bit wise multipliers to calculate the threshold
+ * @mot_det_mult_xz:		Bit wise multipliers to calculate the threshold
  * for motion detection in the x and z axis.
- * @mod_det_mult_y:		Bit wise multipliers to calculate the threshold
+ * @mot_det_mult_y:		Bit wise multipliers to calculate the threshold
  * for motion detection in the y axis.
  *
  * This structure is used to hold information about the functionality of a given
@@ -859,9 +859,9 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
  */
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sca3000_read_av_freq);
 
-/**
+/*
  * sca3000_read_event_value() - query of a threshold or period
- **/
+ */
 static int sca3000_read_event_value(struct iio_dev *indio_dev,
 				    const struct iio_chan_spec *chan,
 				    enum iio_event_type type,
@@ -1100,9 +1100,9 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-/**
+/*
  * sca3000_read_event_config() what events are enabled
- **/
+ */
 static int sca3000_read_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
-- 
2.25.1

