Return-Path: <linux-iio+bounces-8486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87DF952D60
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 13:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5FA1F25EC6
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C75E7DA7D;
	Thu, 15 Aug 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uU4alQi+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E4519D068
	for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720946; cv=none; b=HXwd+cTuLOWzC3j2ySuEWK9mDC3CLwiWc9nhiD0tWh8Fmd8GpIEXcKd28K1mfAu/WFrzG8tlS/3dMrCpwSqi7KqJxxvb0Recb51SzIAfbQ47TK8shMxWQAYNr/PyJFyye1bY9huEosvKREuZiCyyCF8bXxjvMzhJxpgN9+7qB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720946; c=relaxed/simple;
	bh=LI4dNTT9wGpTfollw3qCCsiBXLFYwC9vQqgrAyL/7Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OG8eDMp1wCah0qN/QU3F2umXpHfN+klawO5O+16qu4ofNkdS0bxFQH2lmbPqN3oGFMYLhStyX/URaztGshVUeB949GJLOjqwEjmf5pVK0gqbylh/o0Djy58qaXgAYk6IDcU4U4WxkS7DWJThcO8I9eESGWD2FVfSO6emGYFvUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uU4alQi+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3684bea9728so387317f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723720943; x=1724325743; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GNSXB+BHOtiHIjEuls3CrSqYYZnWQhncLaKiL/U4FE=;
        b=uU4alQi+7CeKtQwm+AHR+RGg7j1Gvtwpv0RZsGoxMSbbMNBUwo56Nz1+cSPIoFwrPf
         ZUe9LT1+WI9GL1Zv9HaggcK7wb1a/2gMaDd4SSO7mxGR5PoQvU73DU3YN2rFpDzGYjnz
         bt7P1UO27hyo5t3VsZCPlR5pcu4MdHaccuxWshj0bHBNPx2zTTpFl1R4Gy753p2vvAdf
         9V7++DeNwnNCd/gC4eXFbVtR5BBTZ5u4d2dvqQjbS/q28SDbiguypvmUqxSJCYerpXyb
         wSu+jZy+gCgyb8vN5rwy67OO9XbVpRvGlzZfvfLI4AbwG32+gx86K1dzab+zUP7LIPfU
         V4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720943; x=1724325743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GNSXB+BHOtiHIjEuls3CrSqYYZnWQhncLaKiL/U4FE=;
        b=miuCmw6tbJ0Zqo56Th6JJwbIPgiswdQfhMMn0ZXhCdjjib7fTsPsVwR+h87P1rt2J5
         QhqW2HrOBcNSVjY6T9EI20sng+Xo9viwiAD5VPRMBGpOgtgXkNYYrNEczkjy9WcJRmmp
         uN0G+n2gZ7feO7Q3Ve9z+oMdScu2Mwei2o0zL27W6tHRF3Ud3rfQorA3MUCnYDOKXELR
         qCOufHiVzOJLAeZ1qkyb9HDBkBN/5tmpWzbud9AK3hVdEKg4q2O4YlyHELW5aG/SvUXL
         zPexg/HLJayRE+dWQQa8PGc8vketPHKTuOwrvwg3nUYuXmAaUC9NfyiJRMzAZqJJ5OXw
         s2ng==
X-Gm-Message-State: AOJu0Yx4pzFrPheP7RZOb/ZWJUTxl9xPQ0eP8HD2kjEUiEJd094N1mgx
	lF83mGtLbWYB3TaylNPEEWnveO6AI3WezV0BhEG/a+/QmIzc0m2pH+dUYdUUZuA=
X-Google-Smtp-Source: AGHT+IE4Uqci9UDZZdun7BaZG2hsllG3d1kQDLMQdE+MRfCxp61m9sYCoiKfVoXSJKmp8DMsAINDrg==
X-Received: by 2002:adf:f8c8:0:b0:368:3f60:8725 with SMTP id ffacd0b85a97d-3717780e2famr3554513f8f.39.1723720942697;
        Thu, 15 Aug 2024 04:22:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aaadcsm1241240f8f.98.2024.08.15.04.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:22:22 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:22:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: pressure: bmp280: Add triggered buffer support
Message-ID: <73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vasileios Amoiridis,

Commit 80cd23f43ddc ("iio: pressure: bmp280: Add triggered buffer
support") from Jun 28, 2024 (linux-next), leads to the following (UNPUBLISHED)
Smatch static checker warning:

	drivers/iio/pressure/bmp280-core.c:2206 bmp580_trigger_handler()
	warn: not copying enough bytes for '&data->sensor_data[1]' (4 vs 3 bytes)

drivers/iio/pressure/bmp280-core.c
    2188 static irqreturn_t bmp580_trigger_handler(int irq, void *p)
    2189 {
    2190         struct iio_poll_func *pf = p;
    2191         struct iio_dev *indio_dev = pf->indio_dev;
    2192         struct bmp280_data *data = iio_priv(indio_dev);
    2193         int ret;
    2194 
    2195         guard(mutex)(&data->lock);
    2196 
    2197         /* Burst read data registers */
    2198         ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
    2199                                data->buf, BMP280_BURST_READ_BYTES);
    2200         if (ret) {
    2201                 dev_err(data->dev, "failed to burst read sensor data\n");
    2202                 goto out;
    2203         }
    2204 
    2205         /* Temperature calculations */
--> 2206         memcpy(&data->sensor_data[1], &data->buf[0], 3);
                         ^^^^^^^^^^^^^^^^^^^^                 ^
sensor_data is an s32 type.  We're copying 3 bytes to it.  This can't  be
correct from an endian perspective.

    2207 
    2208         /* Pressure calculations */
    2209         memcpy(&data->sensor_data[0], &data->buf[3], 3);
                        ^^^^^^^^^^^^^^^^^^^^^                 ^
Same

    2210 
    2211         iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
    2212                                            iio_get_time_ns(indio_dev));
    2213 
    2214 out:
    2215         iio_trigger_notify_done(indio_dev->trig);
    2216 
    2217         return IRQ_HANDLED;
    2218 }

regards,
dan carpenter

