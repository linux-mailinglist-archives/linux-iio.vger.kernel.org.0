Return-Path: <linux-iio+bounces-9996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C1498CCE9
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 08:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE77B20E83
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 06:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14080C0C;
	Wed,  2 Oct 2024 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IGKCfHi9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3bNNFHri"
X-Original-To: linux-iio@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE92260C;
	Wed,  2 Oct 2024 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849196; cv=none; b=a4Nb6OYaqZGd6gg8TPx9u4TYKUEKu+NOaT85kcIOvVCk03zKSQQl4GVZ+e9snIy83bJpqsAFPOk2+MfwqpajNQg4UHAK6Nyl9g2w1bUl9+PK4U/3VEWkqzdE7+kuA2w0mBWIwh/4D6cBupgH77+jimWH1v0ZFvLWV8aM+Zdqxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849196; c=relaxed/simple;
	bh=ZOnyixNdkYYP4iCEqHe+3H95VH7P3xfL/Y3GK6XLpVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8O2hvbSt7rINFY1AbnbpIasvK1/V8zKTp/LLEUKIUszz4j1R0zIYGYUNhmBCLVi6CjNKqJJvjaklfOb7PlKIvEMX7u+30N63WSclmcbheCDYP9hXGDdZNzeXe7AnnUt6oRxEI6D68J0qKjpjpvpSq4vQAGlJmLhJCePywa2+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IGKCfHi9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3bNNFHri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Oct 2024 08:06:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727849192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wcw1gyi6yWjzKR83Z8NM+e6VF6cD/6YLBvCgIc8IKy0=;
	b=IGKCfHi9L1s5xiEZv77F/2BDAFQNFsLbd5AiqOTiWz+XiKI06HRrtgmgHrn8QMqduyVa5c
	PgYmj++C+a3Y2/m98giwLG+MJ0JtkRxbAcf/tt/gSRe+xQ1BYT3sRAv6ueEOqoCAKq8roM
	0xMEsCmFa7v/mFUApWuLxKwridQh5WORpuf3kqILMFzk590YN1OCrOieNQSofJiOIYsaRW
	eL6iY24vUSa5eTyG4l0TTib5TUUAcHjknc1E4RN7gXkZ7BwpYLvobkecVuj/x7Px6okgLX
	FY2IFjHQVGIKvG4QNiDxbTqXxlMWfCVGgId8qLl6Gz3MU3IevzXVs0R69aKCow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727849192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wcw1gyi6yWjzKR83Z8NM+e6VF6cD/6YLBvCgIc8IKy0=;
	b=3bNNFHriiymJYqL0+M1h8PquyWRZjS36dbqFzJ8oZLpXgpIThRNk1OGM7Mp7LooiXXDUtr
	/HKPWziTzjbes9Ag==
From: Nam Cao <namcao@linutronix.de>
To: Tudor Gheorghiu <tudor.reda@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: rename macros
Message-ID: <20241002060626.YX7I6_Zi@linutronix.de>
References: <20241001202430.15874-2-tudor.reda@gmail.com>
 <20241001225426.wUBOFdMi@linutronix.de>
 <Zvy0qyQJP1S17SFv@redaops>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvy0qyQJP1S17SFv@redaops>

On Wed, Oct 02, 2024 at 05:49:15AM +0300, Tudor Gheorghiu wrote:
> I will submit a patch to the checkpatch maintainers with this thread
> linked, and if they agree this is a bug and accept the patch,
> this driver patch will no longer be needed, since checkpatch will no longer flag
> these macros as false positives.
> 
> Do I have your permission to add your name and email to Suggested-by?

Sure:
Suggested-by: Nam Cao <namcao@linutronix.de>

