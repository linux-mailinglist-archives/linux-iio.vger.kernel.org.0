Return-Path: <linux-iio+bounces-12512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618199D639D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 18:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253FB282D50
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBA1DEFF5;
	Fri, 22 Nov 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiAnWmxp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00D1DDA32;
	Fri, 22 Nov 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298107; cv=none; b=SEI/KW1/PFPmNDWX6/D7XB1vtXZdqyQfkFkk/dt3dtVORjl7AhScn7mvLEeHZWI6y6Z9qbn3/PIPczPg+Azf61QvxxXhyYa9LAIPOMy6ryPiFwzPmtjrH7iX/c7U2+d2onGY9mb78hg3z58E4O0v/SrJj7GFIVsCn4ggYRPWGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298107; c=relaxed/simple;
	bh=STKkSxBnZBNupprEJj1gVChbpHkaOEZEA6Q2Jps8ewg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwL429v9i6e8HnrKv5DYmtV1wSA0qPFMIs1yFswLwBAN17B/UcvbsDn+mFhVzSp9WWQAj7AAIzqskhwoj+slfwqYvCkyPoAmR046EhGMCXx4iTAFY9QaAQRI0blyaL4rgNC40bda3YivVoohnQNSaJxHEyGPFvs5eddkzMYEzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiAnWmxp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732298106; x=1763834106;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=STKkSxBnZBNupprEJj1gVChbpHkaOEZEA6Q2Jps8ewg=;
  b=NiAnWmxpOFtIp2NAgpiokfpxQybEtluXoirVYhuq3hq+Vp8FbiVXUdAT
   +USXegCnszrEjM+Cdml4tcHy10+FTo8D8xm88+I3P/Jl9PGWUd7a9qBYi
   57S2E7X5va+ZGGLZ26h/BpzT6zs1Glm87py49AXYhhthQdP27v5BuZ+DD
   dfUJTk1TUJqKJEpNfADctwwzOBh8eWiUSPC2QVau2aKPkP5QjUphn+ZP5
   mTh4ImTXcg7t+vlS8w1IHNKp7Ui7n9mQI40FgZI0voEnkmYUJtjzJIoft
   tEByaXJaXFGRBuJKvmHNpDfBHWtLpN1DHUJlJkap1Tzr6r6FWbB8DtBhg
   Q==;
X-CSE-ConnectionGUID: DbBGebb5Q/OBf6jf+SEMnQ==
X-CSE-MsgGUID: EsOTqVTaQTOZSq7PDhDtzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43527146"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43527146"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 09:55:05 -0800
X-CSE-ConnectionGUID: Awva833OQryuc/CBeUvTug==
X-CSE-MsgGUID: afL7uM5ITfmNpRJmtJqscg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95726262"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.49])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 09:55:05 -0800
Message-ID: <d164919c9290ca1410bc21746511799a5c17b94d.camel@linux.intel.com>
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Fix invalid read_raw for
 attention
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 22 Nov 2024 09:55:04 -0800
In-Reply-To: <20241122-fix-processed-v2-1-b9f606d3b519@chromium.org>
References: <20241122-fix-processed-v2-1-b9f606d3b519@chromium.org>
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

On Fri, 2024-11-22 at 17:36 +0000, Ricardo Ribalda wrote:
> The attention channel is a IIO_CHAN_INFO_PROCESSED, not a
> IIO_CHAN_INFO_RAW.
>=20
> Modify prox_read_raw() to support it.
>=20
> Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more
> channels")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> Changes in v2:
> - Do not change the condition for applying the multiplier.
> - Link to v1:
> https://lore.kernel.org/r/20241121-fix-processed-v1-1-4fae6770db30@chromi=
um.org
> ---
> =C2=A0drivers/iio/light/hid-sensor-prox.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index e8e7b2999b4c..0daa8d365a6c 100644
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
>=20
> ---
> base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> change-id: 20241121-fix-processed-ed1a95641e64
>=20
> Best regards,


