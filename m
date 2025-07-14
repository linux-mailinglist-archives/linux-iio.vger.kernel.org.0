Return-Path: <linux-iio+bounces-21642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6BB0475F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 20:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1631F4A5534
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D472727F1;
	Mon, 14 Jul 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiGHfQHd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63109266B52;
	Mon, 14 Jul 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517480; cv=none; b=dW3iFOA/Da7NHOK42GnH8eoZiOFUk0/adHdM2cLI9phAdUWlqNHUeP3BEY3k+R4Y8MAf7DzMaozBXVmZ9iVl3AWDO+7h8uZGwbV55Hzn2Ygp50lKA33wXVeQPQ4Fh4YLo6lzNOG3BCj+UCx8IN9JhbolEcw1FX/y9riDGxWOrwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517480; c=relaxed/simple;
	bh=9RyjbSOc+cXEdvPnp5WbhrbiDMJMrl/DPBo4L/XRiCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ha63tAZRKE0n3O3lq8fbCRW96qguLnpjeDJWESblrZM0lcHSfO9/Py0+DHSthFoVVBOuuNGjC/lJx/D6rCfTuQ/7WoCFWUHoKt21xcoaG1D8+oWpGldjOuXLrHFTW+hFiv5OOIs5V2VpxEnLCTnbyalXkbtLQcGLKvRDa/xgqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiGHfQHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A40C4CEED;
	Mon, 14 Jul 2025 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752517479;
	bh=9RyjbSOc+cXEdvPnp5WbhrbiDMJMrl/DPBo4L/XRiCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LiGHfQHdXapMtabxDwILAcHMbMXEzwO56kV7rxr0ZmGyR8jupn5bxK9V8q5B+orFF
	 x8MV5q34Cxpqwkr/j50RLwlNDGBwIAS2tJIQuN04L12skGPFZ5Gy6gwY+VlALtxpaV
	 H1Wm+fGWxDTMlz50A2hnuVIa+BQk0joP6+b9M0fcLToKjus5GdepeaGJDKmNn6sPyt
	 qrS36IiJl7RPRowE6aKP48SfdqlD3xf0IdKtJ/tvHiEJ5CZyyfG55dvtGu8Ad/nbO3
	 TElHxO3dZN/gi9RQUM7baDsD7QLQQRrkp5zhd3WmPZ255Ucr7P2mNzs4X07gKuF2d3
	 xT5A1QaBl1qlg==
Date: Mon, 14 Jul 2025 19:24:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ABI: fix correctness of I and Q modifiers
Message-ID: <20250714192433.4bc7785d@jic23-huawei>
In-Reply-To: <d6364e8cf280acd7d4cce0c084ea3325bb2b7fde.camel@gmail.com>
References: <20250711-iio-abi-fix-i-and-q-modifiers-v1-1-35963c9c8c01@baylibre.com>
	<d6364e8cf280acd7d4cce0c084ea3325bb2b7fde.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jul 2025 12:23:54 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-07-11 at 15:44 -0500, David Lechner wrote:
> > Update the IIO ABI documentation to reflect the actual usage of channels
> > with I and Q modifiers. These are currently only used in a few drivers:
> >=20
> > frequency/admv1013 (kernel v5.17):
> > - in_altvoltageY-altvoltageZ_i_calibphase
> > - in_altvoltageY-altvoltageZ_q_calibphase
> > - in_altvoltageY_i_calibbias
> > - in_altvoltageY_q_calibbias
> > frequency/admv1014 (kernel v5.18):
> > - in_altvoltageY_i_phase
> > - in_altvoltageY_q_phase
> > - in_altvoltageY_i_offset
> > - in_altvoltageY_q_offset
> > - in_altvoltageY_i_calibscale_course
> > - in_altvoltageY_i_calibscale_fine
> > - in_altvoltageY_q_calibscale_course
> > - in_altvoltageY_q_calibscale_fine
> > frequency/adrf6780 (kernel v5.16):
> > - out_altvoltageY_i_phase
> > - out_altvoltageY_q_phase
> >=20
> > There are no _raw or _scale attributes in use, so those are all removed.
> > There are no currentY attributes in use with these modifiers, so those
> > are also removed. All of the voltageY are changed to altvoltageY since
> > that is how they are actually used. None of these channels are used
> > with scan buffers, so all of those attributes are removed as well. And
> > the {in,out}_altvoltageY_{i,q}_phase attributes were missing so those
> > are added.
> >=20
> > The differential channel names for admv1013 are fixed.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> LGTM
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

