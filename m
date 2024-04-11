Return-Path: <linux-iio+bounces-4190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C88A1453
	for <lists+linux-iio@lfdr.de>; Thu, 11 Apr 2024 14:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851981F226BD
	for <lists+linux-iio@lfdr.de>; Thu, 11 Apr 2024 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701914D6FB;
	Thu, 11 Apr 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/qxOWV8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9D14D43B
	for <linux-iio@vger.kernel.org>; Thu, 11 Apr 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838005; cv=none; b=f3UUtL6xCwtYILvD07AO7jN42VQHU72HhtSCXeNKtvWficgltfYTZ7JiQsL6eDoJCZg5yDtgmW0Z/rDq/NcmjvZMt4Sna3sYQTDvsGJeyvgL2Fju/9nmKuAxjWlnlJNOO5qlEtPio9nKJixidhnvGqa0MxzFkxludMiTFPuZNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838005; c=relaxed/simple;
	bh=8cSz8qr2jglAkwX08BGxPWvBSShuPap+qxmn0kIPnnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GF8Sy6hRI3eczLSUjC7HgqMjYiKU8ypiD1CvP9NfdXsOGK8/SUFNqfS+QvYmSGkQiolxRhUM326TMy9SAVr8Mgg2R6siraVuEBDH7TXjX7uqmNPWSZ8G6WvcVIVvwkfmtOc/rNjK3fyWJ/SGnpp+JDSlQsYd/l5bReM1mHjJiy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/qxOWV8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516dd07d373so4069196e87.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Apr 2024 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712838001; x=1713442801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1P00YGbL9AJLDv4+mnwmhA6H/9qEyRvY0dmOqRIzjtY=;
        b=f/qxOWV8guRpJmqR/dlYPGSsySMz64s/M4iFIpCbeIwdrHqM/hpIgoNwuglDAMR7Tz
         y6DE8oNjpEqDIAA+6YvFWSTSOxdc2uKJe9PYRkyLINZzeiDeVxz+ONXUWECFTvcKpB54
         uxW+Ne/vPqU3MVU9lroZbJCaJNSLTuSHi5lkT8gIsfWXYVSQT2ZBvy3/lPqgZy9bdxMi
         BxozXj3+hpBuwu9bz3hPxPL9WLTNRGvGQ4ql8V3nJBoz/qvZm3B3arO98rbRTkm+YMM1
         GC/QESRiMmc0+t9J+16RItDzY3MpkYEj3ylzCTfCua7ctRxRaxyk36IHcY28U0/s3uR3
         3/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712838001; x=1713442801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P00YGbL9AJLDv4+mnwmhA6H/9qEyRvY0dmOqRIzjtY=;
        b=mM7nrQ3CqeqiK8hHOJlr3n6xrCYRvQE6Ag3FiWXsAwh9uvZximfyK42HAk4ZIP45LG
         TCbdkzl3IykZx2c0PnB7pWIvhUPf3XzftzTXjCpgmhGLYxFxp21xefT0NfMXTybRqONM
         y8IUgiIfWq+2IpbWI7LQvnvWGkKm95uBYUtSib7AfhsnJ68dpkiW0lySTj3v/U3oau0n
         YX9O/lBCSkhBNwZMyMRIoXqgnewkz3wKsoXE3wjOZZdZmkHVsPv1tTTtmpw0g4mLZI59
         apI2z8Ne6SlZqO2qzxBEA8kom7tacSgIrtv6gVZfmMUMwWDOHqurKVUHYaWVEQMILpyW
         uNfA==
X-Forwarded-Encrypted: i=1; AJvYcCXvuxk1fPPFIW8pNY9BFIC+qjCekHsStGPlPbz3rxVuvH+uzwp+aoYXGK+okngUAt26/PZyNpUJPhHnNr/HVXP8du6ygVGar3hU
X-Gm-Message-State: AOJu0Yyw91OQMi7Y1OwPjol33cgybFI/YKpQl0ZdIFvNRi61JKU9jQ8J
	iOJ90mMFCEBM4t5ornaWaJLH8co40WO01fw5qLc/Vqrv+z8Of5Gn
