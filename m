Return-Path: <linux-iio+bounces-18007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E05A86D0C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 14:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7954D7B59CC
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7471A1DDC08;
	Sat, 12 Apr 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW4aQQqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD771E480;
	Sat, 12 Apr 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744462532; cv=none; b=Z/a8ZA3zFJyW04EGmaQfxd+atgq2Qh8ZeFghpX2xi/d7tAcQyycEU0i/Cboy6CVCxy2hIlzrKiCFvqOxBaDJuyz1n4yeUHdDkfaFmNQ4pJLsciPVMqcCn/oxt5AizYFY+WK39gLbx6AyFkHFg8g5J44yKkl01F4LuciV4c3GyIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744462532; c=relaxed/simple;
	bh=+YJO2InUnvPyvpgRz/iJnWl9Y+kdHzTl1vMMskKQAyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoGGQpw/LixTCffGR8SXJwhFClmRNDiy8uiA9uRWWfP7XumKiDlq+s+ruisLfKbFvatet/rVGazKCzrpI9Bd7Vry3121TNWP/+gnEjeP34Yym0Oi2Ytq8m7MHmVllbVulpDgjosGzynk5yOcV74tbZseD+aUE7WYa7O31ynUe/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW4aQQqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94CFC4CEE3;
	Sat, 12 Apr 2025 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744462531;
	bh=+YJO2InUnvPyvpgRz/iJnWl9Y+kdHzTl1vMMskKQAyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jW4aQQqHCF2K1RRH3plTtkXD+UaA7tb4Ec7lRC8H+SFlb12+fAYPiBxab+LDc+SO9
	 5ofIvyBYoc6LtW8WiTC4oYbvulgI6hPpBRrN5rtFbr6V7Tt0nUYWL86Q9LKL8BEJGG
	 hhkcfT61MKUhh97Bfv0MCOBLZrtKxrmJUOUte0ESrnoILqrd2RcB68ZWc1Ejth3wzj
	 5INb1WBM7pr3yljTK0bYxBulA8FmHIJiHfEq5A7FQf7WDfixWO0rOFXtDGtoc5sYkQ
	 XDUwMRwreq7Jgz6bYaS/qh1P94eMobnDcQVwSgBPVDWc+B40Lb+sORyeMBz1ef9A19
	 SBP6D0RUmya4Q==
Date: Sat, 12 Apr 2025 13:55:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] docs: iio: add documentation for ad3552r driver
Message-ID: <20250412135522.6bc83c52@jic23-huawei>
In-Reply-To: <20250409-wip-bl-ad3552r-fixes-v5-2-fb429c3a6515@baylibre.com>
References: <20250409-wip-bl-ad3552r-fixes-v5-0-fb429c3a6515@baylibre.com>
	<20250409-wip-bl-ad3552r-fixes-v5-2-fb429c3a6515@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Apr 2025 20:36:29 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add documentation for ad3552r driver, needed to describe the high-speed
> driver debugfs attributes and shows how the user may use them.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
There is a double blank line at the end of this file that git moaned about.
I fixed it up whilst applying.

