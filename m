Return-Path: <linux-iio+bounces-16731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04A6A5BD28
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 11:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9B016AE9C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD1622F145;
	Tue, 11 Mar 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jBJVQtxT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920F2222D3
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687404; cv=none; b=tEVHIBxTCaDOtMRtGJDIgVwJcAoMtZL5Z6W3UlqvGemkooD08reAJEaQLlbRJG8eIb3u+N5m01MyaYeXTC9+KLWTFnUOpjulvuvy6mc6OIyPXcFr/rQnoS02YetuF9LkJ7khB0CcMN60S9E5xln4FcC0tZqNB8AzRlahsoQNSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687404; c=relaxed/simple;
	bh=eMCa5JvVuf6X5CeoiaqOMsynimzrUt5BlGb+LzfNlzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY1Iil5QZflNdQG4VKOHtvEE5g7PTiA8YfhBIy6ApO24UjgjaD6tX5ndPyShFxNSx768qOWtk8A9j+0fXsOypU/WL3TokXgXzHLt2B8hlnxj8J+FANM669id9RTh7ADFEIPerlkug95m9FAzRkcgZwinQdwQgJ/5h5WN0qabxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jBJVQtxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D75C4CEE9;
	Tue, 11 Mar 2025 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741687404;
	bh=eMCa5JvVuf6X5CeoiaqOMsynimzrUt5BlGb+LzfNlzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBJVQtxT0yt9rItj4MWlFZSgLleJjKw9rDMUqpmbMHHzwzdbpRj5FH/wPs3ZkcnLy
	 e8FB1nNyYG//xutV0Rfdrefu/rMz4jgVWKsqf8sri/L/6dDBLtYZ4xODM732GgpLXb
	 +F90m5MLrZspTjBHl+VMP9oiFNKLefBUBpmsMYxg=
Date: Tue, 11 Mar 2025 11:02:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 6.15
Message-ID: <2025031151-unsold-idealize-b83a@gregkh>
References: <Z8-Fh9pzgxS1idk2@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8-Fh9pzgxS1idk2@ishi>

On Tue, Mar 11, 2025 at 09:36:23AM +0900, William Breathitt Gray wrote:
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.15

Pulled and pushed out, thanks.

greg k-h

