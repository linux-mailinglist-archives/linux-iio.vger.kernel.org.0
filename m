Return-Path: <linux-iio+bounces-27134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105FCC6C84
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09666301705E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01A314B7A;
	Wed, 17 Dec 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deH2tIfd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313833986E
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963533; cv=none; b=RWpK3Vi4dpLAL893bwGkJWDWlbJ8BYGK3MQhncqX1+fcbLP5l7s9NFhPReSUjKQczjlI2Dua02JMJhvD3bk3esLXsn2CxEAgmsKfFq0zMccbG7NqCBb2PHY/jCWr5E3C5XYavUfpaBK/UTEH7eODGZcHU2077fy+ealAuc7jb8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963533; c=relaxed/simple;
	bh=mh8sWPmSpWx3ZdkV9IT1FsYBpWFgM3TDmQCsYyUuY4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ssl3aPHPxjiqjiSAEEVezg493MHmjgfpJJ6f+oX4TiS75PC7RurRFAkj7byRLJtUxLa9yrvCQ189sNSvZ7bOyhhVvyP/yGLiM+0Dvd5CY0vDPrGcT92GkXLqQeX+vTXszFhgZ4dkWztWl1+/k0w8NHqHZUlgn2dFo66vaaB0iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deH2tIfd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so32787225e9.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 01:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765963529; x=1766568329; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mh8sWPmSpWx3ZdkV9IT1FsYBpWFgM3TDmQCsYyUuY4M=;
        b=deH2tIfdegTEXXDfZNaDG8rU26H/FRtEwL8Jbx5YtbxLJNNb4OkCujcH61egVZAjOR
         HLlyMn3pog6zIhMfH9JTF8qpzPPdT4PF1SOF8wrhjVNmXdZ9g6ZJh53EeR8UBq67UFU8
         35ZZ1ggrctthZ6zFkIAe+2381IxtqLwh5NfzpA4oU8FIPmjFkAC73hr+LEWAtnKwY/mG
         fCLXC8LU+tDW8qc9pWVsSec3DIeRiQvNhbsUxjduAbCFn4VkHrhFkFpfXRGuEPOWd++r
         lXTq4cxM7mkwwYV0rvOdE0g/jlnBGKTrIDGe4a8aY9Y/5fC9+Yz3/cqkpvCNB5CKlu/h
         vUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765963529; x=1766568329;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh8sWPmSpWx3ZdkV9IT1FsYBpWFgM3TDmQCsYyUuY4M=;
        b=ZYcD7Sv4XZzSLtJ2fnBKt30wyfTNaQ/1Kpmar6VNUdR5NQskhXVMrqCbGleFyUCMuC
         VMGZZ85Do4pcZocEFjqyufpfUuDPF+TCeWPwm4d8VyTqMCHqU3N2xUELhYtDYAz8t8PO
         gpYFTZi35Ok6MfGewnjx3McgWljINyfi7sBzzcF1vmgB90AJ9Li0tQaW3J2jB/2rPlEY
         EUOxRrLQ3Bma+sZYRZfHXjLOPeKNIXeyzEoU0rFJYIdxIXQ4L0SPXv2Ed3T4CPp+BW+W
         eLYO4XWx2+GtKgVuGl6Ug2EyCaugXplxGGBXHcTeAonLuWqcNNSnf65jmTGBW+N253nM
         hZAQ==
X-Gm-Message-State: AOJu0YwCNsBgw+GlmSLkdcYUEn4kUTqFKZQcHwr9gXmfAvajWcY9sWgS
	/PEaBm6SRKXkar/+pfZ14KAG/egQ4r4NQO4Cl3JllglSRzJx4ls1RG2R7nOe9g==
X-Gm-Gg: AY/fxX6rUDL7GLszdRp82/Blr9y0y86+aVs4OovxG8VXCjhN+UsBcaURIxVAwS4Lilz
	HX/Z9p7Z8FO+cHqwmlqd9CshErjPqc/8G8Hsd3IC4U43kwAxgDnyA0mzdIq4boJgqdvweDVb+63
	w3dze2YaBmFyiPXeNht3U3b4IbGpfcaipxQmWZG1lkw+hATTZWn1GKFrzo8mN4HyPkYVVTQClvW
	7mpeW+SOSFW81ukgLYY6wboBGXXJgHTxAsn0s0Sh557S2yxAwopN+N7GkTlYDi5TvCRG055wA8J
	MQ0MG23Z07+yS3e+7sjirPnSYhQqN3aGsFA0+OqT5SG5eCWKwVMNoM6PCpqjr8KFsxHaIWGNOwQ
	gqez4gzbE3nGkdTKPnT0rnAA7BKwq+6sEwMIfXTZLv5bHbLq1e5tvxHURY2oWB0hl72ZLgHGU7u
	6dPyLO/8aE1QE=
X-Google-Smtp-Source: AGHT+IG2ersucBiyzONpcJgR7W3RTu2Yc+gUs2vocQ0U+PZmiVw3HjlOZQIp3HWvl0bVa4juC08aWQ==
X-Received: by 2002:a05:600c:4691:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47a8f90ee62mr196853745e9.26.1765963529027;
        Wed, 17 Dec 2025 01:25:29 -0800 (PST)
Received: from [10.5.0.2] ([45.94.208.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be011cc67sm1644745e9.10.2025.12.17.01.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:25:28 -0800 (PST)
Message-ID: <c3ed08159082c15f8804c6963b4422bbbf2039ab.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 17 Dec 2025 09:26:10 +0000
In-Reply-To: <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	 <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
	 <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 15:39 +0000, Tomas Melin wrote:
> Hi,
>=20
> On 16/12/2025 14:56, Nuno S=C3=A1 wrote:
> > On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
> > > Not all users can or want to use the device with an iio-backend.
> > > For these users, let the driver work in standalone mode, not coupled
> > > to the backend or the services it provides.
> > >=20
> > > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> > > ---
> >=20
> > Which users? The only usecases (for all the supported devices) we have =
require
> > the FPGA backend. So do you have a specific usecase for a specific devi=
ce? If so, I would
> > prefer an explicit boolean in the chip_info struture for the device(s) =
we know this
> > can happen (unless you have a usecase for all :)).
>=20
> This is generically for all the devices supported by the ad9467, not
> only a specific device. So it's about how this is used as part of the
> design.
>=20
> This is aimed at users that do not use the ADI HDL reference backend
> with these devices, but instead have custom backends suited for their
> own needs.

Hmm, ideally I would then like to see the backend driver upstreamed...

> In that case, we need to be able to skip the backend registration and
> register device as a standalone iio device.
>=20
> Hopefully this made the use case clearer?
>=20

I mean, I don't love this and I'm not really sure I'm ok with it. These are=
 fairly
high speed devices which often do require an FPGA IP to handle the data flo=
w. Now
we can ignore the backend device (which is an essential piece) being it
expected or not.

Or maybe we can just do something like regulators and get a dummy backend o=
r just add
some fixed kind of backend. Bottom line is, it still seems the backend devi=
ce is a core
piece in your design and we're just hacking around the driver in way that c=
onceptually
doesn't make sense to me.

Other question that comes to mind (I guess I was not that clear)... Do you =
have a real
usecase with your own custom backend IP or is this just theoretical?

- Nuno S=C3=A1

