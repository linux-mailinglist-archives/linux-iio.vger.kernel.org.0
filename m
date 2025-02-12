Return-Path: <linux-iio+bounces-15427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8772A32222
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CC93A5C83
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A02066EE;
	Wed, 12 Feb 2025 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xs55mz+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4CF205AD4
	for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352523; cv=none; b=Q/s0tGq18KgKNIS3Y4fwBtKYtjrfC/3C/PnXqIc8ksSYMmTDut0AinJL5QHnb/L9r7nTN3YwnuKqCJUkq/hsBSqefpkAbtgcbXHKw91ZdD6wsDoVXAjIiOJgF9nfjFRDwBwXUsNH6gl3waUml9W0SIUfryoxYbfklYtXRXGkEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352523; c=relaxed/simple;
	bh=uFVlU83SxZEg8KXhcJTQ8Cvg/Bj9thZVki3RD4LLxOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAg7D46T8uxB1rDoQhMWcJ+xujfG4QaEVBUaT9RjAwr/4Ck/ObfvjBLZx5K7C5/ZI+utF6beODYmw51ZeGr5n0azt/8dK4UgjMjUBc94w8hXk2o5jIvmG7rbCMNPmLzar8MRZYesX7PZGHztHf0MVgwYkSVM+5jbCEYh4d3v4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xs55mz+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFAFC4CEE2;
	Wed, 12 Feb 2025 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739352522;
	bh=uFVlU83SxZEg8KXhcJTQ8Cvg/Bj9thZVki3RD4LLxOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xs55mz+13OwbVyLRXGor8sEdP0vovmlUh54xbmuQwgHqPtlECPryTaM5L6j7UXUeF
	 ILsnAozIqCh6lLSFM8IWrGHfKlQRJyguikKfUWz0hpzXFMRnAP9Rq1L/EzI+8m0cQv
	 O+FYjqt+w/KH2twwUeZvQd1/YCqDswnMfyYV8ED4=
Date: Wed, 12 Feb 2025 10:27:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO fixes: 1st set of fixes for the 6.14 cycle.
Message-ID: <2025021204-sarcastic-patriot-a316@gregkh>
References: <20250210192941.67c3901b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210192941.67c3901b@jic23-huawei>

On Mon, Feb 10, 2025 at 07:29:41PM +0000, Jonathan Cameron wrote:
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.14a

Pulled and pushed out, thanks.

greg k-h

