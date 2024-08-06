Return-Path: <linux-iio+bounces-8267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64052948C38
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 11:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAEF1F228E5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33DF1BD034;
	Tue,  6 Aug 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJK7muSq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47E5464E;
	Tue,  6 Aug 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936995; cv=none; b=XsN4l4q6qy3Wxqhj9XTlJvxkx/KQBWX6YZ/2ncjAdFgQT8iQYPjeQ4drSCig4XRKvNsZEzciGTGVi4xvY1S5s/YFFyfl46ZP0im4+jmwxejkLk/+sPTVuC5cgk1fEk3/9Ecb2st9Xk01VymrAsT+FgyknHAh4Xmzibt039OxkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936995; c=relaxed/simple;
	bh=+zkJokAmmFgwU+N0NvTSkW9+gD9wFOa+HQl0TJrSAoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COMKtOMIo/DmQhGtmKhnX8fvWrApnZhpBpYSxYXY5qnE+RR8vmbTwehNT/mOOXjKGyA2odE9df3xi7lASuy81zZLzVJvFzju4gCaTfUyIe/x+4bIFI67Yd91GpwOd/8QhD2ZsR/n3LGEus1FuE0hrTAfzByDNEj/nwp3po4kUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJK7muSq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso3650211fa.2;
        Tue, 06 Aug 2024 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722936992; x=1723541792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=friFXl5CaLmYBm2Vyahe3SBQ1/GEd0V6mM2m8uh7kIo=;
        b=DJK7muSqjTrDHkEJv/huKoazFY7ZaJh6bvmA9B71YMEGWL6WOvws3D49gGeo4PU34Z
         7t4B0D04qPV+DqL0NxUtu/rr+obB7XxQXrY0MITb16xntmGINBof2Yi72mylfpG+qysI
         J1Dh1VFBiUlsOLnFoNgA9oYjXg3JZnzh1liUr1+Ed+IICyWbBHEtZFG7hAM/DlljPPth
         Ka2HI9KUgtjtSJHH3IjPLiO1Iu0B9hocpS15tXKHSI7RDINaLHdGDLObhnsCQkkXGSQ/
         lDknW/BwXJXWQ/SR6UEny1Cwsq0wadb30xr+csbBHaOZHpovVgMrz65qxbKeuxHf6Wsb
         nSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722936992; x=1723541792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=friFXl5CaLmYBm2Vyahe3SBQ1/GEd0V6mM2m8uh7kIo=;
        b=vwDBZUsWGUSfmOWlDl0sSeNtOE2AOQUPsCVDmX4VErfnjWykq4YLWHRu/6x7cW4nxn
         etvDkSVBjbsa9kjlSwXT2LKT0R92Xh4lHS9Ofr72xMBjCe2HQRRX2VjiQXF4YsVu8lgD
         /IkPgYiVk0958eoHdu7FdteQAEmZtoS96/RBCUo7nphtfCOsoDv0voWaGxBO5KmijLlx
         yaQSzexD52SQI+aap2gCvdf/9K/EOgz6s8UAeMLgU9534dIgGD8sCrU5vELJrHO8Mpyj
         2np2mskPCmO7JIwIWhKOHLkHhc5x272+n7DYa185R9SDqrIoOP916DBTKdOLcrjR5lxC
         TdeA==
X-Forwarded-Encrypted: i=1; AJvYcCVzR1MJFwfmqU/JdjUgwTgYg/VtQW3xbJmEbAv6WOf3lu/DWSjLm17qI8ObKLzB+F6lKVhQJGn/xGJNnxHbXmbv+Ubn3h3IzKOziiQf
X-Gm-Message-State: AOJu0YxMyMW/E4pJ225h78HOlzvd+bbXphZJbACFChu76jsh+O5f6ztZ
	4tUCvq/GzVBD2IfKbsR+B9lS9rXPyXPtU9QejVHoPfGrcE5Rab6S82kv3Iaz1ejwtauRQcCCq33
	Cok9nYCGWvToEEljx+0R7Y5cHqcHyvS5EopBm2g==
X-Google-Smtp-Source: AGHT+IEv51oosfe3wDorXVp8GIvXgCFAMlTGSG1FlmhIbU+fWYeVxK5UpIgC7sTYmCPc4BdlTpVfXpMjjs+gLM5Qo1M=
X-Received: by 2002:a05:651c:10a5:b0:2f1:6cd6:c880 with SMTP id
 38308e7fff4ca-2f16cd6c92amr66781811fa.37.1722936991801; Tue, 06 Aug 2024
 02:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801143857.16438-1-abhashkumarjha123@gmail.com>
 <20240801143857.16438-2-abhashkumarjha123@gmail.com> <20240803145836.4e372899@jic23-huawei>
In-Reply-To: <20240803145836.4e372899@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Tue, 6 Aug 2024 15:06:20 +0530
Message-ID: <CAG=0RqKoMTSYFxHvgVc_mOQSg9X0Y4kQuFoN4ReRj0XvYt0bNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: light: apds9960: Add proximity and gesture
 offset calibration
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 7:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu,  1 Aug 2024 20:08:57 +0530
> Abhash Jha <abhashkumarjha123@gmail.com> wrote:
>
> > Proximity and gesture offset registers perform offset correction to
> > improve cross-talk performance. Added `calibbias` to the proximity
> > and gesture channels.
> > Provided facility to set calibbias based on the channel number.
> >
> > Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
>
> I nearly applied this with tweaks, but I think there are enough improveme=
nts
> that can be made to make it worth bouncing back to you one more time
>
> Thanks,
>
> Jonathan

Hi Jonathan,
I hope I understood what  you were trying to say correctly, I made a 2D arr=
ay
for the registers and then modified the set_calibbias function accordingly.
Here is the link to the patch v3 :
https://lore.kernel.org/linux-iio/20240804134212.51682-1-abhashkumarjha123@=
gmail.com/T/#t
Do tell me if there is something else that needs to be changed.

Thanks,
Abhash

