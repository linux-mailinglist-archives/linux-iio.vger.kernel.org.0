Return-Path: <linux-iio+bounces-12040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E989C2144
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 16:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E1CB2559C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D821A715;
	Fri,  8 Nov 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nvs5wlN6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A11F5820
	for <linux-iio@vger.kernel.org>; Fri,  8 Nov 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081414; cv=none; b=jTyQlI5/oIhWQ2LvlY7R0te2LFHEREXHeJgzuh2yvGHEpnYGwucjvpnjRSh1cm0dfSMmpGTRwrkSEryKQmJ5BSqK9hV4jcppcKZaKhHZkX16eZ8nfAmGgvzCDavbINYFMB9UYKRP+ZnsJ1gZYSzNU2R3c++RqJRkdl39KtQwGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081414; c=relaxed/simple;
	bh=1mLOg7ZY7UjrPcT1aUHqT8TVtIxnFaG3CK75TGnXcXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ12hWVqlcZGQoBflDzZ0pm3XdbC/AQ74o5OzaRZYd6sSGcAkPy829v9w8XttPVhzzBFt6IZiF9hbzCtgiDWegPcUBBppi8f/J6z6oGV1nVuq0fyRAuJnhyZG+HUVNmt6idRE8lZC/enbCmuuEEZU4fVE0P1+tiOeSS7dE6aJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nvs5wlN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E756C4CECD;
	Fri,  8 Nov 2024 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081414;
	bh=1mLOg7ZY7UjrPcT1aUHqT8TVtIxnFaG3CK75TGnXcXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nvs5wlN66+sNnZBOQ0TN8KFTVUhx/u0jLKNORxZPoT+qwadDkPRwWLoX8zfvfcW30
	 GO7hvN8SiI7Kwr2A/NQS0uqxUeIPAvpEuCx3Dvwa5OTBHoEFN3wQ387GVtv4Q1HBAX
	 rokFk4gkQYqNMW1FEbLgdatD6uz/5REvLw6TyYoE=
Date: Fri, 8 Nov 2024 16:56:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 3rd set of fixes for the 6.12 cycle.
Message-ID: <2024110804-dancing-creamlike-0de2@gregkh>
References: <20241107183156.12299e63@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107183156.12299e63@jic23-huawei>

On Thu, Nov 07, 2024 at 06:31:56PM +0000, Jonathan Cameron wrote:
> The following changes since commit d0bc3b92fb9b2c3c981984d52fffe8cca77165dc:
> 
>   Merge tag 'iio-fixes-for-6.12b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-10-29 04:10:12 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.12c

Pulled and pushed out, thanks.

greg k-h

