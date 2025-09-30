Return-Path: <linux-iio+bounces-24597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D56BAE01C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 18:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BE21941AF1
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598F2343B6;
	Tue, 30 Sep 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PA6hDWj5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149F13EFE3
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248462; cv=none; b=mbv6AIBHiCeCu0tDBGDXRWgxYM9gRleOCJIzD0UA61042JEyOuJgqTwV3G86xU+ehxDuE00SCZuvAFhFst+YJ0UuXgX9EcgLR/DTmXsmYu2IrEYq//pc9LhHtG1xEWwGMxdYSI/44bQ3qLvIvAoh4GC6R9QXvki+598diC5U9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248462; c=relaxed/simple;
	bh=hfls3aigay6G7X9HZ/ny0MXW8pPDvqYfJKINpvOwK+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvARV9v9ZwKB8hKhXk4savHIn5iGJTBh7Mq51XtABc5AhqIQHbT/Zk95X1SoA5L/7/wUcoIpUUxnCoU5Oc/UxTGi5T+CfzzpT3sOiN1ca7DwCM4LqFcpfz8laOrmRP9rclUryHzWTBpwAc46Enq9Lfce15kqBMV1coWxOgMut90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PA6hDWj5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759248461; x=1790784461;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hfls3aigay6G7X9HZ/ny0MXW8pPDvqYfJKINpvOwK+Y=;
  b=PA6hDWj5ImGE4nLGI4xw+wSamfOVHB5WG4N8YngkZ/vXmi46OVHtpySg
   s6avnH3XWxsXDxTRsWFCAZB125+N1dvLwppj2WI7K7hTVfD+d/bxiDISW
   NZyIwiMwvlkxCRve7kl/hLvmcaO//QpPLVQ3uSMD2lDphJLCE5lUG8p0n
   pPhuL3l6L15WHXrE2+z3XJ+c/wJ7SaHEqys7BmFKPKNHgt4JIz4Ydrtju
   eV3Ip9FiZZHTAQr3U3iAnDtmuhSIbbDnmznxgIi1SMPXPriWJKF8+IQCq
   FjB57Oa7O4JyQATNA3QZyx8JwzLylGSDScZ9GShyx77uh3b3BHAPyrC6f
   A==;
X-CSE-ConnectionGUID: zLQ/rtBsR76iCH87ARWWBw==
X-CSE-MsgGUID: A/xKdnD0Sg68WeNTZVaNeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61677735"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61677735"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:07:40 -0700
X-CSE-ConnectionGUID: EKT7o2+UQh+5GwgDrKuE2g==
X-CSE-MsgGUID: B94gmG4UQAy5cQ8Rw1QUGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="182580534"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:07:40 -0700
Message-ID: <a968fd1b90e31d211d03e18f6fcf560f0d009f62.camel@linux.intel.com>
Subject: Re: [PATCH 8/9] iio: position: hid-sensor-custom-intel-hinge:
 replace sprintf() with sysfs_emit()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Esteban Blanc	
 <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner	
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Marius Cristea	
 <marius.cristea@microchip.com>, Neil Armstrong <neil.armstrong@linaro.org>,
  Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl	 <martin.blumenstingl@googlemail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Jiri Kosina	 <jikos@kernel.org>
Date: Tue, 30 Sep 2025 09:07:39 -0700
In-Reply-To: <20250930-dev-sprintf-cleanup-v1-8-5d65d096a952@analog.com>
References: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
	 <20250930-dev-sprintf-cleanup-v1-8-5d65d096a952@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 16:33 +0100, Nuno S=C3=A1 via B4 Relay wrote:
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Update the hinge_read_label() function to use sysfs_emit() for
> generating
> labels.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> index
> bff7039690ac33bcc9747add8055023dd5a1f3ab..a26d391661fdb64cc34c8c0e163
> 333c01c1f069b 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -176,7 +176,7 @@ static int hinge_read_label(struct iio_dev
> *indio_dev,
> =C2=A0{
> =C2=A0	struct hinge_state *st =3D iio_priv(indio_dev);
> =C2=A0
> -	return sprintf(label, "%s\n", st->labels[chan->channel]);
> +	return sysfs_emit(label, "%s\n", st->labels[chan->channel]);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct iio_info hinge_info =3D {

