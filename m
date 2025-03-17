Return-Path: <linux-iio+bounces-16968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E6A6501F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EA01895927
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE15219E8;
	Mon, 17 Mar 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyKQeqAi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E87485
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216553; cv=none; b=l7ErO9YkJFmRBwUMXhIGlaDWgGjG99/AIiDTfpl2yygqxZOzk1acBHqgGY/Q/rJ/cWc0pa1o5o9oN95Zhja118UpGjLk/7z21BFzMUaebJlfaYFAkzkmR63gLMopjgozZkJSc6kkWLM4gEIKcAJZAEVQygz6G3sTw97Qk41yjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216553; c=relaxed/simple;
	bh=rAgM9sXM6UK35pQzCVk9jQ1yC1erSnGrou20ohsDQhw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIqSwAJenfDSwUCcEjr/6b0MSnk+FZJGvjvK63L30qV1nGmTOMkIasTk/pXGkNsCs8MKAQGcf5yXsy5thxxLQARMKUsacd50ukcVCzLIQFmYuKjy67DmebCyPUSigrERkGAnRKsROhbRHaFRbSkq1RTQoeSNGuZntSRSCNqHIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyKQeqAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7130C4CEE9
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742216552;
	bh=rAgM9sXM6UK35pQzCVk9jQ1yC1erSnGrou20ohsDQhw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eyKQeqAiwolFi+xHxpnfr3lzHfTc4onBxT2P53TIE7T1YXNSvXG+R/Cl9AGMGd+Qc
	 ASJsUHhyfEh0flOi3TBRBVocQBTRd8KM8l6MwKrZkBqR22rjiE+YPDSHtdU8S+20bu
	 1l3Dmo6o5+vQ6DXFD1RJ61/ffafmHaS+K6MqZaCxP+NsVPR6OXcgqybGXLEfe7Xh5i
	 E2qp6GmjNMqJwY1De1Y+E/oJpm+MJB0KaHhHrjN1Y8Fen/uZwO4+Aerr80j8OkEtxb
	 mF8nLKPeAJNhXET1ipRPrV2l9Wc8pcS50+IjWclir21ue+JsoNjx2j+VZ5kPze3Dog
	 CEeMrt64942JQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8FA55C4160E; Mon, 17 Mar 2025 13:02:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Mon, 17 Mar 2025 13:02:24 +0000
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
Message-ID: <bug-219890-217253-UhojLJ6ONz@https.bugzilla.kernel.org/>
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

--- Comment #2 from wysiwyg81@rbox.co ---
Hello, Did you mean in /sys/bus/iio/devices/ instead of=20
/sys/iio/devices/ if so: /sys/bus/iio/devices =E2=9D=AF ls -lh Permissions =
Size=20
User Date Modified Name lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF iio:devic=
e0 ->=20
../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.00=
0E/HID-SENSOR-200041.6.auto/iio:device0=20
lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF iio:device1 ->=20
../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.00=
0E/HID-SENSOR-200041.7.auto/iio:device1=20
lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF trigger0 ->=20
../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.00=
0E/HID-SENSOR-200041.6.auto/trigger0=20
lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF trigger1 ->=20
../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.00=
0E/HID-SENSOR-200041.7.auto/trigger1

(bugzilla seems down currently, so I try direct email answer, hope it=20
works, I will check once bugzilla is back).

Best regards,

On 17/03/2025 13:15, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219890
>
> --- Comment #1 from Jonathan Cameron (jic23@kernel.org) ---
> On Mon, 17 Mar 2025 09:38:50 +0000
> bugzilla-daemon@kernel.org wrote:
>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D219890
>>
>>              Bug ID: 219890
>>             Summary: illuminance sensor is jittering between correct val=
ue
>>                      and 0.03lux
>>             Product: Drivers
>>             Version: 2.5
>>            Hardware: All
>>                  OS: Linux
>>              Status: NEW
>>            Severity: normal
>>            Priority: P3
>>           Component: IIO
>>            Assignee: drivers_iio@kernel-bugs.kernel.org
>>            Reporter: wysiwyg81@rbox.co
>>          Regression: No
>>
>> Hello,
>>
>> I have a Lenovo thinkbook 13x gen4.
>> Automatic brightness control is flickering in Gnome, so I checked sensor
>> with
>> monitor-sensor command (iio-sensor-proxy).
>>
>> it shows following behavior:
>> monitor-sensor  --light
>>      Waiting for iio-sensor-proxy to appear
>> +++ iio-sensor-proxy appeared
>> =3D=3D=3D Has ambient light sensor (value: 316,000000, unit: lux)
>>      Light changed: 299,000000 (lux)
>>      Light changed: 0,030000 (lux)
>>      Light changed: 299,000000 (lux)
>>      Light changed: 0,030000 (lux)
>>      Light changed: 299,000000 (lux)
>>      Light changed: 0,030000 (lux)
>>      Light changed: 305,000000 (lux)
>>
>>
>> the 0.03 is unexpected has it has never been that dark.
>> it seems it's not a iio-sensor-proxy bug as I can see similar behavior by
>> checking directly content of here :
>> /sys/bus/iio/devices/iio:device0/in_illuminance_raw
>>
>>
>> I checked the behavior on windows to make sure it's not an hardware fail=
ure
>> from my sensor.
>> While I cannot have direct access to raw sensor data on windows, the
>> automatic
>> brightness is perfectly smooth: no flickering of any kind.
>>
>> I didn't found sensor name:
>> =E2=9D=AF cat  /sys/bus/iio/devices/iio:device0/name
>> als
> Two possibles types. It's either a hid sensor or an ACPI class interface
> with a sensor wrapped up in firmware.
>
> My guess is hid-sensor.  Can you do an
> ls -lh in /sys/iio/devices/
> so we can see what the parent is.
> +CC Srinivas based on playing guess the sensor.
>
> Jonathan
>
>
>
>
>
>> But if there is other place I could look, let me know.
>>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

