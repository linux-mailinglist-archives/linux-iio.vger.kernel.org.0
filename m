Return-Path: <linux-iio+bounces-9861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB39894CE
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8C7284CAC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D613C918;
	Sun, 29 Sep 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inpW7Gcq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2BE3C00;
	Sun, 29 Sep 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606176; cv=none; b=a4jCjGpqDiKe+adRuIArvanoPrn1SheTzsXYfqPbmrqn5FkIa5SRmTrFDsISke6zgvJBiRMNgBVeFpnq+0eX5Y8iyYUEL6AZebMfcPyp4snse4SRNIvcfZEJkyUTEW4EbtbSHNDWp3senUpDl8e1Grd2iwZfbEXx6AfBZMJdNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606176; c=relaxed/simple;
	bh=L+m3z5juxvucEe7v3SkSQR6CEZUKaqzrIk23dnU8/iU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QceS0rl4c5yuLW4AFxwCDzNBo0EeZwLkaD16LoA5vzG25tRTj9xqEpdalpAqwnwtcI1gHmlkNaH86rQeoKEcQNgNZrIhstsnKx92DStOrIKrU6NaYeYwn0BCW/D6TUKJGieee7SBpkLYp3PvLi7LwLAD+M+gcEyhZsgKzXBeTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inpW7Gcq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso26748615e9.1;
        Sun, 29 Sep 2024 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727606173; x=1728210973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nf+Wy8xYMIhQ8PaFRVi+iGpVsERjKRIneHV2Gc2riLw=;
        b=inpW7GcqbB1FTXNIrKtzZeFaDifFiPMtRR+ewxlW81mEMw4O+Dl7iahCWYFcdajNTj
         +Qq17QIWhxuq5KugfmKspDgdg5ePl1O/ZwqTi9aDkfTKQ33Zw3FRP7a6k8aTPbkV4dTu
         gkUISekzc6PIDq+e138r24UpZWb3Sjj+gskJeaPkYI+iUCeYX8yiNJGYxBq8qVdTqHB1
         AVisY7nvrW+5DSzlzxNDwqz9vy1Am9rbOTzbjiiRT9rT948S/SBs4T76r8BnxQIXe5OI
         SQiCzvxM5k1qJuySNmJCqoowynKZA+kRdIpzIHnYVgKx4bNB2hrFRISn4etYaRE9JYTE
         MO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727606173; x=1728210973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nf+Wy8xYMIhQ8PaFRVi+iGpVsERjKRIneHV2Gc2riLw=;
        b=aqKmAiSmGArkkqwS78x4/NTiVtifINCyJbn2GD8cmDWIV90rQSaw1NDw8WeZPhq3oR
         llZO+5APcpDBSBnI4y8UH5bry5rBLQboFtd32Slw24vb0G+RxfvQRWV5q5g/gzzOhiHC
         gtvz5vJnpmpiMT1Lkhh/UQvPbIx+7dMJLZ5S96/hh5soPkAzDAzPrJtsCaDS/7uIeCcX
         IfnMVkuL1N8TGllzeLkvxqWOg35iQDRpNIHsDhTMuNvf38A8/hNKZTUAc+I8fSqBMtHj
         fid+QzMMX6gWZtM0f4Xs4KmlLFw104a12FAtWA6mkaCHCS5vC1ndZ/tIqLuUmCJ2nW09
         OZiA==
X-Forwarded-Encrypted: i=1; AJvYcCU2CsiSOaKdvXEbt4SDDY1nG+M6cOHlggMHP9kP95wQINO1vrelglI+Jii8NgSjX+1S3n+vvmJaOrislgp/@vger.kernel.org, AJvYcCVg/s5cgx3HZ219dhxogRFSDx8RSY3aIdY2DBSH90TR2P5VBmybG/4aJvxzdwB5rLrX3YcVJJhoqlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WimhgxZFymL/MTPcG6q7W2Oi2EMd0Z7KKROmuU0YwmKo7L4f
	Mdd+T4VlvEtS0c9p53ywIr8ETBB8dutJ4RjTlXn/SxIDEU2JN1iy
X-Google-Smtp-Source: AGHT+IHXdXFCRYgTs+0lE8Ro7LHGvSVpcpleFTuQGBMxRAdZHVVcUkfxLmeVUYhOkki8NxL489j4Tw==
X-Received: by 2002:a5d:614f:0:b0:37c:cbbb:10c with SMTP id ffacd0b85a97d-37cd5b07267mr4961856f8f.52.1727606173346;
        Sun, 29 Sep 2024 03:36:13 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:4d6e:df7d:f1c8:ebc2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57427b9sm6540982f8f.95.2024.09.29.03.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 03:36:12 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 29 Sep 2024 12:36:09 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] iio: core: remove iio_validate_own_trigger()
 function
