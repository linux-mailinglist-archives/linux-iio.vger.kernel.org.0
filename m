Return-Path: <linux-iio+bounces-11950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C88B9BF3F5
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 18:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3140B287405
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A149206515;
	Wed,  6 Nov 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXmQNybx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F72064ED;
	Wed,  6 Nov 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912860; cv=none; b=t3hUkyUZLiU9Ch5vA07Uad0esRube+p8gh08i4R++SzrPO8nsERTXYkYPmHhARKSulShyYm3xxG6LsxRtJHPRSAcc55e0gXS+ttp8Niu1jgzqETtQpJ/t7KImS5d4Q7MyKOCbFh+w9LeVlzz1Upl/qXjtGMovQVXGLiYCj87o5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912860; c=relaxed/simple;
	bh=PWUwMXSmdhMVZG5CyYFOKLPQMIFbQ2XIOUmCa9ZyZfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UK5T6Z7nkyuRgcct3lM725cKfA4+ChQQZZnA5sCrXN9k9LLUIX0BUeT7dyU8ycruCDVxthZU1LSVDCgYIeWyro0WGHDEQhXltEMGcGOh3oCcBk7uMbITqmBnoUuf0990ZYpMRYfl96Jxr2IYdjhkEmYFlyUcBE5VCG6CMrnUrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXmQNybx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730912859; x=1762448859;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PWUwMXSmdhMVZG5CyYFOKLPQMIFbQ2XIOUmCa9ZyZfE=;
  b=OXmQNybxi42DRPQHatch0wRwipQOeND+qqB1UVD8TOfvwlS0SWKliL4d
   nCO1Rxs50lLCLifY5xR+lwSzSJmoxqQQDVzhoysgtZJAotvuRFThCHpSz
   zgK0s+2hllTDfDg0jfk7x1TA0jCK6Y6FXjMMwM6AONh9OwIcewsuNCGC+
   onoGt6Z4y6jl5vzr77YO6yeqqA51m+K+nPjugXTOCoEtGjHdrOJMNwhDB
   LzB/fc0jC5tuk2RHTHh4wMIX2xHToBHPsS1YFV+2LTpA+u/8tikmyqSlW
   dwAkUgGhePPZ+GUuqU2tWBjp0SJSUgn7qoTYHqjJAOH6NzDEVp5awM1nb
   g==;
X-CSE-ConnectionGUID: u5XFDFnHR/GUcLYel6yXPQ==
X-CSE-MsgGUID: i+UWLIltTpSPXSa4YL4/ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="42102114"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="42102114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:07:35 -0800
X-CSE-ConnectionGUID: XRiLSzzfTFuHNigc+/asqg==
X-CSE-MsgGUID: AG8W6tFeQgWZJzxCV1ys8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="85463822"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.53])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:07:08 -0800
Message-ID: <f7e474ae70e659a33174ff3571ee7d311e47c8d3.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] iio: hid-sensors-prox: Add support for more
 channels
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Ricardo Ribalda
 <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
  Lars-Peter Clausen <lars@metafoo.de>, Harvey Yang
 <chenghaoyang@google.com>,  linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 06 Nov 2024 09:07:07 -0800
In-Reply-To: <20241101153255.4d835495@jic23-huawei>
References: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
	 <20241101153255.4d835495@jic23-huawei>
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
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-01 at 15:32 +0000, Jonathan Cameron wrote:
> On Fri, 01 Nov 2024 07:46:26 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>=20
> > EgisVision 620 provides two additional channels:
> > - proximity
> > - attention
> >=20
> > Add support for them.
> >=20
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Looks good to me. I'll queue it up, but Jiri / Srinivas if either of
> you have time
> to take a look as well that would be great of course.
>=20
Sorry for the delay. I was on vacation.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> I'll only push this out as testing for now to let 0-day take a look.
>=20
>=20
> > ---
> > Changes in v3:
> > - Make attention CHAN_INFO_PROCESSED.
> > - Fix comment style.
> > - Multiply attention by 100 to make it a percentage.
> > - Link to v2:
> > https://lore.kernel.org/r/20241028-hpd-v2-0-18f6e79154d7@chromium.org
> >=20
> > Changes in v2 (Thanks Jonathan):
> > - Create new attention channel type.
> > - Improve documentation for HID usages.
> > - Link to v1:
> > https://lore.kernel.org/r/20241024-hpd-v1-0-2a125882f1f8@chromium.org
> >=20
> > ---
> > Ricardo Ribalda (5):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: hid-sensors: Add proximity and atte=
ntion IDs
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: hid-sensors-prox: Factor-in hid_sen=
sor_push_data
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: Add channel type for attention
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: hid-sensors-prox: Make proximity ch=
annel indexed
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: hid-sensor-prox: Add support for mo=
re channels
> >=20
> > =C2=A0Documentation/ABI/testing/sysfs-bus-iio |=C2=A0=C2=A0 8 ++
> > =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/light/hid-sensor-prox.c=C2=A0=C2=A0=C2=A0=C2=A0 | 195=
 ++++++++++++++++++--
> > ------------
> > =C2=A0include/linux/hid-sensor-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0include/uapi/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0tools/iio/iio_event_monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A06 files changed, 122 insertions(+), 87 deletions(-)
> > ---
> > base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
> > change-id: 20241023-hpd-edeb37f1ffc4
> >=20
> > Best regards,
>=20


