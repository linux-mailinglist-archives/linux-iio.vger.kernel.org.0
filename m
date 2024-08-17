Return-Path: <linux-iio+bounces-8566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746895592C
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1118C1F21C26
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C815533F;
	Sat, 17 Aug 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfWRMOC4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2755C2E3;
	Sat, 17 Aug 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723916273; cv=none; b=itTaTyAaa17WxUttL59TcbsKecvwhbFMzG3MW3IOCQWjDUNoG5GYBowegwmD0pd/tSAsBCmDtQFWCEvrUN5iXbo7YszP7g7NsmOQuKU+v8X8iLdD73pQfoGvMD2WN55Z+JXLsXrXCZp2Hcrjj3n1KHEzPx/8FzbXZgEKzq33tDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723916273; c=relaxed/simple;
	bh=+cEI/xItrRT5nq6RI5L8xglbEZ+sSMqu2zck20RBW/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkZrmRJ4Ywd0oTixwqQ4+6q1ijBMXcLfQzaPSeKafnFthMx+FrPEUckiThZGerAgNBckqv/OhavOZ8zx1Rkf8r63efD2QWggSaE9pMphQ1VQD0m31YVo/k7U6au/P6XuUAKeFbRpaX3Z1ztxvDgZ2JKNNkubohiybu8MNiXw80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfWRMOC4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53310b07267so3998253e87.3;
        Sat, 17 Aug 2024 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723916270; x=1724521070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0SZvSC0Uru0/uzuhZQvmWzgYlBLlTeTbI1JzeU/3YS8=;
        b=WfWRMOC4REr1xvi6juzqysbrxK/y84VKOOwZlaGzVwlN5s2sqMS8s4f5o3bapxHnu1
         sLK1HYWRoITiw6xWiQ16K5GAFg/LxI/kxRWIFqoVzOgiZytVx5qenX8PtBvrqeYChNVE
         qT0EBkDKd7OJv/ceOwGXdKkAHMZ5tnCWOgrXRAXH615UgJXbN2OOtodKsAdJm8Ffy84D
         HekupvDPL6nebaWp5d90uyuorYsXhQpaDBTbYrsictGjDRCvxoZqmRaMpVfPg9hQNCT/
         PYlYNVh+YFKt1IN1h5fWOjzgPF7IxykMQ/bNetbM13fGEPcjfhOyjX3NHc7grxU4+Xvl
         53xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723916270; x=1724521070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SZvSC0Uru0/uzuhZQvmWzgYlBLlTeTbI1JzeU/3YS8=;
        b=do4e9Mo6ba2lFvJCf6d5apKZOZGyp2VIBO5yTkZYe1zyEXRWfIxCaiWGxxR7D8cTHL
         Vu4VrNzRCZ181DDQYo24eIyMtB32qATzHI4pptqT6fpopo4iQ/2NwA+JIRvp644+e1gW
         Eh18VQXiNsF5GqA9QukkgkxxO4WcDJZSgtNgF6w6ZlOSFmLQ6LMoBPkkD285pmYP0bKk
         pTZi5gbGA4Kw5UQWhHLQoMrC3OwI/HXulM++gfJ0ZEOSxrVbx9l9bq3Mk6/JFjdjtfdj
         YUesFB7lqOjNg12WfugF7qocaptAqGopEg36RXYSv/cDm51rTPnT52AcPPW9E8pBez/W
         UYjA==
X-Forwarded-Encrypted: i=1; AJvYcCWoBO40piGuYFrjWzqkQ7PqglGrmhiTMnYKuo/JoQR5w7AgMXJgUK4V/xAc3ya7FpazpiDUKMwyjZV5hGhtPTX6tc28+bmkEnnHu19u
X-Gm-Message-State: AOJu0YyLZcu5hyOJz+bVgkk/HjJanZGVGhmzyTQ985c1QVFDDHdpnrW7
	ahIi4AOlprQxloTRRbNTJ6Ig3QgeVQjNJC3RIMahmbyditx1YmXwwp8Bmhpwrna4xhNMgLyeYy8
	bDigekcntQs1tsCumyAD+tJyBBZw=
X-Google-Smtp-Source: AGHT+IFk1aynC9pVGiMcTqJmEk0gV5pciM6iNSSDMpa1ydVTYikM65Lzkvw06z/6iX8MFFspmExGzbXANomBqn1ewZI=
X-Received: by 2002:a05:6512:b01:b0:52e:932d:88ab with SMTP id
 2adb3069b0e04-5331c6aff01mr5250435e87.23.1723916269384; Sat, 17 Aug 2024
 10:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
 <20240817153953.1743e020@jic23-huawei> <CAG=0RqLaigoVLN2D9LEfC0_1ctJO6OzwEgpeOx8NQavB4mZxoA@mail.gmail.com>
 <20240817174919.5583f28a@jic23-huawei>
In-Reply-To: <20240817174919.5583f28a@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 17 Aug 2024 23:07:37 +0530
Message-ID: <CAG=0RqJN=M5+w4CDXggDnoyOrW5qxTejJy=UkzMQX36emFT5fw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add light channel for LTR390
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I think I have.  But with two versions of v7 I'm not 100% sure which one got picked
> up. I've pushed out now as testing, so take a look.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
> >
The two versions v7 patches are the same. I had sent the same thing
again because
I thought it might have gotten lost in your mail.
My apologies for getting you confused.

Thanks,
Abhash

