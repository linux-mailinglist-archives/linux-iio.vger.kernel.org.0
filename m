Return-Path: <linux-iio+bounces-19802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D44DAC0D8B
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F447A6AE8
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D528C015;
	Thu, 22 May 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I3H6fHSY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDD2620DE
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922673; cv=none; b=A2wfO9++Ws5A8WhJTNr1o9oHpSLxVeiOkYWWk4xVhGq/4Fowaqt1GzwXMYF0Y4v693mLwWkAYqmdq9hCaZfj1N411moHKAloRijwn7MYvSmd1pk18nJ8CKAb47f0903Blc/6z6e2WhFNkNLEF7YgrMBTeG4N6G53fkxlLTobb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922673; c=relaxed/simple;
	bh=My7L6JMhilLMOLHDJImVmRE5SvBqb3KIUc1AahK5tS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT8eCOYIT5MEvRjh3WGNUHCRnsZOSt1xGoYfafkjQZpSOanz8IUzRnVeVFa7q9xNy8CTrbALTys4T5fiPwMEeYXrihYYe8juSgBwMdyB1ciiZNjRpnXzqWK+l7Ndj2X6VnSZYZWcAyC9Td2mJzl/pMj/yJMbR87/X7TpU7bp6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I3H6fHSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C74CC4CEE4;
	Thu, 22 May 2025 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747922672;
	bh=My7L6JMhilLMOLHDJImVmRE5SvBqb3KIUc1AahK5tS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3H6fHSYPWPU1CFseAhUx6mCvT0bhc729vTzTCkfVxO0WFBI1Xsa4zBglp9c61r2s
	 huIBihgiU4QFmDpzu6xg+l7e0LR6/4eTah45DJtl2xUl6kx7rC+aTepcEMFb5CPRTW
	 HPdtpVkRpjIH4s3/pZEDbaZYYwT+EsyAfx4NU4fo=
Date: Thu, 22 May 2025 15:57:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL v2] IIO: New device support, features and cleanup for 6.16
Message-ID: <2025052212-nicotine-laborious-e0af@gregkh>
References: <20250521143159.097d9b52@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521143159.097d9b52@jic23-huawei>

On Wed, May 21, 2025 at 02:31:59PM +0100, Jonathan Cameron wrote:
> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:
> 
>   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.16a-take2

This one worked, thanks!  Now pulled and pushed out.

greg k-h

