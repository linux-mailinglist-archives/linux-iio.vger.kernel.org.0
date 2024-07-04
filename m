Return-Path: <linux-iio+bounces-7301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCB89272DC
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD7289FB3
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC251AB520;
	Thu,  4 Jul 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C485VbzD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE71AAE2D
	for <linux-iio@vger.kernel.org>; Thu,  4 Jul 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084855; cv=none; b=F95KMC2X9Em3tHMN1Rpvud5yYuWO7ajr5Sa8pK/iJFCzJ+u9/qNyIMX7BYzVTwX/aI40bgcZo4Eym+0Yi9zImFPqgW8NCA5km2eK2kZbsOhqccr50iRuKfzysfD9QeI0BLFTIF+3rSs5E9MP4yQUmJxgXM5CjWK5P3IjasPJCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084855; c=relaxed/simple;
	bh=ytExEjcwmvJXNLPgPdmCKl+KsGkoDcQeHYmAHl1874U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBqiWbwvsSVyAJ2mSpWd0yIyS2osKug7i0KDgjzD7S2xQfzTQHsuoerzxCSaPVQ3riovN9U7rVfCyxIgKwl6h6uMpgb9g/nVSxPG0bhklDtpCFrJ6J9keJXoqFIN564nHA014Ft0KQLD+Rmcs+W9bIpvyHVEhtv9Mu0u/hCsUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C485VbzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BAAC3277B;
	Thu,  4 Jul 2024 09:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720084854;
	bh=ytExEjcwmvJXNLPgPdmCKl+KsGkoDcQeHYmAHl1874U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C485VbzDD3UQpDCttL6h+yv+gNhUNXBH6rEjOvUJSli68JtU8Pv0Ql1mCgH0bqH6W
	 Q0fOvwaRzqfszvbGUfX7V/d4Tz6j/NnDglXQ55troQL6tOVfnYxAMix++2HI14yKMX
	 ixRtG9S7P87+UoG5o8YxjdUrYi0FGJFC574IoLbw=
Date: Thu, 4 Jul 2024 11:12:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set new device support features etc for 6.11
Message-ID: <2024070401-finale-junkyard-491a@gregkh>
References: <20240704090535.06322620@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704090535.06322620@jic23-huawei>

On Thu, Jul 04, 2024 at 09:05:35AM +0100, Jonathan Cameron wrote:
> The following changes since commit 20460472952043a4735e9abc1fd9de8e024d1c9e:
> 
>   Merge tag 'v6.10-rc4' into char-misc-next (2024-06-17 08:31:12 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.11b

Pulled and pushed out, thanks.

greg k-h

