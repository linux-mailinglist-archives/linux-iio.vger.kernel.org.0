Return-Path: <linux-iio+bounces-17156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29800A6AC5B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 18:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB368A2A9A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4A79F2;
	Thu, 20 Mar 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q98BvE0k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D501DEFD2
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492792; cv=none; b=bfwbB7ai9fqTy1cdwimuSFx3fVlp4ZS2kOM+62aaJCUKv9LE7afZs4tPdvCK9l8IdaglsK5qSPl/e8RsPGWeUNFJK7xFXHSJW2y4uy97HBQCIj/IfF34kPYfS0iPE4pNPC8w45Vk+aubcowCqujln4oYsv3mYF4RAtGX1rmFFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492792; c=relaxed/simple;
	bh=LjZ1MesvEYcGDScIpiz8zfD4EO7Z7JSSG/LDp57H4JU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TyTfWkRF+asLwnj9lVJqGaYOpG/ZCBAzrbhZ4lTJoKJ4hDJTJGU3aDL3Yk5D8QgTnBnUPQTTufE9u1BgFrHmfQk4wyuKPbEsbQG9QJHDqjZBNVtw6ZbQ0LsAl7WSQQilw+bUFeKrjnLyWvJrViu5zLdp6MYxSifd2jltb6xGb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q98BvE0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DCEAC4CEDD
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492792;
	bh=LjZ1MesvEYcGDScIpiz8zfD4EO7Z7JSSG/LDp57H4JU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Q98BvE0kTGWyGMry2mnsVVzsDwGS5vhY4tTQasKp4ToxXXqxxMLPYxzflcAdyksWC
	 rA4vt2t43ssgM9tmtUH43Rq45PsZccjE16zySFUPC4fVG2f+FqZpduSNKQpJQzA1hV
	 excIfKpySa8DYDe66wiD5vlBH8ZG+ygX8bSWOH9au0p8HP8AOnWkX/FhE2ElN9q9yw
	 TJuNSoeK/pDhEEHcRxoWuhdin3mbgLomvDk1b9fhfF6DwOUcmqPwR0PumuxtUcsMev
	 EXLvyujhbmkE90waeIIbHSXB5elEJ7ihZiI21KxG7lznSLUBnrGdtcWQY5AxMGcdhn
	 FEFVRkiT4XDFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 23D80C3279F; Thu, 20 Mar 2025 17:46:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Thu, 20 Mar 2025 17:46:31 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-droH682ucF@https.bugzilla.kernel.org/>
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

--- Comment #26 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
Also check from iio-sensor-proxy
here on this system weather iio-poll-als or iio-buffer-als is getting used?
Means weather it polling for input of using buffer mode?

It is possible that when you poll, then you have this issue not when using
buffer, where sensor hub will push data.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

