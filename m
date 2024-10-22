Return-Path: <linux-iio+bounces-10924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE749AA2DE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180691C22209
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C119D06A;
	Tue, 22 Oct 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqwaOAAT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476719ABD5
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603060; cv=none; b=otQkHnF3GMPC4oedgVQ3SNdyAz+LwouESHAMs5HuTklRz5CxHCEI8D/qLtt9qVL9RBdAB+rctVUznKbLqVzVb9bLYUTLXdmBezKvBwvDLAZhmRuxt05afItPw7MBHnqqXYvB9SHkhyNqBun6rjgop5To3ZrM6a7irMvha1pMmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603060; c=relaxed/simple;
	bh=cjSE7g1sRGxJBOESjyKtcLLU7btMplH6oVWyinzJXyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iJxACku0uKrjXB2lsPP/3M3zJLfUz7hY79XCydoXUdHY6km7OmYL4QiBOFRed5GKs4FxBiydxhkDmUQXScoNKFvNrgJr4a9S/pjukf/RpoHnl8elpa5h9eCPBjXUwWMvQamrlETN0+CxxfGWGLnNpFemFC+w0sfxQThQETCPEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqwaOAAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF6C2C4CEC3
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729603060;
	bh=cjSE7g1sRGxJBOESjyKtcLLU7btMplH6oVWyinzJXyg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QqwaOAATkBiswAKnfkUf6kZhH+Blp/sJ5+428amC9YYQvIoshtrMR4UZEL+T6bgKt
	 PI8QNUHc2R9ucEtsxFDgVjqT8Zpk8AYfjZqcFC+sVDxgH8r81PFFjf0CWSn5WqA58H
	 o4GxtUK/HdhBOEHiSK3MshiAjaw0y8iNl/u+GTf3l1hkV0spzcf7/LPX31IhyhOTis
	 EkRbE2RwD8B/2y6RKGSoocFxeXIqG2gWm5+AdzgXbYPDjBw8MScQqIpbnHTkQ+/ykY
	 tzIXf//LKSH2OBjPFL5lpTg55NukzbfpUjO7VeXb8lNWd1JzqIqL6PErIiFf6Bq07d
	 libPWsz7AxSKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E5F40C53BBF; Tue, 22 Oct 2024 13:17:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219418] BOSC0200 Accelerometer Invalid chip 12 initialization
 error
Date: Tue, 22 Oct 2024 13:17:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cameraphone77@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219418-217253-W8aIY3iiYR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219418-217253@https.bugzilla.kernel.org/>
References: <bug-219418-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219418

--- Comment #1 from Camera Phone (cameraphone77@gmail.com) ---
Created attachment 307036
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307036&action=3Dedit
dmesg output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

