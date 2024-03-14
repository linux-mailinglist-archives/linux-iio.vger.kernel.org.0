Return-Path: <linux-iio+bounces-3506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE8E87BA8F
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 10:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750EA1F23C22
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417D6CDCC;
	Thu, 14 Mar 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5wr6N8f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29786CDD4
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409017; cv=none; b=P809ab+l69nWKdII87UaElQNRh1wiIAEjNHXSH/G22QW+67cHb6+qCOKbDBBAY1W3DGRPO6Jh31tf6NKh7uRJBzDvO0RuEmKGpw6UDhVsAtIKNot0aUdPuahozh65R5YIxxDPuokwizgZwsbYboaSciNXasj7vunMHLWxIpmP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409017; c=relaxed/simple;
	bh=yq8DfW36Mdo3AU6y2k9fC7v+l27ojjQWsD0Frjc4ri8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/f+cqGHaCAw+9daZDGYvhcMDQq7Ejl6NdTyyEfJgZQMjOsKZ74K+rAxO1zUM3shhEDo63kdHxzEQxDHgNuOFbgiDjt9gxabNTUYhOfB+kFR5Lmp3ovlaD18lBhx34ggtxHJEtk9X7rVuAWyUXxTdLK7DFygBqZbkV+AbYD5ljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5wr6N8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20959C433C7
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710409017;
	bh=yq8DfW36Mdo3AU6y2k9fC7v+l27ojjQWsD0Frjc4ri8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q5wr6N8fF+YECpPhwgRFgODQF17+XqNdgz7XMaUTJ5Remv8kgjxWIxn33CG2688ez
	 JRVUKtJObKqbP6WVgFvMJtlcZj2GXRHeLuSVmacU6XJQVX+nFEZK1arReTekSbDBLx
	 24Ou3OSclSyy9od68rX1tr6OCuv0yCXE6scPNoONmXwKcW5/MLF4fl4Zdi2j86s91+
	 XZ2higP59MgqekzGmREPxX53u/oN9MjCTQtVY6FrImjCfs2K0FANSWx50gmu3hXZun
	 6iCtHU56Efr5Z2H4AZjTiWw4tYOxSi9gCZGPoDSiNqG2NrCVwRv7wb33pfrnSxEBfd
	 3hPd3chTyDzXQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1A91DC53BD0; Thu, 14 Mar 2024 09:36:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Thu, 14 Mar 2024 09:36:56 +0000
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
Message-ID: <bug-218578-217253-WBd9pU9Yvs@https.bugzilla.kernel.org/>
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

--- Comment #9 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
p.s.

In your next comment please also let me know if the accel started working a=
fter
the reset.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

