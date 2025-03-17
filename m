Return-Path: <linux-iio+bounces-16998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDDEA66159
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 23:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B127A71E3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7A202C40;
	Mon, 17 Mar 2025 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/0atxZP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2E1FAA
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249597; cv=none; b=l+IRsjbBue9O5llXuW01d6X1m3jpGdUeaeNFUaIzORUzGEFvxcp8rQw1/0q9ufzXmf6mZtxHhQsPQMVUmIDdEfGGvkzKHz4yQpKipElXWu/NgEFTRnQAHWY2R1CmKxWl4wkpNedv1Yj/b6Z3zlVxV5pJmHDJlRkTQDkt/1g+GeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249597; c=relaxed/simple;
	bh=UgHbhlG89dEDqZ4i72qxhdCFZUzl8mDEOPgZJCzGLrk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U8UTFfcotKt6CNaK/7oWKSWbSKRj7ROXbYIKCBsnNNzmOC0p9lguo+dvef/JAkXkumh0YgQwP5Hs/NKRIuHfYtZWOk0OzFxPIVcnKn56lkDnbtvvPC4isUaqVoQI6fTmk8DBU0nrRMlmA9YWxHt1TOrOdTDgS6DaP71gvQV1CeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/0atxZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B533BC4CEEE
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 22:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742249596;
	bh=UgHbhlG89dEDqZ4i72qxhdCFZUzl8mDEOPgZJCzGLrk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c/0atxZPwpTrE96XlyUsy/d1t3UWDPSYTBRsSSTnCMdgYI8v/bxTF0z0DrgYQNwQ6
	 +HUrJeGCQUNSp3HenKJjnPDORkBQI8qsnoIMC6HUmme6bnpsYMYtxnsnIAhI8md2NS
	 3GvQjy5aZ1KK0YPm7vKXExfJRbr0a1NNe0+7ONnLw0uNMaYgWMyKEL1quwmX34RKwM
	 fU9b2wOKtIBn3DESSq20uJHgGc7zMEEbKAFhmHxLmv7BZaBs9GoovH0g8nsydzK092
	 lZJh54DqCG68weJkZRtErZ30QyBC3axB6NMUwq7uA5H+egSBxtEV4wmbsPBHaTT0cO
	 dtJ2HboMrMpxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A106BC433E1; Mon, 17 Mar 2025 22:13:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Mon, 17 Mar 2025 22:13:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219890-217253-MS89o0efNT@https.bugzilla.kernel.org/>
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

Srinivas Pandruvada (srinivas.pandruvada@linux.intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |srinivas.pandruvada@linux.i
                   |                            |ntel.com

--- Comment #5 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.co=
m) ---
This is HID sensor.
I wonder if you read raw attributes, there may be power ON/OFF, if there is
delay between them then a 0 sample in between.

Can you try
sudo ./iio_generic_buffer -n als -a -c 1000


You have to stop iio sensor proxy service.
I don't think you can disable, just rename /usr/libexec/iio-sensor-proxy to
something else for test.

This tool is under Linux kernel source git under:
https://elixir.bootlin.com/linux/v6.13.6/source/tools/iio

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

