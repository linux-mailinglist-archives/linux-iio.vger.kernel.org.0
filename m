Return-Path: <linux-iio+bounces-8300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6AA949966
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 22:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E70282D2F
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D4158DBA;
	Tue,  6 Aug 2024 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNmonm7D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295447F6B;
	Tue,  6 Aug 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977113; cv=none; b=muAMfp4Hpher3W29JyJavwn/Ef0demCKgYZc1cUe3BxtlAUaihLW6xDc1E8G9q5B0JRTWHZzXK7+dQ+km8SXhcvA40KWZxnMsBaDnofA8pEhtvOvPVdU9iQJV2AKF4ykM4D2ext2v39ESPn245Zv7w0BVq6UnWB6+uTjCAPdiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977113; c=relaxed/simple;
	bh=KIuqqmJpBYBODsWb+cOMINZVAttBqf/tOMB2ESlS/cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Or8h1/et6iMHxbhaW52bv2ageWHKpVUSpu88NSeWxUUU4tocNhMPPbkNc8DVIdw694St7nP2NRoLvGw5nObcO27FCY8gwVwJUsVYZ6h0fHJ+w1L/V1N3aUVSJQ45Gq+pXZH/1MKXsiWJFYInpO0mfUvIfWv2ooSY8zl0Sv3iYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNmonm7D; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36ba3b06186so591658f8f.2;
        Tue, 06 Aug 2024 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722977110; x=1723581910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOg6CYStGsFYA3cE/78c/lPHwu3rcEs4hIt+mQogWrY=;
        b=fNmonm7DFpvZTqN6chJOVCfxX3qFEJLnb4hM4pQIN89y09bEzn5QbNl0DgiE1vNR7g
         UcDE2tTzcr02CKvcnPdjKUs7v6Y/QMCn/0ClmDmBZbNwk5Y5LMeKiQRFZW7hN+JUoAF9
         IYPru+S/nzRf4C4sSJwDMlo70i95P86fbPxlkYIn6HQCPoWn+imu6gvNTJEhJWkvSLlK
         syDEoWEunhCa+ez2y+twsbrlDVd+GMOEie8sdPy5Yq1nXukcROwoGMyroKPcME350tzS
         yCLi9mf3q5IkKqqkJP+gdI/BwkCdqfdaegoD0vpEA/mEygm5I1alYhKSLfBA1SHXcSxX
         m5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977110; x=1723581910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOg6CYStGsFYA3cE/78c/lPHwu3rcEs4hIt+mQogWrY=;
        b=onEdx+UJFxgMfKwPllMhyE3/ci4EWPJ7KYkAV8HVXQuFg98O7AKQnO37h4E9M/XHuD
         n9uB4F2BtZ3AFQ4TM+bKKQPSbotGfsymnTn3INTb5wamVc2/+i+MU4uGVxwsPXlqceph
         V9gj68mRNmu3D0y8/o3pcohp9pEQVj+lujLnaXp8+0nuAU2i0Az3koDxTwvXeZASUJ7n
         NSi8U36jjQVTPu8YCcFnMqbgTAxtnYbrbTR4oNypJkPb4HdW5I+dE+chz+YQZErOMdSu
         wRBSZffxm/GYMwGc6Mv0X1lmt5/pxVu9aTfftTGTJa0RK8GHaat99fCtWObhFl2cYyxy
         QqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrmj64p6STFQYb2Saqi/7aySe+Mstm3vfGPFJm5gNwYJl/nqtOO4qWPfuzTtjEdUkZx48bCnBqsbrnM2AELS54+rbC21nIn/VT5gwXD3fD7EbHfOtQdyAsvlBz0PgxD5s0Ool2mA==
X-Gm-Message-State: AOJu0Yxn3ufyWCLO3/m5k/1MswyReE67HW8Aob5HWtj0tnnfsvOhgj7S
	Z8dmKE0cC/NKmDikrcwcYXsNIzjWU4FHRCQ0jWfi2sS1SlV4bd9S
X-Google-Smtp-Source: AGHT+IGZSd4SSanfsuHMDv/NQfTB4T/YAdjutfajpEpk6SceNnV3BqFIVTXztk1vx7VerGImtafjvA==
X-Received: by 2002:adf:9794:0:b0:366:eb61:b47 with SMTP id ffacd0b85a97d-36bbc0c6b4bmr9775385f8f.8.1722977109710;
        Tue, 06 Aug 2024 13:45:09 -0700 (PDT)
Received: from ?IPV6:2a10:d582:37c5:0:24ff:23cd:356f:3efc? ([2a10:d582:37c5:0:24ff:23cd:356f:3efc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd26f8edsm13985739f8f.113.2024.08.06.13.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 13:45:09 -0700 (PDT)
Message-ID: <23e8b9d9-d0e0-44df-b464-fc2d1f2d5507@gmail.com>
Date: Tue, 6 Aug 2024 21:45:07 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: light: ROHM BH1745 colour sensor
To: Matti Vaittinen <mazziesaccount@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240718220208.331942-1-muditsharma.info@gmail.com>
 <20240718220208.331942-2-muditsharma.info@gmail.com>
 <5622f011-222a-459e-9086-138adf0796aa@gmail.com>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <5622f011-222a-459e-9086-138adf0796aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/08/2024 11:28, Matti Vaittinen wrote:
> On 7/19/24 01:02, Mudit Sharma wrote:
>> Add support for BH1745, which is an I2C colour sensor with red, green,
>> blue and clear channels. It has a programmable active low interrupt
>> pin. Interrupt occurs when the signal from the selected interrupt
>> source channel crosses set interrupt threshold high or low level.
>>
>> Interrupt source for the device can be configured by enabling the
>> corresponding event. Interrupt latch is always enabled when setting
>> up interrupt.
>>
>> Add myself as the maintainer for this driver in MAINTAINERS.
>>
>> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
>> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Hi Mudit & All :)
> 
> I know I am late. The series has already been applied (thanks 
> Jonathan!). I've mostly been offline for the last 1.5 months or so - 
> "all work and no play makes Jack a dull boy", you know ;)
> 
> Anyways, as Jonathan asked me to take a look at the GTS stuff (at v7), I 
> tried to quickly glance at this. It looks good to me!
> 
> Well, the real test will be the users of the sensor driver - so please 
> let us know if GTS stuff brings problems to users. I am mostly 
> interested in knowing if gain changes caused by integration time changes 
> are handled gracefully by the users. :) Well, seeing there is no per- 
> channel gain or integration time setting, you should be safe from the 
> worst side-effects :)
> 
> Nice driver!

Hi Matti,

Thank you for your review on this :)

Best regards,
Mudit Sharma
> 
> Yours,
>      -- Matti
> 


