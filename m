Return-Path: <linux-iio+bounces-9930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD198A694
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7C1F23D0D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B918FDCE;
	Mon, 30 Sep 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SADRd6c9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6B190052;
	Mon, 30 Sep 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705089; cv=none; b=BGJ0ej0rCPgDc9/bmoImshtWo9C6H04qTqjPWFgtERXaqh+1zmjoLgwxPD8jdZp9QTZdti2httBOymFlX67YxHrXG4MS1uRzG45b7GbDbD22HUWCp1tRfFjmZTqR3rpGBFgQWh68zYvfpzNMM+C05ayG14U5MEljfSkx+t6qzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705089; c=relaxed/simple;
	bh=vFJT6H6IOZsJq7j7fkZqTGiiLfg08rFfqR6ay/1SXKo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=aZUs1MpaJkQ0LAFhu6LDvvE7rduidQc3z4w29vw6OddVEu9zYA7+IXa78+SiePkfVQ2ekQ874V3yVTLYUBeUHJRjmeXN4lN3OK3aCHh4YyRuAT+Vsep9KM15LF7Oh4r8GxcCJFpuLW80z41Ow8Dx2YWrUmfaH/EtYY+0RtqY0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SADRd6c9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so5345740a12.1;
        Mon, 30 Sep 2024 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727705085; x=1728309885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rEUa3qFDTvH4HThzgtl8aN7HMQnTXIOhHNcD6ZDluU=;
        b=SADRd6c9Ioh7+Qb+aYU5BCJqQeWVVSnoMGXArhNAJS/d2emAEyLzBOVLZ7E75AVRjV
         zCFVjivxcXR8ZX4jExvDrovfvccrfSiCdNG2cIgWApJflUKMykmRXehXcoxaIIoJeUHD
         b+jo7kZj6ZvXzY6u0Vw+DxrVOetvRX08TzmhCu81XAokYbu33iTVOGrRZrYdm3cHLBAK
         cXao/GmGxUhtnNxEIaHJqrCce98ndWnf9WbqKSvff8OuuupY0KrxuxhFXrRfIz6V56s6
         r9+2bvnKMnBM6oa5r8zfOIAfvgdwGXqjSmkw427+9koO1aBA5R6u48XQOv/Dxw7PihgD
         P/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727705085; x=1728309885;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rEUa3qFDTvH4HThzgtl8aN7HMQnTXIOhHNcD6ZDluU=;
        b=Z+v5kWLrQIiGCIu2/Z8iTJ9Z3v/UlZMbpN0QSxAgmDdX6u08USBCRwPT8DuQGOe1Cd
         Pa0ou8l4PteGDq87pCEl1GwODB62SZM+AV8yEzJ5YvFpRdl5UTlm6e+xAPsv5KEROL22
         ik2a3CC1ZZqdILdorPtzddZwoRFHGkiVWbWrG7AiOlLkSgiPzkNFnZyi8Z1OKYv/Lkap
         fyV7yf4vOzQKGl45LONgSTVK5eVvPM/hJ/tlp2nqw1OooNoiOeUx98/ykDFvw501IoAy
         HVC++4CvO0zhlNo3xATdvmaa1NjstNjyvGE8wnsV1umrhzV+DTraWvHzqvzXws5bMQKP
         8+8A==
X-Forwarded-Encrypted: i=1; AJvYcCUFVsSqmI7ZtSmZ4W3rzGE1/OLnVoZbL36MWS2BfypEcg1n40pUX4lgBGnSYwqRKpcnwiDaqeVfzuqffN9l@vger.kernel.org, AJvYcCX652WEWzuL1wkK34h51IBdflqe8ytBFbELi1plVLpEmWNTCtFg7+lLDx1QtDVgoJkF8bGntmE6pMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/pLj5Xq4a4gXYhNtuiis/m1NIjZPf3Bj4YR6eIbPjGPix2pw
	SYOI9JPVGdcQmhsfF31A6+zf2OGmytysSDhNyl4km01vB241jD3s
X-Google-Smtp-Source: AGHT+IGF66hK5QRZb2tBiCEKrXuGNWaVytTb69zRD8Rj3PNi7lvehFWlOYTUesT5waSBY2pWm29ojw==
X-Received: by 2002:a17:907:7fa7:b0:a91:1787:a955 with SMTP id a640c23a62f3a-a93c4946d4emr1200066766b.28.1727705085236;
        Mon, 30 Sep 2024 07:04:45 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997d41sm534719166b.194.2024.09.30.07.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 07:04:43 -0700 (PDT)
Message-ID: <eb2394c0-5b27-4e13-aa91-e214327cdf42@gmail.com>
Date: Mon, 30 Sep 2024 16:04:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-6.12-rc1/drivers/iio/imu/bmi323/bmi323_core.c:133: Array
 contents defined but not used ?
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: David Binderman <dcb314@hotmail.com>,
 "jagathjog1996@gmail.com" <jagathjog1996@gmail.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <7e9ae281-448c-429b-9ca5-86581f777f68@gmail.com>
Content-Language: en-US, de-AT
In-Reply-To: <7e9ae281-448c-429b-9ca5-86581f777f68@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 15:58, Javier Carrasco wrote:
> On 30/09/2024 15:49, David Binderman wrote:
>> Hello there,
>>
>> I just tried to build linux-6.12-rc1 with clang. It said:
>>
>> drivers/iio/imu/bmi323/bmi323_core.c:133:27: warning: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
>>
>> A grep for the identifier shows the following strange results::
>>
>> inux-6.12-rc1 $ grep bmi323_ext_reg_savestate drivers/iio/imu/bmi323/bmi323_core.c
>> static const unsigned int bmi323_ext_reg_savestate[] = {
>> 	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
>> 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
>> 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
>> linux-6.12-rc1 $ 
>>
>> I see no mention of bmi323_ext_reg_savestate[ i]. Is there a possible
>> cut'n'paste error in one of the two for loops ?
>>
>> Regards
>>
>> David Binderman
> 
> 
> I think that is a bug in clang:
> 
> https://bugs.llvm.org/show_bug.cgi?id=33068
> 
> That happens because clang sees that bmi323_ext_reg_savestate is not
> used but to gets its size, and that means for it that the variable is
> not needed. That does not happen for example with
> bmi323_ext_reg_savestate (right above bmi323_ext_reg_savestate) because

bmi323_reg_savestate :)

> that one is used beyond ARRAY_SIZE.
> 
> Safe to ignore?
> 
> Best regards,
> Javier Carrasco


