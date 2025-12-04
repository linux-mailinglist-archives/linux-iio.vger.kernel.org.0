Return-Path: <linux-iio+bounces-26759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF11CA4D12
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF339301BA81
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EBE34B1A3;
	Thu,  4 Dec 2025 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7ePMD/Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B634B190
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869743; cv=none; b=fanBhsaen1LAVmRhcWyY+Np4zGtg7/OfIwiG3T9GcLidhR+QeyCUWJBwQKWWxDw3n1jHcJxjrFTGpYCx3+kKff/YCb4yHUk4RQZLaqSoe21rM8ksLIkak52UZAukE5pUwYPi2KfY3934U4IxmuTXWL2W7on/ksWj1aHRkGm6QLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869743; c=relaxed/simple;
	bh=6R56nSeR32U6rOCR4CVmw0k/TDzh/HkC9g9vHuA++6M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nPyzO81+0TomirRdqnroaqHljk7Zh4ya6Ld/m4KpnlajLn+7hmCOY688DSGRJn7QUPPo9ZHSArQjOsgovOL35Zls6yJbC83N97vpMfSm2LqQI+V3NYYxJ3h9JHlbyCRFqW9lwgO3V5dk83fBzoeNP4hMTsP1jKlm0nBLPPD0Z1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7ePMD/Z; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5599688d574so391871e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764869741; x=1765474541; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R56nSeR32U6rOCR4CVmw0k/TDzh/HkC9g9vHuA++6M=;
        b=H7ePMD/ZeipTUrP3TPbLIQDqH2r7U6hArpWmYyyJNayXXu03NC/D2wqz9xZpsobXkd
         ps1/FRf04aF3vCDqDftibuOewp9EDNa0w4gjw+A27aenmji5Z5JSwMOCgFReyo3CA+Ck
         7PpYQHVo4PXyoSXw/zlWSDyScqTsXyJrN25xVj9sbwoSLObHAtC2E0btXwJNfxHCDJw2
         EGpCxxDncwUrWVVXvfgNosEQw0pj0c+unjYqdc8B4stkCOVxEYuu5X/xe2z3JQNmDVW/
         t1wbyXgUfWOXefyQ87gJu3ieXsetxu22+YBxzHSKTTQeKw3v1nJ9FBd7YtDYAHCUGOvu
         wPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869741; x=1765474541;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6R56nSeR32U6rOCR4CVmw0k/TDzh/HkC9g9vHuA++6M=;
        b=k0/I+CjdSSh+KsKI3bIGOhzUriKBOYwEoRGHImXIEkmtuo33FQA5swUxhBAU7lfK5f
         FzINvgD8/o4VtdMtZClww8Utk5NmSvJlBF3iKL+sJBKezm7v8XfeOM/GxdYv8uYdvE3V
         r6Cj2CHhF0DMWaG55wHTYlEXbLSbB62zX4ZhWXocHB/Ecxoer8LZBPYOcjJa2FVbED/S
         fgz6HTN6YMBUvydBjLeXvwR6qerjc5knSCPG9ZqWQSj4HUsWNDJBI3MCJeKpa+gWK6TV
         zHceZf/rvEwx5gy24NU0+q8Dr9VzyejE7mcoK/s4PEXnTrQ+cOd8BKonKiU/ZRAlKD+q
         09Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX1NsPOm4ppCjcwrDRMveYhYxbMOOv4lv3zTCrXAyeOp91K0sCeO0RRLA1Gxl/SOEQaaqkfUrVGPRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLHhzPe8DET8yH+EvuXBsMQedat32Oj9dMniA+QdKgjqLjSP1
	I9uh8g8O6CyyGJROIB26Pt7Ky1T/VkqGLg2vdzXXJGCyy5krCdBPQLqo
X-Gm-Gg: ASbGnctr8RocI7QcU6CVjQ7vzz73ikxrwEGswsIt2W9Gmo0bNC9EIm8vK2Bj8AxkmL8
	o+tvhQH8oCf4HZw3cZFtjp52rZH2Z+8wb8171l+kIi4xHTynu7iywSbuugu/xjK25VO/RJ6YuKu
	S6+bA1b4OflodU64AJWvvovA/hHyFxPG6xpKGEgqIBPFxLf1eUdlPxlJgq2TH9R0Lrk3pQRyYjq
	BCbJ+Sj5xmIoVNZaTOWgZpvcQeVLIQmpaU+mY74C5kGMi18Sw8JAwi3eVUAE5WTFUADeMxxYmZ8
	0mZ+ODrnhl9xmDuQL9CcOkdsUdkqJDKf8b/0KDIPOR5H+FonmHysiE1btZ2uJWYWTZS0c5SRB0x
	vL5Ep5kJRCrMfEVKekWu7ZC8WKb4k7D1+k6VdmN0pw9oCoRf2JJDhqe2S2Gdr/dg/bgb5PgYlt0
	pDByUM37AUe1klm7AX
X-Google-Smtp-Source: AGHT+IGwtANy/661crb/1sN/81i88XnN3TTdGswi0hzsnAwJI2k0rXUkbUlonsTOlnKceWWaxsvU4Q==
X-Received: by 2002:a05:6122:318b:b0:55b:305b:4e3b with SMTP id 71dfb90a1353d-55e5c03d909mr2486205e0c.17.1764869740700;
        Thu, 04 Dec 2025 09:35:40 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c567571sm929666e0c.4.2025.12.04.09.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:35:38 -0500
Message-Id: <DEPM3WWMT76K.P5E00DKJ73UO@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 2/6] iio: core: Match iio_device_claim_*() naming
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-2-b4a1fd639423@gmail.com>
 <40cd9574-ac26-45c9-91a4-b08ad799ca99@baylibre.com>
In-Reply-To: <40cd9574-ac26-45c9-91a4-b08ad799ca99@baylibre.com>

On Wed Dec 3, 2025 at 4:50 PM -05, David Lechner wrote:
> On 12/3/25 1:18 PM, Kurt Borja wrote:
>> Rename iio_device_claim_buffer_mode() -> iio_device_claim_buffer() to
>> match iio_device_claim_direct().
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
> If we decide to do this, I would squash this with the previous patch
> to make a clean break of it. Although it is helpful to have "mode"
> in the name if we can keep that without breaking things.

Agree, but If rename iio_device_claim_direct() that would be too big and
I think it should be separate patches.


--=20
 ~ Kurt


