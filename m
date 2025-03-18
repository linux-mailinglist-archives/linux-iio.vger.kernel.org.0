Return-Path: <linux-iio+bounces-17038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2970A67BE2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 19:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AB3175EAA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274AC212F9F;
	Tue, 18 Mar 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgtT0mm9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA12212B38
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322459; cv=none; b=Npj9wHG2r3B9Vz4GB/dJSqYiQcrQcyiWpmX5IAt74dl68jBQ24jfb23HX2nRWU2gjI9V//TM/CsWNVUShhNapV1zvQfwTY0qbT5EwhnBg+fb9Hrm/pog4U89yRb24J57447+SR+w5IP2VkFU5oBJ/ehq3uajT9wQPyZVkonwvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322459; c=relaxed/simple;
	bh=lf137VnVcp21I44m9NQAVewbbub8GACVWaYAVqh9olY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XSs1dCB7O5sghheVm2VtdWC4LTmORCh9ljG0Ydt07jurZ+eopYM08n4BXqW5H/uAXeNNQENLMUDHRFVMqukXlqBs0mRIszHWIpcmtW9dY0OMI+uRNJISIlIR2Cr1CchTEOvzSi1Exab8m1mROpfi5awvZcuy+/ou0U2J0yObWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgtT0mm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52E78C4CEE9
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742322459;
	bh=lf137VnVcp21I44m9NQAVewbbub8GACVWaYAVqh9olY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HgtT0mm99DEV0UHgSQA4l0TrUAc9yvtrcGdxt0xUgVySSG8oL4Nn4B/mLwZgsMPG+
	 s5inVhxiV01mo/oUJia2LPustSPc6v1KjkoBXXwPOTP7kWcDzgk+uk4/W5Wej0D5/g
	 yMfJxawZ76+1hoGgJ4+SHi8TAE1T251RgbhmZmR9GbGn8Cgw7ymfKOVlWZOV7o5cEx
	 haTM3j+AVI6wwL8h3B4KDU/xafw9zfTObbbEjXl0/FpJe33CJ0uYastRU07EodL3Lv
	 kI/ahtbCv/yN5Q8AhQvFPTwQi8tGoWxkHQEDpEg4L1fNKmikmntoSMwPfxHVSyU1ft
	 x9TCwrEd6o8Xw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 39014C41612; Tue, 18 Mar 2025 18:27:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 18:27:39 +0000
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
Message-ID: <bug-219890-217253-ut4wAPJxm5@https.bugzilla.kernel.org/>
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

--- Comment #12 from Fred (wysiwyg81@rbox.co) ---
Hello,

I did:
echo on | sudo tee
/sys/bus/platform/devices/HID-SENSOR-200041.6.auto/power/control

sudo ./iio_generic_buffer -N 0 -a -c 1000

I hope it's what you expected?

It's evening now, ambient light is lower than previous.
Also this time I use a smartphone blinking screen app to add some variation,
otherwise it would take hours to fill the 1000 samples. hope it's fine.

let me know if I shall do something different.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

