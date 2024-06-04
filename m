Return-Path: <linux-iio+bounces-5743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A048FB03E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1969E1F219F6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04311146008;
	Tue,  4 Jun 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBbco7mE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36015145359;
	Tue,  4 Jun 2024 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497847; cv=none; b=UxDulkC2R4qIWDKfxZc5H2LcAxPQG1olJxeD7dQYZPOx3BgARcODjpOmenyPtkYDmx+SYCSIqViILdaA+1k/7sqaAhlHUOxv3iPRBwSxbcXQNnDrv4Ljne3hZbmV6BqbDCZNzzqFyxepyqobjxBx6YiLQjC7GuMKbYlY2993Y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497847; c=relaxed/simple;
	bh=wBV43WOasxU6MkjbVM2dQ7Prcr1D9RwFmDufjLAgqzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGKYgA6eQyPS7cC+yMbHwIYJgfiQQErZQnEK9sc1Xep/5S9z4lrTw0Bkx+Fp5ALg1hW589kSdmIZvpJjEDYpd/LrJ88dbZWhncWxgfSOTmN1J/VOTuwnWmI29BKqUTmTgwUW4IbeRwwudyCpWF9+RUuVJcL4K3VcTTszugiLgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBbco7mE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421140314d5so48960935e9.0;
        Tue, 04 Jun 2024 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717497844; x=1718102644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dNPqmIyypeWatapyJh5rP4jTzLjDYjPT3cK3mzfbQY=;
        b=MBbco7mEP90xEhw7S/zFlOt2Uq8O4c2PlgxTaA5O25dRVDY0lAwf6QvwUzh2jUUMzf
         WGxBqGfmbw8cZEJ4HmvFty0vr+xr1E4EKlNJ3WmK0uAk8TuKLSDtDzhipiHdzoWFCyDk
         iABRfGZN1H/uKcEP7z6QbxT8FiDYSRrwKIQCyZ7DaIAa2sEQm+fMxpte+fDdY403FvM2
         yM888+FyL5b2NYmWdkpNohk6a1EZ/NBITNazbxntsKmJ/eYEBaFhDy/5fBRHiFHej4mw
         coSWkq7DD7JlP2ljieXdu/z1vA/za9f2nIuka1UKoCQHNfG9xBuXz9ynDb6hE7+uNtL3
         rL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717497844; x=1718102644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dNPqmIyypeWatapyJh5rP4jTzLjDYjPT3cK3mzfbQY=;
        b=N7f1eE6fvq1/PozEdagFWKcd8T49SwZ0eXUKKG2/PM+cEM9s2SVMgHDaySu/jA1fOl
         nusdswvY0ECU5Wtz75pDBFn6NCnUnFiRnwU6UZ9Loa5k1uSWxpDwIHZ6V5nDwmPLIAmx
         CMGE7+NzVu9gIo9eVrcjWz31wBxRo2KSfIGYRfl2qx1ZZqZNpy+ReCKWOoAMElJl6lVT
         uG3gXTuTfZyPRcXd5ibRARvVx6wCVcjNGlR6QfGb/WI0XX3+KRnlxy8RK31rADM+UDYN
         HTztgbIvlTr+23YQfQYEQtfN57SCuFHYypcueUbuwuqLDVMovqQpBqJ8qUpjDT8OwVFL
         4ZPw==
X-Forwarded-Encrypted: i=1; AJvYcCUlvweATQu/af1lNKVpXIZP9+HoFqhH39DPUR0S4DcrmhgHblLnIfNvROTcJQ6ZaTBtQcfQeUYWz4uDUutTiSp6WNgndghO5byL0tHXrHz+Xim1ri6iuRSoyYn2cAAr/Ly37wIk/A==
X-Gm-Message-State: AOJu0Yw/oDhD6vnysmBqiLuHAXf4CuMoK9xmNgBZsuxfdaFPHk0uEQxc
	DFZY5KrO3KUFgM1smnPxH62WlLt8onimQEeB0aL7PEqJqhPrnQnn
X-Google-Smtp-Source: AGHT+IH5L+6qgsyNFREciOE7FNfGTQGkoAyxiH0fIGnnwAIl105h77CM9l2e+Sg4KqoVExbrDvcVEA==
X-Received: by 2002:a05:600c:1da1:b0:421:5329:227 with SMTP id 5b1f17b1804b1-421532907a8mr7517205e9.26.1717497844344;
        Tue, 04 Jun 2024 03:44:04 -0700 (PDT)
Received: from [172.16.100.125] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42135511679sm118777425e9.36.2024.06.04.03.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 03:44:03 -0700 (PDT)
Message-ID: <961fa617-a76b-4b79-956b-795a55fec959@gmail.com>
Date: Tue, 4 Jun 2024 11:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add maintainer for ROHM BH1745
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 ivan.orlov0322@gmail.com, jic23@kernel.org, lars@metafoo.de,
 krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
 <20240603162122.165943-3-muditsharma.info@gmail.com>
 <a628db76-a48a-4492-a3cc-f93c0f67ad04@gmail.com>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <a628db76-a48a-4492-a3cc-f93c0f67ad04@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2024 23:37, Javier Carrasco wrote:
> On 03/06/2024 18:21, Mudit Sharma wrote:
>> Add myself as maintainer for ROHM BH1745 colour sensor driver.
>>
>> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
>> ---
>> v1->v2:
>> - No changes
>>
>>   MAINTAINERS | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d6c90161c7bf..945873321fef 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19407,6 +19407,13 @@ S:	Supported
>>   F:	drivers/power/supply/bd99954-charger.c
>>   F:	drivers/power/supply/bd99954-charger.h
>>   
>> +ROHM BH1745 COLOUR SENSOR
>> +M:	Mudit Sharma <muditsharma.info@gmail.com>
>> +L:	linux-iio@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
>> +F:	drivers/iio/light/bh1745.c
>> +
>>   ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
>>   M:	Tomasz Duszynski <tduszyns@gmail.com>
>>   S:	Maintained
> 
> Hi Mudit,
> 
> is there any special reason to have a separate patch for this? The
> addition to MAINTANERS for new drives is usually included in the patch
> that provides the driver itself.
> 
> Best regards,
> Javier Carrasco

Hi Javier,

Adding this in a separate commit was just a pattern I notices with some
other drivers, for instance 3b4e0e9.

If necessary and/or considered good practice, I can squash this in the 
patch that brings in the driver.

Best regards,
Mudit Sharma

