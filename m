Return-Path: <linux-iio+bounces-3431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB8C877691
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C371C209B4
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9E1BF53;
	Sun, 10 Mar 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo3qD2Bv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E82C18E
	for <linux-iio@vger.kernel.org>; Sun, 10 Mar 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074018; cv=none; b=DmzK/LJPiCvXXDZ67jos/QtrubML4aJb/NX7N9a8W/anmApG0VERaO0kzgxuzuq/G9YVv/clCKZF9oF+SYiYLssRHeUlVnc/hTzXfl3tR22sKKak6+uH8vb8MRhhbb5T12JeSUogFHn0y0YSpRfcBJE1URp83Aimpz8ODEp1w4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074018; c=relaxed/simple;
	bh=UpMxARanqghzs5nAQSqETKHse1Nsw4Vw1w9ui96yTr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uK6Jzp2ycoAHRx+sFXqwAcpAKjYuo2IOTbzZLn90Cf6ucJWabt2RO3DpQLl/o/Y9CFOKfDGagtFEAd3vCoBA/Uv83SiNTwtzUxVEbK0Xdh3aQhvF/xCI60kRLGdrqJzeiljaJ1DgwjH+EHkUiKXXmnDpHDcb/u5fKsWijYT9uYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo3qD2Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA95DC433F1;
	Sun, 10 Mar 2024 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710074017;
	bh=UpMxARanqghzs5nAQSqETKHse1Nsw4Vw1w9ui96yTr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uo3qD2BvG4QKEOulh7IAZJNJILtbCM0SQDBvI+cGGkD4qQhgxq/nmgFwOOmDt3voH
	 2VGYnimo/7+zsJFZ+6QmEQzQ7/0go2q2CGpN4Voffie9H8m8BWktB5TJV0XWcvc4cC
	 z/tr9DmhECetp10Z+geeMzZvW39D7D3D0KaOglPOI83JPhiWBkA9gSdOgKNHhf5UK6
	 LKtUIPcq2CgeR/saR3yO6ABBDDmYT7AYgWgbq0oPWhUBjkTqLo3KzAmfUmwouuVd19
	 NeFgtAqvtFdqMUB8cW6eWMqrflxXZ6yrL0xsa1cC+NGFQiy21SkyX08RhPm5yaMDMC
	 vzUeMPpN15RPA==
Date: Sun, 10 Mar 2024 12:33:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [Bug 218578] New: MXC6655 accelerometer not working with
 MXC4005 driver
Message-ID: <20240310123323.532c48e6@jic23-huawei>
In-Reply-To: <bug-218578-217253@https.bugzilla.kernel.org/>
References: <bug-218578-217253@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 09 Mar 2024 17:55:32 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=218578
> 
>             Bug ID: 218578
>            Summary: MXC6655 accelerometer not working with MXC4005 driver
>            Product: Drivers
>            Version: 2.5
>           Hardware: Intel
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: kernelbugzilla@kirkschnable.com
>         Regression: No
> 
> Created attachment 305970
>   --> https://bugzilla.kernel.org/attachment.cgi?id=305970&action=edit  
> Output from udevadm info -n /dev/iio\:device0 && also some samples of
> accelerometer raw values I see in /sys/bus/iio/devices/iio:device:0/.
> 
> Hello,
> 
> I recently bought two Chuwi tablets which contain MXC6655 accelerometers.  The
> accelerometers work in Windows 11 and the tablet rotates as expected in
> Windows, but upon installing Linux the tablet auto rotation was not working.
> 

Hi, thanks for the report,

First thought is that there may be some power control hidden in the ACPI tables.
Could you dump
/sys/firmware/acpi/tables/DSDT
and run it through iasl -d (from acpica-tools)

Find the section related to his accelerometer and post all of that.
Sometimes there is a _DSM (device specific method) used to power things up
- this stuff is completely non standard unfortunately so we have to base
any support on table dumps from the particular devices.

Thanks,

Jonathan


> The Chuwi tablets are:
> - UBook X Pro 2023
> - UBook X 2023
> 
> This does not appear to be distro specific, as I am seeing the same behavior on
> both:
> - Linux Mint 21.3, with kernel 5.15.0-91-generic
> - Fedora 39 Workstation, with kernel 6.5.6-300.fc39.x86_64
> 
> I came across this thread indicating that support was added for this in 2020
> via the MXC4005 driver: https://www.spinics.net/lists/linux-iio/msg53171.html
> 
> This seems to be double confirmed by another issue I found here on this bug
> tracker: https://bugzilla.kernel.org/show_bug.cgi?id=206703
> 
> Unfortunately in my case, I see the MXC4005 driver is in fact loaded and
> running, however it appears the raw data is not changing.  When looking at the
> output from iio-sensor-proxy with "monitor-sensor", the orientation always
> reports "left-up".
> 
> I tried a test where I watched a cat of all of the files in
> /sys/bus/iio/devices/iio:device0/, and I never see the raw data changing when
> the tablet is rotated.  I'm attaching the values I see from the raw data in the
> text file.  Interestingly, Fedora reports different raw values, but
> iio-sensor-proxy still says orientation is left-up with these values.  In both
> cases, the values don't change when the tablet is rotated.
> 
> The output of "udevadm info -n /dev/iio\:device0" is attached too.
> 
> lsmod reports that the mxc4005 driver is loaded, along with industrialio and
> industrialio_triggered_buffer.  Unloading the mxc4005 module with rmmod causes
> it to disappear from iio-sensor-proxy as expected, but otherwise unloading and
> reloading the driver seems to have no effect on the symptoms.
> 
> If there is any further information I can gather which will be helpful, or any
> testing I can help with, please let me know. 
> 
> Thanks!
> 


