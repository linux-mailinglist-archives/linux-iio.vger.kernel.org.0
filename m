Return-Path: <linux-iio+bounces-25344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590AFBFB89C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 13:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC94568118
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FA9320A0C;
	Wed, 22 Oct 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAK1q5/5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB6299A8C
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131111; cv=none; b=QdDtU6q8jVYjs/l6HWVoVELhkybdx65RxCyKsre5/PA5redyj1eW8tiGDiTfSD+1CXj1E0TD1/rDXlXMLrd0tUgUmG0n7nasp+yWC8fIi0+utzJiwHAfsfmjiXiRJjwevJ4OCuocaaNi7Gk/VtwCx+0oLWIGIahFAkFKKSYqfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131111; c=relaxed/simple;
	bh=k/XV2MWcnA2Sz4dS032qJ6Jdbqs4hYbOsDA26lsRJBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MWfGg5TVjNhCfUIJQgwwGjjQ9UknENI5+QBMgPDwEmczfLA7wyYK7IFE3R2HYVvWK2xhBgL5CcESBbv8gAfceAKThsCHbWhHGz8a9zWVXaCGO9Yiv9NYIM+Gfj6HGCK5BXkf4MroisD4k4OOW6YhhZI1EGo30oHFZjQ4lLwc8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SAK1q5/5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bcb25so4015586f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131108; x=1761735908; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YC5fAMbX2oWGTXVlxAXkZBZYkAqJHmZfAJXqki8F5gs=;
        b=SAK1q5/5sPXsOaGlm+UW3rKYnv1v/EtQd/nn4hELwKmp8bKlRQP/DDhNJ8evoSzcaM
         AURffpi+QRQlTS8qBDyeOr+8Jo5gzunDP1l+NKFTVbi0EKCLIUzIXCWS9+nhsc+D7MBZ
         JZlkQcKuKAzqVszVd73dKyw5J8KzrYAG72Greo+RwdNdA0O1iar6nCph7LcfLW+MQiH+
         Ok9ruU4lTBAbe3YZMNEeLJCGVR5I9SsFWErU+Za+nyo1z20BVa2GM3uSU8/oBq5N16Hn
         ++0QLvw0+NyyqT3Lhxihfuq8r25Y0d817oUgXeirwY6p+IFP2DzpdKyEWSEUJR6RSEfR
         jytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131108; x=1761735908;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YC5fAMbX2oWGTXVlxAXkZBZYkAqJHmZfAJXqki8F5gs=;
        b=YbTauqtNw8f4tNa3VII6bbFD0+YHUt/yT5YwC48aEon2LbOjQKCdhzAZ+FRH3lg9IT
         w0JYFL6gZXM106mLqb9j33+TFW+R43AntfODMeS+vqrdveTGPNmBBUha57bg6oqMXKM4
         cpfxjtfl5joOb1Da3YQqgeG/PX8h8SJ/IelcY8NomDi7xfEkbum14FpXT3W3J+pbzHHi
         EkQEcFxj4h42zjd8u29wMfxeXgjD43pdO1eAKrjqMD95oKJKbuBEa9LgFmcFmrUooVr7
         YbQ/8+hWJiMrmUMMGorz3c9x4w1rgClsMpBkOA9jV+aHoDRL5Ja2cLRAUqRA/WPQ0/8R
         vRyA==
X-Gm-Message-State: AOJu0Yx9xbWIpREd4VYl9TK6IIqt4w0HT5RCDKQok3WtVG+7Vps796Wc
	A3O6gBxopggZKtbtkB3RcUv3nPBl0B9efbAouSewy/gtaozWKx6D1r6hYXVi62hejiA=
X-Gm-Gg: ASbGnctl84kfAailGywmlPmMOnGCvv2JO6kNOoLryaOz5rAPuBQ0/4vK7RpifPmZ6yM
	VF91MEED4kLmxl5737YwXlZ+4e9YHX22gJLURT1lTLbw5mc3u/XO0hrLfmtRCk1zCI2CIj2Twd1
	ZVQ9QIw0M21H7wbngQu8krUSiDYrwouO4I2PIB0Z+uLgM7x8rNZt6w4Ng5VZCLgfsQcvfvDsetW
	82YWSz6GrkCS9u27rcvZVpqm2ng+26FLNXEazKZj2/shIM5Ai8tzHyT30J4UJ8KXZdTqsyRmlqG
	9HZqNhYA67sybyhMrHP3VB2V5rzGWV62nKTdUKyptvw4rCVuRsU9V2UUi3ZSh2EwHwH//PBsnWb
	aYa0XJ9vH50cpCmg2n2Jqpau7hP57RomMbNHvADoZJvT1zWCwW3NcJYaXvYmIN3fshErzOdJHCc
	otnc2eGueUKCy+zdG9
X-Google-Smtp-Source: AGHT+IEF0P//KngOe1MI7xdiQoENWliDPdQe5fCtM2HyEXV0Yk/DHRRTJDn0qsWdwjQIOJ/Q45z78Q==
X-Received: by 2002:a05:6000:200f:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-42704d521e8mr14823878f8f.14.1761131107573;
        Wed, 22 Oct 2025 04:05:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5a1056sm24443694f8f.2.2025.10.22.04.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:05:06 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:05:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Remi Buisson <remi.buisson@tdk.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: imu: inv_icm45600: add buffer support in iio
 devices
Message-ID: <aPi6Xw-ZoUkW76zR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Remi Buisson,

Commit 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in
iio devices") from Oct 7, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c:377 inv_icm45600_buffer_postdisable()
	error: uninitialized symbol 'sleep'.

drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
    354 static int inv_icm45600_buffer_postdisable(struct iio_dev *indio_dev)
    355 {
    356         struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
    357         struct device *dev = regmap_get_device(st->map);
    358         unsigned int sensor;
    359         unsigned int *watermark;
    360         unsigned int sleep;
    361         int ret;
    362 
    363         if (indio_dev == st->indio_gyro) {
    364                 sensor = INV_ICM45600_SENSOR_GYRO;
    365                 watermark = &st->fifo.watermark.gyro;
    366         } else if (indio_dev == st->indio_accel) {
    367                 sensor = INV_ICM45600_SENSOR_ACCEL;
    368                 watermark = &st->fifo.watermark.accel;
    369         } else {
    370                 return -EINVAL;
    371         }
    372 
    373         scoped_guard(mutex, &st->lock)
    374                 ret = _inv_icm45600_buffer_postdisable(st, sensor, watermark, &sleep);
    375 
    376         /* Sleep required time. */
--> 377         if (sleep)

sleep is only set if _inv_icm45600_buffer_postdisable() succeeds.

    378                 msleep(sleep);
    379 
    380         pm_runtime_put_autosuspend(dev);
    381 
    382         return ret;
    383 }

regards,
dan carpenter

