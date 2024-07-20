Return-Path: <linux-iio+bounces-7747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96EF9381F0
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162DD1C21619
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FC133987;
	Sat, 20 Jul 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA8RNShE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EE946C
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491131; cv=none; b=YT7zuWZmtFt8gyiHZDUKEEtL3MhNakVsh3Mt5XwRCBeMOPEl9yCr4c2cReTGBt2d4TTc5ErYJeMbXP9JEcSStpuHRumyzsuEBjHlL5XM2FEB/8E7T22jw47eqhlgNtzAYdjzV40K96l8kVAy/T0sx+j61YEpyUC/AoTZ1aX+TSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491131; c=relaxed/simple;
	bh=RXjB6DUe7GWQjIAZxdIuDYDI+7mKxU/mTHk0USSQhGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0o30NI9uit0m3LywkZ2SAer5UeuqzNyRyYuPPfs/ATfHrJsREdXKrflgn5Xe/7CSEHX1VLKk0OCRAAmbsx0IqEROBEPh0jM90gSD3BGRT9SsQuZgqS0QyL/eSnz0EXEJ/MxZ6pYZKlYhfRDovi04lIO7kH/btffkopZorESCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA8RNShE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96B6C2BD10;
	Sat, 20 Jul 2024 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491131;
	bh=RXjB6DUe7GWQjIAZxdIuDYDI+7mKxU/mTHk0USSQhGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iA8RNShEvwH76290+Vju3319q7MORRE6jB942p7A2uD1DYJFb1S3KGoAc+PI8m5hq
	 CfRro+m/wvQOf1sKxPXjjq+/d/X3swLss7yT2MFErp2Wx2RGqFshZ17Ad6cidMwua+
	 mlHd9GjlGsuVPXmHyHA7pn6jAfEezCYiVyqAnYWa25b8f2D//IosXatwdjkqjaCInV
	 M9aM6AiKAKshTBOADQUDs8AHTDyW7iuXtGsLdQfQrf+SlnD0o2owBQmoVu6qPbodFm
	 YmNCXnRrXBpcvxnCMJZGbqMjEB2JZ+t3/8zT0E7Dp93bhhU9TOFKnPZXp94eKPvnEB
	 1yYL0D7WObHJA==
Date: Sat, 20 Jul 2024 16:58:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 00/22] iio: make masklength __private (round 2)
Message-ID: <20240720165845.703d8c36@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:37:46 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi Jonathan,
> 
> Here it goes the second round about annotating .masklength as __private.
> 
> Again, only compile tested for arm with allyesconfig.
I'm going to pick up as many of these as I'm happy with. However
I'll only be putting them in the testing branch so there is plenty of
time yet for additional feedback as I can rebase that as much as needed

Thanks,

Jonathan

