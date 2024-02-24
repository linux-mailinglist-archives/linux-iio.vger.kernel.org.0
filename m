Return-Path: <linux-iio+bounces-3003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E8E8625E1
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C50528337E
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC8C4655D;
	Sat, 24 Feb 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxPBVfkc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B946521
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790286; cv=none; b=B+w3ZGJg/HdeEJgzdzC0Wi36FikUy9JW9ss5yqKsEcrQd22TI5xjV1UlQsE9dJgWgfCSWxE4bofcL4Wjvtfd7RAmfTDcppgso1tjKPoZ5V+A7nFYPZlJhOTm/EupYsW+hpiZ912l90uBwwGsunFRn8Sz40GcD5QosMM/yQC7uzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790286; c=relaxed/simple;
	bh=XlM91kEFzMhmonymFm+6kMEYlNzK6VQw30YJFpY6luU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjohvYwh3mCNPNW+CYpM3e+zehm6rVwYEA0IgPdZQYMzfxdry8pf9XrPXCVLCIQIHhGgqLkMqy7c9E45tB8I6X+LONZFM2WZAAQgo4zCDBInvoQ6ipZDyL1LArKck/+/GzbF0JZVKKQF1xFVrCOuWbuPTZVtv62ne0e5PDPLFhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxPBVfkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B09AC433C7;
	Sat, 24 Feb 2024 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708790286;
	bh=XlM91kEFzMhmonymFm+6kMEYlNzK6VQw30YJFpY6luU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CxPBVfkcfZ9v2seEuxhGksB3hOu6niV9JL6e7mgc5zogNmI0kKh0fg08G9n/6l9qP
	 +QCHH+c+IyVHtyMwedeitRk6tdwtA9dI6rLO+5BYPMjwE2rny5McyH8UuwGrELKJ7H
	 acZdXGXt2Xo4cqHwPSb0aDkmuKB6Ti0C+o1VJQBnShTvYuxwIIx01iwyQinFsdaA4o
	 s4N5bxfGxEtp+6YlZgymLV0Au7zH+FjJYAroyRPKVDRpEcqF3ewIlkJp442w5UlcGN
	 adYKLnqI0NWsLKAzhOizAmxri2VVEpAKoY4Ls6FNUt1N7S/+jwt/qBoejqV1jVKMXu
	 puDTvJQn+E98A==
Date: Sat, 24 Feb 2024 15:57:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] IIO: Drop incorrect includes of linux/of.h
Message-ID: <20240224155755.0fb87963@jic23-huawei>
In-Reply-To: <ZdNIfangVS5GzKiD@smile.fi.intel.com>
References: <20240218173323.1023703-1-jic23@kernel.org>
	<ZdNIfangVS5GzKiD@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 14:24:29 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 18, 2024 at 05:33:15PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > These were false positives when I was looking at which drivers
> > should be converted over to fwnode based handling from
> > linux/property.h
> > 
> > None of them use anything defined in linux/of.h, so drop the include
> > and include more specific headers (mostly linux/mod_devicetable.h)
> > instead.  
> 
> Simple and important one (makes me not look into unrelated code),
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied.

