Return-Path: <linux-iio+bounces-8297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD271949695
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526911F2722D
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FA481A3;
	Tue,  6 Aug 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgRr/fm1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E644C81;
	Tue,  6 Aug 2024 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964824; cv=none; b=Bc26PZWNVi3IyPGEg3uC5GnwaFoGbVvv0UOi0HHuvZSMM68oXpl/fidKhY0Qrs+q+zDjDRGMNFZKLZ3L76IFwqKX99pjrVtL8zjiF2LfKLzGqJ5XZRSRjc0iIe8spbMoT8zYV9GYSBgfkv/+FukyKbCCTUdPPKCK7BpeNJ4fRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964824; c=relaxed/simple;
	bh=QqbvnXDPvD7nyES6YjI2mFUe5RYhtsVohxek/3Tzbok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfCqx+UjnZovDPvryAWHlkFsH5bdzTQKQOVw581nmAr0qLrOG/AjFVuHXFedHQ/z0PPynU9w1zurF+h7QnVTWJgJFZL87Ahwyako72dPiJxxWPMv4aBlbpqx6cK9ZSsOYZva2AugN/nOK5oN4Birl0z92NRMTEBGvoXTXUZzjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgRr/fm1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso10336541fa.2;
        Tue, 06 Aug 2024 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722964821; x=1723569621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X+aYSSNv8a6wuzwo2EcjpjYYr4doVkE1B+J9kwuUIdg=;
        b=XgRr/fm14bexuUFvIlAg3V+4uVrbCMyK3YsniIc0BL25zWHPWbTdUDzDqxSD1aoNCw
         bV9gn4hov6nAPSZAf+vBwhvKo86zAudkuhO3dQ4nFGsPywVfdOl/wWBM1/PHrVIUYuwt
         bPkiJG3cGZRPIP1KMfgUhC7N1rRCKk6+YVGUIOkEdyt0SmhY1EBASQH52C2QSo4CBGjT
         eZDvHq8Jlr3k1VU8yuVyPpB1MHwEmbJv0scgiBLfi1Ic5Z0rVIoqkf5CeprtG5XuHoLm
         9tfW+L5OiEvHKK7YoHuBTGFGUYioUFjabZduDMzUxeHCK3UzPkUK+ghqaYCmZt2C8PoY
         R9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964821; x=1723569621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+aYSSNv8a6wuzwo2EcjpjYYr4doVkE1B+J9kwuUIdg=;
        b=O116aGDGFhEv/bC4MGnwx2DkrWqJIpFXsJzEHJdwZ0/H09qSI58CqMhbmR17dA3AXz
         M6UNNycqJ3is/enB8EVkXVwZ5ns7VgldWpuvHtI/iFw9j1j9pOZG9mZFTua9keINsGCl
         Z/DSftTwYve54FmH3MJlrum68r6on61g7MEia2HbRSimrK71NdL0A7ZUcX9YPWYYb2/R
         uguKgCl5EaLluwozW1hKABdhtQJMXE/u+nLA/5d8pJ0BWToDM4EwfYBvoh6O6x45nIPN
         aiGtFOCgwBUvIohFireiVKoHKe51m7eWFj2OizCAAvoSaBxVCyqPv+tuhNaQN/AERdbP
         /hiw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ878JUPjLLHkDJmET6sIaHz5+Xdf55+UQSn+kotdwgBLh6eBGUOVS04dHTBDytuHqd/hV/RAyZEkWdW0caIbwqEfbwTyLbCFIVujf
X-Gm-Message-State: AOJu0YxxhvqIYUA7HvrZrrPn/aI+a+lW1HA4O2Zct9K+QUbh2FT/ySy5
	HihGVPkzlkEZLQzcBAtxi6xJ30/bINvUvhVv797NMqFOc3nyrPNY6evzgsjHcDGvEgL31fkbA9x
	dicunQLxYBE/c5uWpVnGB92DEIP+32JiW/Ek2wg==
X-Google-Smtp-Source: AGHT+IEEZMD1QjoF1lVRRdrLVUue5NyyeHwSwW5woypnb52wQ0huZpyLKzmzzuAxcW79Az58WKtwngF8gDSQmej49sk=
X-Received: by 2002:a05:651c:212:b0:2ef:185d:e3d7 with SMTP id
 38308e7fff4ca-2f15ab06524mr98098071fa.38.1722964820843; Tue, 06 Aug 2024
 10:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
 <20240731063706.25412-3-abhashkumarjha123@gmail.com> <20240803151033.359e8586@jic23-huawei>
In-Reply-To: <20240803151033.359e8586@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Tue, 6 Aug 2024 22:50:09 +0530
Message-ID: <CAG=0RqKr+Fe+dM_Vw7Dm0YzSJNeJTLqARKO1VmgDMQCinHJvew@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hi Abhash,
>
> I think I managed to confuse things with earlier reviews.
>
> We want a light channel here, but because the scaling is just linear
> we want to provide it as in_illuminance_raw and in_illumiance_scale,
> not a processed channel.
>
> Sometimes we have no alternative to a processed channel (typically non
> linear maths) but when we can present the scaling via _scale (and
> if needed _offset) then we do that.  This avoids a bunch of future
> problems:
> 1 - Processed channels are a pain for buffered capture because they
>     often need a lot more bits to store.
> 2 - Any events on this channel tend to require fiddly reverse lookups
>     to get from processed to the raw value that needs to be written
>     to the device.
>
> Also note we very rarely provide both processed and raw for a channel.
> The only exceptions are corner cases such as having to maintain ABI
> that we should have never have introduced in the first place.
>
> A few other comments inline.
>
>
> Jonathan
>
Hi Jonathan,

I have made the changes, can you look it over and tell me if it looks good.
Link for v7:
https://lore.kernel.org/linux-iio/20240804142321.54586-1-abhashkumarjha123@gmail.com/T/#t

Thanks,
Abhash

