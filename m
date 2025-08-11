Return-Path: <linux-iio+bounces-22605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90EBB21653
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 22:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007CC1A219A6
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 20:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062C32D9EC9;
	Mon, 11 Aug 2025 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaPRU/lE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF852D8DCA
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943438; cv=none; b=ks7DKkG8hfkPMXeniPi4rgwDlO2VSPtLj/ukK4a0fOfkHiOLmIhcviQXqZy5ghUCESnOddrOhQC3S9Pl8xeHvgC5JYUEgd9zXS8hJvduXEuLFM9izhZk/ey+4P2z2Rfd4FmB172EEBi5NKJGo3RynPKRHnivB4mpHFxjM87r7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943438; c=relaxed/simple;
	bh=DsixB3hhX6gceWv7dtzmkayyQ+ixdQrAfrwwljT3UmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQBAtZMfgNOpIay6XH81dZDZX6dQCNud9jS+IGuGelrprbAO1YmBtqF5PMHjtjQSvJvob6y5nhXrCf42JqSGpnIwdMlt0mLnmbtzlKjt2QYUubd28x4VTwfbax8yZ65dDdi3sIyg+Zo7xAxZC8wP55BAHY5dQjO8q28uZxrejpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaPRU/lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C262C4CEED;
	Mon, 11 Aug 2025 20:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754943438;
	bh=DsixB3hhX6gceWv7dtzmkayyQ+ixdQrAfrwwljT3UmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZaPRU/lEzL/wSou3AetCIyJBIudXnkhh98HQCdMH0H+ayWH0OBqO6fyVL6lb0AyEN
	 xqcMvoSHuhoCEaZu3VLxnLO84rBirIi991noh72h1zUFSuV7Js/rQ8+Pj+Ypy+pPop
	 fClQLSvdql1R6NnTytTmxrzs/sIAfzkCcPQN6zow26l0oIBlqCcwpPWn8svb9kw7DQ
	 XnEusx0F+HUFIPQn6nrPlp3tIsDfna+i5FpZsFpVd97Nm0Wqy37AbFE5SOc7pUG/gG
	 hpnBZFKk6/XvnurY4w47dOBgPB93IneajDON3YTGTOeryGlTccy4gVL3kPOhmX+8O7
	 4d5MYS85eFPpg==
Date: Mon, 11 Aug 2025 21:17:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 0/9] Fixes and enhancements for the bmp280 driver
Message-ID: <20250811211711.392d5c74@jic23-huawei>
In-Reply-To: <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 10 Aug 2025 20:58:37 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Revision History:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hi Achim

For future reference, don't send new versions in reply to old threads.
That's a sure fire way to reduce the chance anyone looks at them as they
get filed pages back in many email clients and the threads can become
very very complex if discussion on multiple versions overlaps.


Series title and version number is enough for people figure out the relatio=
nships.

>=20
> v1:
> 	- initial proposal, incorrectly prefixed "bmp280" instead of "RFC PATCH"
> 	- patch series presented in the order it was created
>=20
> v1 -> v2:
> 	- prefix as "RFC PATCH"
> 	- drop channel switching
> 	- rewrite to present patches in smaller units and in logical steps
>=20
> With v6.13 a change was made to the bmp280 drivers to use MODE_FORCED
> instead of MODE_NORMAL.  This broke userspace functionality: reading
> from sysfs interfaces no longer worked and an error was thrown
> "Measurement cycle didn't complete".  This series fixes the underlying
> bugs affecting the measurement time calculation and implements
> additional functionality not available for the BMx280 devices
> previously to allow the use of the sysfs interface in MODE_NORMAL
> again and control the corresponding parameters.  The implementation
> follows the already existing facilities for the BMx[35]80 devices even
> though the actual functionality of the BMx280 devices is slightly
> different.
>=20
> Achim Gratz (9):
>   iio: pressure: bmp280: correct meas_time_us calculation
>   iio: pressure: bmp280: implement adaptive wait for BMx280 devices
>   iio: pressure: bmp280: implement adaptive wait for BMP380 devices
>   iio: pressure: bmp280: refactoring
>   iio: pressure: bmp280: remove code duplication
>   iio: pressure: bmp280: enable filter settings for BMx280
>   iio: pressure: bmp280: implement sampling_frequency for BMx280
>   iio: pressure: bmp280: implement sampling_frequency calculation for
>     BMx280
>   iio: pressure: bmp280: test longer autosuspend (WIP)
>=20
>  drivers/iio/pressure/bmp280-core.c | 350 +++++++++++++++++++++++------
>  drivers/iio/pressure/bmp280.h      |  22 ++
>  2 files changed, 300 insertions(+), 72 deletions(-)
>=20
> ---
>=20
> Comments:
>=20
> Thanks for allo the comments on my v1 patch series.  I have not seen
> any reaction to my on-list replies however, so it appears y'all are
> expecting to Cc: everyone involved?
>=20
> I've just seen new responses from James, but these are not taken into
> account for v2 obviously.
>=20
> The dropped channel switching code may be revisited / resurrected at a
> later time.  However it can not fully achieve what I want anyway for
> how I use the sensor and the later implemented controls for several
> sensor parameters get the desired performance back.
>=20
> The remaining sticky point is the control of the autosuspend delay.
> If the sensor is suspended between measurements, then even when it is
> operating in MODE_NORMAL, an additional latency of 12=E2=80=A615ms is inc=
ured
> when the interval between measurements is long enough to trigger
> autosuspend.  I have set the hardcoded value to 2s as a test (see the
> last patch in the series) and this additional latency vanishes,
> interestingly also the tailing to long measurement times I have
> observed otherwise is also much reduced.  However so far I've not come
> up with an idea of how to control the autosuspend delay from
> userspace, to wit:
>=20
>  /sys/bus/iio/devices/iio:device0/power/async: disabled
>  /sys/bus/iio/devices/iio:device0/power/autosuspend_delay_ms:
>  '/sys/bus/iio/devices/iio:device0/power/autosuspend_delay_ms': Input/out=
put error
>  /sys/bus/iio/devices/iio:device0/power/control: auto
>  /sys/bus/iio/devices/iio:device0/power/runtime_active_kids: 0
>  /sys/bus/iio/devices/iio:device0/power/runtime_active_time: 0
>  /sys/bus/iio/devices/iio:device0/power/runtime_enabled: disabled
>  /sys/bus/iio/devices/iio:device0/power/runtime_status: unsupported
>  /sys/bus/iio/devices/iio:device0/power/runtime_suspended_time: 0
>  /sys/bus/iio/devices/iio:device0/power/runtime_usage: 0
>  -rw-r--r-- 1 root root 4096 Aug 10 18:41 async
>  -rw-r--r-- 1 root root 4096 Aug 10 18:41 autosuspend_delay_ms
>  -rw-r--r-- 1 root root 4096 Aug 10 18:41 control
>  -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_active_kids
>  -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_active_time
>  -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_enabled
>  -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_status
>  -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_suspended_time
>  -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_usage
>=20
> =E2=80=A6which according to the kernel documentation is due to a lack of
> unspecified support from the driver.  Now, it appears I should be able
> to switch off autosuspend altogether by changing control from "auto"
> to "on", but that doesn't seem to take effect; also I'd rather
> configure a sensible value in accordance to my measurement settings.
> The other handful of IIO drivers I've looked at that set this
> parameter don't do things differently, so I don't know if there's
> anything that can be done about it.
>=20


