Return-Path: <linux-iio+bounces-23865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D10B47B98
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 15:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FE07B0459
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981D277017;
	Sun,  7 Sep 2025 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERhwafM4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212920CCDC;
	Sun,  7 Sep 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757251608; cv=none; b=OmAny7Pc0TXSphfG590BziVU16H8ub6NusbzcjEqci671ijl4dnOfYUgN5rhW2KL9+y+vTNzPYcTfc7t/8rDs0UOJ7SKxzRtq1IlD6ZAkyc/fERkCdD6e9I7YJgouiOI+5YSK43bC2KgpnHETmVGnKIUOOFHWc4+N61nzeOjLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757251608; c=relaxed/simple;
	bh=1/F3Eu2AKxDKTyyvFww0JZOexx5tvlq9svKOw0GJ7K8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuXvmCsZt/PQ69oDZw7pxEXuxW7ZXi4MttaQIxmoOk8Smw/dqb8wimRc8izK5QO8AKOI+djkkqhFurbn0ccDjU16guXXgDD5Z3rElOj8uMhbWH9RtoRzez5fUhWCyWE5YVxbrG6LnBQ27jKdNjbG1SRORdV3Nzt0fuirpdjPrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERhwafM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A453BC4CEF0;
	Sun,  7 Sep 2025 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757251608;
	bh=1/F3Eu2AKxDKTyyvFww0JZOexx5tvlq9svKOw0GJ7K8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERhwafM49eWW/ihGqwo+fNGqN9lyW/YADLfF3teKaV7mREi2q1ss+3Z/9JzuELTw6
	 17zJ/TTsKKEv7nYIt9A5TtIJhumTqIJEUd6628/6VZzynrBHm6LdbuDIjPtDcnL5nW
	 iYRRcaJNQQfDLJWVmBwcfXnYcwSJgpMcYVL1fLtT5eUi7nty7WC0jtHaIJwy+Ka1ol
	 c4LealXmK+1Ef2LJN5sUC1GjLAIjpxzaZYLAz05QWIHeR9zeNI0RrEhGCI8Hm8YL+R
	 cCxP/RL9k6fazU6OOW/I6NPK0vZc/83VSv6L6wJ9jbXATVcz1C3gF3N4duEJuOMjGi
	 AMR8niOxeY+UA==
Date: Sun, 7 Sep 2025 14:26:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 4/5] iio: imu: inv_icm42600: Use
 devm_regulator_get_enable() for vdd regulator
Message-ID: <20250907142639.489496d4@jic23-huawei>
In-Reply-To: <e97130f5-9ec6-4ac4-9944-96f992eb215f@baylibre.com>
References: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
	<20250901-icm42pmreg-v3-4-ef1336246960@geanix.com>
	<e97130f5-9ec6-4ac4-9944-96f992eb215f@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 14:49:05 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/1/25 2:49 AM, Sean Nyekjaer wrote:
> > The vdd regulator is not used for runtime power management, so it does
> > not need explicit enable/disable handling.
> > Use devm_regulator_get_enable() to let the regulator be managed
> > automatically by devm.
> > 
> > This simplifies the code by removing the manual enable and cleanup
> > logic.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

I've applied 1-4 to the togreg branch of iio.git targetting
the next merge window.  I marked the first 3 for stable inclusion.

Given we are fairly late in the cycle, the breakage isn't recent
and you have additional patches on top (4 and 5 here) I didn't
rush these in via my fixes branch.  Hope that works for you,
shout if not.

Thanks,

Jonathan

