Return-Path: <linux-iio+bounces-659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC1806F98
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 13:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53493281A82
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 12:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B25D364BE;
	Wed,  6 Dec 2023 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHFuHTD4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CB3456A
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 12:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86309C433C8
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701865357;
	bh=QWkPrjInzqd+rT49UsT+wQzrAvOYAt4exoghTRpB9dc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AHFuHTD4fbeRhNamK2LouS71p4ySpP4FFG1UNaigcUcsNAP52+er/Sqy71JdeRyby
	 sOkaLslUYMuNz4ldasAKE3tuaXUSc/obRRDt0H4JInD23Ps2sy+P7lwKjOHCHTR/yn
	 gTDgO+sOHOgu8LUDMrENNB8CmrUqmD0aYE8SyLzzGJgUZTvY7QsG5+XicB2Mk8dVQk
	 vMNosK5kA63acOFfN/BalklwWNTmHNQ2bccmc0KgUEPOvwWxoYbNT7uaGaCm4U8zk3
	 vInePB9hwRPvgynLskcrRmcn2/+W3FSaQ97nAaxgZgVQVYr0DBhSF+H5lvf2ueCU+l
	 5KQ83SnBISltA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6A652C4332E; Wed,  6 Dec 2023 12:22:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] Ambient light sensor on Framework 13 AMD laptop stops
 working in Linux 6.7
Date: Wed, 06 Dec 2023 12:22:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218223-217253-FNmluatVJz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218223-217253@https.bugzilla.kernel.org/>
References: <bug-218223-217253@https.bugzilla.kernel.org/>
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

--- Comment #2 from Michael Marley (michael@michaelmarley.com) ---
Created attachment 305549
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305549&action=3Dedit
Full output of dmesg on an affected kernel

I attached the dmesg output.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

