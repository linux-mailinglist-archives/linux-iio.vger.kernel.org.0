Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE72240EE
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGQQ4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGQQ4V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738CAC0619D5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so15938794wme.5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLQMRZhAcaiH98XmK2nRHQzjjK7ctPbh4JOJq8lN/Zg=;
        b=OReukPQJ3TIWhVLoquVjq+BeXvQT7cuSvvCcBFb0FD3W6ukPwpAZ3t+VKU2KQZDNJB
         uLfyuKrtlK2hf/RZvQ5c7JhBXi0h3LBcNPrdTaNSCZkHimnuOwlFsIT3mlpVFlTjtA87
         LGIALjoVGtVa8I28KhjT+QpMYCyq/cjQHimfvPZ2gkcdCnVDw6I+/8aL7CU1xb+MmNCP
         BNCsb4Npwo3oQMvEUKza2FYOXeRL/MmcQNwHelQNf7luezRVKDgfbLJtjmQXtukgnet1
         e2GKWxtR2vqawEYMOPl1xWO7n/UrcD9/dzfAKj8XSMioQbV9BRnBvA3cxsxOWW0gsbFx
         tamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLQMRZhAcaiH98XmK2nRHQzjjK7ctPbh4JOJq8lN/Zg=;
        b=uZaMnGeteU8MQRBx2u5VHICwTg7UZnO7T+VKQj3VlareKFW7lLVklypjYLsaRmxOAE
         CwhN0yGqHYqy/9iDZK0ucnOF5Uss2xgxVSz9Rod19BMgpd+cVbHC4izkV5/k+zIHmfGK
         Zr308xtmWoHPhx7Dzp530K2lHYA1F2DZyeARS0TDMo/dnDK4pclLvgLCXNg8iMrJRm/C
         Ispb8WoD2zsNEJrGdCkKzxJdDNcvgfOjGcYy82sncqNn2nw0ptnWmbDEt7NFDDpUL67y
         yB+6Pp6k/IYW6HN0yQDOeNE7ALttkbEVzDsh6DUUlpfd3Qjanfq6j1u+A/H7SyUYpTTe
         XcQQ==
X-Gm-Message-State: AOAM530iOX4zPekU0aOoYoKMtcKg1kTVi52tfSjzYPdLf9iwHDpRZ1Yf
        2gA4DE6MAJHY1YPg2/wvBwjxUg==
X-Google-Smtp-Source: ABdhPJzKZPc/M/DK0dDuqHn74s8nL8cUXwq6RyA/6MudfzQXS/4hRjICV/HEuGEK7f9Kwc9NxblCwg==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr10064679wmc.60.1595004980122;
        Fri, 17 Jul 2020 09:56:20 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 19/30] iio: imu: st_lsm6dsx: st_lsm6dsx: Reorder 'inline' declaration
Date:   Fri, 17 Jul 2020 17:55:27 +0100
Message-Id: <20200717165538.3275050-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:487:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:497:44: warning: ‘st_lsm6dsx_accel_ext_info’ defined but not used [-Wunused-const-variable=]

Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index b56df409ed0fa..3e47a9287938b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -484,7 +484,7 @@ st_lsm6dsx_write_locked(struct st_lsm6dsx_hw *hw, unsigned int addr,
 	return err;
 }
 
-static const inline struct iio_mount_matrix *
+static inline const struct iio_mount_matrix *
 st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
 			    const struct iio_chan_spec *chan)
 {
-- 
2.25.1

