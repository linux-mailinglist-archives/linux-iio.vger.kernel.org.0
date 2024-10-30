Return-Path: <linux-iio+bounces-11600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D249B5F4B
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 10:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCCC1F21DFA
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590561E2313;
	Wed, 30 Oct 2024 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxfDbvDb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4D47F69
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282048; cv=none; b=kwbW4Lbszgqr0akAHZ3wD4hG042dj1B8dB6lot7qKtefV95nD62bS3M7GVneq6eciVjIN3jO7iSPMcF8BNbuZEzrWQCMl8vzbfb8sSOgMEZleHOuCysUfh5svbg58L7CIyLiqWL93ZYQcMLUp0aPpHbyK2SILWMdNz3kqusitc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282048; c=relaxed/simple;
	bh=67leAV1I74j8MgeuAGWlpBe29cBjTj7QjBoM2k6vDOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u2oYP0SK2k9+qjeZ2tgl3kdsyli5V6VdnvdwOmreo3vL4RPVlscCBRWg/4i25eTDAjltcp4wSD6Vqk99ph+x3Zwbq3e7Ib4frM5nfFvPRqhz4nkwgRAzW20gCgjZDwzLFe+j7uTEq7kkkv6tTQrheADVfHsuIK5vpekxVJLhtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxfDbvDb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314f38d274so81947195e9.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730282044; x=1730886844; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CedamvdhSxdU2iybu5pNO5UEx1tTJ5zcKxsOW2Mhv4=;
        b=zxfDbvDb2JvUFCdR6mHus6QS+lObO9gSqzhl0RtUizdgJHkamx5EUd5V5erVUur5Hy
         GTS22fCd8YM/C1thFtbcxEsUZ1/4A636N3tPRNEi9AFvnAc0OJye9VDMHYlMkMwrw4zK
         eIg9rI37sIuGAMvLZlp3tW0rbiFzz9xm/pNCm07luLxqKBuZUnqrXLI1m3Rc0GG0rAiG
         OS2H1s1WKe24LvkZ6dfRJx3qejradOD0JzmerQxI4PldqDmbs2wXg7aqgFqVhNEYIukI
         YQqxuH1rhvyHZZihJyNsvQhehyGKuYrKxjdhKb8HAI8X+tNSi5uMNb6slJOUmi11WRNx
         yvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730282044; x=1730886844;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CedamvdhSxdU2iybu5pNO5UEx1tTJ5zcKxsOW2Mhv4=;
        b=fKF977AmGdswdBGgQ6C22Dp3ZOwdg7HWocNm2NDCl7Kps0aL4m67+ZehCeKZEeWuB6
         /PrXTXlQW8lSBbSBMOxXXwGJBZTZDwlRDOsQMIPCHNGRe2vjKSDQGW0a8tV3Lj/SNiQY
         TJEgTGozqUZEj0JUX7LKIr4enShoT+a4TRVX1qm2GT4tVNlFX4Drkg7Hs7WrZiAF52OG
         1soUNQClc4P1Vi299Q8eEehdN+GVtq1e7N2fr4jww7uukZgwhhenvV99HA7ePfFbQGMd
         TB1CLkJpbzpOQRXYpTtZbDBRYK0MsoVqb+EyynfCmmOjm+bLDfz16hK0hSWz8JVzqDUv
         W50g==
X-Gm-Message-State: AOJu0YwlKQbyFNQjBozAMllasyLe6CkS7BEuZ/jTmDg4Pb3Qjz8bedpt
	hbwe8bIgOq2eVV+h5MA+pkCdSAKK5SDF1V86iKFVC3akLSuN3gaZlr/0tujc27k=
X-Google-Smtp-Source: AGHT+IGQfkQm4tSr6BHjz23DAVT2XaM7B9hQW93jOfG/pLDeknK2VzemRgY8fK6E4uDOJy9JN2T8qA==
X-Received: by 2002:a05:600c:354e:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-4319ac9bc3cmr165269125e9.13.1730282044254;
        Wed, 30 Oct 2024 02:54:04 -0700 (PDT)
Received: from localhost ([41.210.143.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d620sm16232095e9.25.2024.10.30.02.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:54:03 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:53:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: light: isl29018: Replace a variant of
 iio_get_acpi_device_name_and_data()
Message-ID: <54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Andy Shevchenko,

Commit 14686836fb69 ("iio: light: isl29018: Replace a variant of
iio_get_acpi_device_name_and_data()") from Oct 24, 2024 (linux-next),
leads to the following Smatch static checker warning:

    drivers/iio/light/isl29018.c:724 isl29018_probe() error: uninitialized symbol 'ddata'.
    drivers/iio/light/ltr501.c:1514 ltr501_probe() error: uninitialized symbol 'ddata'.

drivers/iio/light/isl29018.c
    701 static int isl29018_probe(struct i2c_client *client)
    702 {
    703         const struct i2c_device_id *id = i2c_client_get_device_id(client);
    704         struct isl29018_chip *chip;
    705         struct iio_dev *indio_dev;
    706         const void *ddata;
    707         const char *name;
    708         int dev_id;
    709         int err;
    710 
    711         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
    712         if (!indio_dev)
    713                 return -ENOMEM;
    714 
    715         chip = iio_priv(indio_dev);
    716 
    717         i2c_set_clientdata(client, indio_dev);
    718 
    719         if (id) {
    720                 name = id->name;
    721                 dev_id = id->driver_data;
    722         } else {
    723                 name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
--> 724                 dev_id = (intptr_t)ddata;

How do we know that iio_get_acpi_device_name_and_data() will succeed?

    725         }
    726 
    727         mutex_init(&chip->lock);
    728 
    729         chip->type = dev_id;

regards,
dan carpenter

