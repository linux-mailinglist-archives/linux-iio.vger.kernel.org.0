Return-Path: <linux-iio+bounces-24760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C19BB97CB
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 16:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F381885B18
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749628727C;
	Sun,  5 Oct 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fKUOC6ct"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40CDDA9;
	Sun,  5 Oct 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759672838; cv=none; b=sz0i6qKl5e5tHD5ZVO2Zj8GjaPM1yhkFIjLeEVnOzndwVXoF7dtx09Xz0y+bxZhG4dLA0H0kbbPRFyTmlx1iYJmDQs/7FXKJikM2RE/8JS2FgeU7VJz7bdDNWKFsIgBGM+YvzwFrcUwUBPPm/VurAO/z7khZHXlw01kNfNVC46Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759672838; c=relaxed/simple;
	bh=jsze0dxgqV1SusYStT3KI2932sXcWbnJvfbpP0/DJZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urP2tN0S4nOoYv7gX6BMpahhz9VemuK/xF4bvgG6fGb0N6fLos1umpwFOp0Hj/XtngXuK85NegZndwciKOBrvcPgBvvf9DoTF2xNPVjs0OMAiqMUDhgr67T6TnmHcWFbTN2mBy2702s9wo4/QCIimeBxiRhFxNTRqmGoHLpXAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fKUOC6ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6021FC4CEF4;
	Sun,  5 Oct 2025 14:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759672837;
	bh=jsze0dxgqV1SusYStT3KI2932sXcWbnJvfbpP0/DJZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKUOC6ctjN/641/Lh9pcB18jFkxSdYiiTcdYfWFLdqqkmSANN24TKgRMD8yllBuox
	 GKFugpe6njft3tIL6kZtUi1A6YT5gAEOwopeVoI2/mEcjANquR/oqbxaDKsuZEciUl
	 1zhAhDqOXhMjtT4df1LYNx4XYDkkllLRknP4+0+o=
Date: Sun, 5 Oct 2025 16:00:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Taimoor Zaeem <taimoorzaeem@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: ad9832: move ad9832_platform_data into
 include/linux/lib
Message-ID: <2025100548-stereo-patronage-408a@gregkh>
References: <20251005121829.175943-1-taimoorzaeem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005121829.175943-1-taimoorzaeem@gmail.com>

On Sun, Oct 05, 2025 at 05:18:29PM +0500, Taimoor Zaeem wrote:
> Move struct ad9832_platform_data from
> drivers/staging/iio/frequency/ad9832.h to
> include/linux/iio/frequency/ad9832.h.
> 
> This clears a TODO item in the drivers.

No, this should only happen when the whole driver moves out of
drivers/staging/, staging drivers shoul dbe self-contained.

Also, why is a .h file needed for just one file anyway?  Shouldn't this
be part of the .c file instead?

thanks,

greg k-h

