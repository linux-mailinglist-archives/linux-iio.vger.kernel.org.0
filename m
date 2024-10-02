Return-Path: <linux-iio+bounces-10007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175998DBDF
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C5C1C23D48
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47591D2F5F;
	Wed,  2 Oct 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb8/eZYV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8AC1D0E1F;
	Wed,  2 Oct 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879401; cv=none; b=dXTmMZpXN8bMPWC6w1aIG56XntyChVHSkp3jxOetGe+dFXdv+R43aKM9EkTguYz71menhkTp6gK257CDNad6kQbGTTUmHrpP55twy44e8VA3x7D+n6qR2ic4umosXgyCm/JcpEiWTnev3wrxaxYtVgxlWKZAgFp9aiP28nqOdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879401; c=relaxed/simple;
	bh=IUfxm32tVmmOfVDOlQoXOqb9lUBiGHe/gcVKrRhCn1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6UEt1urvtG5/gv6D491T2rK36e8LwrggFh1xKnCTfz6021gx2aD0n2leBz3tdVgrt1tK0TQDgYtRezOQhGUQ95fAsx0yKhHuAEq7YTstSsRB9APpjaFN+mmb3+PNNf2M+MvulmDtMtC050y9KFhNtYjR+/vATDlw/vocZx8oEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb8/eZYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEC9C4CECD;
	Wed,  2 Oct 2024 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727879401;
	bh=IUfxm32tVmmOfVDOlQoXOqb9lUBiGHe/gcVKrRhCn1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gb8/eZYVDFhHJKakbJ8WlEWhFR95OE73ArjCjV28CVojPFO+O3gvDbkES7n5AREVi
	 XA4sCe1Ck9E7RTxW3wZrI88j9lW4FmyPQDLAnitliVTNQi1G7o3y+g0YuJTOunILum
	 uZ3PYAa00MZ4NRMgi/8Gi8d5jWwcPxBepQBVUb3EHb8GlVWtHhOs6n86C1DWl81+l+
	 VE56BhJ/T8fW49awBNztf62zepKIZz7GAhh8gXUTnC/UeRh8zk+Ebzk1vEaWDno3r8
	 qWN73CFF618npbKqlQ2a0dWnXIXgp90uSQIiUc814c4H1UmUgvf08zUQbPDmJRm3Jw
	 gYaiJEfetPirw==
Date: Wed, 2 Oct 2024 16:29:54 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, jikos@kernel.org, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, jdelvare@suse.com, 
	linux@roeck-us.net, srinivas.pandruvada@linux.intel.com, dmitry.torokhov@gmail.com, 
	pavel@ucw.cz, ukleinek@debian.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v8 1/9] HID: hid-sensor-hub: don't use stale
 platform-data on remove
Message-ID: <xwfsbi7qrl47owvcozlw3fhg2zvlxo4itlhqulcvs46f56hxrc@fsvgfsaqoy7q>
References: <20240908210803.3339919-1-heiko@sntech.de>
 <20240908210803.3339919-2-heiko@sntech.de>
 <20241002135850.GE7504@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002135850.GE7504@google.com>

On Oct 02 2024, Lee Jones wrote:
> Intentional top-post!
> 
> Just this patch to be reviewed now.
> 
> Any of the HID people around?

Sure.

> 
> > The hid-sensor-hub creates the individual device structs and transfers them
> > to the created mfd platform-devices via the platform_data in the mfd_cell.
> > 
> > Before commit e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")
> > the sensor-hub was managing access centrally, with one "completion" in the
> > hub's data structure, which needed to be finished on removal at the latest.
> > 
> > The mentioned commit then moved this central management to each hid sensor
> > device, resulting on a completion in each struct hid_sensor_hub_device.
> > The remove procedure was adapted to go through all sensor devices and
> > finish any pending "completion".
> > 
> > What this didn't take into account was, platform_device_add_data() that is
> > used by mfd_add{_hotplug}_devices() does a kmemdup on the submitted
> > platform-data. So the data the platform-device gets is a copy of the
> > original data, meaning that the device worked on a different completion
> > than what sensor_hub_remove() currently wants to access.
> > 
> > To fix that, use device_for_each_child() to go through each child-device
> > similar to how mfd_remove_devices() unregisters the devices later and
> > with that get the live platform_data to finalize the correct completion.
> > 
> > Fixes: e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")

That commit was included in v4.1. Don't we want to cc stable here as
well?

Besides that, with the limited knowledge I have of MFDs and the commit
description above, this is:
Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/hid/hid-sensor-hub.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> > index 26e93a331a51..3cd00afa453a 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -730,23 +730,30 @@ static int sensor_hub_probe(struct hid_device *hdev,
> >  	return ret;
> >  }
> >  
> > +static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
> > +{
> > +	struct hid_sensor_hub_device *hsdev = dev->platform_data;
> > +
> > +	if (hsdev->pending.status)
> > +		complete(&hsdev->pending.ready);
> > +
> > +	return 0;
> > +}
> > +
> >  static void sensor_hub_remove(struct hid_device *hdev)
> >  {
> >  	struct sensor_hub_data *data = hid_get_drvdata(hdev);
> >  	unsigned long flags;
> > -	int i;
> >  
> >  	hid_dbg(hdev, " hardware removed\n");
> >  	hid_hw_close(hdev);
> >  	hid_hw_stop(hdev);
> > +
> >  	spin_lock_irqsave(&data->lock, flags);
> > -	for (i = 0; i < data->hid_sensor_client_cnt; ++i) {
> > -		struct hid_sensor_hub_device *hsdev =
> > -			data->hid_sensor_hub_client_devs[i].platform_data;
> > -		if (hsdev->pending.status)
> > -			complete(&hsdev->pending.ready);
> > -	}
> > +	device_for_each_child(&hdev->dev, NULL,
> > +			      sensor_hub_finalize_pending_fn);
> >  	spin_unlock_irqrestore(&data->lock, flags);
> > +
> >  	mfd_remove_devices(&hdev->dev);
> >  	mutex_destroy(&data->mutex);
> >  }
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Lee Jones [李琼斯]

