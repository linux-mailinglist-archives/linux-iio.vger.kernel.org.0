Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C72240F7
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGQQ4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgGQQ4c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F80C0619D5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so18223358wmf.5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjCKbpOQYkAjrdgAsqIA/xWvJJA5FtP0GGnZ8k9FnTs=;
        b=ivqSuFwJF4H6NAcbUhesIqowLDzidp+Q6Cgsz6IjVOhNdsxaKBhzss9ugyry3dFrG9
         fQBBBXEoej+fOoDSGBnxdVz4CD13TQB1T+4cVVZGFzQvWpki0ODmu5u0v8v0yt+41hPZ
         1mXsEez3J1Iat433csy4cV4yJDHoaj+RVbK7fHmvFa9nVwOztrPrIJZkY9DI5PaTo8D+
         YuZFDeHGjalJQa0UxKX6Ael4XD7z+KkPZCYKNEMG+IzrADbDZHezMpzqZroHmMKs3PyT
         9PQIrqjsIt04NXtb0AP3+bwWH7ZWRo98fJpOTcrHezrFH14KJOj3pX+9SuOaq0LtKqnf
         eTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjCKbpOQYkAjrdgAsqIA/xWvJJA5FtP0GGnZ8k9FnTs=;
        b=UwI4ia9X2GNQkSPoXhiAvMcTNMYIbi5t9gmWO2//XMF8b+ZfA2C0skBvLbAryP1De2
         UhLmtcyH3gv3DkE2prZqx4gCv6euMpcel7dEnEpTvQbtnK5V/WBHI1oq2gUzD3WfWs3c
         nTgl6cL5lBat8+HbSlriw68wUN+AxDnpzrP9+DPPt9FQ2c1GlE9kQgQTzGEEepuxKRwc
         Dv0z4+LiPHh9ji33APnD4G78kPNRY8TcXNZ4Ub9nsHMpbrLDxt1VdnqFJrP4zTd3ifFh
         KTQaq8n7pAKVGOzHbkHrzaiSJquPBnse4G9EVDyx6q9rlmWzl3YW9BOHFVTgRyG1dLKq
         5tUw==
X-Gm-Message-State: AOAM533HZuYDodgtcbHK9Zx4e++5LKtFwPey5h5ZG+XrW6M6GAqbIwJG
        w+3tQGwRmNjPicm+a+Cp8mlv1A==
X-Google-Smtp-Source: ABdhPJwW9dW090U2vHUzNPUpV1Mt8bRTkM26NfT0oEOck47f5YKRu8EkwGOvWNvxyd4IU6KLo0tJVw==
X-Received: by 2002:a1c:6805:: with SMTP id d5mr9938456wmc.19.1595004990415;
        Fri, 17 Jul 2020 09:56:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 29/30] iio: imu: st_lsm6dsx: st_lsm6dsx: Mark 'st_lsm6dsx_accel_ext_info' as __maybe_unused
Date:   Fri, 17 Jul 2020 17:55:37 +0100
Message-Id: <20200717165538.3275050-30-lee.jones@linaro.org>
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

It doesn't make sense to move it into '*core*' as it's co-located with
other, similar definitions which are used in multiple locations.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c:17:
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:497:44: warning: ‘st_lsm6dsx_accel_ext_info’ defined but not used [-Wunused-const-variable=]
 497 | static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c:17:
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:497:44: warning: ‘st_lsm6dsx_accel_ext_info’ defined but not used [-Wunused-const-variable=]
 497 | static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c:16:
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:497:44: warning: ‘st_lsm6dsx_accel_ext_info’ defined but not used [-Wunused-const-variable=]
 497 | static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 3e47a9287938b..d82ec6398222f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -494,7 +494,8 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
 	return &hw->orientation;
 }
 
-static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] = {
+static const
+struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_accel_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
 	{ }
 };
-- 
2.25.1

