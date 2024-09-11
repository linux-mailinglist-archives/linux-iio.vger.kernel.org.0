Return-Path: <linux-iio+bounces-9439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C784974BE3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 09:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24705B218BB
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61BE13E04C;
	Wed, 11 Sep 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KM2vHSs5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D013D8AC
	for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041273; cv=none; b=t4Q+jCpoElu1GA7JULUV/9ISYliApllB3F9bMSgLii0eq7zwhnsrCKDmqxxvcZJn+8IN6l/kksK9Kpd/jIcZkWlnEHNPafL0O3kUG6kE9VAsfEx/Fcglbf/pYuqT0SXdKm0jKDCJhL2baJJ3AHuqIKsHM9RzbwJmXisVBWjFE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041273; c=relaxed/simple;
	bh=JwDXvBMIcJ0cEyE7/K39FaGGwLoRz1fdPA4mgPlF084=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q7hvj9NiP0mlrJAmDCNjIVtzWwA4yJmYAyMgXh2Dbt2q5l1FFYiFlITIdF1boWKxy/q+Rm5h/VVAnzN0H/EpTTCrWgBHS+WMTe+yEfTk0em8VAwZMoHlGgczItMbIgp2hWpUeIOVzVvLu2bO31Di6NZmGjVrzbjszNsRmn7Jwjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KM2vHSs5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so22839055e9.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2024 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726041269; x=1726646069; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFDXMVw2a2qtH/DhsDJ1EGdSmuLP+t4A6t5u+JU2Kmg=;
        b=KM2vHSs5NnYfAfyUZObCOJHWGSGHp0Q/gROJYRPCOM3vmPLByJTB3NyFdcYAZ617W8
         ldwjk51YilO/UsUExce7m/Xn9N6O2kx/01pD+BzjYvmsTkKqVuHMmBFOxAXKQkQq7pol
         e203P4i2FakxW9qcV5NTbmXFdvT5DFPuTuo7uVBPJPYGbsERaNdCCa8wpd4psamzCq3n
         7G+3oFdYpnKIhDCRzmwH/cprjoOgFV64BK/0IcUhZDB51Ff1Q4vgJR4vsfxnkoiM9TUW
         NZZ1z9gBuuf5kcC6yWYFR3NqkYUGEjjoOzzdGSEm2NDN38q1SPWXyCTxvTISwZeBEvOe
         KQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041269; x=1726646069;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFDXMVw2a2qtH/DhsDJ1EGdSmuLP+t4A6t5u+JU2Kmg=;
        b=XPSvjUgRr35pNsELzcgQnd2Idff1VLAajxMhJqXYKBq8xj4CvOgAfJwXxHa5tTErvz
         yz3GN1/P5jSttPGdL0bAOjlNzjXR4xFAWTm501Yi3EvGEOL1X9uGUkT0sK4F+EIitHKP
         SwMyzORk2ImCqitMvXnsbSKHNNXhiovzo2EUfYdtzMz/jZitJt4YWqlast9mb/Bhetr4
         et/d8lQO6rIMej5W1ek/1svEviwiE/PZDm3islUJLoRR5l7YfP9Kxq23gx87YWngL5q4
         x3Kx27x5Ll53UUy2qWKb5X1oy2eP+xID2PxvuM74iODrgFPzblGAEuCCr6JSSNP5lasa
         S32Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhcmwsTwYtmhMuTRSN7Fi68DY6dhlxOJoT/E3SlhoJTLttHwOSTdtOMNkVVv6dveWLU/qaSBypwos=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZ3P7lSg891nfGyacV1TY1dKdZ4ZDZ43ve7tkueQUlHl8D2Pe
	9FOfprMDBXXnx6PC0joAH9Ssngztm9n3yxb5copTmNQLD7olhd/pSo77HQB2T3M=
X-Google-Smtp-Source: AGHT+IHMGxiJwIOhxACyDX9LH5o77Ml1wigv6PlpISWVmZUFFncR/IDRy7m4dUOHOG2tDvF4nXUVdg==
X-Received: by 2002:adf:fe82:0:b0:367:8f81:fa09 with SMTP id ffacd0b85a97d-37889674bdemr9244557f8f.47.1726041268975;
        Wed, 11 Sep 2024 00:54:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3743sm10900659f8f.79.2024.09.11.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:54:28 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:54:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: bmi323: Fix some bugs in suspend resume
Message-ID: <2efd1dd8-5a4f-4df0-8acf-972c91b7c9a0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These were a couple bugs I found using static analysis.  I have not tested
this code.

Dan Carpenter (2):
  iio: bmi323: fix copy and paste bugs in suspend resume
  iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume()

 drivers/iio/imu/bmi323/bmi323_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.45.2


