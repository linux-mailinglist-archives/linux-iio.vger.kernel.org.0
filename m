Return-Path: <linux-iio+bounces-25562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B4FC13D1F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF5B3AA66D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57D72DCF72;
	Tue, 28 Oct 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFzeK94G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658D2FFDDE
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643649; cv=none; b=rX6Ktgw/9s90Z/pUea256T3VsgoNgDNljMsMsiOd/GPB+ThZ9Fu9tZP48+PJLAABOv63aiQQ+jYMhlf+tO7judgc5bd/zqt+P2nVVaXKEDCBuNLknTM2LoU4rKS2h6d9JXM57u8cHstZMgNNPwF7nuwJKPm6/rHBWZgSQvoMRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643649; c=relaxed/simple;
	bh=2nzO/Lgis0CGEF4PRwALL8keP37eKj0EffWsyrHfk8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POdlOQvowCBNUczmq4xiOpPzuv8N7P++QArDFTSO/6ZGtQX1BN3jBPo9u34eBr8PM7u0tpfCv6nO5ndWzGJkVqr9ul9gI8kfEuFLs2FZOIpIENV+LQm679z/aWC7RyQgvdO9pHu/ae97QPNLD8g6/EXNmbNlas+L3a6FKLuvexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFzeK94G; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so5846067f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761643646; x=1762248446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fa94rq4LY4WzohJQBw+1+fnrKto/qSLOJsPZx6Z7XI=;
        b=gFzeK94GevHbhOMiC3e73zh2DVpGzeNYpfuermoLx17CgcM1z15E0c7VRnKDatBmJ9
         jBfbONzCHIDfmkUHshBA01wOYhy7sios20iu02Ik00nZHUM4tWkWWSHSA9CM3zEyFn6P
         BpUBQe3jLgkj3+jUqgzA8PIVc9kGACoPAYrDjZeNcOJWpMKKCyuHGDhm63G3N7WQ2CZ2
         1DkV+0ij+AhS1S6s/bO0/fbzdUsOIK9RVU6t41G06Ox5M/drv9NGsVvIuFivpw1IJaeX
         PF0SVq6RaPCfVb7CZxPQOijIHwDp+xe6SQ67OSGT31LA3hK/5LiY9Dh7Jk6bXRJMayVY
         Zu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643646; x=1762248446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Fa94rq4LY4WzohJQBw+1+fnrKto/qSLOJsPZx6Z7XI=;
        b=ew6VPZlapGz4x19z+5FTUwYu9WDhl5xiUaNPj1BMKHQXqNlVUnc8O07mQ0V9meFk4Z
         oh37xyObphHzxu3viQRyaY1HiAB3pAUS3tZnv6XgzaStbmroX6Uvj1Bn9Edieym8XZZd
         wdlCzGzQM/ZGCx6dGYgpIs8BzjLVLBNrJ/Rajj9D/XLjBlVXpMbTSxjaJpoObRk/YFA4
         DX1wSbC0QRzeuwdJKJVTXVmcyXC835m/tR/4Sr9DbPLrPKzJL7bNNfaHagTW983DQbzr
         aQGHPnHfgNJzx6Hjn5qajYNRW6ltmo3pHBizOIWL+mNNvPDetxQ3U7r5Lec3WPHde7ct
         skMA==
X-Gm-Message-State: AOJu0Yw7pDAOaPE0RIT0ZQLLNDUHZu8otfSGyUq1v8KDyHcBmdZ3bYnQ
	r54BdhYOh4ceRezfyrPZxSR36Wci4gxbCHDQ2qyD7SQGYYUjFU8UL0CV
X-Gm-Gg: ASbGncvVO7WxrfBeOTy5IXb5/XXpifX+e3FABb6a+ACuXuPx0HQe9nPaAQ+VaOR6/Fe
	nJYF/U/Fp5W7E77xB5eR4khG/OBj4f5NElyI2JYFs930hukjx4iw6WMyrugPO/HU5imt+dAWy63
	GD3wEwRU1+uiAKHl3yfCrEJY1LG6+S6RtEeJQQTkiBdBNg6rpyQZwhCIh2WHubBapqWse1l2RsV
	9QsJldfJNH6WVqFTkybJil3z1RGU7OpYJAoVZyCAn5Xhr6Cc3yIdeei+Jgyn4obVH6iBuHhchrR
	pEe1PRScuvH/L+YKi7o/DBOHj2XGkHs+R1+yGGBk+Fwq9ZMOuOUS5+Sq+OCphEBNvrPEtlzje3M
	/V6FNZGunlJGC3i7lAfxitMg2Yjfup1BpjOdpx24qYXj4k7JtoWHVubPcTnS7VzfIXHU8QemdRf
	HSeE4nw6G5U1MP2X9fHxhFY0e5o9GXgCiwci/jYAEvyg==
X-Google-Smtp-Source: AGHT+IFF5YJfFnpTtTAVxGmV5ZlBFo/mf4gYcQP7jzA5jKthEnOt4UjCXc6otkG5ppk07jpyxXmDJg==
X-Received: by 2002:a05:6000:25f4:b0:429:a7f1:bdda with SMTP id ffacd0b85a97d-429a7f1bf31mr2313106f8f.47.1761643645777;
        Tue, 28 Oct 2025 02:27:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm19408803f8f.21.2025.10.28.02.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:27:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:27:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: Re: [PATCH v1 2/6] units: Add value of =?UTF-8?B?z4A=?= *
 =?UTF-8?B?MTDigbk=?=
Message-ID: <20251028092723.3403d122@pumpkin>
In-Reply-To: <aQB55GjWQL3VD1MO@smile.fi.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
	<20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
	<20251027193033.69728215@pumpkin>
	<aQB55GjWQL3VD1MO@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 10:08:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Oct 27, 2025 at 07:30:33PM +0000, David Laight wrote:
> > On Mon, 27 Oct 2025 15:34:51 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >  =20
> > > There are a few drivers that want to have this value, and at least one
> > > known to come soon. Let's define a value for them. =20
>=20
> > > +/* Value of =CF=80 * 10=E2=81=B9 */

Thinks - should non-ascii characters be allowed in comments.
They can cause grief.

> > > +#define PI	3141592653LL =20
> >=20
> > Is that the right value?
> > IIRC the next digits are 58979 (I used to know the next few as well)
> > which means it should be rounded up. =20
>=20
> Right, today I have the same thought that actually ChromeOS driver has a
> off-by-one issue there.

Not as though it is likely to make a difference.
If any code needs anything more accurate than 3.1416 it probably cares
whether the value is rounded down or up.

> Btw, do you know if we can have compile-time divisions that can make 32-b=
it
> constants out of the 64-bit input? DIV_ROUND_CLOSEST_ULL() doesn't seem a=
llow
> that.

Not sure, I did wonder how much thought had gone into the LL suffix.
The value used will fit in u32 - but then any maths becomes unsigned.
OTOH using LL forces 64bit maths on 32bit - not good.

I suspect it would be better to drop a digit so the value fits in a
signed 32bit variable.

The other issue is whether scaling by a power of 10 is even right.
If the code has to rescale the value using divides you really want
to divide by a big power of 2 not 10.
So multiplying by 2**29 may be more useful.

	David






