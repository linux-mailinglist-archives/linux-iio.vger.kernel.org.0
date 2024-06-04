Return-Path: <linux-iio+bounces-5763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C45F8FB440
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D442826B3
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3738F45;
	Tue,  4 Jun 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvGS5+Oo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8415AE0;
	Tue,  4 Jun 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508852; cv=none; b=dF1QWysgazPxyjaRFjBCJFBJV5of7ILGCIU7mB73Uq05Bz9jKVTwe8BGboP2oekmLQZIu7Oy17qmS7oPukk66T1dogwh49uDLb1ULfYSKvS2l9Sl84QnWYpZMTH8th26TJ0Ac1ulQdfxekasD8LZNAxpWgpV1Q6enenajNAnhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508852; c=relaxed/simple;
	bh=nUWHcu9w0M56FpQUkxmy4z9v4pO1ADXybuG/gsBk3vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uW3y48ziqH4qeiGr64G1xpDdZ395/sR2dljn4/qz1eK2qceHUKOfnjiYVyOjSzqmvoywK1EdGWVwMrCIPY8FmW91juMiUg29fs8KbEmdRtQoXJWHggaewoYWG6dqgWTb/Rusdbd67iqAvoAChc2tE3kxOwj/0h2r2m/SEJNe6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvGS5+Oo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68c8b90c85so360270766b.2;
        Tue, 04 Jun 2024 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717508849; x=1718113649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuPhePm0WTllrF3I6lI44urnOc5vgeZut0thAGNsi+E=;
        b=UvGS5+OoCDlzDZepQpi/mTfpSM96/1dt1MwYMynD3ObKzCYGL1OLGBEXETNyJEG4l3
         q5plMuHRSuXOFxALPhB8has00CdpkYO8H8fRZvswbVkI/aDfW0IaZQv/L3UhXBgm/L9N
         NbSXzjv90tYPZXuX9H/2IYbQ3CfxwRRbrNnaLRUWC4TUadwj28jPfxSoDFOYiQdpljib
         25Y4xMdwON/eQ1n6cQiBHwFRacUFH9W00svm/VRQ+8LvDlWRoTKBQ4X4rFnXYVZvHtSa
         4eA+qXOjXZtukOYLIClpv73pDgT9kQx54ck+kdnruLClNDo6ZooUSRSg6WJkcXIiIUxd
         0lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508849; x=1718113649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuPhePm0WTllrF3I6lI44urnOc5vgeZut0thAGNsi+E=;
        b=Vbv7f40Y9pRN0hfRYNI3lvAtpgx2nO3Pu3oLPZ9sAt1RP3MZy5PiyxsTRkdVqCcx/1
         fCQTeIBAJLxAeCV5/h/fJATrpyYUXGGQ0/CZ9nSJU7ZadUYe4tTgtl5w9zAvVCBQaUtt
         Sao/NqPL6egkIZlLVaYufWObnK2eu0+V6mTBM0m3b/RVoygMtBKx8fsYHE2CM4uLEey+
         0BwlXWo1jOkJZRu/3N7tpnYW1IF04iwXZ2oQ0IumEHAQRplpGdKRLTi3t4i/TL1Clrpe
         1aCYJqdWwDASJDDUDgWXrnsZH/66VsjLQ0vknKzqK8lZ20bCoR1MCh1b/rVl81gCTPex
         V4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVRhxmOQ3b5TqurG1LROqUBD70eyhdn78comtlR1+0W3b2a+wH9kr9Mbhg9JwB5VJlJkC6BmMugvp6Qqr967v1hdBuhwOi8mnFUm1iHOlEzuiaIvfG7xFr87Sw59RzkgTkj4UFi+Q==
X-Gm-Message-State: AOJu0Yw4sQD02agvk794/lgoBqZbwHfprTgXYQ2rgWlBQ+yZSEZ7UGmj
	OdAdJc36akIDmgHHX4/T1L63dnUB5hAnXyisv3wWOK8RuqmK752jHb+0Y+Le
X-Google-Smtp-Source: AGHT+IH8q7cGkQrbC5vNQ33lLByeITer2W51d+2mhsA+h/q38zQ8nqs6xdyhyowoBcvrh7lbxBnxZA==
X-Received: by 2002:a17:907:7787:b0:a69:edd:332c with SMTP id a640c23a62f3a-a690edd367emr379963266b.47.1717508848871;
        Tue, 04 Jun 2024 06:47:28 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f8840bd9sm358715466b.20.2024.06.04.06.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:47:28 -0700 (PDT)
Message-ID: <7446cf8b-cadb-4f4d-9870-51bcda46a831@gmail.com>
Date: Tue, 4 Jun 2024 15:47:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add maintainer for ROHM BH1745
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Mudit Sharma <muditsharma.info@gmail.com>, ivan.orlov0322@gmail.com,
 jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
 <20240603162122.165943-3-muditsharma.info@gmail.com>
 <a628db76-a48a-4492-a3cc-f93c0f67ad04@gmail.com>
 <961fa617-a76b-4b79-956b-795a55fec959@gmail.com>
 <f241957f-6f4b-424c-9ea2-d7eb564daa4e@gmail.com>
 <17b23723-d0d0-4744-9828-cef316cf3fb7@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <17b23723-d0d0-4744-9828-cef316cf3fb7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/06/2024 15:38, Matti Vaittinen wrote:
> On 6/4/24 15:53, Javier Carrasco wrote:
>> On 04/06/2024 12:44, Mudit Sharma wrote:
>>> On 03/06/2024 23:37, Javier Carrasco wrote:
>>>> On 03/06/2024 18:21, Mudit Sharma wrote:
>>>>> Add myself as maintainer for ROHM BH1745 colour sensor driver.
>>>>>
>>>>
>>>> is there any special reason to have a separate patch for this? The
>>>> addition to MAINTANERS for new drives is usually included in the patch
>>>> that provides the driver itself.
>>>
>>> Adding this in a separate commit was just a pattern I notices with some
>>> other drivers, for instance 3b4e0e9.
>>>
>>> If necessary and/or considered good practice, I can squash this in the
>>> patch that brings in the driver.
>>
>> Although there might be some cases where it was added separately, it is
>> much more common that it is added to the patch that provides the driver.
>> Some perfectionists even include the entry in the dt-bindings patch, and
>> then add the link to the driver code in the driver patch. I believe that
>> a simple squash would be ok, though.
> 
> I believe there is a notable case where having MAINTAINERS updates as a
> separate patch makes sense. When one creates drivers for a device which
> touches multiple subsystems, typically a set of MFD drivers. This is
> usually done as a set of subsystem specific patches, each adding
> subsystem specific file(s). In this case adding MAINTAINER info
> separately for each sub-driver will create unnecessary churn in the
> MAINTAINERS file - which I believe is already now a major source of
> merge conflicts. I am not sure of this is a reason to have MAINTAINERS
> updates in own patch though.
> 
> Furthermore, I've been instructed by Rob (AFAIR) to omit the dt-binding
> files from the MAINTAINERS because the maintainer information is already
> contained in the bindings itself.
> 
> Yours,
>     -- Matti
> 

Good point, in that case it would make more sense. But this driver only
apllies to iio, and there won't be such conflicts. But thank you for
that clarification.

By the way, I think you have some issue with your email configuration
(no line wrapping).

Best regards,
Javier Carrasco

