Return-Path: <linux-iio+bounces-16964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D5A64E5B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC5C188585B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB2A2356B0;
	Mon, 17 Mar 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B90WY1kV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94822DF95
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213660; cv=none; b=Oso+wbCYJm+nk434F5l5RU4aGhMI5KXLtU8jqhkzpA7J3nZPyMkO6W4fGEgxAV9ApIWYWx+aiLmeVK7q+cn9gFZU2eNpJx1gClpbaAmiXpvu9sT3mJT9oPj4H8gVacqnyFeR3plFEaHLNNx4qDYdvA/TCbIisfBKdPEEfQRGUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213660; c=relaxed/simple;
	bh=AeP55J1dNMhR0ySTO/1TlJe4ymsbLGdDe3kGCVhBvV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsP9B1xHWwwB4dTkMbOqpG2E1pAh5zOOBv3o9P8zZmSi8t01XvIcLP8afrp0/G7O/UCwvdcPO+moONdtiYg6ffBOsaU2Q1VXr78FRhsvABNmwo8U7565Fppkqmt0AwfjmF9tTOO8t9fZ+5wcQLsmRoC2/40WtnfOWclibH8N0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B90WY1kV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58800C4CEE3;
	Mon, 17 Mar 2025 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742213659;
	bh=AeP55J1dNMhR0ySTO/1TlJe4ymsbLGdDe3kGCVhBvV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B90WY1kV2PtAAT/0y8NJ0CcRe4+IWJ+4Z1YoQxgKj6wuRi3pFFlwvNoSemz+pk9Yt
	 Vm/MVx6dm6OsB3bVe2u6ykWFxcU4+3m1xaDjspXOwHNCxUNc7Hrwp4jdqtuDrPonb+
	 GkBpkDzWD3y5EzXykUr29DlP73JYRE5DkGCTG1wtMl4mQXImicitMI9LqIbJqvQNGx
	 Y7ykdJCzRdusuU5aaxgXMBRtQrMWbXh86R4zX2gJ2nendikzdwESjLTXTiT+f+OwLY
	 0+lG7ghlr59QRVDIc9/QxjpN7Tb0Tjy4Jx+dwL9CAFZJDNKw2gKdvhWkG6ASn5UoBk
	 pafnT1+y3NYiA==
Date: Mon, 17 Mar 2025 12:14:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>
Subject: Re: [Bug 219890] New: illuminance sensor is jittering between
 correct value and 0.03lux
Message-ID: <20250317121409.707590a7@jic23-huawei>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Mar 2025 09:38:50 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219890
>=20
>             Bug ID: 219890
>            Summary: illuminance sensor is jittering between correct value
>                     and 0.03lux
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: wysiwyg81@rbox.co
>         Regression: No
>=20
> Hello,
>=20
> I have a Lenovo thinkbook 13x gen4.
> Automatic brightness control is flickering in Gnome, so I checked sensor =
with
> monitor-sensor command (iio-sensor-proxy).
>=20
> it shows following behavior:
> monitor-sensor  --light
>     Waiting for iio-sensor-proxy to appear
> +++ iio-sensor-proxy appeared
> =3D=3D=3D Has ambient light sensor (value: 316,000000, unit: lux)
>     Light changed: 299,000000 (lux)
>     Light changed: 0,030000 (lux)
>     Light changed: 299,000000 (lux)
>     Light changed: 0,030000 (lux)
>     Light changed: 299,000000 (lux)
>     Light changed: 0,030000 (lux)
>     Light changed: 305,000000 (lux)
>=20
>=20
> the 0.03 is unexpected has it has never been that dark.
> it seems it's not a iio-sensor-proxy bug as I can see similar behavior by
> checking directly content of here :
> /sys/bus/iio/devices/iio:device0/in_illuminance_raw
>=20
>=20
> I checked the behavior on windows to make sure it's not an hardware failu=
re
> from my sensor.
> While I cannot have direct access to raw sensor data on windows, the auto=
matic
> brightness is perfectly smooth: no flickering of any kind.
>=20
> I didn't found sensor name:
> =E2=9D=AF cat  /sys/bus/iio/devices/iio:device0/name
> als

Two possibles types. It's either a hid sensor or an ACPI class interface
with a sensor wrapped up in firmware.

My guess is hid-sensor.  Can you do an
ls -lh in /sys/iio/devices/
so we can see what the parent is.
+CC Srinivas based on playing guess the sensor.

Jonathan





>=20
> But if there is other place I could look, let me know.
>=20


