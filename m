Return-Path: <linux-iio+bounces-9614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5282397A3DD
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E4A28BF2A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583A15B57F;
	Mon, 16 Sep 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUvsLUqg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB215B963
	for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495761; cv=none; b=Y2uOJoX9en8RWgqJBtxmC8PvHx1HBdSu0A2Vjzl7Bz4gP0r6tuHuDGJkv9mJtylIEEC3n+oAGNPhB0Yqtm64yV80j316LnuaUIUOM7VNj1QkEVeX5tY2zxcPo87303v6MbwMKIieUDfxU5/7sy4/LzU9POj3OSKbUsfTxFiPNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495761; c=relaxed/simple;
	bh=oIihtEvugRekngdvGX9njfL9N3T0RbQ10ngt0gMQo5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQxX8hc/8v1GVt9nj76mdPhsVdjPnRhxCN73VtjQRRVgFHlD2hDil6jN0Jfl8V1iei+6xOyJI4r8j1qHfySIGHGTcAgDpTo1U/067sQ5EfgtKyg3bY9CsaNe54MDcNPadBt+O6ypyu4TObWoA+4/Mxt9uNbCNo9FGQlawPeOxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUvsLUqg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso824000466b.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2024 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495758; x=1727100558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=96jeFUgbQRZST+IYwU8Ial8RWWjGSXkDlbIleOFp4OM=;
        b=DUvsLUqg9N9NDtNpHXrYuFqWLcTH6OHP/dVVTfu3rRTsauhgtd+/777gy939XfdJbg
         VR9nPxMNajliOMvPOoMmfQVUUPzv7xEyNFPosl+bx2GbkMm0Ay4Enia63rORUVuo3azC
         nfp5r4BTuimSg3WLM729z50n+FH6+LFUzayZSCmtk+HHvRtDCr1vASWAUNPvMyk+IQNF
         iXJ+cH2VoJGXB5Ti6e/fXw57mDbozzQTFVzaUi96/uGLkTlEmGfeNxZMihEEPi+BAuI1
         e7+MI5aI11SmF+0gO0BTq5kn3wFNFfk0273a1mGwYa6l+Spu+sMzqzAGX6aG9SyA2Wxj
         j9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495758; x=1727100558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96jeFUgbQRZST+IYwU8Ial8RWWjGSXkDlbIleOFp4OM=;
        b=INOpbDWY2V3l1h9xRnWncmdXZQcLpvQ84fbOMpQCHENhKf/0sr9Wma2MjfMHBtSCiz
         k3B2ZSAJ4AfDWfdw1Do+jiT4KUtgdNLhTFFFj21DNzKB26TCYfbi/dxn39zrXvNocSzx
         Mm8YoGTEpyuoeYK3QQ3JPmk0k+/SskXvhjxk+ZezBv/6mVpvl1w++1gX4wLA68BDJCg1
         9U3boZV5O7QZQj/6RhLHotR3+ifP2PvaXQ2Pd5m0kFdCLGTO8uop7P213QBtDWbxUePL
         NDteKHHeh7+h6XfIPqBVvmF8nBgfFtpBCZKqM9uyhCRqmuWWd+lPIPTcqHPWwJvHCRAH
         +8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl9l1QqwCEptWujx60YSQcj2kcXvOKYwI49yAg0e1hWDx+kKZxSJ/OaUavPfkG/XagaJ32hfchb8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrR/SmvKIaLUhI82r5hCPJwN0GA1Hnnc2Aqwgl424af519PUI7
	RmWSsslYvG/zmIoKvAxyeHr+V29I+dBQVf0o/gve5pczMyUcO2t1zVuWA5U0Rw0=
X-Google-Smtp-Source: AGHT+IHdZDPEBYWGYVLwV9TT2w6/zrnSjBTkWHdxrQG17ms6CikqS20u1qTFWfpLL/hEdMh16kOitg==
X-Received: by 2002:a17:906:3395:b0:a90:34e8:6761 with SMTP id a640c23a62f3a-a9034e86912mr1253481866b.6.1726495756446;
        Mon, 16 Sep 2024 07:09:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f445fsm322270666b.68.2024.09.16.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:09:16 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:09:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: bmi323: fix copy and paste bugs in suspend resume
Message-ID: <7175b8ec-85cf-4fbf-a4e1-c4c43c3b665c@stanley.mountain>
References: <cover.1726333044.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726333044.git.dan.carpenter@linaro.org>

This code is using bmi323_reg_savestate[] and ->reg_settings[] instead
of bmi323_ext_reg_savestate[] and ->ext_reg_settings[].  This was
discovered by Smatch:

    drivers/iio/imu/bmi323/bmi323_core.c:2202 bmi323_core_runtime_suspend()
    error: buffer overflow 'bmi323_reg_savestate' 9 <= 11

Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: no change

 drivers/iio/imu/bmi323/bmi323_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 89eab40bcfdf..f6ff07ba98cd 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2193,12 +2193,12 @@ static int bmi323_core_runtime_suspend(struct device *dev)
 	}
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
-		ret = bmi323_read_ext_reg(data, bmi323_reg_savestate[i],
-					  &savestate->reg_settings[i]);
+		ret = bmi323_read_ext_reg(data, bmi323_ext_reg_savestate[i],
+					  &savestate->ext_reg_settings[i]);
 		if (ret) {
 			dev_err(data->dev,
 				"Error reading bmi323 external reg 0x%x: %d\n",
-				bmi323_reg_savestate[i], ret);
+				bmi323_ext_reg_savestate[i], ret);
 			return ret;
 		}
 	}
@@ -2237,12 +2237,12 @@ static int bmi323_core_runtime_resume(struct device *dev)
 	}
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
-		ret = bmi323_write_ext_reg(data, bmi323_reg_savestate[i],
-					   savestate->reg_settings[i]);
+		ret = bmi323_write_ext_reg(data, bmi323_ext_reg_savestate[i],
+					   savestate->ext_reg_settings[i]);
 		if (ret) {
 			dev_err(data->dev,
 				"Error writing bmi323 external reg 0x%x: %d\n",
-				bmi323_reg_savestate[i], ret);
+				bmi323_ext_reg_savestate[i], ret);
 			return ret;
 		}
 	}
-- 
2.45.2


