Return-Path: <linux-iio+bounces-3539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0529D87C78D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 03:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996831F219AF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 02:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497A46AA0;
	Fri, 15 Mar 2024 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyB/f78I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8DCA4E
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470030; cv=none; b=SGGlWO1sotuPAKCaS2ErAln72ZTd3gEp2/I7JUTr541XVTRk8iMKdS8reOpIMpvxVfgEjQ2XQ/bWPax2OVgixZwj2IYsWQW2jXftT7XE+BftmOL2OVgKmJWqEtN9lL99xDbFkZrKGvtWy+hoBvSUa4V2Fi4VOMTyhLCbVb93EWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470030; c=relaxed/simple;
	bh=ufw8bHbLFQ6Xf057v3z/u7Zrx5XmvG/Ta9JflD7nVkk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAYPeO/8hKINE4Zzzg4aOCLQkRL0P7n8rUmP2eYpuOFG71qimivS99g3PTOJjiw08WuMD0RRhkbohicN5FtHja0LcNc4sE8JjShLt9GVH8G9ToLPI/mBEJR+cgcA5JcWY789GUrQ1nCA2bYgQuF0PVOZfJ8d+WlkSQ4OyG2BaLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyB/f78I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80CDFC433C7
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 02:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710470029;
	bh=ufw8bHbLFQ6Xf057v3z/u7Zrx5XmvG/Ta9JflD7nVkk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gyB/f78ImX6YukQOSBaeopkwpDvutFOusYZ9Ubtnj5N9Bb7tQvzCFyFYrl9DfRkhS
	 zhGcl0kQNo5K17B/Tt5SydtoS1k4LJmQOtKktBjitHhkdmlrKAHvUQFOwlLHMmIQdG
	 MrK1o5pv/epEV3ZMzB3owyvVlDUqRNv3fO7R2ng81daEn85fiidNuO/oAl7mOwVMYW
	 5QH5b/+0ZoQJ2EL/ktvw9SI789Uhua+P2GPVq8ShKM5X7DOCVdwgMKq2uQkFHPDbPm
	 vjWWgi2LPf0rfuqf/xjhVTa17vvJrqrLTP/mZf33xHUVv59itRs6LFFD+IAJdcU+IG
	 7oRDBw9LMG/eQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7AB6AC53BD0; Fri, 15 Mar 2024 02:33:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Fri, 15 Mar 2024 02:33:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-JEUXXIZZ0v@https.bugzilla.kernel.org/>
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

--- Comment #14 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Hello Hans,

Thanks!  I think your diagnosis is spot on.  I went ahead with the process =
and
attached the files.=20

Resetting the accelerometer with the provided command immediately made it s=
tart
updating again.

Cheers,
Kirk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

