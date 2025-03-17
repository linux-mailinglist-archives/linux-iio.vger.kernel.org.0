Return-Path: <linux-iio+bounces-16942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC1AA647A3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3915E16634E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BED2236FD;
	Mon, 17 Mar 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSxD9IXc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C5221F1B
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204331; cv=none; b=RSN/VlZsq0b+rWai+R1wzzOqZYMLvQlY3S30afQev7HKnJ1Kziqp4gMwQKwMuYwzZQanGx9tb63U90nr8m0WL/Yv8UxAQ2204+GCIZ3i37gqXQJyQQeZod6O1sOl+Ckde4NVdjXaEWjUZiv5iWubmso8z/BMRvGE+W6cM9Ze6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204331; c=relaxed/simple;
	bh=oWwmKbi/HtXoQ4LstbPyv3nh7Xa+NN+hy3hAZLsvFi0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bB8cvxKnUqkb/3XEST1REXFaJvOKB8BrMKEY/Kv7qog22/egHhvWcINsC2eycT2+ameoJlqFGfiwQEEctmggqmQXggkfFL/1mzQno2iaciAthP0l3kwbqd9q7Qhhc7kKXJ7NEcLy60zVAnt7WF4aId2qDppOJmDeMfi4JG7uMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSxD9IXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FCF7C4CEEE
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742204330;
	bh=oWwmKbi/HtXoQ4LstbPyv3nh7Xa+NN+hy3hAZLsvFi0=;
	h=From:To:Subject:Date:From;
	b=QSxD9IXcEKc1IUGw9GfgW5Z8fiHL2UV6YKE8wS6JrOUGmaY1wMRopA/mX9qB1dnB3
	 6xmxXT1q9W9CHRbyS5zE2PlKPPF+CZ60jMLBSYeG35rhzP6sE+wAInmZYrJ/e8QtF8
	 eX1MrpznYAbnXMK2cBoakb0l6gptSjyr7c+1agz8jeHwK/EEKrZfuqgq8csUFVeFWr
	 8qcrRPTSZmIvM+zt6grWUkFtLv2GcQkApSWREskj6/6pcs/YJsdLymC76IAIpDxwhk
	 C/pRyy01ZxKwfKZC1sKPB7N0r1K9BZugBUkIaEzpA9De/hWUvHHOn5ZRe2217g+vM8
	 4Dg7kweL6Q9Iw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 663F0C433E1; Mon, 17 Mar 2025 09:38:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] New: illuminance sensor is jittering between correct
 value and 0.03lux
Date: Mon, 17 Mar 2025 09:38:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219890-217253@https.bugzilla.kernel.org/>
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

            Bug ID: 219890
           Summary: illuminance sensor is jittering between correct value
                    and 0.03lux
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: wysiwyg81@rbox.co
        Regression: No

Hello,

I have a Lenovo thinkbook 13x gen4.
Automatic brightness control is flickering in Gnome, so I checked sensor wi=
th
monitor-sensor command (iio-sensor-proxy).

it shows following behavior:
monitor-sensor  --light
    Waiting for iio-sensor-proxy to appear
+++ iio-sensor-proxy appeared
=3D=3D=3D Has ambient light sensor (value: 316,000000, unit: lux)
    Light changed: 299,000000 (lux)
    Light changed: 0,030000 (lux)
    Light changed: 299,000000 (lux)
    Light changed: 0,030000 (lux)
    Light changed: 299,000000 (lux)
    Light changed: 0,030000 (lux)
    Light changed: 305,000000 (lux)


the 0.03 is unexpected has it has never been that dark.
it seems it's not a iio-sensor-proxy bug as I can see similar behavior by
checking directly content of here :
/sys/bus/iio/devices/iio:device0/in_illuminance_raw


I checked the behavior on windows to make sure it's not an hardware failure
from my sensor.
While I cannot have direct access to raw sensor data on windows, the automa=
tic
brightness is perfectly smooth: no flickering of any kind.

I didn't found sensor name:
=E2=9D=AF cat  /sys/bus/iio/devices/iio:device0/name
als

But if there is other place I could look, let me know.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

