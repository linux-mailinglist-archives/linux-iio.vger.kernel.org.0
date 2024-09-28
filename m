Return-Path: <linux-iio+bounces-9846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3599998906E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D430A1F21C07
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B71428F4;
	Sat, 28 Sep 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrQJx65O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270A5FEE6;
	Sat, 28 Sep 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540992; cv=none; b=gqsIRQzL33xN4xZW2y6ygH/194UV5+bQylMmsZd+6Bz2wWFmOe9PTWpB34ol2sH/DQoQqTPVk+5Cl4eh++CrW2P6PYFtL/7cpGXFgLrSokojl/fHk81RWmgAmlhAPZYr+NijXdI4DIENeWWeeIjgBZLJRJAy0BJsbISr7UxvXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540992; c=relaxed/simple;
	bh=f7It2CatrjhmD2pcjpPk4oE/AIT6Ex9NUsQxqsMgh0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzCKJjzKC1SaWfkvbIMs2Oq3uNg7WbxDuih3fMurtEECNl9SC/IFVZLqsr1GEydBOFSNfmnkkv4bFTSoHtXY0IZRLba+vyN+7JnAKZSeDYFoLjDjOcs15wiGPfDpCWIae/8jgJ3hSzfzj1IzIYSQAXhafVZODY2popoSQG9bq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrQJx65O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31187C4CEC3;
	Sat, 28 Sep 2024 16:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727540992;
	bh=f7It2CatrjhmD2pcjpPk4oE/AIT6Ex9NUsQxqsMgh0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZrQJx65OhK6f12Q23BR5WzIdCRCFiUu3mSVHZSSFMWrFkhe0RQCly7Y1B9jzzG3Sd
	 xsUxCx6Z2qXOiWudsogTHV6pTkE82r92WR4qkabGM5+106uENLSe7uhYtg9T950ita
	 x/S9wQ9XGvtXkNRsEVcIumeF+yoF2t5CjGdmT92oW+uZiEieuXJm9RPZbVZCVsIl3S
	 j7a5RI2+MdMYqRr4Qgo7dcHntvLcNjR9GBdu73mOCeIoUxTpiODFqkRA8ZXOGAURed
	 H8CG9dRgrVzAunPkiyvyx585N1qEtXjlOR9/zqzG78cY1Ap8NQlP8YhK29p52DJLD1
	 1pHWUhT7XnLUQ==
Date: Sat, 28 Sep 2024 17:29:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/4] iio: adc: use scoped device_for_each_childe_node()
Message-ID: <20240928172944.10da3b60@jic23-huawei>
In-Reply-To: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
References: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 18:08:36 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The device_for_each_child_node() macro requires calls to
> fwnode_handle_put() upon early exits (break/return), and that has been a
> constant source of bugs in the kernel.
> 
> This series switches to the more secure, scoped version of the macro
> in the IIO subsystem, wherever the loop contains error paths. This
> change simplifies the code and removes the explicit calls to
> fwnode_handle_put(). In all cases the child node is only used for
> parsing, and not assigned to be used later.
> 
> The straightforward uses of the loop with no error paths have been left
> untouched, as their simplicity justifies the non-scoped variant.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
All look good to me.

I'll be rebasing on rc1 anyway, so there is plenty of time for any
other reviews to come in.  In meantime I've queued these up on the testing
branch of iio.git.

Thanks,

Jonathan
> ---
> Javier Carrasco (4):
>       iio: adc: qcom-pm8xxx-xoadc: use scoped device_for_each_child_node()
>       iio: adc: qcom-spmi-vadc: use scoped device_for_each_child_node()
>       iio: adc: sun20i-gpadc: use scoped device_for_each_child_node()
>       iio: adc: ad5755: use scoped device_for_each_child_node()
> 
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c |  8 +++-----
>  drivers/iio/adc/qcom-spmi-vadc.c    |  7 ++-----
>  drivers/iio/adc/sun20i-gpadc-iio.c  |  7 ++-----
>  drivers/iio/dac/ad5755.c            | 11 +++--------
>  4 files changed, 10 insertions(+), 23 deletions(-)
> ---
> base-commit: 92fc9636d1471b7f68bfee70c776f7f77e747b97
> change-id: 20240926-iio_device_for_each_child_node_scoped-cb534e6f5d9b
> 
> Best regards,


