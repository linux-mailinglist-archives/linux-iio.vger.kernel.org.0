Return-Path: <linux-iio+bounces-5123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D708C959E
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C9AB20CA9
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9D50284;
	Sun, 19 May 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQW8X0NX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148A4F207;
	Sun, 19 May 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716140623; cv=none; b=jiKf+2eea6ExcN67P95VOpVI5xYq6O06vN/QMnH4DHyjaNeuzjDJD1V5wxVQ7AtcWsr7sbyGgXnHP2gyKBEXgxuZjlj3Jm4yNvCC72Rjq/BM1NgXuJXxwyOZ542Hn6ntdCZrLCr6dj94oudTGWqfkoibWbhbbJiO8YeCXXmH3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716140623; c=relaxed/simple;
	bh=cCXZLo84qNU75ElL88uDa5+2wNh05EA9nfN5Ws/0eQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPgkwV63bRZWh9xdo8KgCNCvxK9hsiD7qHtsEp+H/MjmJ13nZZDkWuL8fw56HEgNAlVGxpubAqsDNuL34u55nMwgieVphfNJgCIMuUroNYVghs8Zd50CbLS8xMNTKawntj/pkicSXCGI5bKh9n3Emibu9VXpxj7Y+NC16yU5xRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQW8X0NX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF6CC32781;
	Sun, 19 May 2024 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716140622;
	bh=cCXZLo84qNU75ElL88uDa5+2wNh05EA9nfN5Ws/0eQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQW8X0NX27ixWvv1TRwiz8PpZm6612q8k41KYvC7XCwBaOlWdRfw1FRNZr0RMSFiQ
	 ur4vGmwxxmTXcqmvZJoBF0T8NQZRNY65HermwbqyyOj8XLdLLZ9OkH7RXY4JPWKNoa
	 CRLWvoXrUW5UJP13PE79Dy/R88RSQGNrBS0IKHhHac3TK1QFZ9GJLZqyF48YFyAsll
	 MAYugfHln4GxkOSpa6e/98ARrj7AwYpI1dxzjHrEbLsO5jRXc2w/YyWMgDIiv0szfX
	 wm166UcK87CnAoypqC7AXt/12f/nFrhAUurB8MLkQYNyf1ROYNKOmtkzxWKh9rEIcp
	 BsMGhP+PUOIMQ==
Date: Sun, 19 May 2024 18:43:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v2 8/8] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <20240519184330.6d575cb8@jic23-huawei>
In-Reply-To: <ec8174c5-723d-43ad-beaf-0930d1b2c19e@gmail.com>
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
	<20240508131310.880479-9-ramona.bolboaca13@gmail.com>
	<20240511145447.68de0f59@jic23-huawei>
	<ec8174c5-723d-43ad-beaf-0930d1b2c19e@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 11:00:36 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> >> + * device will send the data popped with the (n-1)th consecutive burst request.
> >> + * In order to read the data which was popped previously, without popping the FIFO,
> >> + * the 0x00 0x00 burst request has to be sent.
> >> + * If after a 0x68 0x00 FIFO pop burst request, there is any other device access
> >> + * different from a 0x68 0x00 or a 0x00 0x00 burst request, the FIFO data popped
> >> + * previously will be lost.
> >> + */
> >> +static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
> >>  {
> >>  	struct iio_poll_func *pf = p;
> >>  	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct adis16475 *st = iio_priv(indio_dev);
> >> +	struct adis *adis = &st->adis;
> >> +	int ret;
> >> +	u16 fifo_cnt, i;
> >>
> >> -	adis16475_push_single_sample(pf);
> >> +	adis_dev_lock(&st->adis);
> >> +
> >> +	ret = __adis_read_reg_16(adis, ADIS16575_REG_FIFO_CNT, &fifo_cnt);
> >> +	if (ret)
> >> +		goto unlock;
> >> +
> >> +	/*
> >> +	 * If no sample is available, nothing can be read. This can happen if
> >> +	 * a the used trigger has a higher frequency than the selected sample rate.
> >> +	 */
> >> +	if (!fifo_cnt)
> >> +		goto unlock;
> >> +
> >> +	/*
> >> +	 * First burst request - FIFO pop: popped data will be returned in the
> >> +	 * next burst request.
> >> +	 */
> >> +	ret = adis16575_custom_burst_read(pf, adis->data->burst_reg_cmd);
> >> +	if (ret)
> >> +		goto unlock;
> >> +
> >> +	for (i = 0; i < fifo_cnt - 1; i++) {
> >> +		ret = adis16475_push_single_sample(pf);
> >> +		if (ret)
> >> +			goto unlock;
> >> +	}
> >> +  
> > My paranoid instincts for potential race conditions kick in.
> > Is this one of those annoying devices where the fifo interrupt will only occur
> > again if we successfully read enough data to get below the threshold?
> > Snag with no public datasheet is I can't just look it up!
> > If it's a level interrupt this won't be a problem.
> >
> > If so the race is the following.
> > 1. Interrupt happens, we read the number of entries in fifo.
> > 2. We read out the fifo, but for some reason our read is slow... (contention on
> >    bus, CPU overheating, who knows).  The data fills up at roughly the
> >    same rate as we are reading.
> > 3. We try to carry on but in reality the fifo contents never dropped below
> >    the watermark, so not more interrupts ever occur.
> >
> > Solution normally is to put this read sequence in a while (fifo_cnt)
> > and reread that after you've done the burst read.  If there is more data
> > go around again.  That way we drive for definitely having gotten to zero
> > at some stage - and hence whatever the threshold is set to a new interrupt
> > will occur.  
> 
> Hello Jonathan,
> 
> Indeed the watermark interrupt is a level interrupt. However adis lib does not 
> allow for level interrupts, so I had to create a new patch in v3 to handle it.
> Until now I tested the watermark interrupt as and edge interrupt and I did not
> see any issues, but indeed if the FIFO is not read fast enough the watermark pin 
> will stay high (or low depending on the configured polarity), so the correct 
> implementation is to use level interrupts for FIFO watermark interrupts.
That is the easy way certainly!

Sounds good to me.

Jonathan

> 
> Ramona G.
> 
> 


