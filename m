Return-Path: <linux-iio+bounces-3507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3C87BA91
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 10:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276361F21A56
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD955D478;
	Thu, 14 Mar 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry8IudeZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48992D629
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409060; cv=none; b=abnEEYDCWFGtsSca1EKi6nJdJ93YNhwf0ZZhhjshuYWBJeAqvt6kzlWi0nzsIrqXWqmQ0ticDHI0PlE/zBu/o5/P+vZErZZxRThg38p2Zt0sApLlx4+DxTedrOakqAQ57H4oPI6TZBrYJmqDfw5fTd7ENt5COvsS3vag8+oosWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409060; c=relaxed/simple;
	bh=KoiKWJbV1oAmHbpp3/e1PgR6nkMz8nkr5nW/GVf1hMo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jw/fgwe6GZB5VQNEvyT06bCn7o5+XVhUxQmVNq9Es53EHCwOMyfPBB9EMMdEWULbX6PXLwkYHJIt5JocAw+5rAIrgUVuqjlKinLvFn5/cHSFF4ql4S4QaGRysEoBIU4/fPXwbeQXmJyOMJhG1ewDxfq9/dm66BYWimdI84pYu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry8IudeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44F84C433F1
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 09:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710409060;
	bh=KoiKWJbV1oAmHbpp3/e1PgR6nkMz8nkr5nW/GVf1hMo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ry8IudeZWpYDVLlMIwrswggimAhJHE8u0zLRdE0eR9nK2DWeTQ9XubBL7TPHlw1K4
	 7Vd7VnzNCVIY1ORNums9oe8qRVSPWh8i0a6K6tbdqPCGtSXyP10MrG9aFuYHB/H8id
	 pEBg7ZFFURWGOO+W4LGIUx7OBjjGck2473s1ZQ2mcia7oulyi9FKwHp/nh0si//WGa
	 vjWKN7+H9rYCXLCnhmz0rKbSEckEdtA5B3TaktweT4baCiIcM4OP/bPCzAMdZoLlkH
	 rx5ld9U7/cDZDH5E4OJkiEt5QSSCR0nwljvIYn2UizsOTvcV8/zzaQDTwXh8zLPVAL
	 CLslHAbmLwqRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3D2B8C53BC6; Thu, 14 Mar 2024 09:37:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Thu, 14 Mar 2024 09:37:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-MVi2qj5NvF@https.bugzilla.kernel.org/>
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

--- Comment #10 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
p.s. (again)

And (likely stating the obvious) please attach all the i2cdump-*.txt files
here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

