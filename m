Return-Path: <linux-iio+bounces-10348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B47995583
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24F9B265B0
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AF21F9ABE;
	Tue,  8 Oct 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeLrVxSp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01E1E0DBA;
	Tue,  8 Oct 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408112; cv=none; b=tku8KDvlLCbPkiA5S0IUu/oBW2GZgcZw9HfR7K2SSsmkY2QFMQ0XQkslGVbh8aKDxkMAEQDupIgcNW4kf0/vTe9m6HZa27G6B5ZDvGyPpdkWJqy2+U/OuE6zcXlOPjKVQAtiboQaaot9mrzT6pwilFP2KgZ0a0p1dizQ5rsWT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408112; c=relaxed/simple;
	bh=kDbzKdugs2bpuuz33Rap/swMBaulFpe2s1uIm6r0TvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/8VLSm7vk0F3B2HCO7A/f7dGSZSLsqa3IITeTfRUnd0hQD7RKuda3duopmDBHptUzpQKmYxgsaeECfev7pAGbjJD+A1a31JyIkFx0/GDMMpuNHIVTWqbmA41aftnnuiRXrsW+CId0k3zynq0yZ2WDOSR1EfJt1SFlScSh5ZNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeLrVxSp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728408112; x=1759944112;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kDbzKdugs2bpuuz33Rap/swMBaulFpe2s1uIm6r0TvI=;
  b=MeLrVxSpICAtvve+m7WOfbLmM2lZqyea7wDrolCqjNziNsJYrZoZnF8D
   ooeUs4KbowKdGSuCIoDTfUcU5YcX0vvltC+VIAZXgrq1ZaPzaunK5nf/v
   34VhqoIL+EEPvqUVw/TZ8FxkY83xKmAn2T0vuzi1QfY2vsNCE6tLW4JMn
   x+8x6k4pt5TFGR5yNjaA1rygjal1Fi2Ygf5Fpuef5r5Zr6uof6KQxGjgi
   hTv7XdIX53ZmYEZG15JFb8LbAOvXvkUWAM6bzunLkmbn8a4ttVBPINJeV
   746ME9pMPDuOyU7K/7DBgy1VeQjfYrkPVsNRgnBLh8WsGw9dgKmRqlgvw
   Q==;
X-CSE-ConnectionGUID: tcNpC9/FQuOHhebcDXyDnA==
X-CSE-MsgGUID: fsYXNMn0TIWKoxsyepIZUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38198157"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38198157"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:21:51 -0700
X-CSE-ConnectionGUID: 0fueLD3URkaYSKaLn+IWQA==
X-CSE-MsgGUID: ERtNobcGRyCt/5CAIzC12Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80937476"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.162])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:21:51 -0700
Message-ID: <f099a9e8e0651a8599d09a5c98f2f960f0bb3d61.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensors: Fix an error handling path in
 _hid_sensor_set_report_latency()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Christophe JAILLET
	 <christophe.jaillet@wanadoo.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Date: Tue, 08 Oct 2024 10:21:50 -0700
In-Reply-To: <20241005190620.5f8633a9@jic23-huawei>
References: 
	<c50640665f091a04086e5092cf50f73f2055107a.1727980825.git.christophe.jaillet@wanadoo.fr>
	 <20241005190620.5f8633a9@jic23-huawei>
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

On Sat, 2024-10-05 at 19:06 +0100, Jonathan Cameron wrote:
> On Thu,=C2=A0 3 Oct 2024 20:41:12 +0200
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>=20
> > If hid_sensor_set_report_latency() fails, the error code should be
> > returned
> > instead of a value likely to be interpreted as 'success'.
> >=20
> > Fixes: 138bc7969c24 ("iio: hid-sensor-hub: Implement batch mode")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > This patch is speculative.
> >=20
> > The code just *looks* wrong to me. No strong opinion, if it is done
> > on
> > purpose or not.
> Agreed it smells :)=C2=A0 But I'd like more eyes on this before I take th=
e
> fix
> as maybe there is something subtle going on.
>=20
The original HID sensor spec HUTRR39 didn't have this property (usage
ID 0x31B). This was added by update "HUTRR59" to support batch mode to
improve power.=C2=A0
This attribute will not be present on non batch mode supported system
and on supported system this attribute writes will not fail unless some
hardware error.

Returning error is fine.

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas





> J
> > ---
> > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index ad8910e6ad59..abb09fefc792 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -32,7 +32,7 @@ static ssize_t
> > _hid_sensor_set_report_latency(struct device *dev,
> > =C2=A0	latency =3D integer * 1000 + fract / 1000;
> > =C2=A0	ret =3D hid_sensor_set_report_latency(attrb, latency);
> > =C2=A0	if (ret < 0)
> > -		return len;
> > +		return ret;
> > =C2=A0
> > =C2=A0	attrb->latency_ms =3D hid_sensor_get_report_latency(attrb);
> > =C2=A0
>=20


