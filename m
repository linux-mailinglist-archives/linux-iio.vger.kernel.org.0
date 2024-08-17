Return-Path: <linux-iio+bounces-8564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F31955906
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0612DB21063
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FBC824AF;
	Sat, 17 Aug 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1OKJzP0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2C440C
	for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723913197; cv=none; b=h6w8GhP7pQ2cMR+DGxOxDTx72lCJ9w4XwLW/pmZOH97N/W7nCuo2eBXpR/q01OoZUece5uCksqKfWjlMKtBc9GyXoQVI5ZKXKhZcTZu5IcCc+6V28IbjfEfYuHtHqBbaTuaojgAQjrL7GYiQkyn3ftX9xZSoff80+kyqbfjLta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723913197; c=relaxed/simple;
	bh=q8rpkTWL+pv4hZxCCFIVUcRx6eicrrX7eVr2Rs6IkeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJgGyMzuphJ830R+hOA7f6GD5goREOAg7egqqKIVW0G2xC4Fs6Z1xcsmd6aPrQ7OKuCIqc5JCvW0Rnq6U4cBS8cIUe4BfO2cx2wHPVQsn35umuxpYHqwj+Eo/o7se3F9e6gjvjAv8VGX64n4cBIRtBXc50BVej4izfuA7iZKrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1OKJzP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DD9C116B1;
	Sat, 17 Aug 2024 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723913197;
	bh=q8rpkTWL+pv4hZxCCFIVUcRx6eicrrX7eVr2Rs6IkeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1OKJzP0nmSA3DlQHb7FqihMYMZk0g2Rl1W1S+fRF8j4R42FT7YfuiSUw3+td+wXv
	 BjMnZJZJ+8EaAXtHKGSJJ9vmNEIjSuULbE6wrBT4el7LRiFKBN0NM4eSLydpwU//8v
	 F/i+Rt+TOgNCvDnPXZrXybuEgNEEG+QKBA/gPRuleV6fACMVkCE0aDa97FOFpUZ0SS
	 3EnM8agFiCwljJHeEQ7j2BBKXZI7CawCQMbivXvuWUKglTcb8HZBIRKruOdKw3AH+p
	 +ewuuqSyLzntxJPTEGDaXG4F48/StYqyFL4nyK375QrqTA5lC3uq77wLdOfNhF4gs8
	 wI1yWbu+Bh9Cg==
Date: Sat, 17 Aug 2024 17:46:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Okba Slatnia <okbaslatnia@gmail.com>
Cc: linux-iio@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: st_lsm6dsx minor issue
Message-ID: <20240817174630.1c24bb02@jic23-huawei>
In-Reply-To: <CANArCKRKt4-Epxw6KCmrtRZNKBKTLT78m9Rq0__3GG9BJMh6ig@mail.gmail.com>
References: <CANArCKRKt4-Epxw6KCmrtRZNKBKTLT78m9Rq0__3GG9BJMh6ig@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 15:27:33 +0200
Okba Slatnia <okbaslatnia@gmail.com> wrote:

> Hi all,
> 
> I'm building a yocto firmware based on Linux kernel version 5.15.148
> and i'm facing a little limitation or problem preventing me from
> changing the value of the sampling_frequency of the accelerator:
> /sys/bus/iio/devices/iio:device0/sampling_frequency
> despite i'm following the
> /sys/bus/iio/devices/iio:device0/sampling_frequenc_available for the
> possible values.
> for the info , i can successfully change the sampling_frequency on
> another yocto firmware based on Linux kernel version 4.19 and despite
> keeping the same kernel flags confs i'm still facing this issue , i
> made sure it's not an access right issue because i can change other
> files in the same path with same access rights.
> 
> Can you please help me and tell me if I missed anything ?
> Thanks in advance.
> Best Regards.
> --
> Okba

+CC Lorenzo on basis maybe he's seen this before?

Jonathan

> 


