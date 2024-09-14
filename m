Return-Path: <linux-iio+bounces-9541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE097908E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5611C20491
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC531CEEBD;
	Sat, 14 Sep 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeyWWWjd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19091CEE91
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313848; cv=none; b=UjCw2TBbVIUnmrBXwSWl4jXRul/n91VNRjL4PqkmM7PdEXtyrDlHYbMWYD9vOST/dJnA71roh64EbBc0zSpFMKlS8l+kQJS95xt+k3nTD186p2bQONgbKJWR9jtUHFpIpum2s5VkVZBtCxyYGOIFNuqNalYaoXWHzjmc5zpWWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313848; c=relaxed/simple;
	bh=qoS/CsvBpSG6tj/cGqqC37Oxb56lSjVsfPYP7oG7rtk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5qH4LVi9t/XRQRUdP5Xm8uT9HaK8ScDaqwsQzsWGQR4HBPkr0MKpbDMI6lwR2UzpMlAg5nfZbBrhVBeWlZkdzIJ9/zYQDsqDCkskSGNy+e+rIUIc6QZqiRNfq/ksSda49a2EqYXyKTvwSQpxGtZZGOEXy7SIGRBEHFcEnysobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeyWWWjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F665C4CEC0;
	Sat, 14 Sep 2024 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726313848;
	bh=qoS/CsvBpSG6tj/cGqqC37Oxb56lSjVsfPYP7oG7rtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LeyWWWjdUTtnMzt2vctwzLjjztLN3K6Q+PxyC4F/Co4yxieue1QEZnXSnbqmybiSb
	 6avk/ex1N14xKsq56ZcgPv6aXo4+sMzymxGUkOw2GyXESAcyyjpht1G9gkOeqcnhiS
	 gY9K8DyV7kx2NlhIcNcmN1fTgVVPOa0+XyqQ9gf6AMYqNTdcGosHm2hwezHyM9yQbl
	 1Kqui0d6zM+FL5tRulpQSk4eCXLCoEzLiyT3FtFO6s5mC4C+ImYyrmBcnmhgHnET1D
	 N3U2ZLpigyFAfScQ7bxz24lN0zk/O4uxPGHNSbGfukUnJoOMrrGKyeLPp5Wtq91esu
	 UbE6tEl6leQ5A==
Date: Sat, 14 Sep 2024 12:37:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Message-ID: <20240914123722.7a687cfe@jic23-huawei>
In-Reply-To: <bug-219192-217253-CplyWJOX49@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
	<bug-219192-217253-CplyWJOX49@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 05:42:56 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219192
> 
> --- Comment #4 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> ...with the difference that here it's GCC...

Good point!

So might be something completely different :(

Jonathan

> 


