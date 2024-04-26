Return-Path: <linux-iio+bounces-4527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC76D8B2FD7
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 07:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256FD2847BB
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 05:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03A113A3EF;
	Fri, 26 Apr 2024 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Heq7PJXe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4713A276
	for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110790; cv=none; b=IgORC14ylMopgStxw/GwbNICNZMVnnSyNHuQu64WNrQyeRcaOIqQsJ1mVbX4prCV+fHEcE0SYFc1Ra8xPuq8niS+kDT0c1MxPXrGbHzlVYfclJ6stBVlYOiyIcj8Tp151gd5Tq4aPMbW4k7fmfNAQ8L8qc78BRWtUrczch9/FjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110790; c=relaxed/simple;
	bh=mjfSJojLjfyc1Ua4EXan4g9Y+bMhA/PQF8gLzNbcSp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tih2hHzti2tWPn4tsoEMhUyxt+m6i5WzkJZOHkDiR01TCCYr8HP9jwjC/gI2MfOKhmwSMcOdtv6nH3m1PRG/bxni506gTMcC1XMIBiI42OMtcTu6x/GwgN9BqCE6TWoUZ1ndE4eU/heuBtnpEFjkFETwjtdCayjz6MerEmmjqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Heq7PJXe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2def8e58471so21657141fa.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 22:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714110787; x=1714715587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZwtUDVlOdDebfZ438fIFa5UYJbNZbVv4JUwPqDjjPE=;
        b=Heq7PJXeNHN9NlsjcvhPQ4rgVNHYK1W1u8tS3dlbKsIs7hgIsNduMZnedFYbUDacLl
         6ltPm0Ja0gYHoTnLQroQg2zifxIDGoSrL4bAkP6BaBAWeBpFXvGq6pS7fdleAn8dsjtZ
         IgaMpPEZYNsj+IsQT0KYxh5FccGJXgTHOq3OqRAII608zvbgypJsoaAkY4uoeewJn0SL
         s65SL0uf7gYNNOAxXPOxe+Qb6gNqvR+ZppOzTqC33rPaZKhgX42X0j0rPc7fDdY1+ChN
         wd7T6dB5G4sg8bcv/JZtlzbm5KYEVK7MWZnloa+xA0K2rG/qZ2YaAtQlTFbi4fa1bzpq
         bvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714110787; x=1714715587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZwtUDVlOdDebfZ438fIFa5UYJbNZbVv4JUwPqDjjPE=;
        b=FF9R4B8sVCx2FIjI3owBTcLPk6bpebeHJiO8VznjunWRoBkYVt6E0UX/Be3EW/5EAL
         /gimgWcEPv9M3cm603bZrmZsJQ5t+mb8LMwbHFfrzpfaYtMvPlPSQd/aL/gmI9XjaE8K
         TaeFoX6jAPnXFOAeF4qLbEvaj5st1iaWNiFgJWgrVhbYJ5kgUBC89RhD4lL+DI1zuuv5
         /gNHHM38DPeRwCtTjHoFuPfy+x4nPx53QrFlO0zg6rDO+6L2aVZfLZ8tGG3HqaHPhraQ
         cpTKa9aiMZIuNBwjJsyLqkd7fjdadplyBo5nm5NyTVEryMelsUQp+1aoS0SJdgm1XO/U
         QUnw==
X-Forwarded-Encrypted: i=1; AJvYcCVS8tVKJhwJ5vAPexgWLxp7VBxEowYK/8nOjHCMUG49k0HRIfnnf8Yi2j2lXOdh8qqq8U/GIJsGMi5ZoW9AfbLTgRseeV7Xdb2y
X-Gm-Message-State: AOJu0YyUINRn7BhIaCheNWx/25UZOjDtN38JXZB3IbnsNOH9KtsD5efg
	jZ9u11x4r5XCGLmrX0Yxrjc2KObNmypxe4b/PL63DQeRl46ilFQHqTy9qzIqP6hQUUN38AVpOOb
	2o9V3fW9PF6JeXuuU8UASXRrycxE2NA==
