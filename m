Return-Path: <linux-iio+bounces-10190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799489918B8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82D51C210C7
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539FE158A13;
	Sat,  5 Oct 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfRYMle0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019C1B960;
	Sat,  5 Oct 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728148379; cv=none; b=NcnKpNJtR0xyJLCVi/Fuif+1XikwaQfET2wJ35VrVwvywFmwfZYNwNRm4hNwxadgSmRtmV340kLCsL6fmSWKvp4XnkqZ9ZbMNn5jxSh1zs1VOVweKDQXjV9ze0bezq+U3fDxaE7vqh1wPf8VKg75MirgWDPFuASE90uN59SKeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728148379; c=relaxed/simple;
	bh=VVfkxSA2+Yz2lB7BsR41E1kh129bmbsLSqB4smV2eLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGTMdS5LIg3om13DyUVTWt5fqX81QSTZHeaMhvYs9IQZ/iqY2eWLPiKbzsZH5DgMnov5eJ3csGMl2Ut5HTUidE79taoYybcm7uojYl0dSdPCaFRC2+QBxv9dLomF8UldVVlyeObOLYt/G/HplfAe83D6gy+gwyUVFr7g5wbB7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfRYMle0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so4209329e87.0;
        Sat, 05 Oct 2024 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728148375; x=1728753175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VVfkxSA2+Yz2lB7BsR41E1kh129bmbsLSqB4smV2eLs=;
        b=BfRYMle04QEcfZKAT3tB6Mj/mCQUYnKjR5Q3auk6w3ypPe1SDqMVO/jmJ4mJInB6R9
         gpysJOwC7/wnkgUqGf5lLy9yJS9Wh1wGK6lXOvNsPiqoo5YoH0kSi0Vmj7Vyl1v6eRDj
         mK+vcqTmiUcUOCKU+GGngaCIoZd88iY1lUV7dfRgW9TwEu0XUFKeah4LHuGGCMwDHdu7
         qxJjf2xY7oqCWDVhkJGCcTS19qiio7B3gxCGaL7qQ3guPXqhh4KKPQ5I88+VckjOrZfX
         If2tBvyr41FF4URexnQQD+KlI0uxbuTZIu3vZPOhG/dLZk5MbNtTmnaZWs1mRk6eREUT
         7bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728148375; x=1728753175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVfkxSA2+Yz2lB7BsR41E1kh129bmbsLSqB4smV2eLs=;
        b=fUWI5RCLUgYQhB15H/+QCu+VvulWKDGhC7xz2t/yZRc6k9KOYEh9bHiveaMYHhcv1Z
         zGBNIq8tLOLfFoVjKyjv0EclpvUsqgm++Fc47GJxkm3/DJcQjjveNcRnX+8vymlPliV7
         25jajJQm6OB8loA/To9tFIapLQReCJRFcoFOZcDfSp0M5skiXKFD0VIYU8qhUB5JOdXM
         6iCnCXxYEilFnbTuktTcOiwjMV7ZhicoNyxjFFuj/Zy3O/2Gf+qLbArASnn6/PzIe0Xq
         zcbncV0JQCWGpioGdqTfCW85ihYhMq1DcYIAVOC477z+kcGZVMw9Lv5RFv+GovFTZ5KB
         rb8A==
X-Forwarded-Encrypted: i=1; AJvYcCUHBVbi0Cd+dsrEUElAW51CFV3lIMdQS+R1EjBvi4Il8W6o4yF5qMqQ7C+PxYpY12c7NaR3Tgye9WIcejA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0j567AiUgvT/K20cXHGjAN22Z72smbZP7wB5KMGFFU3mBEKH
	o4xQvhZMq+mvfPLkQ1wI5TM8sSBKizsRXNdKCgQVuK86wTYk28Z9Y0VWYidT0Kz4tWdCKMf37zi
	zs57C5usGlV31XmVtRyPI9vZCNtg=
X-Google-Smtp-Source: AGHT+IF0GXMyJ4hMSfadju9wcX2sDpdBvi8bztrgf5kHXKAl3MEkJ/UvTrYUxhvewQUco++8oqaNbS/Vudg17VM013A=
X-Received: by 2002:a05:6512:b09:b0:539:9f70:b01d with SMTP id
 2adb3069b0e04-539ab86acedmr3272396e87.26.1728148375267; Sat, 05 Oct 2024
 10:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
 <20241004150148.14033-4-abhashkumarjha123@gmail.com> <20241005175932.00438b0f@jic23-huawei>
In-Reply-To: <20241005175932.00438b0f@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 5 Oct 2024 22:42:43 +0530
Message-ID: <CAG=0RqJNJNg9yydeKfpo87P6sYd5n6Xi0MoLz0OFQrXPgb8cFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: light: vl6180: Add support for Continuous Mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hi Abhash,
>
> Some comments below.
>
Hi Jonathan,
I will do the fixes and send a v3.

I have a question though:
The device has a 8 x 16-bit HW-buffer.
I want to implement the HW buffer support. Where in this driver should
I read the hardware buffer?
How is that exposed to userspace? Is it even exposed?
There is no buffer-full interrupt, It just has the latest 16 range
measurements and
latest 8 ALS measurements.

There is also a SYSTEM_HISTORY_CTRL register, which configures the HW buffer,
like setting which data to capture (ALS/RANGE) as well as turning the
buffer on/off.
Where should all this configuration be done?
Should it be default or have some sysfs attribute associated with it?

Thanks,
Abhash

