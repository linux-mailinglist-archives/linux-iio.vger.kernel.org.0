Return-Path: <linux-iio+bounces-17282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C7A7356A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE5B17A1CE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E615666D;
	Thu, 27 Mar 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsF51urM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4A17BBF;
	Thu, 27 Mar 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088465; cv=none; b=IVBd6yizHmMW0zkbiPuOpLuCWiPoxV8JCFQ1MFrF4cp5TxMj0yQ7j2zo5+hGSvabzJkyXsuWtDCeNGqYMzXCHrtpcKmNSVCWofamoauBd2sN0bNr3ufIEGXfu3+t2Aw7HPE3jPs0vI5882rjGQO6/h2GB/KKaY416Hss40SavDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088465; c=relaxed/simple;
	bh=3fahoLuvkxmGiHmjrhB6ZsVBFHd7nTZQfCs1BWWmwCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFnsILQDLjkZ3Q+60BVcfh6ciBbT8WU3GSkbFxbyt35L7i4/PLoQumwpduVHDZyi3ilaQg6PRQZy6PjWPfROhj/N81Z69spSHTDzb3FEh4KveF7BKq5G3U3W5CPDGhI7+vWj9LRKroefXE5JJ02iZs5pzxmQ2/uxIJXjIka8Wlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsF51urM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63029C4CEDD;
	Thu, 27 Mar 2025 15:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743088464;
	bh=3fahoLuvkxmGiHmjrhB6ZsVBFHd7nTZQfCs1BWWmwCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RsF51urMi1dzrFT+XkhonJgpCEZW8fRZoudyK7BxpywICruSeO2oAZr2l5+ZnyypB
	 vNNQQ6GS59xwOommf7E1U6LVg17UDJQZQ+M0wax9rYlbpLDMv96sPeyh9Pmj+E9xeL
	 NhTteSM49hrJtK7Zwy4RKu52wZefWXQLO6BEU8m7+CcxHUh6bho+sHTsGvtJ+KoGgY
	 tjoXDTezgFnCJw3uOEtduGIL4sz+sWazAhebBFVZxgKRNS8g9PzPVVh80dy96LVBii
	 KGIUkBb6URH1HquIhQs02hc+bWcNXWs4E8ko/8GW1zFLzW8gP7KqfrFBVp/ED5W4n3
	 Mdq/BgzShCGsQ==
Date: Thu, 27 Mar 2025 15:14:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <shao.mingyin@zte.com.cn>
Cc: <lars@metafoo.de>, <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
 <ye.xingchen@zte.com.cn>, <feng.wei8@zte.com.cn>,
 <michael.hennerich@analog.com>, <gregkh@linuxfoundation.org>,
 <linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adt7316: replace irqd_get_trigger_type
 with irq_get_trigger_type
Message-ID: <20250327151415.791f65e9@jic23-huawei>
In-Reply-To: <202503270957044481PK0Xb23i08BgwkodLtEC@zte.com.cn>
References: <202503270957044481PK0Xb23i08BgwkodLtEC@zte.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 09:57:04 +0800 (CST)
<shao.mingyin@zte.com.cn> wrote:

> From: Feng Wei <feng.wei8@zte.com.cn>
> 
> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).
> 
> Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Applied.
> ---
>  drivers/staging/iio/addac/adt7316.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index f4260786d50a..16f30c4f1aa0 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1794,7 +1794,7 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
>  	struct adt7316_chip_info *chip = iio_priv(indio_dev);
>  	int irq_type, ret;
> 
> -	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
> +	irq_type = irq_get_trigger_type(chip->bus.irq);
> 
>  	switch (irq_type) {
>  	case IRQF_TRIGGER_HIGH:


