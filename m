Return-Path: <linux-iio+bounces-10222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00D991D1E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 10:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EB21C2163D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AEC16DC3C;
	Sun,  6 Oct 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU3MPzKE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD081537CE;
	Sun,  6 Oct 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728202456; cv=none; b=fuxNcMtbnBcVNAeL2cpd7dDCL7NKAcs0LmsKSWsK3N1PwkUdNfzN+8Yo4bwH9rmMXNfBpbpOX75E6D38cYhO9tzRiDdPCyHPqaXD7fqwQHIddpYHX0iZE7Uffj1u9Ml4RUa/jUwWHI3YfkjKn3e1/FXAsEd1DNAiAZW5Jk/ejew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728202456; c=relaxed/simple;
	bh=47GPyPJ2OLT87E7JnkqZgK15FwzPw0pI261j1vX70KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaBMvNr463B4x6MEbgV+EGMFk+8YKS0nOe+oxH46RD+Q0IN+rIqXuteNetB6VHiRDXNqTvMB0FU7Me9lHiSxXeAqkr/LuqRucRcFkTqGYG1S+4hyn9z+G/h9QrXNuas+RnWCQfaKMCLE5jnUnjocUpu4AtLjFLEjOSlCVhqOIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU3MPzKE; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso34113511fa.0;
        Sun, 06 Oct 2024 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728202453; x=1728807253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfdLMk7SeOxjPc0PTFW5Uu8seb41Jd5Pm+0rGb9Zp4U=;
        b=iU3MPzKEceHnbYSXRUvqfKXNCrydzTCv7qAnH8ixS1eHihj5jqG2U4dFTxthnddZCy
         rbHphYk1A6Fxi4+ch4FJi9B7tf5gTWXOb5DSsrCn77GjKcNjqiWIxJ5CcsNwr/gUMJgT
         NGwOuKWNPc0OmfVO7m0wYqgKGzeCnIuraPM2wxVSXO0sBUTgdXNl9B2WA/qli1rbvx9W
         KuauA1dFU+nDtjry8aQvuofSSEy/cyEYdP+VT2Edq5Gq08ke1B9ewt1LZiUTdncrVvuA
         XJWWSYYUCPk/20PluRYtI1iOE7DRU0qoVERzNKxCD/rpJOJ09hlGFjaDrSdYSoR7zKhF
         fJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728202453; x=1728807253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfdLMk7SeOxjPc0PTFW5Uu8seb41Jd5Pm+0rGb9Zp4U=;
        b=SqBdfQyomFuexdV9KV6G8FZybPaZvcg5gNrKvwjWhXWLYhClLYbT4coaDNFYXVBeBg
         VxJf2CJj05J+xeW+ANcH5lOt8807weYcdUOZzoHtRPfUPufKAC1WhytIm4R0c8HqEXPK
         GGREqoc/w5vI3slsMfLQyeZMfFs2ui08Upp4t11r0KrsG9UMUr++0dzd+3LsWh2uezIG
         eUuBUHLdy1Bzaj08m9jY1F2dOaoDW2m/XRwHCcu1srml4SMAcxmz7j6NJbWz3WELHe3i
         leekdwJknzucEMu5PfAzEHNrvPxTgsvBUFWsh0FlHJdn2Vfx0298Eh4ihEOjFK2RAB6T
         KLZw==
X-Forwarded-Encrypted: i=1; AJvYcCUIJ1sGxl5Vu/qEUyA1NhfvGoI6NGK12lChcXemjVf2vGA4xJhg6fa6LlrHHiT0kYctWH2+Vt9JDxs=@vger.kernel.org, AJvYcCVVqG8McbL8czqBLE5MYAnXQ604jDhSECPa8mGbRa5iM/ZadZ8bI0my/uZUyeDTtSn+VBRjkCGiGj5IanE1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32j6alWYOgFUlrukX8pYehK/a8zZxTKBW3uR5eXHiLnHoehxg
	OQYBCcA8L23jtmo2WaIkZ4FpATOCmqiPyeJI/2nNaJhPegn5uyhW
X-Google-Smtp-Source: AGHT+IHC15DBnXYol1OlUWy9+YUtrksdB2OhUxqAbrkfCq8drhXVofdvLizFEubXYtOe0IoOv7En9w==
X-Received: by 2002:a2e:6112:0:b0:2fa:c83e:e882 with SMTP id 38308e7fff4ca-2faf3d71b0emr26673011fa.39.1728202452496;
        Sun, 06 Oct 2024 01:14:12 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ac4415sm4818871fa.34.2024.10.06.01.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 01:14:10 -0700 (PDT)
Message-ID: <bf34fd7a-d929-479a-9dea-f6f2ccb67aeb@gmail.com>
Date: Sun, 6 Oct 2024 14:13:29 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] iio: pressure: bu1390: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mihail Chindris <mihail.chindris@analog.com>,
 Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>,
 Andreas Klinger <ak@it-klinger.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-12-67c0385197cd@gmail.com>
 <20241005190147.084dd468@jic23-huawei>
 <2199263c-13e5-49b7-bc5f-1fe367c460bd@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <2199263c-13e5-49b7-bc5f-1fe367c460bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2024 21:12, Javier Carrasco wrote:
> On 05/10/2024 20:01, Jonathan Cameron wrote:
>> On Thu, 03 Oct 2024 23:04:58 +0200
>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>>
>>> This driver makes use of triggered buffers, but does not select the
>>> required modules.
>>>
>>> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
>>>
>>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
>> Seems unlikely in the bm1390 driver. Huh. It is accurate, but I'll fix the
>> patch description to refer to the bm1390 which seems to be the right
>> name and add a note on this as it looks suspect otherwise.
>>
> Yes, it seems that there was a typo in the title of the patch that added
> the driver (The "Fixes:" is therefore right as it is), and I propagated
> it in the title of this patch as well. But you are right, the driver's
> name is indeed bm1390.

Yep. I typoed the original patch. The correct sensor model is 
BM1390GLV-Z. I got things mixed up in my head as I was simultaneously 
writing drivers the BU270xx light sensors, a BD71851 power management IC 
and BU18xxxx video serializer and deserializer. All the B?<bunch of 
numbers> part IDs got better of me :)

Yours,
	-- Matti

