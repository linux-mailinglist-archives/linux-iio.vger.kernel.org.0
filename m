Return-Path: <linux-iio+bounces-16178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039BA49547
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 10:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FAE1895261
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51225A2AE;
	Fri, 28 Feb 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbx/IKtM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC31FDE2A
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735409; cv=none; b=YxnwCfUdRqz8f0JmkPHG7G/pvUTbNrQwksNKZPBmjOMf1GSM6fqs4WdGuyoi4x/L8fnqJ2EZjPFUXaU3PKW/neOHvbMOMf6RC+fovW8R8IgJIvXMcb/YrTStRGXNKOoXW2TAmhYHI1/8j4cFWN2scUbYgmFiCXSC/4DHEdxVztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735409; c=relaxed/simple;
	bh=7OAvh2FzEJjI/bPOiRm69JhriGa3UZoS0poO7GliqrA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F94+7XtDS0Dra2cQcIpvdABi0fd6uWKjulDyMF5jJ/5PUGwoIO/B0opxKc8PLXbhqPMu53OJRisqja5ork/qcyOR5I/FVAgYO7B3BBff0V8FgBsgGHJr/AjlxtA1hP/2OkOlODOl0UXcoglggWhx8L43dp0zZ3PBqSa8BkpbOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jbx/IKtM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so3571720a12.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 01:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740735406; x=1741340206; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ai/hJtxYnguTomii4SP20m0cifXXwklqa40fjptgdsQ=;
        b=jbx/IKtMNwFb0YjMoUsqedagbGbpoZEJ+WOfrS3YCsBaxPB/SsBo7W5KgliICxLZ3Y
         2S0HVkBgyMUnhcWh/tciWvTO5BPhU2gSeODj22nnO0BJ+gmmZyBETxEmuNwGtNcEbEMs
         yov/fhSNdYh+fKhh6K9HolZC1D2ij2/JXpTcUWRJm6+ilzSia4ZcgWJYJuTLPCDZIQ8z
         DnFG62suXh5s3vgEpWbXQcVGvIXrGHyr2t5KIMhMpQUHPWNGzf0qrUCKRW75+kNUMOiX
         A0mIlPeRGuArWPQVNFaIO/hiKDRwu3ekH1GJ0rje9384yNFiDciMfnZfZC8VPHEh/MKp
         uFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740735406; x=1741340206;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai/hJtxYnguTomii4SP20m0cifXXwklqa40fjptgdsQ=;
        b=MFdn3ITHlT18EvtLo0jSgl4aaLMNV4snkq5SiNTzI5K6tIMsGM0n5YVi1dK4h0Y0Ra
         NXV+XRzjXolC0xDpujnUs6xEFNZ8m23hOgZI6mTFPdztjRTT4D/ljURbgPHPCh64RYau
         LMzXK3hzQu1JZlEnlLesWilwxfP/O0cfg/lJL91symBbZl/Dq6a5KUF10Fy9PbpgyV+o
         vnWagFh0h1y0PfSm6RqOUQaWW/ilmrS82VuYuteVjNuY6Q4GMy7MGnjPrVZ7K3TNv+Sq
         M9y2E6XxW6eZCfiexJKu+5cTPlb+WYGfsp2yQPKvLMHRMB71GsdXfStYaMqtV+oVRgFu
         mKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoqiizoTtPeeC7krNvSS99SfhivTG+56pvyFI7AxvtPuB6n4O5SqHVo1/uTWsat9c85qxVRYvtyYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoL0T6QWvbX5mX7JbLtLO7qUPgiZUiiHAfcoN5DzUO/TmqWjrl
	c+vIIgubwPlpCTZlPSH18JVVrn++itSyiDK487rcGPZWa85Bs5zUhFk2ypZqsRvINPJvtr2AYtm
	d
X-Gm-Gg: ASbGnctM68vCnqV6Xqo0bAhoaA5BWF5AKQ4RWF4XdArdyXXogW7JB9ZasZtXnxPtLRo
	2w1chwEmpO4eONCI3PzxG2zpLeeKAKn/3z/dUta0lTrBVr+4v7O/Lhrmr2vib67iLSb4Ml6Gjlk
	lhNFHXaTX7WqVCTC6/kK1FzFkb4XUT8+7CvVAhZS+ZDWn6kn0nadljMMwcd0yNlGeDMdkTEGWTz
	+7+SA9LptI1RKXxlCXcbTmvWgmtpsb49m38UZUUtlhMfYAdHDxW59u4ZSdVeJGWeNj9Fgh8N67r
	TVlZzSiP8/k1Tvty1zaSq5uqW6QxNTU=
X-Google-Smtp-Source: AGHT+IGm7vDtQOlmQzD7ukOLgUjBw4xij3s9uP3Fz/LVXmcLAJBxgStvGxHWCueyPd6neqkamka0Xw==
X-Received: by 2002:a05:6402:280a:b0:5e4:d6aa:82ed with SMTP id 4fb4d7f45d1cf-5e4d6aa8563mr2073071a12.12.1740735406137;
        Fri, 28 Feb 2025 01:36:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c3bb7386sm2278113a12.43.2025.02.28.01.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:36:45 -0800 (PST)
Date: Fri, 28 Feb 2025 12:36:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] iio: adc: ad4851: Fix signedness bug in
 ad4851_calibrate()
Message-ID: <f5e260e9-d7a8-4dae-b7ea-f1bbb1760e60@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "c" variable is used to store error codes from ad4851_find_opt()
so it has to be signed for the error handling to work.  Change it
to type int.

Fixes: 6250803fe2ec ("iio: adc: ad4851: add ad485x driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Btw, in ad4851_write_raw() there are some checks for negative but
the multiplication could still wrap and turn negative so we might want to
add an upper bounds as well:

    drivers/iio/adc/ad4851.c:826 ad4851_write_raw()
    warn: potential integer overflow from user 'val * st->osr'

 drivers/iio/adc/ad4851.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 1ad37084355e..98ebc853db79 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -492,11 +492,11 @@ static int ad4851_find_opt(const unsigned long *field, unsigned int start,
 static int ad4851_calibrate(struct iio_dev *indio_dev)
 {
 	struct ad4851_state *st = iio_priv(indio_dev);
-	unsigned int opt_delay, num_lanes, delay, i, s, c;
+	unsigned int opt_delay, num_lanes, delay, i, s;
 	enum iio_backend_interface_type interface_type;
 	DECLARE_BITMAP(pn_status, AD4851_MAX_LANES * AD4851_MAX_IODELAY);
 	bool status;
-	int ret;
+	int c, ret;
 
 	ret = iio_backend_interface_type_get(st->back, &interface_type);
 	if (ret)
-- 
2.47.2


