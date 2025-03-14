Return-Path: <linux-iio+bounces-16807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEDAA6092E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 07:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D73B7FC0
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42D143895;
	Fri, 14 Mar 2025 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="omgqOFmJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8213541B
	for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741933602; cv=none; b=XhnWrQ4p/LOVNFIrt07jg+lhTdFK9ulO0J8rUeqivkQnR+VPxih6pTeQwLh7s9yopYURMeSMUWRovCJzgZyKLtyTfl+hqb/vwZvzJSdtNHC/NaSyrLpk1fhuFxKdchGWbno+C+GnVC9mscfVgbopDAq2WeP8Tjb9NyrEahy0K+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741933602; c=relaxed/simple;
	bh=lDHqJq33TTj2Zw8GGUChxveOcuwTNguB3UX2fnySYVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiYhquasHEBtD4WJZgTi9JT90cpCnutcjfKwZtdr+WtJD+xQLy6/+wKgfFxz6J3und3z8U8i1J8dDAukewmnLVb6JxMMYiEsX2VTsFsBBH2sLZ61MetqcrWw2OnwJIJWV6cNEaP4yfsAbdqeVFM0HQPCYgFeVMomO8WyAl5sIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=omgqOFmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57CCC4CEE3;
	Fri, 14 Mar 2025 06:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741933602;
	bh=lDHqJq33TTj2Zw8GGUChxveOcuwTNguB3UX2fnySYVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=omgqOFmJKihweuZKrmZKezxLjLpL0JIm2hfcm5QMjuTmPi5Ewz7XDVQvKucwChkGV
	 834bIlSPrn9O5/SNiUj/jUl95oev11oK1NKfl+27NYN0ZqAUDkODqZL9OyyNYAzwDS
	 xiQoRIwvwDmEgFuwGAAB8XZ1wf5MJgP7RmVwmR0Y=
Date: Fri, 14 Mar 2025 07:26:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.15
Message-ID: <2025031413-bunny-stroller-cb42@gregkh>
References: <20250313194801.16035f96@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313194801.16035f96@jic23-huawei>

On Thu, Mar 13, 2025 at 07:48:01PM +0000, Jonathan Cameron wrote:
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.15a

Pulled and pushed out, thanks.

greg k-h

