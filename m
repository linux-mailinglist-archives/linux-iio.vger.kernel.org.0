Return-Path: <linux-iio+bounces-25801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34399C28E90
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 12:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD9346F4A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 11:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E72D2741C9;
	Sun,  2 Nov 2025 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqX9bacd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF434D3A6;
	Sun,  2 Nov 2025 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084504; cv=none; b=rxa9MLjDfmtISPk4yzHMlpwQqjZM/2ClqFqYfhCazlCg3GREfwLPzJ//4DmgDJTVHnfN38OdtZcyIYrM4nDexRNE4mlcGbqpp65Qlj1vZ3IvdyQU73zPJIGdT/xzyRBqjwm5kKqR8LKUE+FrobDtfK9gPtsN3zwX1EGUSR8Crcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084504; c=relaxed/simple;
	bh=4byWlS4fL+6q8oWe+gFhgxj6Us50M89a+fr4vDI6gZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6imfd3QXiCkxl/CP3UAm6TeVCgbKIYq40eLkYKIMJUs1Len2+iut8Vz5p0f2ti1KviylrK7iuP5QsQ2dvMgD60BPQga7LzCrVJiU8ay0lgqoNGzBwWQfhYPlcQCVlTVmOgZHWfjAnxHC6yDy+j2g4+at1Jrg4eoPkd+QIy3tMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqX9bacd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A845C4CEF7;
	Sun,  2 Nov 2025 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762084503;
	bh=4byWlS4fL+6q8oWe+gFhgxj6Us50M89a+fr4vDI6gZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sqX9bacdTO6kA04TljVruXOYjIpm0+7ul8GXjT44YpQVb+sYMSJtqp/aoYHXvKWPP
	 57EHN03Oj96eR+u1zUsnwYVuNsRXzgCeuS7piGN3IVMUsCaxGfwXMxNkAvrICusjUQ
	 XyJoUxeNSM/RylCcG3awPmg8bqA5G+vplKFTt4LLyXxmgji6amRGYtdiDgDi5Z/Y9C
	 rvgP3n5nidqVyqNSXYAtdGSejnruy+FVLqJJtjPtDpKBjrIyHiG1vT1/wDvxYI9Bb6
	 tZdgrH4hf9ngnpVKzU23U7WYxXozRtVCY318asSCHqeu1oz0iWwlqv+cbP+NQFdiLa
	 NRBbCN1PQFICg==
Date: Sun, 2 Nov 2025 11:54:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eugen.hristev@linaro.org
Subject: Re: [PATCH v3] iio: adc: at91-sama5d2_adc: Fix potential
 use-after-free in sama5d2_adc driver
Message-ID: <20251102115458.4d37556a@jic23-huawei>
In-Reply-To: <90dec520a9537af2feab9d56b22d99878fba9e2a.1761705396.git.xiaopei01@kylinos.cn>
References: <90dec520a9537af2feab9d56b22d99878fba9e2a.1761705396.git.xiaopei01@kylinos.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 10:40:16 +0800
Pei Xiao <xiaopei01@kylinos.cn> wrote:

> at91_adc_interrupt can call at91_adc_touch_data_handler function
> to start the work by schedule_work(&st->touch_st.workq).
> 
> If we remove the module which will call at91_adc_remove to
> make cleanup, it will free indio_dev through iio_device_unregister but
> quite a bit later. While the work mentioned above will be used. The
> sequence of operations that may lead to a UAF bug is as follows:
> 
> CPU0                                      CPU1
> 
>                                      | at91_adc_workq_handler
> at91_adc_remove                      |
> iio_device_unregister(indio_dev)     |
> //free indio_dev a bit later         |
>                                      | iio_push_to_buffers(indio_dev)
>                                      | //use indio_dev
> 
> Fix it by ensuring that the work is canceled before proceeding with
> the cleanup in at91_adc_remove.
> 
> Fixes: 3ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
This ID doesn't exist in my history  it should be
23ec2774f1cc

I'll fix that up whilst applying.  Ideally I'd like Eugen to take a look
but I'm fairly confident so I'll queue this up on the fixes-togreg branch
of iio.git and mark it for stable.

Thanks,

Jonathan



> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
> changlog in v3: move cancel_work_sync after iio_device_unregister
> changlog in v2: use correct Fix id
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index b4c36e6a7490..aa4ba3f5a506 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2481,6 +2481,7 @@ static void at91_adc_remove(struct platform_device *pdev)
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	cancel_work_sync(&st->touch_st.workq);
>  
>  	at91_adc_dma_disable(st);
>  


