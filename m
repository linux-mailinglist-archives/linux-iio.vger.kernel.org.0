Return-Path: <linux-iio+bounces-10954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69369AB767
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 22:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE221F2412A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE81CB32B;
	Tue, 22 Oct 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWU8vR6e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4013AA2B;
	Tue, 22 Oct 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627570; cv=none; b=UqNRiZXwHjsX7z3C9G66WQKPlV+My8NZYtehMKFd2o8PQpUaVKpH96G50G4P4mFwhEuzw6I3iPCru5iKhA9Ipo+mEK/ebUyAfcyZg57/xRd9/XA8ZwBZIR9DqiBVV+5sXEz7xrdnPl3pNjni0Pbs/Unj8s0oGz3j3uZW37/Q6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627570; c=relaxed/simple;
	bh=pTXa0lFnMCDyEuXkjtGuHVSkjWu46Z7KtuaG27m8gsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ds8mUDlTf0QTO+T1CIVafh8Csd0jYI/8Lt9X0zmflA9q5//9PRah2GER1M9dNuSrnP5ishg1N4fu1J9/BP/KGzPGGMioUSy4vMZMBZHqFNZzlnUqcoHiokeCU7TGCXbqKIPCrhGHUAqcgRJdw77LR3n6yWtttnEfRl+sM+aGtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWU8vR6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4434C4CEC3;
	Tue, 22 Oct 2024 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729627570;
	bh=pTXa0lFnMCDyEuXkjtGuHVSkjWu46Z7KtuaG27m8gsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oWU8vR6eaw/ebks0Qu91duBCh4+FYt6COOeQ6QB1fibVdJistw75v74cYH9EpwrRu
	 gNI8a5l1jgqpR+ncp9B7Qe8uxORFleXbp+tYs4svPt/tJu7rGj64vTqhjiQDFH41Xm
	 ewaKr3zd6Es+VdxozjMG8sArLu4m+wf9wCg9KTY2ofyJmqDqFlMPOxM7GZAV4SLHQT
	 SP9h600q15BUmOj5QMy5ld5CGWSN0yhRsgMNIjiVsXceM5B96MjK+mOxdszLC9dXwg
	 fkMCE9RgacwTFWqHCak7c1gTHhuB1ecPOuaQjdNC9ShYxEOaZni06HnYNJ8Rr0HIcN
	 r/kp3tYjCU/Jw==
Date: Tue, 22 Oct 2024 21:06:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zicheng Qu <quzicheng@huawei.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com,
 judy.chenhui@huawei.com
Subject: Re: [PATCH] drivers/staging/iio/frequency/ad9832.c: fix division by
 zero in ad9832_calc_freqreg()
Message-ID: <20241022210602.691d6351@jic23-huawei>
In-Reply-To: <6c896172-d372-442a-a61e-6b3e46b9cbb0@stanley.mountain>
References: <20241022134354.574614-1-quzicheng@huawei.com>
	<6c896172-d372-442a-a61e-6b3e46b9cbb0@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 17:25:21 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> It would be better if the subject prefix were "staging: iio: ad9832:"
> 
> [PATCH] staging: iio: ad9832: fix division by zero in ad9832_calc_freqreg()
Keep the frequency as well, though less important in staging as we
have only a few drivers there.

I fixed up the patch title and applied this to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> On Tue, Oct 22, 2024 at 01:43:54PM +0000, Zicheng Qu wrote:
> > In the ad9832_write_frequency() function, clk_get_rate() might return 0.
> > This can lead to a division by zero when calling ad9832_calc_freqreg().
> > The check if (fout > (clk_get_rate(st->mclk) / 2)) does not protect
> > against the case when fout is 0. The ad9832_write_frequency() function
> > is called from ad9832_write(), and fout is derived from a text buffer,
> > which can contain any value.
> > 
> > Link: https://lore.kernel.org/all/2024100904-CVE-2024-47663-9bdc@gregkh/
> > Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>  
> 
> Otherwise it looks good.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> regards,
> dan carpenter
> 


