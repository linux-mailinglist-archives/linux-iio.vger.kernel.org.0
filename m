Return-Path: <linux-iio+bounces-10452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4444799A23B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 13:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55172879D9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 11:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546FB212F06;
	Fri, 11 Oct 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2BVf8jP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9B14293;
	Fri, 11 Oct 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644585; cv=none; b=rz3ha9lw8aaXzM+qlWxUMihYbFpDTSpdPM4dohBxbDEUAjMb3c8/lH2Q7JomwaQPyVoE1Ic9baEWVrERiTC3tqF8pX7FsDVKINj8cdSFI7FciPgTZ1+uNB4EeEYJBRhryh1voIiOpp/MTTfMex9lTNVHMsOzTGc0iFGGXrO468g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644585; c=relaxed/simple;
	bh=PNsJvaR2hjTB0m5F7S8kPrYH81jNbMy+cnbFnpqGHtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gC50YkyQ7fi4dqSC3TTv2OmyKLwMuM9GPaczKZ/99p0Qmy+1Ov5PSfwPC7hKiPrq4k+rlA+3tHaRrzpHKxFIUG1lp0wvHTLTpC2Hn3ijNV+QciM4ToOzGmfmwEoT3osP7EazPraHhqYF0/4aTEBnAcdSrD+QLFZLAi46YcQ+0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2BVf8jP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c924667851so2277979a12.3;
        Fri, 11 Oct 2024 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728644582; x=1729249382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDgqCY+XT65kiTHSQJtsyJ8AXYUcreWmz9KtIDjKv1k=;
        b=I2BVf8jPuXfqe/fdVmQgByA7XQirL5ucgM2GXaQdgLBFmF0NICdjuVjENBSvqY1+Df
         KthLdB1lnGO+dDD3O6wYFQUXEwB3HqwXugJtT3wg8jWJjINe6Pwobiyrsc4iXEqPeMAy
         tCeWxElcaq5vTR9MUuHwlDYn2esZr2rXAmfK2zvr89MXsBgm6h6mlsmL1+qCtKX9RlfP
         ynxC9br/wMh6tNaGegN7L6mFumInGsX5eRtiJarcicvE+lIrFVsbCaMSReIsTRgV3057
         75ub67eSPywRSkXmKBnCTiFWTpCDs88nAyriU15ED6MYqAbWwOTcHC+XdBXyMLvF4dq6
         5RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728644582; x=1729249382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDgqCY+XT65kiTHSQJtsyJ8AXYUcreWmz9KtIDjKv1k=;
        b=Zg4pqNpVpCOCHRadSQe1AW9x2TTbZ/3xJEY/0wvBwXNFBmHACUjaTipR+IDzyqkOzH
         3VENWgMG7333nRAv/xQGd/pIZiOz5YLINsBRwGMPCd9oZmIChSCcIN0ef1r/ljRhdK/b
         q2uZpzzpc2j5HDvhbgOFMrbR2GXmczKNuWdQomLMPwXN8WsuQDXLd0+Z20G87dOfDV07
         Je0xypy/+QMRQl/+uErdDX/1IcybCypI/8Is5gLRPOLr7hmSvU+vRJ16Hf26MkfF3JvA
         u0uu1Xq48/gDCTGC4quFEXeSz7d37WV1LulvjL8gHecoApt6+m0n5Ycd+DPnMrlAIFBE
         HJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlIwp+6JUXLvUCctY+UTG8MqwnzJuV3oA++l3Ns30ZtXNp+khzZbeB+/aLiLiZBuLUT4KcFgOM7m8=@vger.kernel.org, AJvYcCW3VTazhlVpej4Wh8HbhNFQ+T6kURkmbpdvu2sSowLdy44m2mvJ7YcAVERhZVs3vpXNojb6VgcMe/l1eilV@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqwFP1fGTSDq9ISIk28UrM+h3GKSFp6fQtB4uaSiryu5Jz03S
	UeV+nVaheJLGWOnaBPZPwbjvFvZHLB1AAiEi0aB6fxaLfHWWrpkz
X-Google-Smtp-Source: AGHT+IEy14Gx0H4bckIlt3krJcapszDFEJlJFkVFRbRzPFWdbCtdvus5IaXo71tLkpD9oWj2tSQarg==
X-Received: by 2002:a17:907:944c:b0:a99:4698:cc5a with SMTP id a640c23a62f3a-a99b95bc0d1mr163059766b.47.1728644581797;
        Fri, 11 Oct 2024 04:03:01 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec573csm200566466b.6.2024.10.11.04.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 04:03:01 -0700 (PDT)
Message-ID: <e9f0310b-c7e7-4da4-92b5-0d2b1948c4a6@gmail.com>
Date: Fri, 11 Oct 2024 13:02:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix uninitialized variable
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net,
 skhan@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Angel Iglesias <ang.iglesiasg@gmail.com>, Adam Rizkalla
 <ajarizzo@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241011093752.30685-1-0xff07@gmail.com>
 <ZwkD8hXNWcL0z4Cr@smile.fi.intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ZwkD8hXNWcL0z4Cr@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2024 12:54, Andy Shevchenko wrote:
> On Fri, Oct 11, 2024 at 05:37:45PM +0800, Yo-Jung (Leo) Lin wrote:
>> clang found that the "offset" in bmp580_trigger_handler doesn't get
>> initialized before access. Add proper initialization to this variable.
> 
> ...
> 
>>  	struct bmp280_data *data = iio_priv(indio_dev);
>> -	int ret, offset;
>> +	int ret, offset = 0;
> 
> Can it be done closer to the actual user of it?
> 
> 

Actually, offset could be initialized to sizeof(32), and only used for
the temperature calculations.

+	int ret, offset = sizeof(s32);

The first memcpy would use 0 as index, as it did before.


Best regards,
Javier Carrasco

