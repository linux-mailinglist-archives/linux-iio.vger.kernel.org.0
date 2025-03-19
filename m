Return-Path: <linux-iio+bounces-17079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63299A68677
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 09:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B56D17AD56
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD629250C0D;
	Wed, 19 Mar 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM3BRp5S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAFC20C46B
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372064; cv=none; b=sJosULXCD1tSI5uUCqKBZbR4VazQiFXUGionSFU85psJYhtXcCHJXXNtZBzaNXeBvkKjBNfrGeL6yRQTH9vg4wm1drJZedrI2uZrButu32pKU5OZhspQg9RTEXJYGeI0MdvdFbFbaEUKjDGjh9UxYwUFUyLNoc0I/lP0xyuXRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372064; c=relaxed/simple;
	bh=cQRZzPjSS8e/9k9ZvPSLuI62o8WPELjCqh2NaxhQzvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXoEVIFBSWQ5jpbmEZ+DNvEcrIomhO3MNioMDdXPoVlPx9kdYgXzjT/a0lT7d02VOZ2vOPcRsttazHjdGO2+eea+t2c+5L9AnmPSJgJH5PqwThrAuSDFn4/1NC5MhfICob8Z5Yn/uSKFZE5kk7eWRdwiqLp6UglNoPntg8JnnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM3BRp5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 089D1C4CEEE
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 08:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372064;
	bh=cQRZzPjSS8e/9k9ZvPSLuI62o8WPELjCqh2NaxhQzvE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XM3BRp5Sq5IH4wPWw7iQHZj3dzeVdgpJGmt2xFoIFklTfofbLeeyFMAuCD+Dx4QlO
	 6ckKOj0Qz49dKFfj5LO+Ox1d+2zi9QKbPa2K+z1Cp0puzfy9Ie9sXzRm50IC5JaRSW
	 YOuKpTUNaNt/43mNi175B2f0wtzhYpKvU7BEqYKTzv23a/zMgAuPH0dexfq6pGXtQ5
	 v1KBUnYmj+Z/pqLg7ljAQ3wZX8nd2r6Ec3ay8JTtfTVVE+JmpsyuXHMZJc6Z569TJm
	 CsACoEakK0Iq8n1QzSW4troC3wnHbO74heEezQ87UNkp/5pKBIy/yf3MsAy9q1aXVA
	 daTfox9+XVMTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E40E7C433E1; Wed, 19 Mar 2025 08:14:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 08:14:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wysiwyg81@rbox.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-zih6h2B3uQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219890

--- Comment #17 from Fred (wysiwyg81@rbox.co) ---
Hello Srinivas,

I have some trouble again to access bugzilla website (error=20
502/504)..cannot see the patch right now.

I try again answering by email directly, hope it will keep better=20
formatting than previous attempt.

In the mean time, I tried the following command. The unexpected "3" are=20
very visible here.

=E2=9D=AF watch -n 0.7 "echo \$(date '+%Y-%m-%d %H:%M:%S') \$(cat=20
/sys/bus/iio/devices/iio:device0/in_illuminance_raw) | tee -a=20
log_illuminance.txt"

I attach log_illuminance.txtto the email.

iio_sensor_proxy is still disabled for those measurements.

I'll try to setup the patch as soon as I can access to it.

Best regards,

Fred

On 19/03/2025 01:54, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219890
>
> --- Comment #16 from Srinivas Pandruvada
> (srinivas.pandruvada@linux.intel.com) ---
> It seems that with raw reads with ON/OFF there may be some bad data from
> sensor
> hub.
> Unfortunately, need a kernel built with patch for debug dump.
>
> Remove iio sensor proxy from running and reboot
>
> Before run
> echo 'file hid-sensor-trigger.c +p' > /sys/kernel/debug/dynamic_debug/con=
trol
> echo 'file hid-sensor-hub.c +p' > /sys/kernel/debug/dynamic_debug/control
>
> watch -n 0.7 cat /sys/bus/iio/devices/iio:device0/in_illuminance_raw
>
> Send the output from dmesg command.
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

