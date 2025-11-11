Return-Path: <linux-iio+bounces-26175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03280C4FAB8
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 21:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C383B69F3
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C418927A917;
	Tue, 11 Nov 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDWtkNf9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B63A8D65
	for <linux-iio@vger.kernel.org>; Tue, 11 Nov 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891768; cv=none; b=IIISdTKex3PKLNHBQXA05XLg/1avJB18TLLzzJIE4hrr2B+qfmyCrUF+AbjOul+mv1lRkQoI6+tN0xsYa71I7XDc7IW+MbitbiSiv2aWjJQZChLI8qQX873aq+cEDRo9M7nJP+dOn5KLf16Pyh8nUhhSkX+49FKGJBQjlZ2lJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891768; c=relaxed/simple;
	bh=EZYbTsE65If5CBgtVKkoP4QofhXikzV8SeaQRRV2SsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPldqHPRTxtWsdOx34fPJhWwv5oGqEo3Kzj9Jpf20fnUkXpZNOncO6kV8yA96d6HbIs5CQOzVXCxwt727WaQaOb66d/ORHFGWBfNsm+1NGV1TBEB+d0ahntSxQGDvQziKl+qfJ9e/KBLDdjMI46gh0E5Qt0UVGXkYh1gSKccYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDWtkNf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EC0C4CEF7;
	Tue, 11 Nov 2025 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762891768;
	bh=EZYbTsE65If5CBgtVKkoP4QofhXikzV8SeaQRRV2SsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDWtkNf9oa1hkBS2ZPe4gQE6+U7KWWtNDbkVHvHOfX7oziFUpXJU4UDkYAb0KcxRI
	 LU1+QT/P5p0RF6bvB9ojVOiS/QzKf6qJt9TtCtnwjh3jkHwEqEOflTuKWvEmyH5QJc
	 hLlcnZBwVcO6hZqRGL9mFAKnf3+kiLSwntCoB6uKk2Fv1juRZrVZAPAXxeeeNc+bmE
	 KYYo+6A6NsK4tvCAawx6hD6o57vYQ4Ik/DbSWFEw1Gv/X2gyrL3srbOiX/M24rxPfb
	 wqq6RDBKVRrQ+jLJ9g3NrLR6Xl5fboHWFyU0Az5WZFy7zKffLu+RaqPndQcmU4fCEi
	 91wV8Zicq7xSQ==
Date: Tue, 11 Nov 2025 20:09:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Message-ID: <20251111200922.55f6ba3a@jic23-huawei>
In-Reply-To: <bug-220772-217253-xYMFkeZqGv@https.bugzilla.kernel.org/>
References: <bug-220772-217253@https.bugzilla.kernel.org/>
	<bug-220772-217253-xYMFkeZqGv@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Nov 2025 19:59:38 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=220772
> 
> Alon Ohana (alon4dota2@gmail.com) changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |alon4dota2@gmail.com
> 
> --- Comment #1 from Alon Ohana (alon4dota2@gmail.com) ---
> Created attachment 308926
>   --> https://bugzilla.kernel.org/attachment.cgi?id=308926&action=edit  
> bmc150_accel_buffer_postenable NULL deref diff
> 

Thanks for the report. The thread you reference does discuss
the correct fix.  The ability to enable interrupts at all should be
prevented by removing the userspace interfaces (that are misleading
if there is no interrupt available!).

A few oddities that didn't come up in that thread though.
The trigger provided by this device is not registered if irq <= 0
So we must be using some other trigger or something else is going on.

Could you share the names of the triggers under
/sys/bus/iio/devices/trigger*/name
and
cat /proc/interrupts

Maybe the tooling is using an hrtimer or sysfs trigger but the
driver seems to have a validate_trigger callback that should prevent that
so I think we need a little more information.

Thanks

Jonathan

