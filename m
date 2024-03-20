Return-Path: <linux-iio+bounces-3632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD55880BA5
	for <lists+linux-iio@lfdr.de>; Wed, 20 Mar 2024 08:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09871C226E2
	for <lists+linux-iio@lfdr.de>; Wed, 20 Mar 2024 07:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83D1DFEA;
	Wed, 20 Mar 2024 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0jTKXUY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774E1EB25
	for <linux-iio@vger.kernel.org>; Wed, 20 Mar 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918171; cv=none; b=OP1IY5tLcDdDKPQ9F6/51jFTvIYVsm8rJL7uNFOG1IA9WyVpIVoK3DXP5eKg4amCKpiCr7F6RxYmTj0HJ4IvWG58Lv8OQXv4coOo9HKJpFFGraWkeK1sovsz06kYftmlEpW1F+5mUvGh+AuCe0UHstoZi5P0PF84eqL2QOj9F0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918171; c=relaxed/simple;
	bh=5iyvIFlD4FhYRNqSuqk71+rs0J22Qw6NtXQi3HOJt4I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WNGQq+ZzRHjYg/ubeVdqkH1S63zTX0HB0UKTSLZucePZVfDkS07dwiftktmgnQt+Jf/tXnPD9UdnNy0zzKcTt+W6WWf2yuao+T4l98JTSuD+m003WE2r6Zu3Vol7xYanQxi86wUicmRTGsPioIAjq6Y5xvn8eVcLW51VeNAyzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0jTKXUY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e4dd6ca4so535629e87.0
        for <linux-iio@vger.kernel.org>; Wed, 20 Mar 2024 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710918167; x=1711522967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aPLaiDxzrgD7YvfOBc8RhjjgS013xRBrOKJxJB3oCrE=;
        b=O0jTKXUYluh7y+fY6IU5UVY+NsxZljmhNA8FGcJxGQDku9yyleBxXwS7gVcMOfexLl
         NwgoQTHEECh9fAPT3qWK9LYe+feXe5Oc5Joo1dw3qOMt7XLaGL/CUUOAe7t6ZFM8ZdJO
         eIVc0H4h3jRq+UP6aWqUXls586u3YYq/H55wacNLSAS7d8OAZVnjuEtY4PeafiQ83Hb4
         HMNSq5z8mQajY3pvLKxzOVh8d0UsLeYKS5hgaw4dP+P9R9mPoxiiiCi1loGcwoVR581O
         NcZ50f4Qvxi23yw57JUMliOTFRMoehwQ9eStQb6sFpdyiDeh9ZGJZZE2Svg/qL1q0dSz
         erHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710918167; x=1711522967;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPLaiDxzrgD7YvfOBc8RhjjgS013xRBrOKJxJB3oCrE=;
        b=j14Rz4Mget/MRXZvkPQ6zX4HYBDudAHAAKsVSg+imuYIWV1Z83p+0ohOW33434uFMW
         c9fxra+J4aY0Gdnu0HCmyJGxYTjkswB9fO6GCvTbSyop7vqEayiXMmqsWzoImKqWfYCR
         4LY01a9ltlXI4vISeEzBDxsHQFLWzrEqA9EOG7C/8+EWxdFZ6quAY0iAy3xvDZLP9Q3D
         zrGPwR5gseb/0vliGC3KzUYj/hDKGKY0pNtqHV95D+Qgkg4kkqGG8m41bNlZVqh0Ul6h
         4OmZiAUpzm8w7wDIi8JIudtqtTOi9PFnpYah25MQuWWtgHq3rl4QqDyOzqflq92KK7/e
         FuAw==
X-Forwarded-Encrypted: i=1; AJvYcCUXrKm7rYPOXm6aeW+X82XcYTTUoe0ixyYZ0fuOqhFd7ic29acgtJ8haH4/XrSCUytPVnzvqglhS6EgCrvtPQ7IrJ5Wb6zOhJKc
X-Gm-Message-State: AOJu0YzOrofSIoHitH6q5wH+YkpUxA4WKbUquC1dxl1vQj59iEd0O4Uk
	3WK2ijhDgCwP8aSD6LPoMBk9ci87qK3IESYpm8PCLtySXOqZoOhr
X-Google-Smtp-Source: AGHT+IEwUU6E0kHLfyVA6PUYCDFhGoEmBvsDR1cdt8VHgCW23eVTyMLveQh+gbR/58bmRoDRo/HvkQ==
X-Received: by 2002:ac2:5f87:0:b0:513:c4b5:aff2 with SMTP id r7-20020ac25f87000000b00513c4b5aff2mr1541177lfe.6.1710918167229;
        Wed, 20 Mar 2024 00:02:47 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g21-20020ac24d95000000b00513cdde18efsm2174907lfe.75.2024.03.20.00.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 00:02:46 -0700 (PDT)
Message-ID: <a9b12f52-c59a-455b-889c-786c0a2158e9@gmail.com>
Date: Wed, 20 Mar 2024 09:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio <linux-iio@vger.kernel.org>
References: <ZfHM73ZqgnCp6CZv@cy-server>
 <a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com> <ZfS0Rhk5WTJbwXU/@cy-server>
 <20240316134035.5eb47a69@jic23-huawei>
Content-Language: en-US, en-GB
In-Reply-To: <20240316134035.5eb47a69@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan, all.

I am resending this as I don't think I found the mail from lore. I wrote 
this using my phone so maybe it was sent as HTML and stuck to some 
filters. If you receive this twice - I am sorry...

la 16. maalisk. 2024 klo 15.40 Jonathan Cameron <jic23@kernel.org 
<mailto:jic23@kernel.org>> kirjoitti:

 > On Fri, 15 Mar 2024 15:49:10 -0500
 > Chenyuan Yang <chenyuan0y@gmail.com <mailto:chenyuan0y@gmail.com>>
 > wrote:
 >
 > > Hi Matti,
 > >
 > > Thanks for your reply!
 > >
 > > > I think the suggested-by tag is a bit of an overkill :) I don't feel
 > > > like taking the credit - you spotted the problem and fixed it!
 > >
 > > You did help me figure out the real issue here and how to fix it :)
 > >
 > > > Do you think you could fix the removal of the duplicates too?
 > >
 > > Sure, I can help to implement the deduplication logic.
 > > Here is a potential patch for it based on your help.
 > > Besides, I changed the stop condition in the inner loop to `j < idx`
 > > since the current last index should be `idx - 1`.
 >
 > Matti, I didn't follow why duplicates are a problem?

The function here builds the tables for available integration times. 
These are shown to users via sysfs (if I'm not mistaken) - and while the 
user-space algorithms may tolerate dublicates, they are ugly (in my 
opinon) when available times are manually listed.


 > Sure the code is less efficient, but do we end up with a wrong
 > answer as a result (I've not checked logic, but I'd expect either
 > first or last of repeating values to be used depending on the alg).

If we discuss completely omitting duplicated times from the driver 
(which was one thing I referred in my previous mail) - then we are 
likely to face problems as there can be register values, which then 
can't be translated to times, read from a HW.

Eg, we need to have everything described in driver tables used for 
driver's computations - but (in my opinion) we should drop duplicates 
from these tables which we hand over via sysfs.

Yours,
-- Matti

