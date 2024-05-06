Return-Path: <linux-iio+bounces-4829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06078BC6A3
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 07:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A30FB2126B
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 05:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670EC4644C;
	Mon,  6 May 2024 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdGW7tPw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6DF1EB36;
	Mon,  6 May 2024 05:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972172; cv=none; b=F9QiuLmkviE7E/YNkVwzzQ1z5DqrX1rgFnh6Kl0KKmqc3kMh9MOwNJLtmDVqX2v8/Tj6tyCfpIOEzTf3hLmrCR0bxRojHhpS6cYv9wHCJN+6piAJARt3CthZJsUPZwnrZp/SlgX8uNEP0Jkj+pyj8etkW+9FhVhyK6cK/5JjyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972172; c=relaxed/simple;
	bh=kh3pjmcgspsFubSCvlFAC12TDbcdkdW7Az3JM3CWzdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnZA2aPBdiGoTIDX77k4l+ZQhGnG9pS6JWlapj/hSAN35FvFC7I5Are0v9aGIHgtH93MYP5zXx8jNiMbQ6vJSpSFvJHJ7HhdpY/KOsofUbtsBR2OOQwIYEvzQTa6ov/YduLf03bulJp/NgOUqQdP9MXkiAT4UZgrdQEj2DAe1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdGW7tPw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f71e4970bso1677019e87.2;
        Sun, 05 May 2024 22:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714972169; x=1715576969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWbsGZx/QEaTtUL6O25aBUxket2/6PHkfifn7NTPauM=;
        b=IdGW7tPwet+7OydmoJHtuZxdw491ehg4aj7vHTNGZkU4JpaBIyBSL0oKbNeWjxiZAv
         GJ1M541FJBnrPUhRG5nlIVEvlZIYG4IpZFdDd9AczeAvv1CgXINXPjxi1zW1M5fWJWz4
         BPEiVQjhJCHdWfqdKSvCCXC1/ZM7K5Qb559NFMNxVGyAyyCUpXMsoor5n84aiu4qzAmA
         fXDLbQmp2hEeslC2PlC1dV+oYFgEjrm3/DLe34tVhUAoW72FReiwYhP9/JBZZNNfFLZr
         sZ6cKmUot405vFkTWUW/aMTEEHi6/CTdf6deIf2eTMZu4OgNFCrgMlQemykT2aTzFt0s
         ta8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714972169; x=1715576969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWbsGZx/QEaTtUL6O25aBUxket2/6PHkfifn7NTPauM=;
        b=xRJ0MWqaBt+AsywvBTWSOXq5GNWuRqEDc1PsbzSWY/9EIPAl+XRPycJ5mfU+ad7EgI
         T0K8aREmTJrd/dB156VPerG/wVCNbu/5pP5ongrFr8LW4uATCGIJwBXDUbUWzAHE74Dv
         mNTJlXbc77HR8CvjkSWgmVY9bcdgrZJt7G3RuVICpXf3jhKk45YocgOzpycftZXUHIjA
         1/eKWVdqkUNCrPqpdRd4xtksVkCex8wxjFg5E34FR1PBBkKCOmxm/++rttVMmeo9LOaT
         FjYJsuBriCgWM1OH16BBF4LeD8xiXXE7cS5w49WJ6EA2MEpFXYRGEuIuOpVEZ+OSkQo7
         Pcug==
X-Forwarded-Encrypted: i=1; AJvYcCUI7Aw5uqK28hVM/kCELlUKDSln34j7QBWiZzxUOudSIYJ/wcsQBmT/zRJJEXC2oiSqOLaFBhZkL8AjyOCNNmuiPgzHQT9x7aVWwNOf50uzIVaVEWnKAHbsJGcENswXRtH90FzQS9ha
X-Gm-Message-State: AOJu0Yxuv929l/LGLaXx+xJK/G793UsM6xU1ysGxi7elMHQXJKw5b0BZ
	dDaQvT5B9MGPfUu2k+ncUTiqbz90EPi6xMEpsrhCDcjjd0uf6byR/+0yDg==
X-Google-Smtp-Source: AGHT+IG9+a1dovRs7qfJ42AfWatHf2uhvZXQ0L4XjfoeXjgYymezBrdcCPX2MgRUpHEcNnuF4JB+CA==
X-Received: by 2002:a05:6512:3f01:b0:518:bd38:1ed3 with SMTP id y1-20020a0565123f0100b00518bd381ed3mr9224288lfa.53.1714972168404;
        Sun, 05 May 2024 22:09:28 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id y22-20020a196416000000b0051723af85casm1503691lfb.238.2024.05.05.22.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 22:09:27 -0700 (PDT)
Message-ID: <11a16488-7f5f-4d53-a091-9cedcab76dc8@gmail.com>
Date: Mon, 6 May 2024 08:09:27 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix the iio-gts-helpers available times table
 sorting
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
References: <cover.1714480171.git.mazziesaccount@gmail.com>
 <20240505185027.18809bfd@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240505185027.18809bfd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/24 20:50, Jonathan Cameron wrote:
> On Tue, 30 Apr 2024 15:44:26 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Fix the available times table sorting in iio-gts-helpers
>>
>> This series contains a fix and test for the sorting of the available times in
>> IIO-gts helpers. Fix was originally developed and posted by Chenyuan Yang.
>>
>> Revision history:
>> 	v1 => v2:
>> 	  - Fix the sender for patch 1/2 (Sic!)
>> 	  - Fix Co-Developed-by tag (drop this from Chenyuan who
>> 	    is the original author)
>> 	  - Fix the From: tag as instructed in:
>> 	    https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> Am I right in thinking this doesn't matter for existing drivers?

I think this is right. Only couple of in-tree drivers are using these 
helpers for now, and all of them sorted the tables already in driver.

> As such not high priority for back porting?

The bug is pretty nasty as it causes invalid memory accesses. Hence I'd 
like to see this landing in the longterm kernels. It seems to me the GTS 
helpers got merged in 6.4, so getting the fix backported to 6.6 might 
make sense.

> I'll assume that and queue it up for 6.11. If someone shouts I can pull the fix
> forwards, but then we have the mess of chasing the testing in later.

I am sorry Jonathan but I'm not quite sure what you mean by "pulling fix 
forward", or what is the "mess of chasing the testing in later" :)

> Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> to poke at it.

Thanks! Appreciate your work as always!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


