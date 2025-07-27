Return-Path: <linux-iio+bounces-22052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48019B1301F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C3B3B9E41
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2AC218821;
	Sun, 27 Jul 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNSDAQOK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E470825;
	Sun, 27 Jul 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631026; cv=none; b=s1LVSJDmBOdwvlVw/6dSmfz2IncWuQSqrClJULT4JADJiv6fKU+l5NzQ5zSuW9Un0iIGvER23F1a6mNTssTn8C6F/3ampvhHL9RmY0ze3wKpHGFnrMyJ2cfTLf1uvsLdZrdi0BJjIaSys+NjH/XV+YnvWEL7Km0iw7xtWZ6P+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631026; c=relaxed/simple;
	bh=zoz469+SQa2Dc1zsiysjdo7V3MLdODW25CN/F08aRPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUQhqu6mEb9V1J1i33RU6K62NOo/Sz0ocLF7KTrDtmcoamEXssEw0YFqV/v5RX4e87/Q6XsWnpvGyBAe8HYIw4YQJfpoQ4dCfhycQ6G2ef8hctFFbepv0oYNm5f0A98eQXqRHSUT4pcn7N//t46VDonsqrseofJfIYDfr2A9U0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNSDAQOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB12C4CEEB;
	Sun, 27 Jul 2025 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753631025;
	bh=zoz469+SQa2Dc1zsiysjdo7V3MLdODW25CN/F08aRPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NNSDAQOKCwm/+WN0tGh0gq4l2b+lBKfp1MpmkK7LUJJ9K5gLUXVLUfex6A4F3bg0A
	 BfaFyUWY75W7CMPyR8rSS0Ye5N2fOuDVJjFhmWiUQJVpCCgUsl7AMm8b5mjidc1qUK
	 +qPF02BQFdjJ4wRK79Uk/xpkGzUKUovuu5k6JXc8bJW4Ydx+cbT/EScImRPcKoc2Qi
	 V4HuZFeCTxJlMKjbrBXy2VRifrTGU4HfTe+aH+d5lrtc+eZ3znb28IFJugYNG5Our2
	 Fa8gGY4QhltOQTYgSmudIC/r+JYKP/wW6KiiiAEfljSZkwQU3mYwJrYwvXLoUdUkpJ
	 /bwdAykUXa1Hw==
Date: Sun, 27 Jul 2025 16:43:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Salih Erim
 <salih.erim@amd.com>, "O'Griofa, Conall" <conall.ogriofa@amd.com>, Anand
 Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-arm-kernel@lists.infradead.org, Andy Shevchenko
 <andy@kernel.org>, Manish Narani <manish.narani@xilinx.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: xilinx-ams: Unmask interrupts after updating
 alarms
Message-ID: <20250727164336.385dda93@jic23-huawei>
In-Reply-To: <3a77d5db-eeb4-43df-9de0-e6bafea4d9ea@amd.com>
References: <20250715002847.2035228-1-sean.anderson@linux.dev>
	<20250724163219.0098ced6@jic23-huawei>
	<3a77d5db-eeb4-43df-9de0-e6bafea4d9ea@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 06:47:16 +0200
Michal Simek <michal.simek@amd.com> wrote:

> On 7/24/25 17:32, Jonathan Cameron wrote:
> > On Mon, 14 Jul 2025 20:28:47 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >   
> >> To convert level-triggered alarms into edge-triggered IIO events, alarms
> >> are masked when they are triggered. To ensure we catch subsequent
> >> alarms, we then periodically poll to see if the alarm is still active.
> >> If it isn't, we unmask it. Active but masked alarms are stored in
> >> current_masked_alarm.
> >>
> >> If an active alarm is disabled, it will remain set in
> >> current_masked_alarm until ams_unmask_worker clears it. If the alarm is
> >> re-enabled before ams_unmask_worker runs, then it will never be cleared
> >> from current_masked_alarm. This will prevent the alarm event from being
> >> pushed even if the alarm is still active.
> >>
> >> Fix this by recalculating current_masked_alarm immediately when enabling
> >> or disabling alarms.
> >>
> >> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---  
> > Anand?
> > 
> > This seems fine to me, but I'm not that familiar with the hardware or driver.  
> 
> Anand left some time ago. Salih or Conall should be able to provide some input.
> 
> Thanks,
> Michal
> 

Hi Michal,

Thanks for letting me know.  Would be good to have a MAINTAINERS update patch
to remove Anand + ideally add someone else.  If not to mark it orphaned
(will still be covered by the top level IIO entry).


