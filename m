Return-Path: <linux-iio+bounces-13366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CB9ED907
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 22:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FB31881498
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 21:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993DA1DDC29;
	Wed, 11 Dec 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgkHhlrc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882951D31B5;
	Wed, 11 Dec 2024 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953720; cv=none; b=Lq9et6scDkOfKo3dx+XZBBzJtKK2sd5noUeBBzPGXNn6K3ORrUUhzEFu8G1oY+hkmKD084V0nOauxoN8RTuGPDFBzWt4NkokFTqnMQEctVOHfgLQnXd1gBXDcG0uib2n0jv/fH58zl1UUmC/xZjVuFv88pbGN0LcuAWkezCKS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953720; c=relaxed/simple;
	bh=alwEGtJsoPyU7sBPmbz0mKL3eWfknZd7WQ2Ac6kO+io=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iH+Zpu7Qgv8Niyb9KWbbZlYOhw3+YJtM+Vi2ikopHi3DAxLxYu0P7Gesuhnv3nWg549BqJrPBj/cZGjpov3VCqnJfe1QeNqZry6jJt6n+7jLjP5JAlR7RK0Y/HUPTZ3ytniDEs0rpx630Ul+qaaQ+EJ1N03pyFx24JnTiYANlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgkHhlrc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733953719; x=1765489719;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=alwEGtJsoPyU7sBPmbz0mKL3eWfknZd7WQ2Ac6kO+io=;
  b=LgkHhlrcq/lA1/d7MFJ7jap6pU7FDR/I8nv3ImKmTnK5iOUP4dfB4tlw
   0EyJU3tRD3JaEqj7KM03Sf3eJno/yX3iknlLhGJmbWpJhu3/IVtM23ihH
   LU3WmrjdCWVmNAF2q8BhpNsaQSaV1NXJ6P1hJ84Ub7UGklqzySHE1kQbE
   oQx+/SQ/gtzM+noMv4UYvrH5eF3vHMfsAXXfNQRkgqvlz+LEsb6e4U5Wv
   0m13aGGyKRFUdhUjjQYDxzFnD1eT6mcKCdv0nRo8Q7Blei8sEIBCa06Ks
   nQC6OAmaYPn+VA3uV6sL/B9p83CWs9/rmej0pmd7HGc1TMQYd9w9i/Jsr
   w==;
X-CSE-ConnectionGUID: jiIrvU5FRNKn4kRLHDBbZw==
X-CSE-MsgGUID: iL+qtiMBSeaGZ449JB2Lrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34079329"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34079329"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 13:48:38 -0800
X-CSE-ConnectionGUID: 3q7nRbSDTzGE9iEQ4U4S2g==
X-CSE-MsgGUID: iQ5QFexWTkyBKwm/TWxE7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133352145"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 13:48:38 -0800
Message-ID: <9756bf2904470c7729d306e5d534c577705e30b3.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensor-prox: Merge information from different
 channels
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Ricardo Ribalda
 <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 11 Dec 2024 13:48:37 -0800
In-Reply-To: <20241211184018.063e4534@jic23-huawei>
References: <20241205-fix-hid-sensor-v1-1-9b789f39c220@chromium.org>
	 <20241208163851.41c47c3f@jic23-huawei>
	 <CANiDSCsD2gGBPVaFMU4uhtpWf3dUr4-MA5MpcjZRcLMgBmtjZg@mail.gmail.com>
	 <20241211184018.063e4534@jic23-huawei>
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

