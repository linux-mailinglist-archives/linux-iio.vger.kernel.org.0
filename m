Return-Path: <linux-iio+bounces-5136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 072638C961B
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 21:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C208B20FA5
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EB46E614;
	Sun, 19 May 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTrTTAXc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0AB53E02;
	Sun, 19 May 2024 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147484; cv=none; b=SvFmQ/MjXfJ48JTZFuL+rpZZP7nNCQlQtRj4pzokd/WfsZAKQ/4eLJAy0UlbXMIEtN7A2eGfiv9dk+d3BXce8fS+36PEUve1oNV4O6eSpSiOlvIwrS11Hx8dDQ0ebdZNWN5woACam29X+8xvt/ToVhSGrZTq3MnCYx/U511QRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147484; c=relaxed/simple;
	bh=pnvDrWgelAMwAQrYjlbqhDtT80Gw5tnuHUf3yzZM37Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tibd+Qv116eZKEnblx6vEb7w2RJL057LQTjXMdbchpDl/lu42CDTeVHap7K5+yDn/8BD62/scI39Lghq+Uad7sfmtmthGu3xMoraLThEBeliGmQxbjuQE0soHUcnuCltnaFdCQV8tSFJ5Zt2GjhRm3CqE/AQT5OEOze3oCsrDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTrTTAXc; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e576057c56so24249571fa.3;
        Sun, 19 May 2024 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716147481; x=1716752281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zj4jSaDvedvDrxg8jax5CvqISE9uZYMJo6q0wXM5EZ4=;
        b=bTrTTAXckdBBFQZQVYadDvSL+aLbRIK9BBhlf1DcZaSlhtNkFSGPpFvt3bX0Nz3GqP
         duJkLX+04mci2YMyaZnAv4gyD+pkcJJYPtgY2bioIRppERELZiESZEDhvbf6/XkoYsqi
         1nVrqh9hhdes7jw9gjbB/MUK21d8TwKqBbCXqfuDzESYYk0GDOpZA4R1NF4Ku+JKUQHa
         3GDI44qfIiCoz4Idhgp8E9Jq4QEnxHRVzEcnqKBHSsfMuvbEkZcZylqVCa8bCxsCwDAP
         xqP5AHZe9soQbmuPoumrxnQlsdL+/u4/vwJcCpbhLb5/rePOrPBgVpxgeEHDJ4cDASla
         7ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716147481; x=1716752281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj4jSaDvedvDrxg8jax5CvqISE9uZYMJo6q0wXM5EZ4=;
        b=Q9vZXcDYlWWXE98SEmvQHQh+2Xm9CZGsTCSOH8g/Bh+CPCtWuDTC52J5zo2qxGD8sJ
         /OsBHOUbvehevYXs3GCQb1knSFKLOhEotJz4XP0Fj1RamEld7rLJ+GWfpSiQyJlHoPfH
         cIq4Wo8PuAWgTmViOH8BkKpCXQ915OBVfd0yGitEpMKKy43f4eENiBMzH3rWBE+rkCUE
         DHvfBseBg3jm7xezbZnTLBayOYgGegKvlnxo7rL4X6rcqFaT/HP5apZOiou0oKWQqyyH
         iOc7cZpU75I57ciILimQrF0Fqr/Q6ApfXPjwRj66oPqizATeyI9NiEAwcm9R1BxMSf19
         UA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDmyN/Y4uykC1qpPls+EVBwsh1eaI3R0en+sYDZLfGLB+upOKynAUNWbtGcr5WXWFynr9SaqhJ/RWV6O3L4BuzXheCVB9jG1qJJCh/lD21myniYafUu3OkkNv9BRFLVhq3SEjyaRIim9O70Q8ik2q589CRXTnmiJc9cDDlDXHRinHTuw==
X-Gm-Message-State: AOJu0YyECy9uNq4jfflpH8W4XTpBm/NqUCAKTofxnK2FfNNI7CDcs22w
	F/v4mxVTRM1zlbSY+Aj2oJsh7VOHzqFqbgOzbdAgAXPcTyPO1AkfTL/z4tIk
X-Google-Smtp-Source: AGHT+IGYqjNIm3JqZ0Z2qoxVpyr9PEu8aydkNDANKwFcJL1ZmR4sHMRhw+A7phcVLRKFJGd1Zr7Ddw==
X-Received: by 2002:a2e:934c:0:b0:2dc:d7e7:d68f with SMTP id 38308e7fff4ca-2e52039e285mr153395541fa.44.1716147480994;
        Sun, 19 May 2024 12:38:00 -0700 (PDT)
Received: from [192.168.0.105] (c7.campus.utcluj.ro. [193.226.6.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfbd3sm14715714a12.44.2024.05.19.12.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 12:38:00 -0700 (PDT)
Message-ID: <34c21023-441f-44e4-a427-f3e2bb2f5c15@gmail.com>
Date: Sun, 19 May 2024 22:37:58 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] iio: adc: ad7192: Add AD7194 support
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, nuno.sa@analog.com,
 marcelo.schmitt@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com,
 okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
References: <20240514120222.56488-1-alisa.roman@analog.com>
 <20240514120222.56488-7-alisa.roman@analog.com>
 <ZkNijKz0N7PPvmeU@smile.fi.intel.com> <20240519190304.4d93530a@jic23-huawei>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <20240519190304.4d93530a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.2024 21:03, Jonathan Cameron wrote:
> On Tue, 14 May 2024 16:09:32 +0300
> Andy Shevchenko <andy@kernel.org> wrote:
> 
>> On Tue, May 14, 2024 at 03:02:22PM +0300, Alisa-Dariana Roman wrote:
>>> Unlike the other AD719Xs, AD7194 has configurable channels. The user can
>>> dynamically configure them in the devicetree.
>>>
>>> Add sigma_delta_info member to chip_info structure. Since AD7194 is the
>>> only chip that has no channel sequencer, num_slots should remain
>>> undefined.
>>>
>>> Also modify config AD7192 description for better scaling.
>>
>> Some non-critical, mostly style related comments below.
>>
> Tweaked a bit. And applied.  Please check the result in the testing branch
> of iio.git.

Thank you guys for the feedback and for making the adjustments!

+/* 10th bit corresponds to CON18(Pseudo) */
+#define AD7194_CH(p)		(BIT(10) | AD7194_CH_POS(p))
+
I noticed this comment got away in the testing branch.


+static bool ad7194_validate_ain_channel(struct device *dev, u32 ain)
+{
+	return in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR);
+}
And the negation got lost here.

With these little changes, tested on board to make sure, running perfectly!

Kind regards,
Alisa-Dariana Roman.


