Return-Path: <linux-iio+bounces-11982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C229C06C7
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191E21F21FB5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B18212D1B;
	Thu,  7 Nov 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD63z4HW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E672101A1;
	Thu,  7 Nov 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984348; cv=none; b=trDtV2cqoFq9dbBfRg/HB0XdP++V3ziJMBSi6Y7k59DcBxozZNI+R59WAKKTQsNmHd338RRdJgVwLf6AxBZh1CidB1uuAjcrdTGKuWLCV82V6jnndepM65ZhQ/gGlso7DHJYW1crnyq0P4NpU8HCc2icnc2PqqpmHzNHfjQet9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984348; c=relaxed/simple;
	bh=O2jEPTTUJi8YuBrD4uo+6+5CJE7GCRdzMd3WNJyIb5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t4cwznAuAehwUFU9S+2q5s7305TCIeWFYv9F+imj+nnqj9Rby9Sam3YFF892ArXz/3Jyd2Kc1durds2lWasL1jfHU2E1jrn+v0by+Rm/9/C73cY+iovs68ll9cSmhgPR1Ru3WuerWlhWkRkZFZDRv3eFFavZsF1kqJTBOtfjLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD63z4HW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC64C4CED0;
	Thu,  7 Nov 2024 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730984347;
	bh=O2jEPTTUJi8YuBrD4uo+6+5CJE7GCRdzMd3WNJyIb5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iD63z4HWcMWir7bHC1m9R+CT/cgDL1VVsJnEYKSEV2jU7HGI+2dVFuZypj0yOnSMM
	 mn3gjCdYb+BdncyjpsM7aAENfKfDqDXnjHN+2pZzXcAtNKO7WmYhwE7RzeUBCUKw2h
	 Nup1Iz0s1HgQ3Gb4OUa/iOOIVQiZ4CeVgWd2UBMnORr7GbcAdAEXM1MgcLuoSUbXms
	 X6tG5gVUTPfyBUebk8mkJuHitQAqBK1utoJ6fBjCahU4wIHzJtNHElOGwm7LDcPfaW
	 MRn8cczXOJQV1BRqGDf6dCM2YXKLjO2zUv3syEb+P+BmVoRQB7n7BShvU1hPmmuX3Q
	 BivsrE6XS583g==
Date: Thu, 7 Nov 2024 13:59:04 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
cc: lee@kernel.org, jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
    conor+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net, 
    srinivas.pandruvada@linux.intel.com, bentiss@kernel.org, 
    dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org, 
    linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale platform-data
 on remove
In-Reply-To: <20241107114712.538976-2-heiko@sntech.de>
Message-ID: <nycvar.YFH.7.76.2411071358210.20286@cbobk.fhfr.pm>
References: <20241107114712.538976-1-heiko@sntech.de> <20241107114712.538976-2-heiko@sntech.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Nov 2024, Heiko Stuebner wrote:

> The hid-sensor-hub creates the individual device structs and transfers them
> to the created mfd platform-devices via the platform_data in the mfd_cell.
> 
> Before e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")
> the sensor-hub was managing access centrally, with one "completion" in the
> hub's data structure, which needed to be finished on removal at the latest.
> 
> The mentioned commit then moved this central management to each hid sensor
> device, resulting on a completion in each struct hid_sensor_hub_device.
> The remove procedure was adapted to go through all sensor devices and
> finish any pending "completion".
> 
> What this didn't take into account was, platform_device_add_data() that is
> used by mfd_add{_hotplug}_devices() does a kmemdup on the submitted
> platform-data. So the data the platform-device gets is a copy of the
> original data, meaning that the device worked on a different completion
> than what sensor_hub_remove() currently wants to access.
> 
> To fix that, use device_for_each_child() to go through each child-device
> similar to how mfd_remove_devices() unregisters the devices later and
> with that get the live platform_data to finalize the correct completion.
> 
> Fixes: e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")
> Cc: stable@vger.kernel.org
> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Jiri Kosina <jkosina@suse.com>

Are you planning to merge this together with the rest of the set, or do 
you want me to expedite it? I'll be happy to apply it separately as a 
proper fix.

Thanks,

-- 
Jiri Kosina
SUSE Labs


