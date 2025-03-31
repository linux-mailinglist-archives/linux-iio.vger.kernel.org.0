Return-Path: <linux-iio+bounces-17473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B474A767A9
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C55168F4A
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EFA1E1E06;
	Mon, 31 Mar 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="et1ErYev"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83317A2E2;
	Mon, 31 Mar 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430827; cv=none; b=JjgHLXoI71TU0SjXOWMRCm6F/i/8fzoSvYa74kpo8p7fgS2d2QcHDXtO9RwaU0gCSOmkorovyH3V7Ew3OszcDUn/exwO53IYxy567ELeIegLFph6OBCe4fLEzo6Ng0bpXi1W9zdCIehYhreZExTHgTHD7t+VST8LHY+zlB5Dx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430827; c=relaxed/simple;
	bh=O0wFPEYoDWvekjkXky/qogrl+c503zmhDXe2lvu+/Xg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nE1KAPDyPBP/M/dFSnpHj54kHpuAQK5OCME0M9aaLFtI94XMT1NwOeTnuOu0hwQ4YInc63yKM4bJF5bu+Vlawt6pzELMgYUHlkrlQ1suVhvjNezA5OBq8OhLg/ulqh1RZRUDpAJeZbeL54lZlgKdLCsmVyYEKmPw2jk9G782Aw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=et1ErYev; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743430825; x=1774966825;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=O0wFPEYoDWvekjkXky/qogrl+c503zmhDXe2lvu+/Xg=;
  b=et1ErYevWNiONZ8OVbEwa6Y+3TuCSEpsSuI+fX9ZMduWSdvuiit0myYt
   iKHUpNPHoGUWmw3yuZl79S/5ZZ3KwmMaJjz99uTJ0CNjOcFwpAaB6zTf6
   nsQ5ReJ5Ak56CMOX4KUIq9doGFB7Gq4ysdbE/7wr0jMxG6dt4SzXl3Lsn
   YE/vP+yOmKFC11nKOMoPsbOTh3BylIPNK6yMY8fhf4xGH2Sh0xl9LK1HX
   unV92cJOsoeByy2ROZZYGvP7SCHEfiLwUn7iBWYzkZtC+iLV+CLGDMmBf
   wQppqlAz2zEeCBOKKq5k5Qqjg2uB0pgyg9MQLcLzVf7/p/pCje8TkI+kr
   A==;
X-CSE-ConnectionGUID: RaaqCO/YSy+iU/lPRKjeQQ==
X-CSE-MsgGUID: fjPkPdKdRkCeYGRBDfSVgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="43868728"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="43868728"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 07:20:24 -0700
X-CSE-ConnectionGUID: mFSvOVTPRZiTv7w9gdLrEw==
X-CSE-MsgGUID: 2bkC6X1rTnyHq08pwJVTlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="157104100"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 07:20:24 -0700
Message-ID: <1563fdf418c33fd86a90ae295669f844b16ae66e.camel@linux.intel.com>
Subject: Re: [PATCH 0/3] iio: hid-sensor-prox: fix SCALE and OFFSET
 calculation
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Zhang Lixu <lixu.zhang@intel.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, jikos@kernel.org, 
	peterz@infradead.org, gregkh@linuxfoundation.org, ribalda@chromium.org, 
	archana.patni@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, even.xu@intel.com
Date: Mon, 31 Mar 2025 07:20:23 -0700
In-Reply-To: <20250331120040.75d0577e@jic23-huawei>
References: <20250331055022.1149736-1-lixu.zhang@intel.com>
	 <20250331120040.75d0577e@jic23-huawei>
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

On Mon, 2025-03-31 at 12:00 +0100, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 13:50:19 +0800
> Zhang Lixu <lixu.zhang@intel.com> wrote:
>=20
> > This patch series addresses issues in the hid-sensor-prox driver
> > related to
> > SCALE and OFFSET calculations. The changes include restoring lost
> > scale
> > assignments, supporting multi-channel SCALE calculation, and fixing
> > incorrect
> > OFFSET calculation.
> >=20
> Hi.
>=20
> Generally I prefer to see review tags (Srinivas' Acks here) given on
> list
> but in I trust Srinivas to have done a thorough review (or to shout
> when he
> sees this!) and the changes look correct to me, applied to the fixes-
> togreg-testing
> branch of iio.git.
Hi Jonathan,

I have reviewed these patches internally. From next time, I will make
sure that I ACK on the public lists.

Thanks,
Srinivas

>=20
> Odd point in merge cycle hence the odd temporary branch.
>=20
> Jonathan
>=20
> >=20
> > Zhang Lixu (3):
> > =C2=A0 iio: hid-sensor-prox: Restore lost scale assignments
> > =C2=A0 iio: hid-sensor-prox: support multi-channel SCALE calculation
> > =C2=A0 iio: hid-sensor-prox: Fix incorrect OFFSET calculation
> >=20
> > =C2=A0.../hid-sensors/hid-sensor-attributes.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 ++++
> > =C2=A0drivers/iio/light/hid-sensor-prox.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++---
> > ----
> > =C2=A02 files changed, 18 insertions(+), 8 deletions(-)
> >=20
> >=20
> > base-commit: e21edb1638e82460f126a6e49bcdd958d452929c
>=20


