Return-Path: <linux-iio+bounces-14176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCADA0A8DB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E013A6F4C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D481AE00E;
	Sun, 12 Jan 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE0cRDAM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62017B425;
	Sun, 12 Jan 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683008; cv=none; b=QGrkdZAJGEMALETRqOSNHH8ex+5c9b0kYQ9o55JXtjKQdQiAIdtiWVa3C0D7mVWYa3mC4g65+tTkDAkPX/KQ2kegEEyZpfb5TEcp73DGJjJ0c2fiLs9Cd3rrqyjl5iVhDXiGofJgdgy4UBxmmwlx8GDG9hyUXhb2odlh2xQW+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683008; c=relaxed/simple;
	bh=7n/TD42a3JmZvJ6uJC1VhbZVCu4UNuRl4GDmxclS4Co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoPK2rhgHKcs2BJy9GwO5LghUgCv7uxOvwMZruq8VRuJc6/19GejylIQhWECB/2Kz5770m9xO3+6s/oc4RIBcxIW0SEmSBqNasqBsMI6cpY0nc+7MZxNubrUu6jfdqhPOFbpnPeSV8YDudcL0Nv6yc2tNcBzxkwdTX1Q2SpYpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE0cRDAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6547CC4CEDF;
	Sun, 12 Jan 2025 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683008;
	bh=7n/TD42a3JmZvJ6uJC1VhbZVCu4UNuRl4GDmxclS4Co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DE0cRDAMEnx+PXNdgi/cJGYf5Bqk0GTv8l8eInR3P4QoGzqqINQUoMISVEpXE8UkB
	 uWLGdb5a0cPJ64nYhpelTaVHj4ECR7r3T+f6XkjT/bubYiu1i0EDV234S+Jux0kPrJ
	 LRuDG4eDsYa8au0IFqPUirF3C3iMWok0X09PVEAas5GgyUpgn1+MDXKr5Rl9k867pY
	 PO7Odr5T2hINNXhm2g2DgJS/6/fHki64k6ul+nol5fSseo9LvDJgFIFoL0brZYVygr
	 cLU0MMxVMMWBh8USSQ994vCI6RqkmHMU39e2YvHyIarqtY+/BqW/kmylX33TWoCwqC
	 itr61UWHjcQkg==
Date: Sun, 12 Jan 2025 11:56:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, cosmin.tanislav@analog.com, lars@metafoo.de,
 granquet@baylibre.com, u.kleine-koenig@baylibre.com,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 3/3] Documentation: ABI: IIO: Drop AD4130 specific
 filter_type_available options
Message-ID: <20250112115638.1b163908@jic23-huawei>
In-Reply-To: <1684bc1a-c983-4baf-8b4d-0c6ff0f1640a@baylibre.com>
References: <cover.1736261047.git.marcelo.schmitt@analog.com>
	<5b86acb56fd2aa337223a6467c1caf2a06682fcd.1736261048.git.marcelo.schmitt@analog.com>
	<1684bc1a-c983-4baf-8b4d-0c6ff0f1640a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 11:53:44 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/7/25 9:13 AM, Marcelo Schmitt wrote:
> > The only driver exporting filter_type_available attribute is ad7779 and it
> > only supports sinc3 and sinc5 filters. Remove options that are not
> > presented through filter_type_available attribute.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Maybe this is not worth it (or desirable?) since the options may come back in
> > the future if new drivers happen to need them.  
> 
> I would be tempted to add filter_type{,_available} attributes to the ad4130
> driver that mirrors the existing filter_mode{,_available} attributes. We can't
> remove filter_mode since that would break things, but having filter_type in
> addition to that would mean than userspace tools could standardize on
> filter_type and not have to make a special exception for the different naming
> on ad4130.
> 
> Then we wouldn't need to delete the extra items here and we wouldn't have to
> repeat the docs for sysfs-bus-iio-adc-ad4130. Those docs can just have the
> deprecation paragraph and mention that it returns values identical to the
> filter_type attributes for backwards compatibility.

Good idea.  Given we always allow any attribute to change any other, having
duplicates for ABI backwards compatibility is fine.

Thanks,

Jonathan

