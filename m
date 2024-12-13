Return-Path: <linux-iio+bounces-13438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7C9F1997
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 00:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEACE188775E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E41B6CE0;
	Fri, 13 Dec 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GP6dc8ch"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFAA1AC8AE
	for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131252; cv=none; b=eqRUGWyvKP9KkfJqsRGYGOBb6f0oWxPEU7ylwt6wb4Hoo+y1wJTUi3+8VDd2lwGUoUN/bA24g2m5UXJ/DHSH0pH39I97evIHAP0rteZL1xXBGVYCbYBy0ZHxBSeMb72oknulzdX+c1sTCrB+jB5PYsZPYtYs+M8vdnHyg6ZqWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131252; c=relaxed/simple;
	bh=/H+/b/EHC3xNySebTV+Fz3fg+2pc9KxaM+KT7VER1Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zg1VmQzcA5a+mjmF/sEgf6Ayww1E2YgLbdHfzRsNVQSCaJ3njpKIaJ9Dt+1C+FzZxy6PwRLXHcyIOnvx1jJEpmKLebfizxW/jG7P2ED38el1zzA5DaGYOZXYj8tuQlEhXWJBhpYyv7oTrF1CwZKpOKf60J/HW0g6V1ysCo2ZsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GP6dc8ch; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71ded02b779so1141010a34.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 15:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734131248; x=1734736048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jfSZOheq1APLMyQGCWSF76X8xyeOXIl1Dcq65BLO0Rw=;
        b=GP6dc8chqENzHwQmqAVDiPrZ9Q4PQtKorxnT7lv80MQK6jZTAEJpP/4Cg2mOX5yat+
         buqY8DoMaQ5bLPnUwNbkgDusL3ix0on3zaKOLhFyTZvt0lREgRS0j1ArUomMWj7x+/T0
         NIJVVX/lvp9qA1FaisajUuPFYd3CNvq5FFuKbzfgMEBupmhYqddJFXjsTYyAhwLni8CB
         ZA8xSG3nbFjRxMauST+TWvAd+54355QN5wINVUq8k/FvKrPRLUEwItKRYl5h0fhH1KUM
         U8dLLofqGH5mTUJegGHnvjIOTE7qEVWRidvJwt7HnBoMP+V++5dMLIIvhPsMrJM+gGmY
         QSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131248; x=1734736048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfSZOheq1APLMyQGCWSF76X8xyeOXIl1Dcq65BLO0Rw=;
        b=ZtXs66O074sPorzMPgEkVggdJCWWOIKvWpWC7DrrjQIHabSDHU4KWT0TzDr6LqCRWm
         5jH77AyFzgK191831vVd1KuFAXQfNJ4TD1S6c86HG86h3kTPtmnzAcXZ544oYr8Ih/SS
         p45CEaIT9R9qXFPfynWv3W9Grdbizl+9SmM2J6oSRjftUR81dp6sM3cmbxQ3m5lF0x4q
         BmKUakENy0tOimoduUQ9d09gAMbohOs3q6kB6SOkwus36pLIliBHUdhVoN5jNrVvwmww
         XAcNU7ENVdDLpA71kfVHaFYo3UAbI1pVWBzInAex6U8xQvpx/4kdegH2LGZj0btDVGlS
         b8zg==
X-Forwarded-Encrypted: i=1; AJvYcCVSzKqz91aSZqqsIwteTg8QfGpkexxRRLGRZfBrqw6Uw9T3y3tu0meFlA+ZJGq1YjwM9tQYBZt9XPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUe1SZ7TLyYPa5j2JofgfM9S/zQEKuRruV1FZHzjle/O2YFvqa
	JcmRr6Yv7jGSJ2Pzx7YMX5zgaPL+wjVMCGAp9LT9vnX6o1V0/O3ubw0hQs+tBI4=
X-Gm-Gg: ASbGncvF1duXHKRLhTmrvlgaEzH8smP5PbViEUFa/My115vHsonBi0O6Lm4ukRKeSOs
	UMo4krE8CldZRKfBocL9eSw1TQF8I1f5OMhxecGE8f9LOwz0nnFubEpI8O/erZhVmdv2iCocDZ5
	s8rOM5WkFHQNMopVglR0OrpJg8O3KIP6imDyTpmYQOIng8TZtb6ZS9Jt1kkHZyoNyjDXYMHGu4I
	C49uhNllQFnuYg983K22Y0oh0mM4izItkbK7oguJYDMiiGOGcNkfb2Rkv10YEHeq9OpgTDpC5hP
	bwNem/shzZthwC/3Yw==
X-Google-Smtp-Source: AGHT+IF3ggw40plUiQk3aTztRn16+YPItO3Hx5qa5rw//9gVpW2Izyaui5u8Fepbsl9Y6ePB6tTJtw==
X-Received: by 2002:a05:6830:380a:b0:718:a52:e1cc with SMTP id 46e09a7af769-71e3ba3a182mr2891997a34.25.1734131248517;
        Fri, 13 Dec 2024 15:07:28 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48307d7csm138229a34.14.2024.12.13.15.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:07:28 -0800 (PST)
Message-ID: <cfd58a1f-5883-4ca0-8ee5-9204594befa0@baylibre.com>
Date: Fri, 13 Dec 2024 17:07:26 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/8] iio: backend: add API for interface get
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241213164445.23195-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> Add backend support for obtaining the interface type used.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v8.
>  drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
>  include/linux/iio/backend.h        | 11 +++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 20b3b5212da7..c792cd1e24e8 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -636,6 +636,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
>  

FYI, there has been a change that now requires namespaces to be
quoted, so this series needs to be rebased and compiled on the
latest iio/testing branch to make sure we catch those.

Example:

EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");

