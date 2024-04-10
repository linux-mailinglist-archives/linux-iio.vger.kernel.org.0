Return-Path: <linux-iio+bounces-4186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633FE8A0361
	for <lists+linux-iio@lfdr.de>; Thu, 11 Apr 2024 00:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953781C20BF9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Apr 2024 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09418385;
	Wed, 10 Apr 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu+R9IW5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64A138E
	for <linux-iio@vger.kernel.org>; Wed, 10 Apr 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788215; cv=none; b=N0dh4bgwZeS32PTnr5AECDCgooIXT5LNEY+NSsQOzcCSx3Xo5oupv0hc2wOMoOmuNlc8Vn3K7Lm4GvSb9dQGdtL61gjtqXKkS9yvx0d+W+96yGH57CoJEprvqFrLlJfLHKM6dBvwAO06zR4Li1yHIvA2YFTGapm22OD5qKrZ3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788215; c=relaxed/simple;
	bh=f9EaIy2savS4pj2VQXWvabZPJ4hHoATbxETNR4V+D8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=udfj+XnkUXK0VV9cqjhaejjTttcv/zJPI+x4k49Rd6E05TMImWgdr2/+cIkbFIlL6WtX80KwEUGWGSaFOZTA8d+Fi1WDgs2ZfpK42mCkMjvDVz87SbzLU+aaVL0q5jnlxys0hk7Yjfq2nY+HaG0kATnbZvK4yOPr5L7RMkKJ8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu+R9IW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 551CAC43390
	for <linux-iio@vger.kernel.org>; Wed, 10 Apr 2024 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712788215;
	bh=f9EaIy2savS4pj2VQXWvabZPJ4hHoATbxETNR4V+D8E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pu+R9IW5UYCLellrQvq8dH8cJtShtxem10q1fFrQvOxG8qLbdqSmVe2spc/i9UYew
	 2+s0QfRbDWu6jYLABcUYbrIWqT4EpdcrejN3T/h4Wt0AgQIhsJpFY7bAoUK38yRUWP
	 SPfc42UwVMrTcQMlWTDV0YYiyYwSwkQeKz01YNr1QCaNkTjJUP7k6588s7QN0znQXU
	 48gaxHGdGwB5XvfJLMfH65qOhJAXSqttucSnXFOcVrGfV590XYPjyBo6v6CVHmV06K
	 EeeukFNT4LDrmQWxbNvkLxc7mAA1Boly0c5RnvIymNIBaqPGdMVfuXF5LOHrnPq4Bs
	 U+6Jpzr8JD8cQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4DAFCC53BDA; Wed, 10 Apr 2024 22:30:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 10 Apr 2024 22:30:15 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-el2xBt7nES@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218578-217253@https.bugzilla.kernel.org/>
References: <bug-218578-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218578

--- Comment #27 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Hello Hans,

I have attached an ACPI Dump as requested.

Cheers,
Kirk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

