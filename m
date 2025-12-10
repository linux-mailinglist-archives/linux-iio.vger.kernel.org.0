Return-Path: <linux-iio+bounces-26991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E2CB2853
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 10:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3665C30AE004
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6493043CE;
	Wed, 10 Dec 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEbnVKKD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE516267729
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358201; cv=none; b=Sbvj7xCLpA+yPuaOso0EvaiM+U+mQAdx8RuDzqJX3pwAesnzVvSFBlZh+oS8is3Y5Pp6pdHz/UKVOXzrToOZcMzPd4XxvJ9AoQ0CCmMoLFy/1F9CLqbXz9vi1/9eW7TE6hPPpTIyAFwvPIY2lKSLFAyxeo0UKubkaDH5WZLsgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358201; c=relaxed/simple;
	bh=mMeglKXr1y95udnLZbB2DRU8LoPBn2+zFpGB0mu+WPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rgkRqM+sy5nrzuFgalaKcmcrQoMG3E873hFjCkYmM6R6TuoLVs8gtJOMuzdPiP3u8m4c7Ibwdu6mt1sMU6Lmql2CK2K8IQOc2CFKAt2+k9LwxGmQcIuXlY6XUb9CxCtCQnzaiJBbsxPtD6Du1w8jbUAvShqlG0X0RZ2ux5X2Y+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEbnVKKD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42e2d44c727so3033494f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 01:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765358198; x=1765962998; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMeglKXr1y95udnLZbB2DRU8LoPBn2+zFpGB0mu+WPU=;
        b=GEbnVKKDqT16c8a95R/zxbPT1LxbxVWwy7rABwh6ns+0GY4CwKYxk3xj0j2jDJb6Uf
         zMs44zJS15B62FPhaAt3UIjOQ2w420TZ0tbqvJ5QbXWk03mPOFyowq700gXMDujzYVFK
         AglDVIcTtGaT2FZCAfko8esGPzUt4M8ZFM/jv+SUYWcZ3T4Yb61RSqSyU6AQ2F0HUMpx
         sGYwLV26Sz/6U8hf/bRn6enhAuZVyITz9FJ54qJSriQCIoOw0Vnj9n8MmbhC+lo8vDJ8
         /9aY1FZ1gJJu+SRlAgguwXb/cRNZEx/hel3h2udNC/LPr93lY+tA0rnlqdHC9inS8TA7
         lvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765358198; x=1765962998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMeglKXr1y95udnLZbB2DRU8LoPBn2+zFpGB0mu+WPU=;
        b=MVJr4Rq5n2ll07+/ZuF0lqNGkFuI7rpYtt4KZ90n1sAn+1oQ6CXwOm0Sc6S4c8YAR9
         AngQpDNLEA8uNg/cDIX4EG4gMpvJWucKNwCr/7KTzJdSOCo1EnNYGCapDLEaZQX4QMCE
         TcHtuc3+hEfSbiMrzS7HFmkxvMgope7k50+K/LeS1+l0dfDcqiVWG7rGXcGCkT0OKPxv
         PhSR7hkZNYTtXaDgOjwQ6YvdFPbP9IpmqrheeOm3XMgy9PIeQWYQjqq97OxdHJP3By9H
         V4f0DW2SbtNzL2hk+lgvsh9pzix2SYjT6GRap/OVyDTj/0zWVP7dksZqIq2k3WFBSdmx
         GH/g==
X-Forwarded-Encrypted: i=1; AJvYcCX3Yba89HEUVGnT17KDTb5OAyj4YtRKmXPfbFjGQIYmXHGnmmI4yUQFqPcfqEJjTIc0DlX/oZTGgp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhDevOLVb+XHBiCsp9kynm05U5Wz/kWL5e2UbYnhguM+Vgtv1
	VzVwwjw+tVvGHRVL+w60EAdl74qX7sDy00WHkRPSOLCL+XgfwXaAa5xi
X-Gm-Gg: AY/fxX7moRd3OUZ7cvCxtlOsaZzUFpksuxENygs11gnCCdFq1X5JwREP9w5TyjdQbuv
	a/4YL5/KRulUgz4Gk1yednysdkqHSXsaY6BCP+pvM1556TvE5O7+ZnuDNA8twHvZPOMx7OMzoD0
	1TlYKjZTukxvwqoyo68D7/J2dzxchN1YNoZ0atYbs0s379/fJ2RRUsYxCJvVBB1jbl0JIYa4KaY
	1U6YcdWt/q6hhQEN2Jhch2uw3FTr7Swv3YpVQoSoBAWVJhKr7zLzNTIRLGvPksf9J1ZQNDb2zPU
	jaks3G0cTFpHqs4/xqrC9PENIb25qXOTiFNX03tBBGcMGCqGRgJ2hcKDgTVtpJMwFiuO2o+jzdK
	2/3WOubEQTAAX01JTQEjfAF43Mmi/ReENLVsKE9r3/P1ZSkb1TbhnAfqeiUBLyyAror6jhVkK+i
	SuVyRF8cocdoMx7w9qVl0=
