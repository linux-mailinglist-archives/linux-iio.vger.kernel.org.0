Return-Path: <linux-iio+bounces-9698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFB097E106
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8D11C20AB1
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FCC1547CD;
	Sun, 22 Sep 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODW2a2k+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28E7DA7D;
	Sun, 22 Sep 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727003248; cv=none; b=PGoiid2o2T0R/edHP2ZgZDYRdql/PYMAqlZHAuF0rmNxX3AAtIIRCXGF3DTBvyXMDD8VOK9/802trzn8Ny/Bn09pkXnR4fpto/3fsKrsSh7AX/dQy+jIfNJYP4gCQheU5CCwJfeHWQ17xNXY/RiW897Ky+0wK0LJp5azKlq4c1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727003248; c=relaxed/simple;
	bh=2IpVwAFd10ZO0WVUn7d5Fc/NJIuuH9awWxy1eETNJjg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntg9FGHimcNa2hClN7mbm3rWLO9ofEtRbwikH4Tng8LPTyBDRWxY8ZSC0uEtmTiH/QMtLhpu/sXD0P0EC7wh0pnhEHa2+UkfS1kj19HZgVNl4GJMx0y6x5WeFHdUWAZYGCojK5x7XIljMaRZ5XeZ+wSjoV6Nps1zhexn0KqP4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODW2a2k+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so32299425e9.1;
        Sun, 22 Sep 2024 04:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727003245; x=1727608045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgtLeaxfiesunEgk8MZX5Vzy4j0v9445AYrKop2nKkU=;
        b=ODW2a2k+3hcsgxDsRj9QsIhAi8wMhA61a0fF3YoLzoQeKwbFCZDwhjx3DZWvwuQ650
         pdesg0kXTF1XwiA9+bIqt72JWT3O9gkHt7LBGfZuHIx1txUk1naBlMKR3cMBdsd7WjtY
         NshdYScbUYe+3WhokdMoLHA8j7T21eanCW5YjsFCnXTxRSaSKUgekxFfdEo8eVwZpYp6
         wQ3/OTWHnNT3q0sidkmA4lhfo4JGiE1Wq28w7hzvERP92O4+/CdVqbYRiqEdSfB3KHAi
         GvZVkqXCB/N2cDEYXiO8HxW4ENz/DaWoFN60uf5ly3+ggaw2LXLNclttIAWp/VBSjxUa
         3oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727003245; x=1727608045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgtLeaxfiesunEgk8MZX5Vzy4j0v9445AYrKop2nKkU=;
        b=ejmJdKzuqjH0Yz6fxd1ufrdUhtjNPKPRMl1hsf6Hmr5TYAkR5+qjOOLyk7TIyEwKEZ
         L35e8te3zU6EH/u6o6Ay/zTz/60PrpWeNf60sTdH9zNIH4QKNyWysXgBO1nMXVVMzMCA
         9foFEa6PXoJiB68b2kjr6KaC1wJjfjr+tI4hTaY/H8u5H8OBYsntNtgCyuq7yjo2dPZP
         6oyfy0jOYBYb0BF7eC/1345fsHS9LIy+bbwhEQjti9Baqz4sjZiPIIbmt69yZgk2qPjb
         /6xuIitoOfG0JrXoV27vPzoiGNV+wmcpI0YgklCynqlsCgDZII0JovTD8+LG9YuMD79k
         vGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnVx+gthegXH8Sr3aOmp6Q1AjoH0kqqvyGTCcDUSsV89/4bS0YIft5d1UiwGE8/xJd8SIOi5sNW85x+UI3@vger.kernel.org, AJvYcCWmTXVuTIJC60STximwHpjCVOyXBQHiIs9qDwSvGW3oxTcnMRfgwBKr064bQyvRL+69uGvmJ56CXlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3uXM9monedGjFK0zQHKIj8Zf4R9KEmXeWV4mdWuy9yCEcBTz
	I579sO/nZY9V5IxYamAT2jsT4lp7j9TRHX8y2Cju0poQ4KJjG65F
X-Google-Smtp-Source: AGHT+IF16sjvViQutJBZr7GMFw3too59eIZ3z0ozXGts5biIDj8Pp/ej4WPI0Wfqxqq7DzWoZrNdhQ==
X-Received: by 2002:adf:fd87:0:b0:371:8dcc:7f9e with SMTP id ffacd0b85a97d-37a42252d38mr4665763f8f.2.1727003244415;
        Sun, 22 Sep 2024 04:07:24 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:a498:414b:b435:bfeb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f051esm21946074f8f.12.2024.09.22.04.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 04:07:23 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 22 Sep 2024 13:07:21 +0200
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] iio: core: remove iio_validate_own_trigger()
 function
Message-ID: <20240922110721.GA439861@vamoiridPC>
References: <20240921181939.392517-1-vassilisamir@gmail.com>
 <cd1df0c5-d95f-4880-b374-a7544a323d93@metafoo.de>
 <20240921200759.GA400156@vamoiridPC>
 <609fdda9-fcf4-426f-84c8-411a59ed5fab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609fdda9-fcf4-426f-84c8-411a59ed5fab@gmail.com>

On Sun, Sep 22, 2024 at 12:44:15PM +0300, Matti Vaittinen wrote:
> On 9/21/24 23:07, Vasileios Amoiridis wrote:
> > On Sat, Sep 21, 2024 at 12:23:39PM -0700, Lars-Peter Clausen wrote:
> > > On 9/21/24 11:19, Vasileios Amoiridis wrote:
> > > > The iio_validate_own_trigger() function was added in this commit [1] but it is
> > > > the same with the below function called iio_trigger_validate_own_device(). The
> > > > bodies of the functions can be found in [2], [3].
> > > > 
> > > > [1]: https://lore.kernel.org/all/51cd3e3e74a6addf8d333f4a109fb9c5a11086ee.1683541225.git.mazziesaccount@gmail.com/
> > > > [2]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L732
> > > > [3]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L752
> > > 
> > > The signature of the two functions are different, the order of the
> > > parameters is switched. So you can't just swap them out for the
> > > `validate_trigger` callback since the signature is not compatible. But maybe
> > > you can update the implementation of one of the functions to calling the
> > > other function.
> > > 
> > 
> > Hi Lars,
> > 
> > Hmm, I see what you mean. Still though, do you think that we could do some
> > cleaning here? I can see 3 approaches:
> > 
> > 1) One of the 2 functions calls the other internally and nothing else has
> > to change.
> 
> I would go with this. Changing the signatures to be the same would be (in
> my, not always humble enough, opinion) wrong. The different order of
> parameters reflects the different idea. One checks if device for trigger is
> the right one, the other checks if the trigger for the device is the right
> one. Thus, the order of parameters should be different.
> 
> Calling the same implementation internally is fine with me. Maybe Jonathan
> will share his opinion when recovers from all the plumbing in Vienna ;)
> 
> Yours,
> 	-- Matti
> 
> -- 
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 

Hi Matti!

Thanks for your comment! Well, I still think in my eyes is better to
have one function do one thing instead of multiple. Also, I didn't
think of this argument with the order of arguments, it makes sense.
My experience is quite limited to how things should be in such a
large project so I trust your opinion. I would still like to see
what Jonathan has to say on this though, maybe he had some
reasoning behind!!!

Have a nice day!

Cheers,
Vasilis

