Return-Path: <linux-iio+bounces-14558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619FA1C2EE
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8513A8FA1
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224FF1DDA3C;
	Sat, 25 Jan 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="funFK4Nu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0F13C67E
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737805186; cv=none; b=PCOCE38XCDVvXr++AUYMfEcOYyJ0vP7ydMWeC8a11CLBKyUfiHnX779y1FExwqwAXOdyqx63py3ebOiyslsEyRTPvIgFfLL/WvuiBldoU8gvvMqbEPukRu0ysnPWRwEfBgFlffjR4KyUx/FpPqSvz6ht1C2NUcCtvBugKICqPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737805186; c=relaxed/simple;
	bh=8ZGG3jgF9MWeJRnT/PUkPdvIKnd/5gA8jsyY+AxShkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWg0Z7CGHIDSqVp2F0mHcmpjwkjyssSi9OIu0UMx4L/pkTGzAKsnytoLuriyclaLBYu4JM9nApviTgE68T9Pi9bzEuJNleyXyDqDkQcuMrlgT+ZbVd9EbCDyAoc/JHlSaI9k/QEJ5EuM9J2NvZ4EK+jBWKSTuDsXRPz0O1SQjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=funFK4Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3354C4CED6;
	Sat, 25 Jan 2025 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737805185;
	bh=8ZGG3jgF9MWeJRnT/PUkPdvIKnd/5gA8jsyY+AxShkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=funFK4Nuk9Axcj4vdAREGPwZ8UMJwGoW9ElQ3op/WoalWoOc6ER6ClLCnrkUzGhmk
	 xav7VEhklv8KzyZVQ0DduLEbme8Wh+YjUh0nR6zlAtWK8F/Zte2lhwh5VESb91xg69
	 CFlh0jg3hTcgJzcEW8YDgFG4/Tvk1e23BofsjkOuxk77EAj7FQuKINLXiN+d6veRwM
	 zx228ER7eTnL3maVjX2PH8weJPWQ+052HsH5NDL1P/8PxFwgXSGNThbzXnXrgcdozD
	 /MyXW7KAh0YssLceRkZZRVEanrqzQ+vMFjzXzfHDmFj+s1o2N7X0VwcIIsVpeU5yDE
	 fa+ls4vcL4MVw==
Date: Sat, 25 Jan 2025 11:39:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Message-ID: <20250125113938.12521e29@jic23-huawei>
In-Reply-To: <bug-219192-217253-TaTr78TvIB@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
	<bug-219192-217253-TaTr78TvIB@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 17:45:29 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219192
> 
> --- Comment #11 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> Do we still have this issue in the latest vanilla (v6.13)? Looking again at the
> code I'm wondering why we can't simply use guard()() instead of scoped_guard().
> It might actually fix this.
> 

Is this actually a bug rather than a false warning?
My impression was that this is a compiler problem and I'm not that keen to modify
drivers to work around that unless the resulting module is actually broken.

If we have to, just add pointless returns instead of unreachable() markings
with a comment to say they are unreachable but we suppressing a toolchain
issue.

Jonathan


