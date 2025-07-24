Return-Path: <linux-iio+bounces-21975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E42B10B49
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D76F1CE3D43
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC822D6408;
	Thu, 24 Jul 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSBej+rC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01F2AF03
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363431; cv=none; b=KIxC8Q6mYrzj/XzUSyNPG9Yb7MpweIUKvkm24pvFNTOTickAQvQXczbg3kyh8EJHhth/LQBmkkcc5R5hHLuispnhu79Ebm4DEsQM2tisQJlogmbfNZuo9trvsXxRyfUN44kquOfyImq/Iz13m26Vo3MXmBPV6hHF/dtkEBckXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363431; c=relaxed/simple;
	bh=5RhohfjJ/KdRL3QkojqNSbnIdzOcM80/W5Yp3J8Elp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYxQKDB3fyLIfQQSamF7q05gk5cHwvuAxsxQ/exMU8IkneNt+YOx9y0/KIx/MhHJq6TSpjcKYUmz28hEfMvAhZ0ME4qdDz8XtsCH7+qjigxkaJucc0Qdh+drcBE8YLeGzR3TRHbVWub0gxMYzJ2eZAwzU07OymcTttWrERxy73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSBej+rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5ABC4CEED;
	Thu, 24 Jul 2025 13:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753363431;
	bh=5RhohfjJ/KdRL3QkojqNSbnIdzOcM80/W5Yp3J8Elp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RSBej+rChGrWO393/EtFKDF6DRMEyIeYYLa+mqcIz8Him95w6IQI+XVds7r0lxh7O
	 sh4x05C7qnaj3QWL1E2gwD1GSvy1RQPajnIlbUlc3X/lhNy/R0z/jiqozdk30HuIlg
	 U+kYfBNeGveHUxFp1jwOanmH+wJpOQnqkGbtDNWt8vds98Oy3KTOxTta9ofqq8w5o3
	 Knjz4ABYfpfnXBcTZ5nPsmFZjxQr3EWUvGotrf+Ah1j1i9z/msTMrZftv/VTyKzu40
	 aqG4yCiWajinqd/OnuRNXsLn6FT87MUiZ7xNkGxbbp3t7jYG99A42Q6nr3mqUxC2JD
	 iVq+7fOq4gyVA==
Date: Thu, 24 Jul 2025 14:23:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
Message-ID: <20250724142344.08067925@jic23-huawei>
In-Reply-To: <68cac85c-d19e-4de8-b06b-1b82d30906fd@kernel.org>
References: <20241219230028.55987-1-hdegoede@redhat.com>
	<20241220194249.434244e0@jic23-huawei>
	<a0d1bcf9-74e1-43cb-9f4f-1fb6f5b20724@kernel.org>
	<20250719120417.7bef0731@jic23-huawei>
	<68cac85c-d19e-4de8-b06b-1b82d30906fd@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 18:17:15 +0200
Hans de Goede <hansg@kernel.org> wrote:

> Hi Jonathan,
> 
> On 19-Jul-25 1:04 PM, Jonathan Cameron wrote:
> >>>> +	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);
> >>>> +	if (ret == 0) {
> >>>> +		dev_err(info->dev, "Error sample timeout\n");
> >>>> +		ret = -ETIMEDOUT;
> >>>> +		goto disable_adc;
> >>>> +	}
> >>>> +
> >>>> +	ret = regmap_read(info->regmap, chan->address, &msb);
> >>>> +	if (ret)
> >>>> +		goto disable_adc;
> >>>> +
> >>>> +	ret = regmap_read(info->regmap, chan->address + 1, &lsb);    
> >>> bulk read and an endian conversion + mask?    
> >>
> >> This chip only supports reading 1 register at a time, I'll add
> >> a comment about this.  
> > 
> > Set regmap_config.use_single_read and bulk reads should be fine.  
> 
> Interesting, I did not know about that flag.
> 
> But I'm afraid that I've already ending up spending more time
> then planned on supporting this old PMIC. fixing all other remarks
> from you and Linus W.
> 
> And I also hit an i2c-core regression which I've just finished
> debugging...
> 
> So I'm going to keep the multiple reg-reads as is (it won't
> matter for what happens on the I2C bus anyways) I hope this is ok.

Sure.


> 
> I did also write an interesting iio-core patch to make
> iio_read_channel_processed_scale() more precise :)
> 
> I plan to post a a new series including this tomorrow.
> 
> Regards,
> 
> Hans
> 
> 
> 


