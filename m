Return-Path: <linux-iio+bounces-13332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9499ECE82
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 15:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FD32874A7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CA1632DD;
	Wed, 11 Dec 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isK9gr98"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF891CD3F;
	Wed, 11 Dec 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927105; cv=none; b=ZqWk485675NuQ7yHZ3a+7NKwNKentsZp8Qa1Cy6sKc+6vvuxLiAE9Q2QxJMqBl5FV2AuiYpfLE3tM7uKLumJwdChh8/ZxELf84abNtMgIvvJIM5mlrVF6T+PgHz3+bjs3VdFlfcKC48FJ0VFmyi5xqTf1IT5U0PMg1N+xeFLeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927105; c=relaxed/simple;
	bh=TO+YB/Y/4TCTstWKm/S0FbmmY68P0DKD/Yt8QeePxEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4MoOr3GLa9saZzu3jgWffR6KHB8gVYxSPXyCump+W2BhitX3EpkbG/WR4Ku65Ejw1HY71pS6j1uAF8FlFPktRDwTQVX6GzOois833H7liu6xcoYz/0CGtQo9gSkFuwtCn8+yQthdVJNf3BJo+MeBbPhuwuki8ObgVYJs8DXEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isK9gr98; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733927104; x=1765463104;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TO+YB/Y/4TCTstWKm/S0FbmmY68P0DKD/Yt8QeePxEs=;
  b=isK9gr98RRG6Va3ErPD5wdE+iN9n51mXsJ18nTnKZcPgeHgDD8b3pLAK
   BSvRR07Rp3S5xTyP/WZyn6j034ZMQdldhpVIIrn8GM8pygkWpm7fz5mAb
   McwEgP8jyRqiK7YpfqGKENPpDWox7/jtKi32UvchAhivXQFam4nCkHTJF
   I53XfTiqnL4YdJ1/F+aOgMDIWoAX/+snDuL0Vew3HqH5+4nwkK957CCV6
   0NKldBBH6DoPm1zkkJA/+Q/XqfqLA74FbySvslQkC3JDWEoAAo1nIbyz6
   f8BqFnQ6CsdtG05RWFJzae0LDxLVnPW4ZhVglig1mCWf/fssaAkMBuKZS
   Q==;
X-CSE-ConnectionGUID: IlHltZeBQ1akvRu9exo9Uw==
X-CSE-MsgGUID: 31C75q+ZQFujCYCU8aE+sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="44979297"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="44979297"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 06:25:03 -0800
X-CSE-ConnectionGUID: Kd1QKuo+QR6IoKNW4XOJAw==
X-CSE-MsgGUID: kCNsvwGPQyyYK8GHI13fsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99920819"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.242])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 06:23:41 -0800
Message-ID: <8d736607552e88f28672ef5217431f61951df126.camel@linux.intel.com>
Subject: Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale
 platform-data on remove
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jiri Kosina <jikos@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, jic23@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com,  linux@roeck-us.net, bentiss@kernel.org,
 dmitry.torokhov@gmail.com, pavel@ucw.cz,  ukleinek@debian.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 11 Dec 2024 06:23:40 -0800
In-Reply-To: <n914pn7o-pr9n-5ss0-p744-73402nnn843p@xreary.bet>
References: <20241107114712.538976-1-heiko@sntech.de>
	 <20241107114712.538976-2-heiko@sntech.de>
	 <nycvar.YFH.7.76.2411071358210.20286@cbobk.fhfr.pm>
	 <4934964.GXAFRqVoOG@diego>
	 <nycvar.YFH.7.76.2411071534110.20286@cbobk.fhfr.pm>
	 <20241112143732.GG8552@google.com> <20241211120844.GD7139@google.com>
	 <n914pn7o-pr9n-5ss0-p744-73402nnn843p@xreary.bet>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 13:24 +0100, Jiri Kosina wrote:
> On Wed, 11 Dec 2024, Lee Jones wrote:
>=20
> > > > > This change was more or less a surprise find, because I
> > > > > wanted to make
> > > > > the platform_data pointer in the mfd_cell struct const and
> > > > > this the hid
> > > > > sensor hub stood out as doing something strange ;-) .
> > > > >=20
> > > > > So patch 2 of this series actually depends on this change to
> > > > > not cause
> > > > > build errors.
> > > >=20
> > > > Ah, right.
> > > >=20
> > > > > But seeing that we're after -rc6 alredy, I would assume the
> > > > > brunt of the=20
> > > > > mcu series might need to wait after 6.13-rc1 anyway - but I
> > > > > guess that=20
> > > > > depends on how Lee sees things ;-) .
> > > >=20
> > > > OK, I am keeping my hands off it for the time being.
> > >=20
> > > I can take it now with an Ack.
> >=20
> > Looking to apply this set now.
> >=20
> > Ack please.
>=20
> I'd preferer if Srinivas could ack this as the more specific
> maintainer.=20
> Srinivas, please?=20
My ACK is already in the patch:

Fixes: e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous
reads")
Cc: stable@vger.kernel.org
Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>


Thanks,
Srinivas

>=20
> Thanks,
>=20


