Return-Path: <linux-iio+bounces-12503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5599D6251
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290B2B23369
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB6813C80C;
	Fri, 22 Nov 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9hytVXs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15515BA20;
	Fri, 22 Nov 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293098; cv=none; b=YhPY2ziVa8VhOCzeTT07LiKQ2n5f1WMm9wiqJsISOpxG+XEdxAcO2ajkDgjxSBK4hfAOjSm2fXOuvd6ME1HcD86Fqc4IvL3ClcnKKdc3k0ktBnX//IqN2sJgLNecrhpo9+thdgV2eHXJX+/llTj9fadUK36pt/txwWym6qoVQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293098; c=relaxed/simple;
	bh=5tLotF7QIpddNYPZIFxLjnodQOu60ssXf96rQ3eKJcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bguz8Xm4krEkkHXPLEODCSFDRdeZm7t8DVU6IMXtR0CvPUH123LjaMsIlb/6qBXSlvcl2dq8ntlRjSoZ+dvuJz7u3IFGUvVWyWeJo+PwH0jjT77OCx/hHKuPiSmgZCxm2wHm3neHlcida7ItsDzKh0dLa+W1Q5cqVZrYzZbW8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9hytVXs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732293096; x=1763829096;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5tLotF7QIpddNYPZIFxLjnodQOu60ssXf96rQ3eKJcM=;
  b=V9hytVXshbo5ot12teoA8i3lnGgX38QeY7out3/CYNybjU/OcJyRALyv
   dJ4XIwC8xwmrT5Z1ri4TGKvQWjx7UrAhzPs+qKC4jqdCVEiBFJXbWn5nt
   UZhO4LiLHCWhS8nSTcSnkRvo9GQLkqcNT2MWSFlXgdiTVFXVf1+Osc352
   trAdEI8q5wcj28SJ8vmEEHJimCt7gd0+4VZnmxdduz7H8gwixBH361hmM
   66ydXSmOKT1gKdiZCURsfTTPdAvv9zJM3AGf3dj3WyPvSDD88UcJNxKW8
   MhLvJygGqDM51ctu6zOz5XcSG0TrxOrEbUyud5cZ47LD0eNSqqUSChbmf
   Q==;
X-CSE-ConnectionGUID: i2UZGUFaS/aQ6giuFkKBLw==
X-CSE-MsgGUID: 4KXLP9V1SiCUBrE+LsaFyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32510776"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32510776"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 08:31:35 -0800
X-CSE-ConnectionGUID: 9ocBxZz0RROlIvDRi8NJMQ==
X-CSE-MsgGUID: oEuoMTQqT/e/DcW0PX2GRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90784962"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.49])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 08:31:35 -0800
Message-ID: <f0a07dfddd690e1d7d62abf1f9c6e799331e4a8c.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensor-prox: Fix invalid read_raw for attention
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 22 Nov 2024 08:31:34 -0800
In-Reply-To: <CANiDSCuV1zo0=wGLir26Bn0np+BbVj9aj-JK3ZMreOT78c73UQ@mail.gmail.com>
References: <20241121-fix-processed-v1-1-4fae6770db30@chromium.org>
	 <853def565622848427e6e5df8f073465fa52e76c.camel@linux.intel.com>
	 <CANiDSCuV1zo0=wGLir26Bn0np+BbVj9aj-JK3ZMreOT78c73UQ@mail.gmail.com>
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

On Fri, 2024-11-22 at 08:46 +0100, Ricardo Ribalda wrote:
> On Thu, 21 Nov 2024 at 17:44, srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Thu, 2024-11-21 at 09:16 +0000, Ricardo Ribalda wrote:
> > > The attention channel is a IIO_CHAN_INFO_PROCESSED, not a
> > > IIO_CHAN_INFO_RAW.
> > >=20
> > > Modify prox_read_raw() to support it.
> > >=20
> > What is the sysfs entry to trigger this IIO_CHAN_INFO_PROCESSED
> > read?
> > Don't you have an entry *_raw?
>=20
> /sys/.../iio:deviceX/in_attention_input
>=20
> There is no _raw device for it.
>=20
OK.

> >=20
> > > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more
> > > channels")
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > > =C2=A0drivers/iio/light/hid-sensor-prox.c | 4 ++--
> > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/light/hid-sensor-prox.c
> > > b/drivers/iio/light/hid-sensor-prox.c
> > > index e8e7b2999b4c..8e5d0ad13a5f 100644
> > > --- a/drivers/iio/light/hid-sensor-prox.c
> > > +++ b/drivers/iio/light/hid-sensor-prox.c
> > > @@ -94,6 +94,7 @@ static int prox_read_raw(struct iio_dev
> > > *indio_dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (mask) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_PROCESSED:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (chan->scan_index >=3D prox_state->num_channels)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 address =3D prox_state->channel2usage[chan-
> > > > scan_index];
> > > @@ -107,8 +108,7 @@ static int prox_read_raw(struct iio_dev
> > > *indio_dev,
> > >=20
> > > report_id,
> > >=20
> > > SENSOR_HUB_SYNC,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min <
> > > 0);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (prox_state->channel2usage[chan->scan_index] =3D=3D
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USAGE_SENSOR_HUMAN_ATTENTION)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (mask =3D=3D IIO_CHAN_INFO_PROCESSED)
Your original change is better. If someone adds a new channel which
also requires IIO_CHAN_INFO_PROCESSED, then they need to change this
line. So I don't think you need this change.

Thanks,
Srinivas

> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val *=3D 100;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 hid_sensor_power_state(&prox_state-
> > > > common_attributes, false);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret_type =3D IIO_VAL_INT;
> > >=20
> > > ---
> > > base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> > > change-id: 20241121-fix-processed-ed1a95641e64
> > >=20
> > > Best regards,
> >=20
>=20
>=20


