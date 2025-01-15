Return-Path: <linux-iio+bounces-14373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCABBA1248A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18365188BF87
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DEE241A05;
	Wed, 15 Jan 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLkV3nO3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60511241A01;
	Wed, 15 Jan 2025 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946910; cv=none; b=AfgdMyrhmuzsnRbJW/lS61ufKh+8Kuqa/wekzCoP8JqpowECOEZ+i9DOhu1wTx0pfs9bL86MsYq1LSgzheHxIWAtkFKQbqSQPO++WPFrJHuDPwhL9D5U6rRoqQfTQ2vAC9Ec+2oBDwYTxwuZKu5Z2H1qUrX6nrWuFG7RQCv7AlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946910; c=relaxed/simple;
	bh=Fn9dB4NSEYXXMvogJP1Bq6nvP3ex5ZtHcuIPHIpx4JQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5wG5jXjILDtYfp3+L2dbVxcQjKD9PIxsj1eMdY/fJVGfC4y8LVTrLXHyL1LoiyXw3nRWykRAGS+NakMpfif1R3ITB2g2dNd4qMlXvHBFxiS3biaU8VMlsNlJNyaR3YTULhrvbYJEQGtFUJ+gaJ9EZYGYq9JWAPF8Pkxcptd+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLkV3nO3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736946908; x=1768482908;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=Fn9dB4NSEYXXMvogJP1Bq6nvP3ex5ZtHcuIPHIpx4JQ=;
  b=aLkV3nO3XWaaME+424i6uK34kbw264OahlKBLgb0b6pbFRsT1MD/dJDP
   1OgPD7XHm2A6kYlasOfcY42duzz0ubvuobLB2ueYInXHqG4ktQfIyzWcR
   3/5gPT1jhAgoly30sPHHKZ40ER5bh2bAcLLeK3XmLJOxIG3OppDPhgVzH
   /eSNZYpTEMUl+dCMZaOwiXhcCB7U8NVrsN0yKaLkz1BVK4A9irIwIG6W5
   mvL7ewXRDqgc21Hm5yCXTQj5MroYZ95e09EQfaoZrN9EqC/+RZJmZfb6W
   YrHrfQwIcBflFmj3KvCGTKxN5ZS51X3vtxLd1ZOYN3VxT4J9xXrZszEG6
   A==;
X-CSE-ConnectionGUID: oBHMy2JSSEa1z++77nuOIQ==
X-CSE-MsgGUID: Ty8rtypTTpKSe3oouomovQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37164635"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37164635"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 05:15:07 -0800
X-CSE-ConnectionGUID: pYRsDTDmRBSduh3ek5bRyA==
X-CSE-MsgGUID: qi5o4arnQvSFwkDe48zTJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104993602"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 05:15:07 -0800
Message-ID: <3135248fcbf284e19a2ffd3ab01767709e322980.camel@linux.intel.com>
Subject: Re: [PATCH] HID: quirks: ignore non-functional sensor in HP 5MP
 Camera
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Zijlstra
	 <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina
	 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-input@vger.kernel.org
Date: Wed, 15 Jan 2025 05:15:07 -0800
In-Reply-To: <20250115070020.2777721-1-acelan.kao@canonical.com>
References: <20250115070020.2777721-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

One minor comment:
"HID: quirks: ignore non-functional sensor in HP 5MP Camera"
For this
The format is  not same as other commits in this file. There is no
"quirks". But not sure if Jiri cares.

On Wed, 2025-01-15 at 15:00 +0800, Chia-Lin Kao (AceLan) wrote:
> The HP 5MP Camera (USB ID 0408:5473)
>  reports a HID sensor interface that
> is not actually implemented. Attempting to access this non-functional
> sensor via iio_info causes system hangs as runtime PM tries to wake
> up
> an unresponsive sensor.
>=20
> =C2=A0 [453] hid-sensor-hub 0003:0408:5473.0003: Report latency
> attributes: ffffffff:ffffffff
> =C2=A0 [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:1,
> 2:1, 3:1 ffffffff:ffffffff
>=20
> Add this device to the HID ignore list since the sensor interface is
> non-functional by design and should not be exposed to userspace.
>=20
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/hid-ids.h=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0drivers/hid/hid-quirks.c | 1 +
> =C2=A02 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 1f47fda809b9..c5b57e857e77 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1094,6 +1094,7 @@
> =C2=A0#define
> USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001		0x3001
> =C2=A0#define
> USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003		0x3003
> =C2=A0#define
> USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008		0x3008
> +#define
> USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473		0x5473
> =C2=A0
> =C2=A0#define I2C_VENDOR_ID_RAYDIUM		0x2386
> =C2=A0#define I2C_PRODUCT_ID_RAYDIUM_4B33	0x4b33
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index e0bbf0c6345d..5d7a418ccdbe 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -891,6 +891,7 @@ static const struct hid_device_id
> hid_ignore_list[] =3D {
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS,
> USB_DEVICE_ID_SYNAPTICS_DPAD) },
> =C2=A0#endif
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK,
> USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
> USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0