Message-ID: <20240929103609.GB92011@vamoiridPC>
References: <20240921181939.392517-1-vassilisamir@gmail.com>
 <cd1df0c5-d95f-4880-b374-a7544a323d93@metafoo.de>
 <20240921200759.GA400156@vamoiridPC>
 <609fdda9-fcf4-426f-84c8-411a59ed5fab@gmail.com>
 <20240922110721.GA439861@vamoiridPC>
 <20240928155519.1112f995@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928155519.1112f995@jic23-huawei>

On Sat, Sep 28, 2024 at 03:55:19PM +0100, Jonathan Cameron wrote:
> On Sun, 22 Sep 2024 13:07:21 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Sun, Sep 22, 2024 at 12:44:15PM +0300, Matti Vaittinen wrote:
> > > On 9/21/24 23:07, Vasileios Amoiridis wrote:  
> > > > On Sat, Sep 21, 2024 at 12:23:39PM -0700, Lars-Peter Clausen wrote:  
> > > > > On 9/21/24 11:19, Vasileios Amoiridis wrote:  
> > > > > > The iio_validate_own_trigger() function was added in this commit [1] but it is
> > > > > > the same with the below function called iio_trigger_validate_own_device(). The
> > > > > > bodies of the functions can be found in [2], [3].
> > > > > > 
> > > > > > [1]: https://lore.kernel.org/all/51cd3e3e74a6addf8d333f4a109fb9c5a11086ee.1683541225.git.mazziesaccount@gmail.com/
> > > > > > [2]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L732
> > > > > > [3]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L752  
> > > > > 
> > > > > The signature of the two functions are different, the order of the
> > > > > parameters is switched. So you can't just swap them out for the
> > > > > `validate_trigger` callback since the signature is not compatible. But maybe
> > > > > you can update the implementation of one of the functions to calling the
> > > > > other function.
> > > > >   
> > > > 
> > > > Hi Lars,
> > > > 
> > > > Hmm, I see what you mean. Still though, do you think that we could do some
> > > > cleaning here? I can see 3 approaches:
> > > > 
> > > > 1) One of the 2 functions calls the other internally and nothing else has
> > > > to change.  
> > > 
> > > I would go with this. Changing the signatures to be the same would be (in
> > > my, not always humble enough, opinion) wrong. The different order of
> > > parameters reflects the different idea. One checks if device for trigger is
> > > the right one, the other checks if the trigger for the device is the right
> > > one. Thus, the order of parameters should be different.
> > > 
> > > Calling the same implementation internally is fine with me. Maybe Jonathan
> > > will share his opinion when recovers from all the plumbing in Vienna ;)
> > > 
> > > Yours,
> > > 	-- Matti
> > > 
> > > -- 
> > > Matti Vaittinen
> > > Linux kernel developer at ROHM Semiconductors
> > > Oulu Finland
> > >   
> > 
> > Hi Matti!
> > 
> > Thanks for your comment! Well, I still think in my eyes is better to
> > have one function do one thing instead of multiple. Also, I didn't
> > think of this argument with the order of arguments, it makes sense.
> > My experience is quite limited to how things should be in such a
> > large project so I trust your opinion. I would still like to see
> > what Jonathan has to say on this though, maybe he had some
> > reasoning behind!!!
> > 
> No to changing the signatures. It removes the difference
> in meaning of the callbacks even though they happen to have
> the same implementation in this very simple (and common case).
> 
> In the trigger first one, that is the subject.  We are asking the
> question 'is this trigger ok being used for this device'.
> In the other the device is the subject and we asking the
> question 'is this device ok to use this trigger'
> 
> When we are checking the combination you have here, sure they
> become the same thing but there are devices where it
> matters that the trigger is not used to drive other devices
> (typically because it's a hardware line that goes nowhere
> else, so no interrupts etc) but other triggers can be used
> to drive this device (often by software triggering the scan).
> We have the opposite case as well but that's often
> a shortcut when it just happens to be really complex to get
> the trigger to reset (often requires reading all the data
> or similar) - that condition can almost always be relaxed
> but sometimes it's a lot of code for a niche case.
> 
> So fine to change the implementation of one of these
> checks on tightly coupled device and trigger to call the other
> but don't touch the callback signatures as to that breaks the
> logical parameter ordering.
> 
> Jonathan
> 

Hi Jonathan,

Thank you very much for the explanation, it makes total sense.
No need to change everything I think, it is a very small thing
and maybe even better like how it is now from what I understand.

Cheers,
Vasilis

> > Have a nice day!
> > 
> > Cheers,
> > Vasilis
> 