On Wed, 2024-12-11 at 18:40 +0000, Jonathan Cameron wrote:
> On Sun, 8 Dec 2024 21:09:16 +0100
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>=20
> > Hi Jonathan
> >=20
> >=20
> > On Sun, 8 Dec 2024 at 17:39, Jonathan Cameron <jic23@kernel.org>
> > wrote:
> > >=20
> > > On Thu, 05 Dec 2024 12:59:20 +0000
> > > Ricardo Ribalda <ribalda@chromium.org> wrote:
> > > =C2=A0
> > > > The device only provides a single scale, frequency and
> > > > hysteresis for
> > > > all the channels. Fix the info_mask_* to match the reality of
> > > > the
> > > > device.
> > > >=20
> > > > Without this patch:
> > > > in_attention_scale
> > > > in_attention_hysteresis
> > > > in_attention_input
> > > > in_attention_offset
> > > > in_attention_sampling_frequency
> > > > in_proximity_scale
> > > > in_proximity_sampling_frequency
> > > > in_proximity_offset
> > > > in_proximity0_raw
> > > > in_proximity_hysteresis
> > > >=20
> > > > With this patch:
> > > > hysteresis
> > > > scale
> > > > sampling_frequency
> > > > in_attention_input
> > > > in_attention_offset
> > > > in_proximity0_offset
> > > > in_proximity0_raw
> > > >=20
> > > > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for
> > > > more channels")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>=C2=A0=20
> > >=20
> > > whilst perhaps not ideal use of the ABI, what is there today is
> > > not wrong
> > > as such.=C2=A0 If the ABI above was all introduce in the recent patch
> > > I might
> > > be fine adjusting it as you suggestion. However it wasn't,
> > > in_proximity_scale
> > > has been there a long time so this would be an ABI change.
> > > Those are generally only ok if there is a bug.
> > >=20
> > > Drivers are always allowed to provide finer granularity than
> > > necessary
> > > so in this case I don't see this as a bug.=C2=A0=20
> >=20
> > Is it ok that changing the attention_sampling frequency the
> > proximity_sampling frequency changes as well?
> > (Just asking for my own education, not complaining :) )
>=20
> Yes.=C2=A0 In general the ABI has always had to allow for interactions
> because
> there are lots of non obvious ones between attributes for different
> channels
> as well as those for the same channels.

In general if this is by a soft sensor in the hub, then likely all will
change the same sampling frequency internally since they don't have a
real sensor in the back.

Thanks,
Srinivas


>=20
> >=20
> > Also, what about ?:
> > in_attention_scale
> > in_attention_hysteresis
> > in_attention_input
> > in_attention_offset
> > in_attention_sampling_frequency
> > in_proximity0_scale
> > in_proximity0_sampling_frequency
> > in_proximity0_offset
> > in_proximity0_raw
> > in_proximity0_hysteresis
> >=20
> > Would that be acceptable? I think that if we are giving the false
> > impression that every sampling frequency is independent we should
> > go
> > all the way in. WDYT?
>=20
> It's indeed far from ideal, but so is changing an ABI we've exposed
> to
> userspace. We definitely can't touch anything in a release kernel but
> if
> there are clear improvements to be made on stuff that we can sort of
> term
> a fix we can maybe get away with it.
>=20
>=20
> >=20
> > Thanks!
> >=20
> > ps: this patch is in the queue in case you missed it
> > https://lore.kernel.org/linux-iio/20241122-fix-processed-v2-1-b9f606d3b=
519@chromium.org/
> It's in patchwork so i'll get to it. Not sure why I haven't applied
> it, maybe a tree
> management thing and lack of time last weekend to check for what was
> unblocked by
> the rebase.=C2=A0 I'll catch up soon.
>=20
> Jonathan
>=20
> >=20
> > That one is a real fix for the driver :)
> >=20
> > >=20
> > > Jonathan
> > >=20
> > > =C2=A0
> > > > ---
> > > > =C2=A0drivers/iio/light/hid-sensor-prox.c | 8 +++++---
> > > > =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/light/hid-sensor-prox.c
> > > > b/drivers/iio/light/hid-sensor-prox.c
> > > > index e8e7b2999b4c..f21d2da4c7f9 100644
> > > > --- a/drivers/iio/light/hid-sensor-prox.c
> > > > +++ b/drivers/iio/light/hid-sensor-prox.c
> > > > @@ -49,9 +49,11 @@ static const u32
> > > > prox_sensitivity_addresses[] =3D {
> > > > =C2=A0#define PROX_CHANNEL(_is_proximity, _channel) \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {\
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 .type =3D _is_proximity ? IIO_PROXIMITY :
> > > > IIO_ATTENTION,\
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_separate =3D _is_proximity ?
> > > > BIT(IIO_CHAN_INFO_RAW) :\
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > BIT(IIO_CHAN_INFO_PROCESSED),\
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_shared_by_type =3D
> > > > BIT(IIO_CHAN_INFO_OFFSET) |\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_separate =3D \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (_is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_PROCESSED)) |\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BIT(IIO_CHAN_INFO_OFFSET),\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_shared_by_all =3D \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) |\
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_HYSTERESIS),\
> > > >=20
> > > > ---
> > > > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > > > change-id: 20241203-fix-hid-sensor-62e1979ecd03
> > > >=20
> > > > Best regards,=C2=A0=20
> > > =C2=A0
> >=20
> >=20
>=20


