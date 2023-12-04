Return-Path: <linux-iio+bounces-615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129728042F2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 00:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC81C20C02
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B303A28B;
	Mon,  4 Dec 2023 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKfukcTv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C836393
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 23:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83C65C433C7
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701734202;
	bh=udtWwyX+8OFPB7/i/hQo5MMHhFHRSKRns+rJeSRJDFY=;
	h=From:To:Subject:Date:From;
	b=OKfukcTvqNLPxilcw7RF+qwjwCIyfPS9MBmc9g3zMiiA2nxe995uxWe2e1s4WpVBb
	 Xl+Hyaq9wImUUmCCw1v9wdCkjwdgYJG0f5GprU+fROs80xR3pTkVo0w4ywNGvHTZ46
	 wO94zcvY3AlZG6hxfwbFnRZoqLVW+wqXJZ4s4Um5yjkNmlzZ15Sqkeigz8bICf+vyL
	 9uF8iRWXZ8/LrWGevNG/XDFIhxpV1q8K7tdlMxTc1mbwB8LY3c9eHj6AmyOaAoPmo9
	 x1KEHH5J5WIqzumvgNJ+FWMFEjoVavc3icoz7mxVA2NoIU44x9PqBOKHA6Ynkqqyu9
	 YgVu2MBR5G7mA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6B755C4332E; Mon,  4 Dec 2023 23:56:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] New: Ambient light sensor on Framework 13 AMD laptop
 stops working in Linux 6.7
Date: Mon, 04 Dec 2023 23:56:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: michael@michaelmarley.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218223-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218223

            Bug ID: 218223
           Summary: Ambient light sensor on Framework 13 AMD laptop stops
                    working in Linux 6.7
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: michael@michaelmarley.com
        Regression: No

The ambient light sensor on the Framework 13 worked properly with Linux 6.6=
.=20
With 6.7 (currently tested with -rc4), the driver fails to load with:

hid_sensor_als HID-SENSOR-200041.1.auto: failed to setup attributes
hid_sensor_als: probe of HID-SENSOR-200041.1.auto failed with error -1

If I revert 286d528bf0fae9f334fba857825b9701df1675b2,
5f05285df691b1e82108eead7165feae238c95ef, and
ee3710f39f9d0ae5137a866138d005fe1ad18132, it starts working again.

This has also been reported in the Framework forums at
https://community.frame.work/t/tracking-auto-brightness-aka-ambient-light-s=
ensor-in-linux-details/16746.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

