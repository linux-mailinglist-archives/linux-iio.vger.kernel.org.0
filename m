Return-Path: <linux-iio+bounces-25347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86301BFCCC3
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB2188BD98
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FBC34C155;
	Wed, 22 Oct 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WILyl/bn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA634844D
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146044; cv=none; b=PUasVsaRTu5+QDifWnpGIzn2sHS24+5BErtPuSF3A/xulFfL3vXzJefEYxy6w+ujlkV4+Co+b0Bj2cKCXeO6rr5YsR/kdg3MIIbIsymNdlhpLX75WSvO89jRMQb3RuuHthjuXlZoMgxvkUlZMNVVSg1pHXQPRaqu8v2/oOF/1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146044; c=relaxed/simple;
	bh=bJkRf2vDW66xzETEmduK5o/Wmh8MgCortzpmg5JEPoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJDI5Q7gMuO/h3SVBqCbnPaV6dgGs0TZnOeheECKMGZmdctGZdt851HkEvgHn5z8BjT8/4trxZQ8YyaWtTtd3NmoAEXRlz+a1Y+lX7gr/lVKT0y9cLUhCbVbvSnMJeS3tEzFm/LcwQFAM6Gha1uR1ptmZ0CUgB/NR7A6sQEwev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WILyl/bn; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-445c6e9e0aaso2041912b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761146041; x=1761750841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M06GA4DzU6q4HcL9w50fg3W9nzfX6SVpmQDyjsPEDxA=;
        b=WILyl/bno9iHRovIoGuzt1qOrfFXuCFLtYkN9W1HXfo7iMfQKCh9aUdvScBILF1qN1
         qHEYWcyq5pcPdEtGuOSOaYcnBgcwXY9Q1HGMND12oMlaqdiHO97g+j0Paq58AwT8kg8c
         qXbMVqEt8VglL7upyQgN7NvkdAp6cgcHk4omYQqARv64nl3ppKZXCmJK2uCUUa3zAtGv
         LyS6QxCZswpi4NRMdRk5Y2ATzVfWtnucCnkuvTQP8xLKaf5Cm9xyCGc2lba/XKF6E0qA
         CcZJk6CxbPV4/2bB56L4AL1qmsoYLvUa6mZrropBBTMZUzL8dOi+mybq/UdOHiiW1ptL
         l0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146041; x=1761750841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M06GA4DzU6q4HcL9w50fg3W9nzfX6SVpmQDyjsPEDxA=;
        b=YCshwDhLa3V+zKsOmKeQXxaVXsnYns8N//nvEPIkqj2ForDJcsqc+zH8qjQsobY+DP
         0sg9emlK6qnpNyflFmaIR49y6cLyCaxZ1+GhX1PhOXsrxMy78Ipt4le2SiJnJA08Z0Tm
         jucfrBPO5qdofhu5w7Zhn/q9a5plO4e2YnRQnn7FOdSFqdB+Ri54s6s0C5RRwWALQ0Qa
         xPZFN3TbAn9lrqRto15c8Ll5T9PDNuUivcrFEjT422ntyOK65D+NdD9JFf9QEFl3K1MK
         qxed69KqGzmWx2ErcQyZNf/wxxNRSjHSdaVirb24uMVbB8bGb0BUIbdt8QDYTwp8eYc2
         2gAw==
X-Forwarded-Encrypted: i=1; AJvYcCXwQxGIZW58Ur0PhdyCtlmZ5FF3wFIHL4gCLgZPasTSGHl0htYCoBNR8zUh9GiGG3DW9EpgvvzW58k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdbu9mRsi3wjNkC8hI9N2DDxKf7KZSlREX1FCS4VnE0kynOTC5
	7qD4SHMQnsOywSgUyKJ1BYmNLm4ZuK26Y5MuHbc9I7AsBiDGgvHABofwo5SWdj15HUA=
X-Gm-Gg: ASbGncvcT1U/YkTOIPvVulpzQ3E0OBvQjkU+lDdiM5jcAPTJJW08zGYhC8T61aStazK
	Kd9gkivQ/+RJf/4NkL6/z5gnJpsgZWCeR45KdUz7zC252Vh4Lhws9epn+Nb3ZQXXHFrhwooHJ6F
	34NJwu4dwx5FTKqonR6PwFaok3flqBhafB8Mepqzm5AccKqcSu8LOu53Lx/YBiibXwTcpFvmlKh
	U8FYZ1LoiLKbPsCdSl+DAS6fBO2AlJ0mp3GK4lINDWo301kPDjwNQ9SRFT9ymz8iZcIqbGhHRgy
	/853t13nFo+XPZxHBs5sL/OjppnjzfyIkS0PwJ0aDmAjXHZVF7fJ5EetqlAhqOqUmmp1VZnBxLQ
	ULbSXPIG3mo53OWth/wh5MHTnQTz3UmS4r+ZFbC7P8F7Uj1aNw1pess2ZOyj6jcs9rHTGQarnWt
	xzKYNyLUxG0iLoKSyB2ihfZVRCQLuL6kCoUcMjDNsHmMqif29lIA==
X-Google-Smtp-Source: AGHT+IH5X1dX+eTbtzPr1DK1hodPbkihzSGYwZP+aVpU3q50pmX97szy9HuXtGku72DLkLr+jPiOWQ==
X-Received: by 2002:a05:6808:2112:b0:43f:1b7d:b631 with SMTP id 5614622812f47-443a30af9femr9009191b6e.35.1761146040880;
        Wed, 22 Oct 2025 08:14:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4176:6994:bd72:1296? ([2600:8803:e7e4:500:4176:6994:bd72:1296])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df628a35sm3311240b6e.22.2025.10.22.08.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:14:00 -0700 (PDT)
Message-ID: <cf276696-2928-4ddd-9750-db84466e4599@baylibre.com>
Date: Wed, 22 Oct 2025 10:13:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] iio: imu: inv_icm45600: Add a missing return
 statement in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aPi5vEp75jH0imQc@stanley.mountain>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aPi5vEp75jH0imQc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 6:02 AM, Dan Carpenter wrote:
> The intention here was clearly to return -ENODEV but the return statement
> was missing.  It would result in an off by one read in i3c_chip_info[] on
> the next line.  Add the return statement.
> 
> Fixes: 1bef24e9007e ("iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


