Return-Path: <linux-iio+bounces-9816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3600C988FB5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D14281F9F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755C1B7FD;
	Sat, 28 Sep 2024 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv53OEPI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4118E11;
	Sat, 28 Sep 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534323; cv=none; b=TwvOuYdv3imtI+paK357affqSpVXP9+fXgtl80/AS5z+w0hOe6CD8PZsrq3aGtxgLFXVD8CewAJ1BOvSEmDq5EMj6a0etIzyM9/HPEHWTSBsa4KYzZD45onLRXTkKSNAgTweQh0hYjURN6ldpnpteWvwZss/O2hdf020g/A7R1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534323; c=relaxed/simple;
	bh=Mg41Czp4iLNXfN0ojsPaj+c1TJMlEK/US6inXCaque4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLwQtDtXwmFupThUbtNerKBWJICv5gEqxeeMFjFTvOGtH6BbbU3tr+LFk21OLpsCpBvM+ig7y0iQ9TMWh93y8V5FOt3/WjYEb+4b/jNWQZSgHAqbwpyhxJ+VJuu8g7cVAGn1rawhNmxCPYzflRVVWORbV+4fIW6G/7Uj0YTF3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv53OEPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5946C4CEC3;
	Sat, 28 Sep 2024 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727534322;
	bh=Mg41Czp4iLNXfN0ojsPaj+c1TJMlEK/US6inXCaque4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bv53OEPI+5t7QuxkwNBcugww/BPfD+CzrZZSO3KUCbrJ99/e3agy5Dy0e21KgA09G
	 SQgo/5X5FSy46I6Sa+o/7vtTHiW4FRFsvBtY9Uq85Gava1J2TH+oAYeykoYQSA7vXi
	 936KFBOtckh+uHlJ3ROYKnkgu1IZc11SYDhyh+oOlGhlLuLBB4og+QsIo1dS6SSjtd
	 LnekcWg4xmQ1FO2GDhI2jL79zvUoRKbuhsiLuIC8O6zQxjV5l5brxTXuNot2RjUvGk
	 bRpQBcAlxpFK7K1nySB7OxWuFmXh0RFWcc32nVXS2R0BFj2nQCwirKRWa6kUVMyUGu
	 YGyYLZSaTvTkw==
Date: Sat, 28 Sep 2024 15:38:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/7] iio: light: veml6030: update sensor resolution
Message-ID: <20240928153834.3577ef30@jic23-huawei>
In-Reply-To: <5199bc7c-c3fe-49e8-9122-78b476c4aa90@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
	<20240913-veml6035-v1-5-0b09c0c90418@gmail.com>
	<20240914155716.09496630@jic23-huawei>
	<5199bc7c-c3fe-49e8-9122-78b476c4aa90@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Sep 2024 10:31:11 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 14/09/2024 16:57, Jonathan Cameron wrote:
> > On Fri, 13 Sep 2024 15:19:00 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> The driver still uses the sensor resolution provided in the datasheet
> >> until Rev. 1.6, 28-Apr-2022, which was updated with Rev 1.7,
> >> 28-Nov-2023. The original ambient light resolution has been updated from
> >> 0.0036 lx/ct to 0.0042 lx/ct, which is the value that can be found in
> >> the current device datasheet.
> >>
> >> Update the default resolution for IT = 100 ms and GAIN = 1/8 from the
> >> original 4608 mlux/cnt to the current value from the "Resolution and
> >> maximum detection range" table (Application Note 84367, page 5), 5376
> >> mlux/cnt.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > Interesting.  So does the datasheet say this was fixing an error, or
> > is there any chance there are different versions of the chip out there?
> > 
> > Also, should we treat this as a fix?  I think we probably should given
> > we don't really want stable kernels to have wrong data being reported.
> > If so, please reply with a fixes tag.
> > 
> > Jonathan
> >  
> 
> According to the Product Information Notification (link in the cover
> letter):
> 
> "Reason for Change: Adjusted resolution as this was wrongly stated in
> the current datasheet."
> 
> "If resolution is defined in the particular application by the customer,
> no changes in the system should be made. In the case resolution was
> taken from the datasheet or app note, this has to be adjusted accordingly."
> 
> Which means that stable kernels are using the wrong resolution. I don't
> know what IIO usually does in such cases, because a fix could
> potentially make existing applications return "wrong data". If that is
> alright, and applications are meant to be adjusted after the kernel
> update, I have no problems to make this patch as a fix and add the
> stable tag.

It's unfortunate, but fixing a bug is a valid reason for ABI change
(which this is - sort of) so existing applications will need to be
fixed if anyone notices.

So please send this as a fix with appropriate tags and
that datasheet change log included in the patch description.

Thanks,

Jonathan

> 
> Best regards,
> Javier Carrasco
> 
> >> ---
> >>  drivers/iio/light/veml6030.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> >> index 5d4c2e35b987..d5add040d0b3 100644
> >> --- a/drivers/iio/light/veml6030.c
> >> +++ b/drivers/iio/light/veml6030.c
> >> @@ -779,7 +779,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
> >>  
> >>  	/* Cache currently active measurement parameters */
> >>  	data->cur_gain = 3;
> >> -	data->cur_resolution = 4608;
> >> +	data->cur_resolution = 5376;
> >>  	data->cur_integration_time = 3;
> >>  
> >>  	return ret;
> >>  
> >   
> 