X-Google-Smtp-Source: AGHT+IHrqf7mIyeUPd8R0z3U+DTug7hwsGSdYQpbPB4xIuQJo+poC0mArsF6zcs5dWqCxqCo3IHXCQ==
X-Received: by 2002:ac2:5608:0:b0:516:d63b:ff56 with SMTP id v8-20020ac25608000000b00516d63bff56mr2795018lfd.56.1712838001070;
        Thu, 11 Apr 2024 05:20:01 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g10-20020a19e04a000000b00515b5cd2361sm196293lfj.164.2024.04.11.05.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 05:20:00 -0700 (PDT)
Message-ID: <b7b28fff-ffd5-41d7-be56-b480dd28329a@gmail.com>
Date: Thu, 11 Apr 2024 15:19:58 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio <linux-iio@vger.kernel.org>
References: <ZfHM73ZqgnCp6CZv@cy-server>
 <a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com> <ZfS0Rhk5WTJbwXU/@cy-server>
 <20240316134035.5eb47a69@jic23-huawei>
 <a9b12f52-c59a-455b-889c-786c0a2158e9@gmail.com>
 <20240323181330.71048402@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240323181330.71048402@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/24 20:13, Jonathan Cameron wrote:
> On Wed, 20 Mar 2024 09:02:46 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Jonathan, all.
>>
>> I am resending this as I don't think I found the mail from lore. I wrote
>> this using my phone so maybe it was sent as HTML and stuck to some
>> filters. If you receive this twice - I am sorry...
>>
>> la 16. maalisk. 2024 klo 15.40 Jonathan Cameron <jic23@kernel.org
>> <mailto:jic23@kernel.org>> kirjoitti:
>>
>>   > On Fri, 15 Mar 2024 15:49:10 -0500
>>   > Chenyuan Yang <chenyuan0y@gmail.com <mailto:chenyuan0y@gmail.com>>
>>   > wrote:
>>   >
>>   > > Hi Matti,
>>   > >
>>   > > Thanks for your reply!
>>   > >
>>   > > > I think the suggested-by tag is a bit of an overkill :) I don't feel
>>   > > > like taking the credit - you spotted the problem and fixed it!
>>   > >
>>   > > You did help me figure out the real issue here and how to fix it :)
>>   > >
>>   > > > Do you think you could fix the removal of the duplicates too?
>>   > >
>>   > > Sure, I can help to implement the deduplication logic.
>>   > > Here is a potential patch for it based on your help.
>>   > > Besides, I changed the stop condition in the inner loop to `j < idx`
>>   > > since the current last index should be `idx - 1`.
>>   >
>>   > Matti, I didn't follow why duplicates are a problem?
>>
>> The function here builds the tables for available integration times.
>> These are shown to users via sysfs (if I'm not mistaken) - and while the
>> user-space algorithms may tolerate dublicates, they are ugly (in my
>> opinon) when available times are manually listed.
>>
>>
>>   > Sure the code is less efficient, but do we end up with a wrong
>>   > answer as a result (I've not checked logic, but I'd expect either
>>   > first or last of repeating values to be used depending on the alg).
>>
>> If we discuss completely omitting duplicated times from the driver
>> (which was one thing I referred in my previous mail) - then we are
>> likely to face problems as there can be register values, which then
>> can't be translated to times, read from a HW.
>>
>> Eg, we need to have everything described in driver tables used for
>> driver's computations - but (in my opinion) we should drop duplicates
>> from these tables which we hand over via sysfs.
>>
> All makes sense. Thanks for the explanation.

Hi Chenyuan

I don't think I have seen a patch fixing this merged? Do you know if I 
have just missed it? If not, do you still plan to send a fix to this or 
should I do it?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