>=20
> > Note: the admv1013 calibscale_{course,fine} attributes are already
> > documented in a device-specific file as they should be since we don't
> > want to make those standard attributes.
> > ---
> > =C2=A0Documentation/ABI/obsolete/sysfs-bus-iio=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 -------
> > =C2=A0Documentation/ABI/testing/sysfs-bus-iio=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 38 ++++-----------------
> > -
> > =C2=A0.../ABI/testing/sysfs-bus-iio-frequency-admv1013=C2=A0=C2=A0 |=C2=
=A0 4 +--
> > =C2=A03 files changed, 8 insertions(+), 46 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/obsolete/sysfs-bus-iio
> > b/Documentation/ABI/obsolete/sysfs-bus-iio
> > index
> > b64394b0b374f2479bab69218f6ad17c6ac651f2..a13523561958b7faf85ac42d965f7=
8b99993
> > ffda 100644
> > --- a/Documentation/ABI/obsolete/sysfs-bus-iio
> > +++ b/Documentation/ABI/obsolete/sysfs-bus-iio
> > @@ -48,10 +48,6 @@
> > What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_en
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_en
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_en
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_en
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_en
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_en
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
> > @@ -73,10 +69,6 @@
> > What:		/sys/.../iio:deviceX/scan_elements/in_incli_type
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_type
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltage_type
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_type
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_type
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_type
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_type
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
> > @@ -110,10 +102,6 @@ Description:
> > =C2=A0
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_index
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_index
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_index
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_index
> > -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_index
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_index
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_index
> > =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_index
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> > b/Documentation/ABI/testing/sysfs-bus-iio
> > index
> > fcc40d211ddf388ad70f489177ba2fcebdb9f8dc..7e31b8cd49b32ea5b58bd99afc2e8=
105314d
> > 7a39 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -141,8 +141,6 @@ Description:
> > =C2=A0
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_raw
> > =C2=A0KernelVersion:	2.6.35
> > =C2=A0Contact:	linux-iio@vger.kernel.org
> > =C2=A0Description:
> > @@ -417,18 +415,14 @@
> > What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_offset
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_q_offset
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_i_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_offset
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_offset
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_current_offset
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_offset
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_offset
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_offset
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_current_i_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
> > @@ -456,21 +450,15 @@ Description:
> > =C2=A0		to the _raw output.
> > =C2=A0
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_scale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_scale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_scale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_current_i_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
> > @@ -603,11 +591,7 @@
> > What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibs=
cal
> > e
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_calibscale
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_calibscale
> > @@ -829,7 +813,11 @@ Description:
> > =C2=A0		all the other channels, since it involves changing the VCO
> > =C2=A0		fundamental output frequency.
> > =C2=A0
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_i_phase
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_q_phase
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_phase
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_phase
> > =C2=A0KernelVersion:	3.4.0
> > =C2=A0Contact:	linux-iio@vger.kernel.org
> > =C2=A0Description:
> > @@ -1458,10 +1446,6 @@
> > What:		/sys/.../iio:deviceX/bufferY/in_timestamp_en
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_en
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_en
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY-voltageZ_en
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_en
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_en
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_en
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_en
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_incli_x_en
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_incli_y_en
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_pressureY_en
> > @@ -1482,10 +1466,6 @@
> > What:		/sys/.../iio:deviceX/bufferY/in_incli_type
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_type
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltage_type
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_type
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_type
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_type
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_type
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_type
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_timestamp_type
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_pressureY_type
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_pressure_type
> > @@ -1523,10 +1503,6 @@ Description:
> > =C2=A0
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_index
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_index
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_index
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_index
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_index
> > -What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_index
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_accel_x_index
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_accel_y_index
> > =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_accel_z_index
> > @@ -1716,8 +1692,6 @@ Description:
> > =C2=A0
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
> > =C2=A0KernelVersion:	3.17
> > =C2=A0Contact:	linux-iio@vger.kernel.org
> > =C2=A0Description:
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> > b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> > index
> > de1e323e5d4741177e58a8c4058fa00271ea3b29..9cf8cd0dd2dfd5b0b67b5dbf28bbd=
b6bb4a4
> > ce7f 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> > @@ -1,10 +1,10 @@
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-
> > 1_i_calibphase
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-
> > altvoltage1_i_calibphase
> > =C2=A0KernelVersion:
> > =C2=A0Contact:	linux-iio@vger.kernel.org
> > =C2=A0Description:
> > =C2=A0		Read/write unscaled value for the Local Oscillatior path
> > quadrature I phase shift.
> > =C2=A0
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-
> > 1_q_calibphase
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-
> > altvoltage1_q_calibphase
> > =C2=A0KernelVersion:
> > =C2=A0Contact:	linux-iio@vger.kernel.org
> > =C2=A0Description:
> >=20
> > ---
> > base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> > change-id: 20250711-iio-abi-fix-i-and-q-modifiers-b1e46ddd8d67
> >=20
> > Best regards, =20


