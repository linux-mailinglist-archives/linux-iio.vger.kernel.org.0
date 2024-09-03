Return-Path: <linux-iio+bounces-9071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DBB969A5F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8576DB21EBF
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E081B984C;
	Tue,  3 Sep 2024 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ykStsXFe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139DE19CC3F
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360101; cv=none; b=rnT/j1sR7jpYxZghNc1XkheYynHp2dk2GpDVkhPcgRd107S78yUABhwqHpaTepiROPMarmYe4b6lY1ei0kjzFd/kA1up5A0SF6TyVlJ1IRqMzv3lms4WQTddNrwJaj0IXbQ21ClAC69zZNbtEiiqRzZXYucPKPO7ZET+s5AgiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360101; c=relaxed/simple;
	bh=yCnF54qjS3X+RuBesWrzhoh/1yETZGG80j41kfhB2Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1ryNYQMOEC8opcvbdhxJQEDXcMzPuOjeF2a/5XIuzBCi/QuZw21evIaY+JUVqzGwlSJgSMaUgdH2lrOrZXaG6FsVcx+Yhv2XpOMImry5/jD3buYSkmsoJF5m6c+Wg/Yz79/EMUnh0mVhhR3v/ukPQQ0IW3ooUgDECaIweDPB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ykStsXFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C25BC4CEC4;
	Tue,  3 Sep 2024 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360100;
	bh=yCnF54qjS3X+RuBesWrzhoh/1yETZGG80j41kfhB2Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ykStsXFeMOLQ07BdT33qYYvxVWoJTGcp17OQcTdb+GPnZt1hNn8TAVWaEXXB1LSb5
	 w2R6mO86P3xsFkMNI83RtA3f39H9EOWKhFc1GFHJ2K8roxCvzmaZ3ISUooA9VzrR2K
	 xLI/WZEyBn6Ua9pPmPyMdp5LTEoVvUZdxIy9tvtg=
Date: Tue, 3 Sep 2024 12:17:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for 6.11
Message-ID: <2024090340-astrology-debrief-1fde@gregkh>
References: <20240819203734.0866fd2c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819203734.0866fd2c@jic23-huawei>

On Mon, Aug 19, 2024 at 08:37:34PM +0100, Jonathan Cameron wrote:
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> 
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.11a

Pulled and pushed out, thanks.

greg k-h

