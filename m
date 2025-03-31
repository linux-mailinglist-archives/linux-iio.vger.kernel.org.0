Return-Path: <linux-iio+bounces-17428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 589CFA7651E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFF5188AEE6
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034671E22FC;
	Mon, 31 Mar 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsrul7ii"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4271E1A32
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421457; cv=none; b=Z3l5JOyGwcGBbUVcLTYKNtbwOFe64qwIDd3lpDNlEPLErYiQdsAUsNkbMhN/ofroLcMS0EgfDT6liQZlrf2UEfhmtk2e90XA8CJIbpYYqLDwedEtT17SLTrHfAN2IoHv/pZAlZ1oWl5aEUXPOZ471TwG45EsWZRnuopeXvX1t5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421457; c=relaxed/simple;
	bh=GpnPGCtC/shzKDShFbfhSBboG6OYlmhjtMQ8Kf7Rs9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaK0DwErxHRo8glBVJVdeyKQBTSYBJ508vkj6j0XfEOkwcdXIihFhh9lc9Zt6Nhkq4H4Pl4XrRLIt6AOxf6K5nUFOB3eeXXCXtPdgwEMeletvWXQNKyMi5EJ1YrdkRQXuxRFsrx7bCfTWf5r0fVKCYJdFw4Y2BJiM8wLX6NRlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsrul7ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D58C4CEE3;
	Mon, 31 Mar 2025 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743421457;
	bh=GpnPGCtC/shzKDShFbfhSBboG6OYlmhjtMQ8Kf7Rs9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vsrul7iivxBxpsgpqBQNcZyJT0Fw/corb2okPFIbipX/R92cXsHRFx3lxU61Bu9Mo
	 kF8IiOkryFC6KJoBpGnLrtP713eirPwkt0jqgIQSP3zzItDIfAYd+BUH3SwmXz8jPC
	 Z/AdGSYI9ywUgfQKZohdV/zhptLyWeRmefwodHDfPe3qBiz2LJU0SwPRlUf+/19gqX
	 yjlwv02rI1Vqg7hxpzsdjc8im4DD0e0uOvow++tDuZIcz79y8Zers6hD3DCLqTrrT2
	 yB31U67tx9ZsOF/4dhdQNIkga+rtjJBNqXkxg0YBjqkCsbxPqjy4iu5WlajvDiD12t
	 coA11Ap1OGnkQ==
Date: Mon, 31 Mar 2025 12:44:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Astrid Rost <astrid.rost@axis.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 17/18] iio: light: vcnl4000: Switch to sparse friendly
 iio_device_claim/release_direct()
Message-ID: <20250331124408.69c27d42@jic23-huawei>
In-Reply-To: <4d1666ef-8683-4d54-bb4b-7d858569c5a3@baylibre.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
	<20250309170633.1347476-18-jic23@kernel.org>
	<4d1666ef-8683-4d54-bb4b-7d858569c5a3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 14:11:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/9/25 12:06 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > These new functions allow sparse to find failures to release
> > direct mode reducing chances of bugs over the claim_direct_mode()
> > functions that are deprecated.
> > 
> > Also split the enabling and disabling of thresholds into separate
> > functions given overlap is small.  
> 
> Should be 2 patches since doing 2 different things?

They are messily overlapped because of the oddity that we only
take the direct mode state if enabling.  It is in theory possible to
do the split of functions first but that will result in messier functions
that we then clean up.  I'm not keen on that complexity so going to be
lazy this time and not do it.

I'll add something to the patch description to say that.

Jonathan


> 
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Astrid Rost <astrid.rost@axis.com>
> > ---  


