Return-Path: <linux-iio+bounces-18163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6DA8B76E
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 13:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279E0189B739
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5823BD0F;
	Wed, 16 Apr 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpenPNxa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50A236435
	for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801780; cv=none; b=sktyJqTAmUfIjUWRuq5K/5j0XxZC0AY0CHNTA1opwwTnAl5unFaex6XFiC8CEa4iVgAYRh6hTgiwW0YRC7qwwWhnmkVrruF3sLvp60NxKVxXMkd5QlGO2V7iw+bOOpnMxWVmIEqFyfCDYvYgjcJlb+NLar+V0aqLP+gZlYsIuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801780; c=relaxed/simple;
	bh=+y8KqhSVfnFlwYzXbSSQMmS3oIDAAaM+xEj5SWn7d0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ux4b2bnwf4iYXFzdRP4TySf4Su9ySIA+up0zgmkH1ZG48bSRY4GBMsceAiCG5flhgfPWdY/OMTnEuPBuyb5LccoErDLMRboAeJJT1bZ9vxe6FAWIdFMCYXLU8SiHBBjzBgTfJoQqIyQAaHLFt6q/P66QoYt/RscHK4UBHLUXI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GpenPNxa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso49533755e9.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744801776; x=1745406576; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ji8R+YWk3MsietQv3MSFseKaQ1O0klM9PlX7ucUVXoo=;
        b=GpenPNxax4ypNOO7NFXOUrRkjWiFGRthyxlJKDdVGzRSCfSkDvfeHliprquE+vH+Ra
         sC+c/m/NjnwDj96BkLlr/QWt3O37qMjTmUDw4Ar7hUZTrEyoRz9Nooe7dX6N3c/cIeDO
         Ge3PB9Oeyfo4kcYGvpTBQpSNHZMNsG3Q2PY7KasR0O91P30Qn6+vyHK1aN252oww0nD4
         UaQcdp94JHsieP07W4jlg5n2JEhaoLYzCfykCef8zBFgqmzke+4YZDr7MKfiuHtehjsh
         Q3m7+LhH33uV+Jm9mGqVAWJFCuGEIiR7pZD/JCvrNiUKGtXQkGjQL97ke/3RA/7P6zWc
         djSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744801776; x=1745406576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji8R+YWk3MsietQv3MSFseKaQ1O0klM9PlX7ucUVXoo=;
        b=u+CP+f3InExN3b5s38HVzZbh9eS+b1Afb9rW/8/OFlrMv2g9nUFlpzj96vcae3m1f3
         s9OY0Xy+v2O7W3JPobsOSHmW9uMmnZCIcVUcwbvfaI2TSrVZJdSU895sVIUBwcsis16Q
         sDt2vBMGaF/lQlZauA36aB/tbUhTjulw91Axm7s3MfxK2ifqvWDEM+cPuknRPSVQgsci
         NxsFTvv4vOj3QGKf9mLS9KHCxFx8jGI/tP4UgwUZ6rND187o282i+9dSI755Iz0cIy/t
         dO9XfrcNWaKcTfZd0KpZrFuQSknPbVc327YSrdF9ijRppyKVMn5djPauvJL1Olii84fo
         SRTw==
X-Forwarded-Encrypted: i=1; AJvYcCWqqMHmEXpsu3XTQ4WJp/BmtWhzH4q3MpwQjq/qmZGobcEwlbDAh7OhKc/S33a2sgODabvEs50Rmlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxcM2Gf4Aynyk5UoHbJ/V+bKH67PBSwpoAnfHRvRxuVpvd8OI
	KY7WdjOSXsIjJiLSAPbxCitHorArl4KpF9mDRzDfLFcfeB0h675aXQp7BlSoqxc=
X-Gm-Gg: ASbGncsywq0fLA6sJISNtnwYJlHvDKLL2oyF7N5eIbW7RckC7mtVq1pqZvO1SBDmD8V
	Y+27Pr8JDeVYhJsmN+UhhxPcMo6a1K/RPiHZy6M9Eh3a/BsmEEOiZkvw4piO6Dea2eA9sqDniOC
	JzT3FUuY2naqGcXz8vw3PaV3Had79EXrB0Bs8u/cWMfpXK1E4bN7ze5QkN3D5fTaHGdjkKF88K1
	SVS9qHcz3kE8O8kqIhN2yCNfBs0YOtL1QM0EW+GYYFjDQQ9jwzLuWXrNr33/y3vam3jocZUw9DQ
	PCb7WcsQnpGpOzgmxGeHL9HWYNZILQ0gutleAfbl1WAKug==
X-Google-Smtp-Source: AGHT+IEKAxZRjlmETxUa8i3VUxPy8BpzguynRSNTNQ+1OBTbY+SFnyW1TOzEANNdv80tEbVj39nrNw==
X-Received: by 2002:a05:600c:1f13:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-4405d5fcd76mr12260785e9.6.1744801776554;
        Wed, 16 Apr 2025 04:09:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4405b3445adsm18145115e9.0.2025.04.16.04.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 04:09:36 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:09:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] iio: dac: ad5592r: Delete stray unlock in
 ad5592r_write_raw()
Message-ID: <Z_-P7bsD3KL5K25R@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code was converted to use guard locks but one of the unlocks was
accidentally overlooked.  Delete it.

Fixes: f8fedb167ba4 ("iio: dac: ad5592r: use lock guards")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/dac/ad5592r-base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 217a8a88818d..5f2cd51723f6 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -324,10 +324,8 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 
 			ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
 						&st->cached_gp_ctrl);
-			if (ret < 0) {
-				mutex_unlock(&st->lock);
+			if (ret < 0)
 				return ret;
-			}
 
 			if (chan->output) {
 				if (gain)
-- 
2.47.2


