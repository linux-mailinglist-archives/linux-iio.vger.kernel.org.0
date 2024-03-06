Return-Path: <linux-iio+bounces-3363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87B3873FCC
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 19:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A4286DA7
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66113BAF5;
	Wed,  6 Mar 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6EReW+q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A19266D4;
	Wed,  6 Mar 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750460; cv=none; b=GvrREcVz+OdlyTaGbR5Dqa/Ybq1uKn1ugi3uKVpJ6eqYkfkQBz/nIzExD9a6rh00JL2qXqdx8wCcSZyuh5/9KWHQSrGIvtsZSry2s9eMuhHZbd3uF9+qvjTSFlJW5GzScubTQNhwvI4M9Wym87olsAJQRmZGdQcBk8d/90SpIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750460; c=relaxed/simple;
	bh=gV0qdvOfcFrVuFUnoKGMfiykayAlHiTwTLIzL0VcW/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tF/bFU5p+t76odSS+AyhkPtugZpgWcdlHLSLpn8an79A8/P0woqeAPQNBErHcDZoGI09w333JeJUc20mHmdpex6/1NA+PIUPnI+AfZo+6vrAYDwvkJtT+PQo7rCV3x+9dfRKylr6VPQDOD1HwFTUw1Ln9CUL0zdvP1RmT5gr/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6EReW+q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709750459; x=1741286459;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gV0qdvOfcFrVuFUnoKGMfiykayAlHiTwTLIzL0VcW/Y=;
  b=Y6EReW+qXsdeX1BJzwY5oeoVc5sSGR1eS2+HBDDspmlqYqEq3jea5PS7
   B6NbYuCSvIL3SwrMh8GLyWS3GOCq3+a6NlSKAeXegZ8rdPVr4mSDpksFA
   IY1gpoOClNr8mp7X8DCgeeiGJ5B9k60MfXrt5oy3XHbokW9eKr0Cxw0UR
   WNde8AcN/o2x2ew6fEKu00sUGd0GkHmTvyIcbcVy5osRDoAlfVttmMNAs
   s9oqaRUG4Dwauwl5QUOUDbGJOV0u5qpI3Dq70enlVAQtQ0g98duqzlaw5
   VFpbMdMF/c0yCmkXL2KaRKYdnOGz2aJxoWluNqaqEOle0PUg4eauTUhvb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4532911"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4532911"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 10:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="47365083"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.89.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 10:40:58 -0800
Message-ID: <bf4206ee5c69c73d487502837b30d0accce85a51.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] HID: hid-sensor-custom: Convert to platform remove
 callback returning void
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, kernel@pengutronix.de
Date: Wed, 06 Mar 2024 10:40:52 -0800
In-Reply-To: <f4c8334ea1548d911862ede881ab0d90a408c156.1709747164.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709747164.git.u.kleine-koenig@pengutronix.de>
	 <f4c8334ea1548d911862ede881ab0d90a408c156.1709747164.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-06 at 18:50 +0100, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which
> makes
> many driver authors wrongly assume it's possible to do error handling
> by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource
> leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all
> drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the
> remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> ---
> =C2=A0drivers/hid/hid-sensor-custom.c | 8 +++-----
> =C2=A01 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index d85398721659..de7287f3af61 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -1032,14 +1032,14 @@ static int hid_sensor_custom_probe(struct
> platform_device *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0}
> =C2=A0
> -static int hid_sensor_custom_remove(struct platform_device *pdev)
> +static void hid_sensor_custom_remove(struct platform_device *pdev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hid_sensor_custom =
*sensor_inst =3D
> platform_get_drvdata(pdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hid_sensor_hub_dev=
ice *hsdev =3D pdev-
> >dev.platform_data;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sensor_inst->custom_p=
dev) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0platform_device_unregister(sensor_inst->custom_pdev=
);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid_sensor_custom_dev_if_=
remove(sensor_inst);
> @@ -1047,8 +1047,6 @@ static int hid_sensor_custom_remove(struct
> platform_device *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sysfs_remove_group(&senso=
r_inst->pdev->dev.kobj,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &enable_sensor_attr_group);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sensor_hub_remove_callbac=
k(hsdev, hsdev->usage);
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_sensor_custom_ids[] =3D =
{
> @@ -1068,7 +1066,7 @@ static struct platform_driver
> hid_sensor_custom_platform_driver =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=C2=A0=3D KBUILD_MODNAME,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D hid_sensor_custom_probe,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D hid_sensor_custom_remove,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove_new=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D hid_sensor_custom_remove,
> =C2=A0};
> =C2=A0module_platform_driver(hid_sensor_custom_platform_driver);
> =C2=A0


