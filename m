Return-Path: <linux-iio+bounces-16969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E267A6515B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 14:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6777116360F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C1230BC6;
	Mon, 17 Mar 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaCZEbZq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86350EBE
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218672; cv=none; b=LjAm4cALCR8eEQNvaX7ozAULOWbbl5FDbnIO8ByKsC9ZOcMMAPouWm169ydUqae2MAiTFdyEr8j2xszZ5nahzgm6zyacHe70HBR8Lz93brmhXKXmuJe/Q2oQ03prfmlKJJlYTSI734+jvEGezSXabsg33YxaR7v4DyA4uLSX0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218672; c=relaxed/simple;
	bh=SUGEU1as6cSYPzl5be4LUHuxfZEku6aLFOfe9FzjWUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o/rzd7h9wLtAisakIZuPBz53GfFaKRiqJC8tSzCa9/6JvftY8QqRPQc/gSHUGl/cs5dUKn1ymIXu7x7fFkpf+2TG1YrevtmXn2yY/OdFC17wjDxKl+blbfcmFesXuubmZ97ie2REVmz1wxCY96+eeVpnh4bEPw85jFbgxV+Sft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaCZEbZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDB9BC4CEE3
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742218672;
	bh=SUGEU1as6cSYPzl5be4LUHuxfZEku6aLFOfe9FzjWUg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oaCZEbZqfLyUv0wEowG2OS+HJ7AezxIxmsWGee5C11+1ov6pkgRdGQ9cWircXJgY8
	 QaMsG2VtB4KlnAh8o/71PrOPRfwBMQIwdYtnuvnOBckjMARZGFqDJG5qNbwdPx4Kw5
	 NKcQmtg0zTzxagOONVhX9Bl1akwWcMIvbCFIwvBV+4penucfP7KyvfF8HfwY1DbEWw
	 nCbax+MCBx+9k6cU/MRBvyUcUNNrTLU2UzidoaPNKWgxJBpj/9cKgmQJ3bVIOi2KRe
	 V4dcycOWf6e3lQKuCNupR2c4orZKLkZI0lt8I1fmIPJVZMYyZ9rVkUHgWIJ5AuC8LK
	 Tj2oCIdDOm2Sw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DF7A3C433E1; Mon, 17 Mar 2025 13:37:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Mon, 17 Mar 2025 13:37:51 +0000
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
Message-ID: <bug-219890-217253-i1N3avIyxQ@https.bugzilla.kernel.org/>
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

--- Comment #3 from Fred (wysiwyg81@rbox.co) ---
Hello,

Sorry for poor presentation of message above, I tried direct email answer, =
not
so nice..

Let me know if it's too unreadable, I'll try to post again

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

