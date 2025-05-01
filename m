Return-Path: <linux-iio+bounces-18951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08374AA6752
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 01:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C4B1897CA9
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE927263C73;
	Thu,  1 May 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TV+xpoZi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911B2367AD;
	Thu,  1 May 2025 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141699; cv=none; b=DGXG5w07ZmyVBOii91vdBw6mWyRyHBVKKD0V2Gbza7uMAQQXgEZnvK00cGbazoarGk6runnuvSoeCxMprVzcdoof6lV4QpSi1u3us12exUBQ/imKw+0sYyqvXKvQfJHQp3Gux/RFNEl46bUlCsFg97nNwk9XQ2MBA1TvuEtloQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141699; c=relaxed/simple;
	bh=MOV+78+NdAm1UlS9xfW1wnoYdX4nXR76p3LYpax7HYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RmektIwhsNtx9C3I9PhlS0yh68nLg5oepP/PZBQiRU4QALG1DojWGlz7AzNQHcPqKlp4SNN84u4Y1v6TkavQ+oFChtPHAfT63YiTIPeEVenUp5NyYmIOvtKHETqG8Z2p9sD4n1voR1DbjN73+Uom9hcsrx/cBGedlI085gDhLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TV+xpoZi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746141698; x=1777677698;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MOV+78+NdAm1UlS9xfW1wnoYdX4nXR76p3LYpax7HYs=;
  b=TV+xpoZiuf5N6smFUx9nxmZi01gTgr5jk7ayj3vB+OXmawlRQ0pnG9eJ
   zedn6DLLT62xk6yetPwUb6qgyBPq5ReKRKwdmrP8DG1U30S7M+RztXsNk
   76F0LX7zJl0pNvqlmwP1n6oRAeGarIP9uSwE4VjCjAg81pBBlxer9ZLEP
   TglSPJxyhBG13RuJcp4UdhmVM+PtfHZF5QdV5/1lZrm4WAI+KWWIDY5Wu
   FWl71fgB1E/a6TKj92XN44CaQr8noFAZwRKovW1e67i0rNz/l8VjLfo5z
   xbiVUskY/TEKWg4NwNIGLfuHnSsIJ0qTSYpRL4i0qtJALP4HSCGyy/WyK
   Q==;
X-CSE-ConnectionGUID: 5OHNYxebQg2qRdW98VNiLA==
X-CSE-MsgGUID: gAS5a5ksR4uSzwdexXorvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47965745"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="47965745"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 16:21:37 -0700
X-CSE-ConnectionGUID: 1T+DrkojSQiT3QOiAyBrHQ==
X-CSE-MsgGUID: qp2gfHl/TKyLmiDn08+raw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="139647025"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.85])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 16:21:37 -0700
Message-ID: <3717e8d0bfc058739b3333931ba6c39d55d2d383.camel@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: Fix typo and improve documentation for
 sensor_hub_remove_callback()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>, Chelsy Ratnawat
	 <chelsyratnawat2001@gmail.com>, jikos@kernel.org, jic23@kernel.org, 
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 01 May 2025 16:21:36 -0700
In-Reply-To: <1f8de7bd-7049-4933-82e3-8ce71685998e@baylibre.com>
References: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
	 <1f8de7bd-7049-4933-82e3-8ce71685998e@baylibre.com>
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

On Wed, 2025-04-30 at 14:17 -0500, David Lechner wrote:
> On 4/30/25 1:23 PM, Chelsy Ratnawat wrote:
> > Fixed a typo in "registered" and improved grammar for better
> > readability
> > and consistency with kernel-doc standards. No functional changes.
> >=20
> > Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> > ---
> > =C2=A0include/linux/hid-sensor-hub.h | 7 ++++---
> > =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-
> > sensor-hub.h
> > index c27329e2a5ad..5d2ac79429d4 100644
> > --- a/include/linux/hid-sensor-hub.h
> > +++ b/include/linux/hid-sensor-hub.h
> > @@ -130,10 +130,11 @@ int sensor_hub_register_callback(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0/**
> > =C2=A0* sensor_hub_remove_callback() - Remove client callbacks
>=20
> This says "callbacks", so is it possible to have more than one
> registered at a
> time?

This removes only one. So "callback" will be correct.

Thanks,
Srinivas


>=20
> > =C2=A0* @hsdev:	Hub device instance.
> > -* @usage_id:	Usage id of the client (E.g. 0x200076 for Gyro).
> > +* @usage_id:	Usage id of the client (e.g. 0x200076 for Gyro).
>=20
> should we also make gyro lower-case?
>=20
> > =C2=A0*
> > -* If there is a callback registred, this call will remove that
> > -* callbacks, so that it will stop data and event notifications.
> > +* Removes a previously registered callback for the given usage ID.
> > +* Once removed, the client will no longer receive data or event
> > +* notifications.
>=20
> I like the revised wording, but possibly looses some clarity that
> could be
> fixed with:
>=20
> Removes a previously registered callback(s), if any, for the given
> usage ID.
>=20
> As above, not sure if singular or plural callbacks is correct.
>=20
> > =C2=A0*/
> > =C2=A0int sensor_hub_remove_callback(struct hid_sensor_hub_device
> > *hsdev,
> > =C2=A0			u32 usage_id);
>=20