X-Google-Smtp-Source: AGHT+IGFXpw4oH+sRySAFOjqOzov95U6sU9jPDFoyagy2ryNVAIetyc/pvZtA25+8I/YTP7H4nOlhAiYaomz/2EWvGE=
X-Received: by 2002:ac2:4da6:0:b0:51c:c3ef:5807 with SMTP id
 h6-20020ac24da6000000b0051cc3ef5807mr352051lfe.45.1714110786809; Thu, 25 Apr
 2024 22:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfHM73ZqgnCp6CZv@cy-server> <a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com>
 <ZfS0Rhk5WTJbwXU/@cy-server> <20240316134035.5eb47a69@jic23-huawei>
 <a9b12f52-c59a-455b-889c-786c0a2158e9@gmail.com> <20240323181330.71048402@jic23-huawei>
 <b7b28fff-ffd5-41d7-be56-b480dd28329a@gmail.com>
In-Reply-To: <b7b28fff-ffd5-41d7-be56-b480dd28329a@gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Fri, 26 Apr 2024 08:52:54 +0300
Message-ID: <CANhJrGPsdY+ReiOrVsXCCvTCoVEV0vqcyFyEMB8AS+ae5JBBOQ@mail.gmail.com>
Subject: Re: [PATCH] iio: Fix the sorting functionality in iio_gts_build_avail_time_table
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan, Chenyuan,

to 11. huhtik. 2024 klo 15.20 Matti Vaittinen
(mazziesaccount@gmail.com) kirjoitti:
>
> On 3/23/24 20:13, Jonathan Cameron wrote:
> > On Wed, 20 Mar 2024 09:02:46 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >
> >> Hi Jonathan, all.
> >>
> >> I am resending this as I don't think I found the mail from lore. I wrote
> >> this using my phone so maybe it was sent as HTML and stuck to some
> >> filters. If you receive this twice - I am sorry...
> >>
> >> la 16. maalisk. 2024 klo 15.40 Jonathan Cameron <jic23@kernel.org
> >> <mailto:jic23@kernel.org>> kirjoitti:
> >>
> >>   > On Fri, 15 Mar 2024 15:49:10 -0500
> >>   > Chenyuan Yang <chenyuan0y@gmail.com <mailto:chenyuan0y@gmail.com>>
> >>   > wrote:
> >>   >
> >>   > > Hi Matti,
> >>   > >
> >>   > > Thanks for your reply!
> >>   > >
> >>   > > > I think the suggested-by tag is a bit of an overkill :) I don't feel
> >>   > > > like taking the credit - you spotted the problem and fixed it!
> >>   > >
> >>   > > You did help me figure out the real issue here and how to fix it :)
> >>   > >
> >>   > > > Do you think you could fix the removal of the duplicates too?
> >>   > >
> >>   > > Sure, I can help to implement the deduplication logic.
> >>   > > Here is a potential patch for it based on your help.
> >>   > > Besides, I changed the stop condition in the inner loop to `j < idx`
> >>   > > since the current last index should be `idx - 1`.
> >>   >
> >>   > Matti, I didn't follow why duplicates are a problem?
> >>
> >> The function here builds the tables for available integration times.
> >> These are shown to users via sysfs (if I'm not mistaken) - and while the
> >> user-space algorithms may tolerate dublicates, they are ugly (in my
> >> opinon) when available times are manually listed.
> >>
> >>
> >>   > Sure the code is less efficient, but do we end up with a wrong
> >>   > answer as a result (I've not checked logic, but I'd expect either
> >>   > first or last of repeating values to be used depending on the alg).
> >>
> >> If we discuss completely omitting duplicated times from the driver
> >> (which was one thing I referred in my previous mail) - then we are
> >> likely to face problems as there can be register values, which then
> >> can't be translated to times, read from a HW.
> >>
> >> Eg, we need to have everything described in driver tables used for
> >> driver's computations - but (in my opinion) we should drop duplicates
> >> from these tables which we hand over via sysfs.
> >>
> > All makes sense. Thanks for the explanation.
>
> Hi Chenyuan
>
> I don't think I have seen a patch fixing this merged? Do you know if I
> have just missed it? If not, do you still plan to send a fix to this or
> should I do it?

Jonathan, seems like Chenyuan has gone offline. I'd like to get this
fixed as it'll bite us sooner or later if left like this. What's the
right way to proceed? Should I craft a patch and add signed-off or
suggested-by from Chenyuan as he has done most of this already?

Yours,
   -- Matti

> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>


-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));

