Return-Path: <linux-iio+bounces-13865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353E9FE77F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5436716278C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1413AA3E;
	Mon, 30 Dec 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DSE5ktjB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E089195
	for <linux-iio@vger.kernel.org>; Mon, 30 Dec 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571726; cv=none; b=pE68/3obF+Dh72z4QAyj5lC5Je+lHQcaK5rqlezTfN2TZlR1i8pfQOU8UeyUe+nJES9KoztbSr3UcgRI3LlVF96KXjbRxSWJdVIJMkumjORH2kvk4UhsgkUQ8/C/+VT+QPB9myaRvGxzOfoqMNneWqdirogWncEBXKY+AV2RbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571726; c=relaxed/simple;
	bh=Dtt1HFRu485h2p4tsjVx1Ldv2xRC0d7xhflmzxIVMRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oK1R1wIX3P6S+K1nJBhHiIBuUmOI97yk5Qtaj38qLPI0o8MEqWhQlcHDZuXL8nRwipzqgBghIsCPbwqs9cWa5Dstyl/K8q8KBeuAXs3ATV1roQv3n5hiBmFIqnTigff3WFClFm6SiwUPvngfXvn2shZEahGdhuqS9X0Nq+PEPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DSE5ktjB; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dcf63155b0so41278996d6.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Dec 2024 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1735571723; x=1736176523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dtt1HFRu485h2p4tsjVx1Ldv2xRC0d7xhflmzxIVMRM=;
        b=DSE5ktjB7jen9oURvIQ8GK3XY/mI5gQrWJCNHh6Lw7wODMLbfU213MDOL7PlvzwnNA
         Bv48axx6j+4qq1CCkrbekJOt1dCmsobPUUWP/KW1rSa+AUuiJ7WLiLhVqGGNnQWyD0oK
         0xzq0Txp1NNBgFT2+Oe5/6BjRKmpr5AXnulhiRXVDUlsRZQ/P/QQKYb1JHIqKkHCRuVe
         Al/rawS0DSp5Zmjkafk/IuISbp14ccAB4i+eJYjP+cNBpGsO5PjhNppPB+DnjseBvORH
         ziaGb6RB/TpG4DZXwZwHB3lAPFbzlTZp3lpo3k1l3tHTWQcrAUC2Mm+Qf4TSdcIJYbTM
         i5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571723; x=1736176523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dtt1HFRu485h2p4tsjVx1Ldv2xRC0d7xhflmzxIVMRM=;
        b=hI6K0mYwCicDWygpFCIJykdUyXEHYJN26JhW02Pk+H95bYm04HoxsoX8qYUQCTMYTd
         UJF13QffD9upPGqaMCfD28rrIWaqVf08m2vOvMkFvonY+EXz9Fq2sGQb5pIhFC9HeIfa
         xnYP+PrYTIjqfN084+6HqjIi+Lmv5I2pOHkWc5rR7Bu3sKhi6xTyRMk7UFIigjcO+T2L
         mXnWJMo+gUydX3pvcQ6xwhn+134j21usA2ojkrLFW3SzcVytCBMpxwutFvKMAumJb6Ov
         9xFYW2Xm2lO56LFowTwYvi3KbnuK71ei1i2SCqImHUX7qwTB7K+k9UOYjPCuQTzG24yb
         uzfg==
X-Gm-Message-State: AOJu0YyuH+WcdgIsOItBKm6LtnWKWFpKZwZak+m+HFu0G+MiLE0/geIL
	wY+MFJrUKL+A4BnFd+c3isfIHOZuYytGzO2fCG5dVDySh4RhYKHjv6kg0Sszrtc=
X-Gm-Gg: ASbGncuVAVMt5oUtuHgxKGDC//+0bEvTNKfL60Gut7vjAkQQiNjq78llAr72buTm34v
	rTrCr/aP0c2On8sE9fRYELjSdzhaFYkv/wBS4wO/6BqFXsSS0YYhwwcXheU1NuQj/k4j0Eg3jxh
	w32Z7Gzglvce/0gor1a/CxVLjLYJvmAz2AtunMzKAqHbGBdKD82b222cnsK8R9OtBYJeh4YvGc+
	Vsr1iXFN1aNoWZdJ6aKuyI4xWuirJaMbk87qirVczY3SzPqlGFbOFruZRzYlmRt6n0fPW4DY8XW
	A8sIItaoovDgxCYJTxACUq6n
X-Google-Smtp-Source: AGHT+IGO4XK7j28wDmBsFZPNXub4P6Rh/M6SawzJvHLoLCHvvrw53ZiL8cb4RxKgH5XJRtHGhXggVw==
X-Received: by 2002:a05:6214:1948:b0:6d4:2910:7f12 with SMTP id 6a1803df08f44-6dd233aea9emr631535736d6.41.1735571723375;
        Mon, 30 Dec 2024 07:15:23 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810d5d5sm103665546d6.43.2024.12.30.07.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 07:15:22 -0800 (PST)
Message-ID: <bbdd02f0-e40a-4ff1-bc7f-10f6b863d2ba@baylibre.com>
Date: Mon, 30 Dec 2024 10:15:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7625: Add ending newlines to error messages
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
References: <20241230151030.3207529-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241230151030.3207529-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-12-30 10:10, Uwe Kleine-König wrote:
> Error messages passed to dev_err_probe() are supposed to end in "\n".
> Fix accordingly.
>
> Fixes: b7ffd0fa65e9 ("iio: adc: ad7625: add driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>

