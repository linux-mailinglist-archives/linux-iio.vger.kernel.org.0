Return-Path: <linux-iio+bounces-10012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17BF98E7A3
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 02:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF45B25331
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C06748D;
	Thu,  3 Oct 2024 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKI78aLz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C264A;
	Thu,  3 Oct 2024 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914619; cv=none; b=npU24QZT1SHf/BdiSyxiyTkWUzkAvdbzRi3yz8F9S8CfDkP6nVxHchZW9+AkJALUzzANepkxJPhr4ljadxsyLkNQlTAT7C0RZQe3qoF7xNm0fQW1Aq1Vwyixa/fsL1nLGIWEEa3U0w8o76NKSyy2g48gIeuKoxuTaiEE5jYUk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914619; c=relaxed/simple;
	bh=t783UiUjich5X9sa7ujzAR59XVGTzDqvLbn/mKTpiX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kv5qYDtcKUg+EvnWQM1MQDjo6glTf3dBF+0dW4b1i2MzL1P5AeYOzlWnROgy4jKcBIQjHqzGrjaMhTe6vgaO4TOBSMR8jYwgeSbIdKmhxPSnJC08XDQFNPJpTMreRPIxOWRXaP+n7hskPkbX2E/R9MYjwzde+GF2l7ULZE6ShVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKI78aLz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727914618; x=1759450618;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=t783UiUjich5X9sa7ujzAR59XVGTzDqvLbn/mKTpiX0=;
  b=oKI78aLzF16dDX65WzG8yegrEJ21c6mERrt2HiBlZ9xH9EjwsVrCHn0M
   U7j9ae8204ICw7+DLPrhkXm+Wz5i6PV/34Nft+LjS/9zmTOP+XRh/stju
   HtSBRlNmEWiZUog91EYDzs10aWHz0jO+JehYl/apKZm38ZlK/3DDQX+zG
   L8hyDh77nyU6ZCBl0VjO0JkxFuL+GUzTLGIQN2oJkg2vNsglhMzjctTe6
   kaOUdyMWkcESN5BMIWyBs+TSjazOZ3E73aRoUsYhVFtDR/Zb5E0sv0k/j
   Mb7Kl7lT3D2kNBHgkNrN+LgfqctSTjk+dflgmpHF2wHcmipMkpiZAOFmF
   Q==;
X-CSE-ConnectionGUID: PnbsB371S06a2oHkoLZoKw==
X-CSE-MsgGUID: gce1vaCFSNezU/I/vkJXKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38483210"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="38483210"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:16:57 -0700
X-CSE-ConnectionGUID: Uj2jFyvbQ+Og+6tBwNr1TA==
X-CSE-MsgGUID: 5JQtABJwRCq2sp64ZE4utQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74419035"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.106])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:16:57 -0700
Message-ID: <edd074ed88830180527417aa45ff222cbb71c1f2.camel@linux.intel.com>
Subject: Re: [PATCH v8 1/9] HID: hid-sensor-hub: don't use stale
 platform-data on remove
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Heiko Stuebner <heiko@sntech.de>, lee@kernel.org, jikos@kernel.org, 
	jic23@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com,  linux@roeck-us.net, bentiss@kernel.org,
 dmitry.torokhov@gmail.com, pavel@ucw.cz,  ukleinek@debian.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Date: Wed, 02 Oct 2024 17:16:56 -0700
In-Reply-To: <20240908210803.3339919-2-heiko@sntech.de>
References: <20240908210803.3339919-1-heiko@sntech.de>
	 <20240908210803.3339919-2-heiko@sntech.de>
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

On Sun, 2024-09-08 at 23:07 +0200, Heiko Stuebner wrote:
> The hid-sensor-hub creates the individual device structs and
> transfers them
> to the created mfd platform-devices via the platform_data in the
> mfd_cell.
>=20
> Before commit e651a1da442a ("HID: hid-sensor-hub: Allow parallel
> synchronous reads")
> the sensor-hub was managing access centrally, with one "completion"
> in the
> hub's data structure, which needed to be finished on removal at the
> latest.
>=20
> The mentioned commit then moved this central management to each hid
> sensor
> device, resulting on a completion in each struct
> hid_sensor_hub_device.
> The remove procedure was adapted to go through all sensor devices and
> finish any pending "completion".
>=20
> What this didn't take into account was, platform_device_add_data()
> that is
> used by mfd_add{_hotplug}_devices() does a kmemdup on the submitted
> platform-data. So the data the platform-device gets is a copy of the
> original data, meaning that the device worked on a different
> completion
> than what sensor_hub_remove() currently wants to access.
>=20
> To fix that, use device_for_each_child() to go through each child-
> device
> similar to how mfd_remove_devices() unregisters the devices later and
> with that get the live platform_data to finalize the correct
> completion.
>=20
> Fixes: e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous
> reads")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/hid-sensor-hub.c | 21 ++++++++++++++-------
> =C2=A01 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 26e93a331a51..3cd00afa453a 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -730,23 +730,30 @@ static int sensor_hub_probe(struct hid_device
> *hdev,
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +static int sensor_hub_finalize_pending_fn(struct device *dev, void
> *data)
> +{
> +	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> +
> +	if (hsdev->pending.status)
> +		complete(&hsdev->pending.ready);
> +
> +	return 0;
> +}
> +
> =C2=A0static void sensor_hub_remove(struct hid_device *hdev)
> =C2=A0{
> =C2=A0	struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
> =C2=A0	unsigned long flags;
> -	int i;
> =C2=A0
> =C2=A0	hid_dbg(hdev, " hardware removed\n");
> =C2=A0	hid_hw_close(hdev);
> =C2=A0	hid_hw_stop(hdev);
> +
> =C2=A0	spin_lock_irqsave(&data->lock, flags);
> -	for (i =3D 0; i < data->hid_sensor_client_cnt; ++i) {
> -		struct hid_sensor_hub_device *hsdev =3D
> -			data-
> >hid_sensor_hub_client_devs[i].platform_data;
> -		if (hsdev->pending.status)
> -			complete(&hsdev->pending.ready);
> -	}
> +	device_for_each_child(&hdev->dev, NULL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor_hub_finalize_pending_fn);
> =C2=A0	spin_unlock_irqrestore(&data->lock, flags);
> +
> =C2=A0	mfd_remove_devices(&hdev->dev);
> =C2=A0	mutex_destroy(&data->mutex);
> =C2=A0}


