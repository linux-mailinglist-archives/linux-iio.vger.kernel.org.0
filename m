Return-Path: <linux-iio+bounces-26069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513DCC43F80
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 15:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19745188AF78
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F352FABFE;
	Sun,  9 Nov 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ0S72Zz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AE2EBDDC;
	Sun,  9 Nov 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696941; cv=none; b=hN+TzOw/Bt/9mVfxstBUBv93H07KwKkIKcjCG2DYRk5GoBwdws47LAwLPjhVqa8mp0ne83ym62tJYABR6reHM8CPe0TYnb+BrzyxdylvXlBZdKql7LKhiwO1+p0+Ir5LniQdZ+b/UhkTL8kTDHIvuxPsSzAdCO21AUDe0Mw7AVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696941; c=relaxed/simple;
	bh=8Xby+xRc+0y+B8bFE0Vu5Y/NCe7fSkl59x0fZcQoHEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uc2re4h7HiW1bJm97XuogpejJbE1cMcAk73cWV0sM1qxBKNAci3fpjrtj0ataYk2NJOgZB93ChHKM8+8AcfjVY+wzudhcTlPjcoiw7c+B6mXSKFWebjMktyRQ4JQUQ/GMnwaxlzejm/GwkIXNScC+sCjFmYPOPFvY4FdGxea99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ0S72Zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19EDC19422;
	Sun,  9 Nov 2025 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762696941;
	bh=8Xby+xRc+0y+B8bFE0Vu5Y/NCe7fSkl59x0fZcQoHEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NJ0S72ZzKx17Xy2t2QhnjMLdmBwVVgN7MXM6yhPfyeufnqBTxYEZ18WowMjeZEy6w
	 nyTQuRlIZxzMazas4osUXakavydLJbQxnVl2Rv8HdV3iPGSPVtbNbXM9qsysZhXUzN
	 t3SZ4qrqQn+Pw2Lw4nPQJ1EqSVoH06OpDO3LELbg9OIqN3vrCfekfUF5UBSIoZIwUJ
	 Y6mv30doYQuM8mxKofGGS8odq//G2PrvweRyKpYNCT68tnHpZYW/WvcSTNIlz6cW+b
	 zf5aiXUo72bd0XPU2h0og4WS4MZfbDOdvJ+PUA2+TV/QRSkw1KUn0WPIRviyH7lAeT
	 YsAoY7iJDINxg==
Date: Sun, 9 Nov 2025 14:02:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] iio: adc: Add support for TI ADS1120
Message-ID: <20251109140215.18655bf9@jic23-huawei>
In-Reply-To: <38483816-8477-4c17-9c62-37d122b0a55a@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
	<20251030163411.236672-3-ajithanandhan0406@gmail.com>
	<20251030175433.00004cc2@huawei.com>
	<38483816-8477-4c17-9c62-37d122b0a55a@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 20:10:15 +0530
Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:

> On 10/30/25 11:24 PM, Jonathan Cameron wrote:
> > On Thu, 30 Oct 2025 22:04:10 +0530
> > Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:
> >  
> >> Add driver for the Texas Instruments ADS1120, a precision 16-bit
> >> analog-to-digital converter with an SPI interface.
> >>
> >> The driver provides:
> >> - 4 single-ended voltage input channels
> >> - Programmable gain amplifier (1 to 128)
> >> - Configurable data rates (20 to 1000 SPS)
> >> - Single-shot conversion mode
> >>
> >> Link: https://www.ti.com/lit/gpn/ads1120  
> > Datasheet:
> >  
> >> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>  
> > Hi Ajith
> >
> > Various comments inline.  Mostly superficial stuff but the DMA safety
> > of SPI buffers needs fixing.  There is a useful talk from this given
> > by Wolfram Sang if you want to understand more about this
> > https://www.youtube.com/watch?v=JDwaMClvV-s
> >
> > Thanks,
> >
> > Jonathan

Hi Ajith,

A small process thing around efficiency.

Crop your reply to only include things where you are answering questions
or wish the discussion to focus.  If you accept changes, just put that stuff
in the change log for the next version.
Save a lot of scrolling and makes it a lot less likely important stuff
will be lost in the noise!

> >> +static int ads1120_read_measurement(struct ads1120_state *st, int channel,
> >> +				    int *val)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = ads1120_set_channel(st, channel);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Start single-shot conversion */  
> > This all seems fairly standard so not sure what your RFC question was
> > looking for feedback on wrt to how you did single conversions?  
> 
> I was indeed concerned about using the polling(adding wait) method to 
> read adc values.
> 
> That's the reason i have asked it in the cover letter.
Ok. A bit more detail next time on what you want feedback on will
help focus things.

> 
> >  
> >> +	ret = ads1120_write_cmd(st, ADS1120_CMD_START);
> >> +	if (ret)

Thanks,

Jonathan




