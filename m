Return-Path: <linux-iio+bounces-14867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD60EA2500D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 22:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CED23A426A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 21:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48F1FBEAB;
	Sun,  2 Feb 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCTBZy8b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE271D5145
	for <linux-iio@vger.kernel.org>; Sun,  2 Feb 2025 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738530053; cv=none; b=o2zlq1Ema6CYgNfVamBrY33Jg6IgcRWCwnPvS8ewRLlWMwnSHt+ibTqBmqyAjoYi9lunLBHnPV0Bxlncz8bgr9/M1/EeU/cCNQolHILjdddlqSaAydUuTjtZe2X82+Mz5WH7dhSIMF5jKmVOnVesKI4F1iSixQLuy4MiHVpCcPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738530053; c=relaxed/simple;
	bh=xwdv7++elUFUUxjj2dGShbGoAhH1wMSWF9aCag3fFW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tx0jdQOQv4EDe0auxgUiQhipJgMsoPGVBnLMqk+Q3ebFfVpevOSnUq7aP+F/+BqOdwATA9jMM2qWIPfF/gUPVp+1WNT4nZf6MLAeAetQMbJ4p4dqhFvE398tuluC3Nb+sAvct3fJemevBXxS7LPUDHTN/muCEZPs+zTVLqOUQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCTBZy8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB416C4CED1;
	Sun,  2 Feb 2025 21:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738530052;
	bh=xwdv7++elUFUUxjj2dGShbGoAhH1wMSWF9aCag3fFW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MCTBZy8bokLuLF6ejtM9Sb7UL8wJjBQz6gyFunl2K0meQqi8fl2yMiXdIJ9T/Y748
	 zaym7tdz1UjWoWfqJ9dcXuRzFT1FKuMOXAKh+VaeXilFCFBb5MHKUHDG1ZEVSMi+BC
	 /3tPHVadCBJzxTrU4xANAfqInf0gYZdV2eovkfd98XizReNJpP5LHCrOO7PxNH+r8x
	 7NWVyp9blzpPH/jQOspdsMTZoa2bRN9czK9YhUt415VMjycQZJWfFSKwNzWAtgZ4la
	 LQAVQdSxbHI2sm7V2mB79+KGw5u9M83TodJHOx4Fvq/KyR3NK3H/N6RbU5ZRBoj/eE
	 Ih1VKxeNWXy6w==
Date: Sun, 2 Feb 2025 21:00:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, =?UTF-8?B?4oCcTHVj?= Van =?UTF-8?B?T29zdGVu?=
 =?UTF-8?B?cnlja+KAnQ==?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 00/27] iio: improve handling of direct mode claim
 and release
Message-ID: <20250202210045.1a9e85d7@jic23-huawei>
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jan 2025 17:25:45 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note I haven't attempted to CC relevant people for specific drivers.
> I'll do that for a non RFC version if we move forwards.

I've finished an initial conversion. 'Only' 119 patches
109 files changed, 1990 insertions(+), 1926 deletions(-)
will be getting some poking from 0-day.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=sparse-friendly-direct-mode

I've combined some simple ones though it would only add another 20
or so patches to break them all up by driver, so I might do that just
to keep things bite sized.

Anyhow, once I've had a chance to take one last glance through I'll start
sending them out in groups of 20-30ish.

Quite a few older, less actively maintained drivers in here so I will
be relying on those of you who review beyond your own stuff!

Whilst fairly mechanical, some of the code refactors are a bit complex.
A few driver bugs found and probably a few added by this lot.

To those who have lots of out of tree code, I'm sorry to say this
will hurt a bit, but in the short term you can revert the final patch
that removes the old APIs.

Thanks,

Jonathan

p.s. At least one more similar large refactor on my todo list that
I might get done this cycle.