X-Google-Smtp-Source: AGHT+IGGphhsdBPpYhuUVQaCWeznKoajx6lTjqKTOyeVxnajYYCGXFRHOAHFacuC5Hrwgx4Mdp9lCA==
X-Received: by 2002:a05:6000:2410:b0:429:d725:410c with SMTP id ffacd0b85a97d-42fa3b186f0mr1564102f8f.44.1765358197942;
        Wed, 10 Dec 2025 01:16:37 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331aeasm36386052f8f.37.2025.12.10.01.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 01:16:37 -0800 (PST)
Message-ID: <8f24bb46e02a6bec6267430d0f0742c601af9aed.camel@gmail.com>
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung
 <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou	 <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>,  Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Date: Wed, 10 Dec 2025 09:17:17 +0000
In-Reply-To: <7aeab2a4-72d9-452f-af86-1e44d5133b67@baylibre.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	 <77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
	 <CAHp75VdNjqZdy0+aSbBzn9CwEwHUhjwED+KRVqkdOMc_N+nX9w@mail.gmail.com>
	 <20251206184645.51099254@jic23-huawei>
	 <54483083c42cf7500239ebb7c0d32d25f11bb02f.camel@gmail.com>
	 <7aeab2a4-72d9-452f-af86-1e44d5133b67@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-09 at 11:05 -0600, David Lechner wrote:
> On 12/9/25 4:34 AM, Nuno S=C3=A1 wrote:
> > On Sat, 2025-12-06 at 18:46 +0000, Jonathan Cameron wrote:
> > > On Thu, 4 Dec 2025 17:07:28 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > >=20
> > > > On Thu, Dec 4, 2025 at 4:35=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gm=
ail.com> wrote:
> > > > > On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:=C2=A0=20
> > > > > >=20
> > > > > > In a recent driver review discussion [1], Andy Shevchenko sugge=
sted we
> > > > > > add cleanup.h support for the lock API:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_claim_{direct,buffer_=
mode}().=C2=A0=20
> > > > >=20
> > > > > We already went this patch and then reverted it. I guess before w=
e did not had
> > > > > ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much b=
etter. Looking at the
> > > > > last two patches on how we are handling the buffer mode stuff, I'=
m really not convinced...
> > > > >=20
> > > > > Also, I have doubts sparse can keep up with the __cleanup stuff s=
o I'm not sure the
> > > > > annotations much make sense if we go down this path. Unless we wa=
nt to use both
> > > > > approaches which is also questionable.=C2=A0=20
> > > >=20
> > > > This, indeed, needs a (broader) discussion and I appreciate that Ku=
rt
> > > > sent this RFC. Jonathan, what's your thoughts?
> > >=20
> > > I was pretty heavily involved in discussions around ACQUIRE() and it'=
s use
> > > in CXL and runtime PM (though that's still evolving with Rafael tryin=
g
> > > to improve the syntax a little).=C2=A0 As you might guess I did have =
this use
> > > in mind during those discussions.
> > >=20
> > > As far as I know by avoiding the for loop complexity of the previous
> > > try we made and looking (under the hood) like guard() it should be mu=
ch
> > > easier and safer to use.=C2=A0 Looking at this was on my list, so I'm=
 very happy
> > > to see this series from Kurt exploring how it would be done.
> > >=20
> > > Sparse wise there is no support for now for any of the cleanup.h magi=
c
> > > other than ignoring it.=C2=A0 That doesn't bother me that much though=
 as these
> > > macros create more or less hidden local variables that are hard to me=
ss
> > > with in incorrect ways.
> > >=20
> > > So in general I'm very much in favour of this for same reasons I jump=
ed
> > > in last time (which turned out to be premature!)
> > >=20
> > > This will be particularly useful in avoiding the need for helper func=
tions
> > > in otherwise simple code flows.
> > >=20
> >=20
> > Ok, it seems we are going down the path to introduce this again. I do a=
gree the new ACQUIRE()
> > macros make things better (btw, I would be in favor of something simila=
r to pm runtime). Though
> > I'm still a bit worried about the device lock helper (the iio_device_cl=
aim one). We went through
> > some significant work in order to make mlock private (given historical =
abuse of it) and this
> > is basically making it public again. So I would like to either think a =
bit harder to see if we
> > can avoid it or just keep the code in patches 5 and 6 as is (even thoug=
h the dance in there is
> > really not pretty).
> >=20
> > At the very least I would like to see a big, fat comment stating that l=
ock is not to be randomly
> > used by drivers to protect their own internal data structures and state=
.
> >=20
> > - Nuno S=C3=A1
>=20
> Due to the way that conditional guards only extend regular guards, I don'=
t
> think there is a way to not expose the basic mlock wrapper. So "don't use=
 this
> unless you really know what you are doing" docs seem like the best option=
.

Right! I figured my first option would be very unlikely... But for the comm=
ent I hope we can
elaborate a bit more. Like "don't use this lock to protect your own driver =
state/data ... you might
need this together iio_buffer_enabled() and if for some reason you cannot u=
se the claim helpers).

- Nuno S=C3=A1



