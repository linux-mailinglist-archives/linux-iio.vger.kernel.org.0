Return-Path: <linux-iio+bounces-4484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1BB8B0049
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 06:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDE51C22EBD
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 04:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66513FD81;
	Wed, 24 Apr 2024 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JDq8uMjH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55213C9D0
	for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931194; cv=none; b=qEI7yPF9tZmbIXjfgBUzs9ZaSAALBVSX9986HjrEoFLxlW+AB9h6r+pe3Qw0rfGeyjFXd/jTNQvMdVXSlZ+PRvmbWQuBzPlgL9sAsheiQLtpvdJCWAmi2dPr427pd+SM26PpOMitmFRdLHs/ONCalW2JmWe8r/kt6AvamtYJ2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931194; c=relaxed/simple;
	bh=DQyYcJj/ohKRdGCZwgrh24HBsiFNHK/Oq9/cgiU0dF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY3/F5IDtxujswGnnX6/Rl5AARnW8+i9QQ01kFMxDwO7B3iLHkkOBrDiKLDAJyiNa9N+RLlxrXuWaz+G8g4aEOs0LWt+8UE68agwpVIMD8YSitGTk7VGMuYxYmWkYbUwWHsrB13UXJHH5gkLf1eDPiaA9MBHsqdrfiYyUEB4FSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JDq8uMjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05D0C113CE;
	Wed, 24 Apr 2024 03:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713931194;
	bh=DQyYcJj/ohKRdGCZwgrh24HBsiFNHK/Oq9/cgiU0dF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDq8uMjHu6JZ7fmIB9bR2R9OAnpKuKq2FPD77kgGVfRMz5OQev/z6Sd4xSImgCyxV
	 dJDzVyG8hmbxQQ7jOehXW+uEBi5oS0rTr6w5Y1hOslyhqjaahduBE3BN0URMchcRHp
	 768+WrSNPtb6kzWhPAPwnVJgx7j+IJiD9I5edfYs=
Date: Tue, 23 Apr 2024 20:26:12 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of new device support, features and cleanup
 for 6.10
Message-ID: <2024042305-fiscally-dash-d3c5@gregkh>
References: <20240423192104.385c59d6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423192104.385c59d6@jic23-huawei>

On Tue, Apr 23, 2024 at 07:21:04PM +0100, Jonathan Cameron wrote:
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10a

Pulled and pushed out, thanks!

greg k-h

