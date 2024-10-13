Return-Path: <linux-iio+bounces-10537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463999B9F9
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2CE2818BB
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEC8146A63;
	Sun, 13 Oct 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K17HVYxD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B701DFFC
	for <linux-iio@vger.kernel.org>; Sun, 13 Oct 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833152; cv=none; b=qu4B1SFy39/9+h+08dn3c6bJUcX5iugH5M7nvkhRLYYXsW2kWduwlasAgkNFo1cjjg5tKPMsXvW2sds707Llnn9ofqQfJ75eOoVdI/tNBWfXGgAe66fWjB88BtW8HSqP7bt4y/TfwDuiyK/JvFmShsngKrAdkFi8NiPnCj4jh/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833152; c=relaxed/simple;
	bh=kO8cyAHXVvCEFnAE3P5aWAt1PlJRgdL4n3pAVWJzKcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apmofjedoe4WbOZ39bQHiejFd9dpnyxu/+cO2q8du3bcVv3suIXvusg+PWxDiGcTl2K/3MfN6obblIa4Rd0S1dNWFfgpOCudM5dSFWSzmUpm/ZUy3pjJ0HlVQFm163B7Ky9SH7/Yeyu9XdHstptCYhwLWg7qPMNds6jNPVgatQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K17HVYxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16999C4CEC5;
	Sun, 13 Oct 2024 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833152;
	bh=kO8cyAHXVvCEFnAE3P5aWAt1PlJRgdL4n3pAVWJzKcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K17HVYxD+BTZQuAyU8AveKXz9UE4fo4zZem0DkzHqQ9bbJsLQUECSGZ2u3FdaayQ8
	 25jqviQNnXIp4tiRiDsVLk9ir3YG1qzR8eDENibP2zAx1vFCRCtKc9vuHIHAGP5zKP
	 cLZiO893coEvAD6Y8wRKvtcz7vKFAEG51kQd/KUQ=
Date: Sun, 13 Oct 2024 17:25:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for the 6.12 cycle
Message-ID: <2024101339-handgun-freebee-b826@gregkh>
References: <20241012160703.61b02c87@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012160703.61b02c87@jic23-huawei>

On Sat, Oct 12, 2024 at 04:07:03PM +0100, Jonathan Cameron wrote:
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> 
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.12a

Pulled and pushed out, thanks.

greg k-h

