Return-Path: <linux-iio+bounces-11599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD169B5ED6
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 10:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0DE2840B1
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FEB1E2017;
	Wed, 30 Oct 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGXUtsIc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B11E1C2F
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280386; cv=none; b=icgDXMjGlSpLEpg7Z+bHYaAYXcC42ZUm3OFXBFIKR/tCmUWeOI1BzS+AZopgpR9ZXvXOHaaBkJUCUp44IuZxI8M/kG+WgHc+xM4gq9jaZZebKt+Y74tAxt98tl3nyeqgxLLzu2f6v+EaoH6F+yQo9FMhyVa4UXaCHIAYseQM8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280386; c=relaxed/simple;
	bh=DTYefueHEnyXzuaHeIAgssX80hJhE0vqTRwPxfHzWJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YW0TmJlnlCS6VGJYh6aqFotzTTDJ0qDmyJkhszESNpuEHhqkqVeCTPWhFzJRCAGgLgnu2lbo78gFwom2yN3gdfPFfTa6hhdsDL/s+5CvNxEpIxcojRZatoe6Zd/VQSL7oPDSIiBZoazmSuWiW/JbxDNvP99bBls2ScQoMQZm4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGXUtsIc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so5226197f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730280382; x=1730885182; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHRFmTjg4zti63TlEyf/WSLKZEbQh43/RraQ/OO7bDE=;
        b=GGXUtsIc4nQoh8eZLDw+7xZwqhs6Gi4OosLN+BntEmcUWkIertFtBON+1t6jb5WkP4
         cKK/BE5uYCavcGabtGKl9GzIoS3rKsK1Nh0mCnPU7hPb8NbmBv6vVoOgyUDuxHlHAaHE
         CXSo42ma2URasgbG+Nxh5wC8qXNpjyFydSHJlpkTDN23t8oQPF6met89j5uerm/b8Y2f
         BcQfbipBj/dHRbBleMWn+/FX5SUWRvyvXXU31a5PDUSqFYcDR9pQGYHAvjysfDhrZwai
         BdLX4AheAhECNZwrwhPMRBZRZa8n5j6ev6/3nWKucgvnlIEezSfwElx7pw5yj0HX58ct
         6KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730280382; x=1730885182;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHRFmTjg4zti63TlEyf/WSLKZEbQh43/RraQ/OO7bDE=;
        b=Hsw2A5xM3GbjmlptfYlLN84FFf6XJmtwTLaQ5vAJaobuXy4WrJpRl0HlsaC+6rY9Hi
         QpLI9xSA4od2GTnL8KTrtU0v78D2dic43mMJaMqMSWFehFK1JIQmG91QYt0xStrLLVZx
         z/scbTOVXW9MKnRbpwNbw1ENoNVzlMdB+BbkfUbRq4Yyrr4vZCPSbaOWvbM5loq9ESAy
         3syLYluO2QyKnbQieHwvYx3lU306tUucip3V6xsXFLmOrauvB2ArOxP8JJRPYF5gHyPc
         1Udv7TUkVIi6vhPa+U3SgSagh+sJYp6vyVWzyyhFIHJsxG/ystLHBoQ/IyX5oGbDvrrv
         5arw==
X-Gm-Message-State: AOJu0YyEw3eKCJ0wPeug/C4EqFvBRSxn+jCPie8KcUxEvARhqto6exbB
	Hdb78K1K8LPiK405GPPsUgZb+cH6cjZKY7qx6QJepMuG2pf8cxXgHQouYLnCxlc=
X-Google-Smtp-Source: AGHT+IGvAOpC+O8Vl3WA/q+L/hNE/hJwMH+Zx1keane7VMqW+ocqBaQwM7kCsh5LA0OWdXJMudb76g==
X-Received: by 2002:adf:fb06:0:b0:37d:4eeb:7366 with SMTP id ffacd0b85a97d-3806114195cmr13546934f8f.4.1730280382404;
        Wed, 30 Oct 2024 02:26:22 -0700 (PDT)
Received: from localhost ([41.210.143.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm14968368f8f.70.2024.10.30.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:26:21 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:26:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: chemical: bme680: generalize read_*() functions
Message-ID: <13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vasileios Amoiridis,

Commit 9b4071ab8cbe ("iio: chemical: bme680: generalize read_*()
functions") from Oct 21, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/iio/chemical/bme680_core.c:760 bme680_read_raw()
	warn: passing casted pointer '&chan_val' to 'bme680_read_temp()' 32 vs 16.

drivers/iio/chemical/bme680_core.c
    738 static int bme680_read_raw(struct iio_dev *indio_dev,
    739                            struct iio_chan_spec const *chan,
    740                            int *val, int *val2, long mask)
    741 {
    742         struct bme680_data *data = iio_priv(indio_dev);
    743         int chan_val, ret;
    744 
    745         guard(mutex)(&data->lock);
    746 
    747         /* set forced mode to trigger measurement */
    748         ret = bme680_set_mode(data, true);
    749         if (ret < 0)
    750                 return ret;
    751 
    752         ret = bme680_wait_for_eoc(data);
    753         if (ret)
    754                 return ret;
    755 
    756         switch (mask) {
    757         case IIO_CHAN_INFO_PROCESSED:
    758                 switch (chan->type) {
    759                 case IIO_TEMP:
--> 760                         ret = bme680_read_temp(data, (s16 *)&chan_val);

The bme680_read_temp() function takes an s16 pointer but we're passing a s32.
This will not work on big endian systems and even on little endian systems, we
haven't initialized the last 16 bits of chan_val so it's an uninitialized
variable bug.

    761                         if (ret)
    762                                 return ret;
    763 
    764                         *val = chan_val * 10;
    765                         return IIO_VAL_INT;

regards,
dan carpenter

