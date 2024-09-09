Return-Path: <linux-iio+bounces-9398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C2971D06
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7DF1F23BF4
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F88A1BA87A;
	Mon,  9 Sep 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK7jKwN2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E51B5831
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893239; cv=none; b=cDkMf/NcKzuopi4NT9VikVkrInhv5590nCn5m9qNRelUGMBslj/TYoQHq1Rln9LHK5DPlm4+HIun46dOd8RACT3d+aK8C9pKkCE0X19hnMlzBxapyTQh0d58y0xVMa/k0XRbIbyEckEzNx9Pv4Bfcocr/2wBJYPP1sjl8bBoobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893239; c=relaxed/simple;
	bh=Rl5vt0KX+PveVWguyt0wtk1PMbZ27VB7F2e6JDPYGIc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBxbqamWhYWK6axp9GQMkZJn2/8aOFRC2cw+B6nFE0KN3mKGD+ePnpzmBnfM8eVKw1zyCuaV3k1OqEHbAcWRPOIZ/8ampkU1wYN3B6jbVQGrDivy0+7ZmSmroE3d+oFZB83jMCsaKlOEkeDzPYAanqEwMB5afDpubagZRyaTKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK7jKwN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28321C4CEC6
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725893239;
	bh=Rl5vt0KX+PveVWguyt0wtk1PMbZ27VB7F2e6JDPYGIc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MK7jKwN2BXGs5JLkBTkfiz7aqf3neA4g7mFiRIpjXeMgiTO5upiQGHCclcTZ4nEnm
	 oGu+dsITUya6Bemj6KFnx86dvVJCd7nqC08Nf2k+3xXepUZOvRZ53WSfA/B2pAQHL0
	 EN4uCYlr67KHXSYvMQO9kImQ8j7pnhL5c2sxUVVzyVHlfna8K4GQHtCJVlvUFaHRsl
	 6HtCzXfz56bYcg21uG4o8ZdPAMe3IlIVzJox/dl5N5JXwP7Ydw1M+d8PwSDB4gjUVp
	 Eb+j9xKf6Cy95ENN0SDf9FnubmhU8gpZ6O+/IhVreEx1gV2FNHjt6Q1Y2Bhe7tw19k
	 nNsCA/+5xGQmQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 14DD3C53BC7; Mon,  9 Sep 2024 14:47:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 216037] Second MXC6655 accelerometer is not detected on
 transformer Aquarius NS483 laptop
Date: Mon, 09 Sep 2024 14:47:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216037-217253-QN0pf1mBpQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216037-217253@https.bugzilla.kernel.org/>
References: <bug-216037-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216037

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andy.shevchenko@gmail.com,
                   |                            |jwrdegoede@fedoraproject.or
                   |                            |g

--- Comment #5 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
+Cc: Hans as he was working on similar issues in the past.

Btw, do you still experience this issue in a newest kernel?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

