Return-Path: <linux-iio+bounces-11987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71649C0823
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95E91C22E2F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5BE212D2E;
	Thu,  7 Nov 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UL9C46wI"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A583212649;
	Thu,  7 Nov 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987491; cv=none; b=nKQ6yz5jYMevNac8AEQTWv7BuuTHdp9sElDUY3KoMWFG9wZXBIijIBgiE32rYoNqNvLtVqu5dHXRvzfhzW5pgMyBsfn5L3eLGP5MKWjWDkNmdgxF0KNQQHXq4V7HZLbKBcXDqTK/bH4FZJp1elBDoTMbMfZFG4t+1kLm2NHo+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987491; c=relaxed/simple;
	bh=zTRFksBbsZzucVoizkgeACRdDVFfkWx96qifjGvnPlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp9HgXCgeWlXbNy34fso9WfD5q5DGxh3kccDFPlmxDS5kOTvimC8rAueR0NFzqiO3BOgIEepj4Oqs3S2i3FgsWxGDjoRu+C2iIVByX7IFfzGgqImEx8HmYo1qIqp5CYp+pUQGCUKCYPnSGwBrcSfCYJUzv8UkzY5mhiaToUuC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UL9C46wI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HX5GOJc4ky/+VuvmS4Zsp8lqZ9shMfpMhaTLW2ZnQSg=; b=UL9C46wIqeoRxhjiykWkxyJJxP
	LxD3vx0burgeau+IFu4BtQ1bd4iQaUyO8wGDlQFjSSzjVim1OAyTgxSELRPGo8NRGhfsf9CjlP9N3
	HZTKi77yo+zIhDj1Fs+nyPuU3dJSBv53oWw85C7IQpdGW8nNn4/cUfpr347PIVIKysgAkAn8oUyuK
	Hctki9lGI0O4ZDVyFcaMj6PkPZrhXzkcqblrCpgJ74TIT4fuuiap/C/FQxWP4HkbUq7YQae/QqSKN
	PeMmvMI4MJH0LmDVpHAvSu/9Jl/cXF/ipe+/DuG8tzexcAe7/T3M8DSjsk+1OcFjFznnygLIABiM+
	ihKq9SpQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t92ua-0006Xa-JT; Thu, 07 Nov 2024 14:51:00 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jiri Kosina <jikos@kernel.org>
Cc: lee@kernel.org, jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
 dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale platform-data on
 remove
Date: Thu, 07 Nov 2024 14:50:59 +0100
Message-ID: <4934964.GXAFRqVoOG@diego>
In-Reply-To: <nycvar.YFH.7.76.2411071358210.20286@cbobk.fhfr.pm>
References:
 <20241107114712.538976-1-heiko@sntech.de>
 <20241107114712.538976-2-heiko@sntech.de>
 <nycvar.YFH.7.76.2411071358210.20286@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jiri,

Am Donnerstag, 7. November 2024, 13:59:04 CET schrieb Jiri Kosina:
> On Thu, 7 Nov 2024, Heiko Stuebner wrote:
> 
> > The hid-sensor-hub creates the individual device structs and transfers them
> > to the created mfd platform-devices via the platform_data in the mfd_cell.
> > 
> > Before e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")
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
> > Cc: stable@vger.kernel.org
> > Acked-by: Benjamin Tissoires <bentiss@kernel.org>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Acked-by: Jiri Kosina <jkosina@suse.com>
> 
> Are you planning to merge this together with the rest of the set, or do 
> you want me to expedite it? I'll be happy to apply it separately as a 
> proper fix.

This change was more or less a surprise find, because I wanted to make
the platform_data pointer in the mfd_cell struct const and this the hid
sensor hub stood out as doing something strange ;-) .

So patch 2 of this series actually depends on this change to not cause
build errors.

But seeing that we're after -rc6 alredy, I would assume the brunt of the
mcu series might need to wait after 6.13-rc1 anyway - but I guess that
depends on how Lee sees things ;-) .


Heiko



