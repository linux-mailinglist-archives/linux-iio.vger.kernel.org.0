Return-Path: <linux-iio+bounces-9331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4E97085E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29C6B21555
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA1F17332A;
	Sun,  8 Sep 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5Hhl9Aj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8229CF7;
	Sun,  8 Sep 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808547; cv=none; b=lI1FgcfEjQJPfi8J10v/ezwsZm9RZUibrSoAAGAdyeHvvYjJgkP2XAWOjhkSIa57XuJ4YAPUynKJJYPC+u4/Wm5J0ug11kAXvvmJ3Z2374etBwahKiKHI4I60LOivtkE1sJTa9toDuus5clYon0X3ATPipwS5OXywkxL/pzGyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808547; c=relaxed/simple;
	bh=Mqv83ZBGngbz20wCjlC8PUNAQsSIC7SA2wgxi/5LLC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzb0nLpjwrojjH0Q378AhqC8+99EIyQnrNmDsMvRG5GRb+/YHEYlKHLaS6/+LjheijNUR5n5Rcih4TiX01KAdY4iWekCud/kjn7nJj/uZNSsLjTA1bkSoWWDHTg+vs71ECZmVUyZAxPyOwr1LyyVAWtomorokZ12qp7DBqwSE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5Hhl9Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F017C4CECB;
	Sun,  8 Sep 2024 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725808545;
	bh=Mqv83ZBGngbz20wCjlC8PUNAQsSIC7SA2wgxi/5LLC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V5Hhl9AjYgs2Wjj+PP+bfO/tF/1eKfMVs0VYgwgGK2Yhb2mBcuskpzSlRjfVyMj7W
	 xxPym8RRoj0km0OJP8T6fimIOzuSNunOBEA6CbaZEYmptnNphOkG/8Y2bi2ereksOl
	 NLPQFrt6tt84HoBCCtw8JroVe21XTahaz5x8C6zgAMQADbR6R1CcrNZ/HEPSQ2wsoT
	 OSRzf+QobZXsb8qYk/a6rTbPQxHbe2fbY2FctFOpnTYEVQHoK0rHiUOiqUX3Qp8Ql0
	 EWHV1Jc7Sf++TvxbketzZKsi5c0xHnPzV1mZdDPaM38zFLgZYwceCxMrKMLZel2lfW
	 xzP0du8uJFvsA==
Date: Sun, 8 Sep 2024 16:15:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 6/9] iio: dac: ad3552r: changes to use FIELD_PREP
Message-ID: <20240908161537.24733689@jic23-huawei>
In-Reply-To: <20240908161420.7af6c090@jic23-huawei>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-6-87d669674c00@baylibre.com>
	<20240908161420.7af6c090@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Sep 2024 16:14:20 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 05 Sep 2024 17:17:36 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
> > is removed. Variables (arrays) that was used to call ad3552r_field_prep
> > are removed too.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>  
> 
> If it isn't too hard I would drag this to the start of the patch set
> because I'll happily pick it up as a cleanup before any discussion of later
> patches is complete.  That will reduce what people need to look at for
> future versions.
> 
> Jonathan

I'm being dopey.  None of the earlier patches touched this file
anyway so I can do that once you've addressed David's comment.

