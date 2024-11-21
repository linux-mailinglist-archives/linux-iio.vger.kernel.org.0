Return-Path: <linux-iio+bounces-12470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C619D50DD
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 17:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC8A283DA3
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5E31A0AF5;
	Thu, 21 Nov 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SX1dwKv6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176F41C79;
	Thu, 21 Nov 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207496; cv=none; b=GnoKcf18qN7G+TAf88p/9+RHrSDiIxlt+SpZ+wmsArVw+8qE5EfmH0C5DdsrzxUo880njLeG7S6FjaIEYpc8JVs5CVU08gt76OFKKW5MHZI66N3TlV3Pz+nq5qI9WYYJQpgj5NuInU/W+kFaGOIVdHjGiapzK30EYOoeMiRhIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207496; c=relaxed/simple;
	bh=JG8GOin1RPGr6lBzi5vNbhQX9ZAXOl1lznBI9WMq6iM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zk1aDILWAs+FH9amp1Np1XOQvXu0nnm9aPVMAq7peUopgLPOagMz6tnqYcx/ALRD/fQ6bMBb6OgVwRBR2iZ4m6ZMK6JDdYKMsHqUEG1rBADBQ65e8V1YpAskMkU8gPjJqZjjVhI6FAqoLHnVkZuO/5MqG2dqBhhkPVJgird7ERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SX1dwKv6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732207495; x=1763743495;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JG8GOin1RPGr6lBzi5vNbhQX9ZAXOl1lznBI9WMq6iM=;
  b=SX1dwKv6xWdjxQQaqCHsT4Y1+bmppTsQuPP0zBVVGeJBr7kMLsYqEJoV
   O+CQw+fA6Y/OyCOAP2wZoR0rCLpDC7jOiP4nJU+V4lvO8GG1tOCa9MXYv
   RiS7CwDW5EZKaSFehSMCbY7wrNG8D6ZEpKyNC5vSbVLQ75CmI8jKIV3El
   he2EMaaXpiSTXgzGU6V/JvqLgaIOIuPMc9yYCKTV4TPzMzPA0+iyHD0qZ
   hviw3UeztyQ4Hb0Sfu6MlWkvK9PFAM75Qa275fEuykCyH+QgdHFvs89pV
   PlTpS/wWJRbObBtOyGEKK4+eYay1BuhkmYS4zbBQYEypsC2RUq8gGfB5n
   w==;
X-CSE-ConnectionGUID: 5LF0sjoHRFqOM3PHSWqMrQ==
X-CSE-MsgGUID: 888t9XJnSvOR0oNZtPtijw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32263245"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32263245"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:44:54 -0800
X-CSE-ConnectionGUID: AbYmCwoOQ1WaInLSQtlp5w==
X-CSE-MsgGUID: 035BzuBzQh6wXY0wl558Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90727624"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:44:54 -0800
Message-ID: <853def565622848427e6e5df8f073465fa52e76c.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensor-prox: Fix invalid read_raw for attention
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2024 08:44:53 -0800
In-Reply-To: <20241121-fix-processed-v1-1-4fae6770db30@chromium.org>
References: <20241121-fix-processed-v1-1-4fae6770db30@chromium.org>
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

On Thu, 2024-11-21 at 09:16 +0000, Ricardo Ribalda wrote:
> The attention channel is a IIO_CHAN_INFO_PROCESSED, not a
> IIO_CHAN_INFO_RAW.
>=20
> Modify prox_read_raw() to support it.
>=20
What is the sysfs entry to trigger this IIO_CHAN_INFO_PROCESSED read?
Don't you have an entry *_raw?


Thanks,
Srinivas

> Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more
> channels")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> =C2=A0drivers/iio/light/hid-sensor-prox.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index e8e7b2999b4c..8e5d0ad13a5f 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -94,6 +94,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
> =C2=A0	*val2 =3D 0;
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:
> =C2=A0		if (chan->scan_index >=3D prox_state->num_channels)
> =C2=A0			return -EINVAL;
> =C2=A0		address =3D prox_state->channel2usage[chan-
> >scan_index];
> @@ -107,8 +108,7 @@ static int prox_read_raw(struct iio_dev
> *indio_dev,
> =C2=A0							=C2=A0=C2=A0
> report_id,
> =C2=A0							=C2=A0=C2=A0
> SENSOR_HUB_SYNC,
> =C2=A0							=C2=A0=C2=A0 min < 0);
> -		if (prox_state->channel2usage[chan->scan_index] =3D=3D
> -		=C2=A0=C2=A0=C2=A0 HID_USAGE_SENSOR_HUMAN_ATTENTION)
> +		if (mask =3D=3D IIO_CHAN_INFO_PROCESSED)
> =C2=A0			*val *=3D 100;
> =C2=A0		hid_sensor_power_state(&prox_state-
> >common_attributes, false);
> =C2=A0		ret_type =3D IIO_VAL_INT;
>=20
> ---
> base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> change-id: 20241121-fix-processed-ed1a95641e64
>=20
> Best regards,


