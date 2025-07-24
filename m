Return-Path: <linux-iio+bounces-21989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1FFB10ECE
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC07316A32D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C42D3EDF;
	Thu, 24 Jul 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OibhsSLg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65041509AB;
	Thu, 24 Jul 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371149; cv=none; b=AGZTVgrun+Ko+kiR9MydzGn+eHmbdTKeiWPQzc7ZArNSr0f7mpCJBK9YjNq9a3Gh4BI0TAaJFI0YgCoGD7Iz5Ow2BhyaC89qgwTJ9XKeW8MCH6FkTNcPraZURCQOGuTY86t+9cgwADhm/pyGBe25sIG9CNZ2g9cTbJq0/rbfKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371149; c=relaxed/simple;
	bh=pL9X6wBVQbvY3/cwyyVMcF73RrjD7dKiLTM7koIBeFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=su2vIDLxeMc/LT0X8d3NxcoMIuoI/g601tRKZLtCjzXVfSdq5VRAW/ySM9XymtQZzDTv4weD0ACiZi5NidhYJpTtAGADF9WBCtm7Xd2XmpvHr5/0iMlSo27AVRkJH90N0v0otkF8y6TgRJi8oGFnCIJndO0VAWbtz1l/KaX0bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OibhsSLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70797C4CEED;
	Thu, 24 Jul 2025 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753371149;
	bh=pL9X6wBVQbvY3/cwyyVMcF73RrjD7dKiLTM7koIBeFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OibhsSLgypSM5xeL5fgwkJ3cMf4Rj/60CVbD+4XRnxQiMz9i9Xspun4kfhRz2tDKN
	 NuuTfFwGzs5EhQGJ/mgGL9y+yLd7iNs/edoPpD3NzbwM7gjjEQp3pYY/89S+yFbXdi
	 Te0BEdFSqlUq8FpgPCtPN1IeAz0ii6jWNjYGoqplIRdqD6plynRdgmuDzwMUEr6ENm
	 t9SrbB2hqt/WKCY6hvq24cJmYTwhAxrfwFlCcmEPhkzB02K+C4OSB5Jhg+PRiN5rx6
	 qKFBjx11EYeS6f1eZuNLnbHucFCjJ6dPPl2VNmgtAc1dt5Y2Wced2casLXhapg4m0H
	 2hEdr4SmbKCaw==
Date: Thu, 24 Jul 2025 16:32:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@amd.com>,
 Andy Shevchenko <andy@kernel.org>, Manish Narani
 <manish.narani@xilinx.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: xilinx-ams: Unmask interrupts after updating
 alarms
Message-ID: <20250724163219.0098ced6@jic23-huawei>
In-Reply-To: <20250715002847.2035228-1-sean.anderson@linux.dev>
References: <20250715002847.2035228-1-sean.anderson@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 20:28:47 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> To convert level-triggered alarms into edge-triggered IIO events, alarms
> are masked when they are triggered. To ensure we catch subsequent
> alarms, we then periodically poll to see if the alarm is still active.
> If it isn't, we unmask it. Active but masked alarms are stored in
> current_masked_alarm.
> 
> If an active alarm is disabled, it will remain set in
> current_masked_alarm until ams_unmask_worker clears it. If the alarm is
> re-enabled before ams_unmask_worker runs, then it will never be cleared
> from current_masked_alarm. This will prevent the alarm event from being
> pushed even if the alarm is still active.
> 
> Fix this by recalculating current_masked_alarm immediately when enabling
> or disabling alarms.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
Anand?  

This seems fine to me, but I'm not that familiar with the hardware or driver.

> 
>  drivers/iio/adc/xilinx-ams.c | 45 ++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 76dd0343f5f7..180d4140993d 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -389,6 +389,29 @@ static void ams_update_pl_alarm(struct ams *ams, unsigned long alarm_mask)
>  	ams_pl_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK, cfg);
>  }
>  
> +static void ams_unmask(struct ams *ams)
> +{
> +	unsigned int status, unmask;
> +
> +	status = readl(ams->base + AMS_ISR_0);
> +
> +	/* Clear those bits which are not active anymore */
> +	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
> +
> +	/* Clear status of disabled alarm */
> +	unmask |= ams->intr_mask;
> +
> +	ams->current_masked_alarm &= status;
> +
> +	/* Also clear those which are masked out anyway */
> +	ams->current_masked_alarm &= ~ams->intr_mask;
> +
> +	/* Clear the interrupts before we unmask them */
> +	writel(unmask, ams->base + AMS_ISR_0);
> +
> +	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
> +}
> +
>  static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
>  {
>  	unsigned long flags;
> @@ -401,6 +424,7 @@ static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
>  
>  	spin_lock_irqsave(&ams->intr_lock, flags);
>  	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
> +	ams_unmask(ams);
>  	spin_unlock_irqrestore(&ams->intr_lock, flags);
>  }
>  
> @@ -1035,28 +1059,9 @@ static void ams_handle_events(struct iio_dev *indio_dev, unsigned long events)
>  static void ams_unmask_worker(struct work_struct *work)
>  {
>  	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
> -	unsigned int status, unmask;
>  
>  	spin_lock_irq(&ams->intr_lock);
> -
> -	status = readl(ams->base + AMS_ISR_0);
> -
> -	/* Clear those bits which are not active anymore */
> -	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
> -
> -	/* Clear status of disabled alarm */
> -	unmask |= ams->intr_mask;
> -
> -	ams->current_masked_alarm &= status;
> -
> -	/* Also clear those which are masked out anyway */
> -	ams->current_masked_alarm &= ~ams->intr_mask;
> -
> -	/* Clear the interrupts before we unmask them */
> -	writel(unmask, ams->base + AMS_ISR_0);
> -
> -	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
> -
> +	ams_unmask(ams);
>  	spin_unlock_irq(&ams->intr_lock);
>  
>  	/* If still pending some alarm re-trigger the timer */


