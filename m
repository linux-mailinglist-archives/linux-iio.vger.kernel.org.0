Return-Path: <linux-iio+bounces-9961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8798BE2C
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763931F22727
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E0F1C231D;
	Tue,  1 Oct 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a6eolNAq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA7194C8B
	for <linux-iio@vger.kernel.org>; Tue,  1 Oct 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790147; cv=none; b=l1lI4JQQpNsjbQakbJAVuZjDaje5YhKTIeITsm1DwbpX2azr16oDL2lutkFHDpwiOk4hn0umDYxA6OZPbibxoCbMJ6fgo4Y8PyyU3mZolyx+c8++WNiEUg/r8f08xce6JpS0G69maB5qV5WfqvL9h/1FRWhqfZdvp7GSmglcYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790147; c=relaxed/simple;
	bh=Hxb93VBN2wjQjq7K7CdVUFSYbZsXI3NIAZECR/42fBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANBLWqRJuna2pJ8lAoFcp67chc1Kikpl+nkrilXsP+hWKLUOYtsoB7pvV0dkie4ZTEUCkGcciLKSNS2bJo5yD8zCXr02oZ/tR4yD80AKX2QtQKC5kx7i4Ar0TzGdJ9hIHyyW/rm1pzsG8AFVsDNyYOwPFeF29uSxmPltXmgd8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a6eolNAq; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-709346604a7so2964816a34.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2024 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727790144; x=1728394944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zO30q9nPhm3Q0tzD5dpPGZWjk6LKGp2tiZZl58C+1tQ=;
        b=a6eolNAqg22EG38jDFtNyR6guZblbQak/M1hurm/mnq2Is1Wd5OUf09eAa0iBLedRn
         RVYt/WlHBY4OARtLjEukhSWKmMmNRB3S3gpd1I9ldHqi5lojz7Jw1UOWR6jpoUeAruun
         fdsDyErKzImR8LNgrMP6LtKhWTHuRTudxRa2FomX6C1JvpxP4BcNbClp9hkVvI/gh5n9
         Zssw8CxjeliWmKH9u6a906n+wGEZt6PWNU4AGCFYfZ90Nch3miPPL4NOXf68BmJpdBhY
         wrWM8GJq0eSvIbvYoPtrBbQOY91qyQ6v/Ky1ccKnw0IorxCbezerzY9xpjkFCBDH40rj
         XhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790144; x=1728394944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zO30q9nPhm3Q0tzD5dpPGZWjk6LKGp2tiZZl58C+1tQ=;
        b=LiAgIv9L7OiBkVHAC7V8iUW7RM9WUSc3cTMffByQX/2uzCFgG/QhKmamPljgOgS55x
         u9fDzBq8I3ozrjN8z12CsQvXDa7FvOA0N1/799epI2xk+9VhMN36CTmflz33sBUbsyDl
         ZUFM0oIeEywnP54I3mVjYUOng5zwsUIr/t+iI1JQvr093NqBHrLLOi+PRwOr5SBQVy2U
         u6vKdoLfLcVLCbHpqHFpdY+93a7v33r6My67k1pJnCiEXIL2s9ixH38MBtuUAz204fU7
         Z4TKKMiyJBONf+7ARfW7ttfruC5FGn0GGJxmgnNe/zSF0pwyXAcKv5sMqafuKLD0LLZ5
         m3hw==
X-Forwarded-Encrypted: i=1; AJvYcCXxOqTd5oqqgdzM+eHKPQmPsogNjjtIkFijl7GZ36GlGPja7ght9jekjEMrO5NNuxBQ/lA83xzOFYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2smDjB7XXKh98lux/jpp9v4gl3MMlf97Ek56y+A2t7h/7aU62
	NAbye+9ifCTZnA0wdAG75xJtc4roUkBi+YuQAPkjaXqMbNATdQqjxCH65yUCb48=
X-Google-Smtp-Source: AGHT+IHFNuEbhuCxlZk9FEMhWvFEJI416om35o/BvxuQUNU1PzqlhDNXl67kUSrg3vRnuGn7A+ok6g==
X-Received: by 2002:a05:6830:3819:b0:713:8b3b:8289 with SMTP id 46e09a7af769-714fbe8fc85mr12996098a34.10.1727790144500;
        Tue, 01 Oct 2024 06:42:24 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-714fb64fd10sm2889619a34.10.2024.10.01.06.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:42:24 -0700 (PDT)
Message-ID: <047034ae-135b-4ce9-a407-9b2a00841324@baylibre.com>
Date: Tue, 1 Oct 2024 08:42:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] iio: adc: ad7606: add support for AD7606C-{16,18}
 parts
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
References: <20240919130444.2100447-1-aardelean@baylibre.com>
 <20240919130444.2100447-9-aardelean@baylibre.com>
 <CA+GgBR_kKYOgPUHM5-LUAZboy6nab1tLvC4TFtzpqkjP+5A8wg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CA+GgBR_kKYOgPUHM5-LUAZboy6nab1tLvC4TFtzpqkjP+5A8wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/1/24 3:26 AM, Alexandru Ardelean wrote:
> On Thu, Sep 19, 2024 at 4:05 PM Alexandru Ardelean
> <aardelean@baylibre.com> wrote:
>>

...

>> @@ -153,7 +349,19 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
>>         if (ret)
>>                 goto error_ret;
>>
>> -       *val = sign_extend32(st->data[ch], 15);
>> +       chan = &indio_dev->channels[ch + 1];
>> +       if (chan->scan_type.sign == 'u') {
>> +               if (storagebits > 16)
>> +                       *val = st->data.buf32[ch];
>> +               else
>> +                       *val = st->data.buf16[ch];
>> +               return 0;
> 
> Arrggh...
> I messed up here.
> Guillaume found a bug here, where this should be "goto error_ret" or
> do an "if ()  {} else {}"
> How should we do it here?
> 
> Do we send a fix-patch or send a new series?
> 

Since this patch is already applied, just follow up with another
patch with a Fixes: tag.




