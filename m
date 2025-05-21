Return-Path: <linux-iio+bounces-19770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA90ABF3C1
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 14:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EE38E575B
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 12:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF6A26461B;
	Wed, 21 May 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cuWiCpua"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8A221D8D
	for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829311; cv=none; b=j8ECYeOV9lEu0DJpi1JIu2DEC4Ztt2K9uryRNNXlDNXZKkRk//5gBAgYSy4AMBLn7Z7c5YN1Hu1rSSyrf/iOgrd2tStzfVC/Qsokq2j3bQnfoWhKDVZ36iWwpYFwfdW4Yc4KOfvuqMVlwu9XLEbVMzZaDVpmEKVzl1URuL96Bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829311; c=relaxed/simple;
	bh=H8A/nTkxIbNdnvqMebodRqRVCrz6b0yiqDY7HxIaYL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmlBLfqRunOG5EqS1mQrt5dpkHrjkBEIM8Ega9ZfffxI2bmvT+ULnID6T7a29j5RUZj1rrR6uKFEjKTGTaVTOwoQhjVsTHbsm0xg+L3jHCU7DDNGMIlqjH6F1tpmOXL0idsPxo8UVGhX3L1COPVoWUnIPLnbC2QEyO1toIiXUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cuWiCpua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BE7C4CEE4;
	Wed, 21 May 2025 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829311;
	bh=H8A/nTkxIbNdnvqMebodRqRVCrz6b0yiqDY7HxIaYL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuWiCpuanEo1gpAL0VndS8RkqB5kWztT3LaqmziWJAF/IaAR9y4EsBf0nU7rSnGP9
	 yFx440ZkUHnG4znK9yNwz2JGKFA4Ei6RyNRnJkuTs+BU0EFwVOwwhI4hWTS7pleMOR
	 A5YVTy0nCbJCjSmiH9CwWtiDMFlx8Ysx8aYtRuLE=
Date: Wed, 21 May 2025 14:08:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter updates for 6.16
Message-ID: <2025052120-qualm-shaking-e181@gregkh>
References: <aCBKpiURrnfaacBf@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCBKpiURrnfaacBf@ishi>

On Sun, May 11, 2025 at 03:58:46PM +0900, William Breathitt Gray wrote:
> The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:
> 
>   Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.16

Pulled and pushed out, thanks.

greg k-h

