Return-Path: <linux-iio+bounces-675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A598076BB
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC601F211F3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D46A01E;
	Wed,  6 Dec 2023 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR0IQyF+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC52364B2;
	Wed,  6 Dec 2023 17:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073BC433C8;
	Wed,  6 Dec 2023 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701884226;
	bh=RwGl1RcbRMFQzj6CBreX5lxtcFVvuIjpzUngRG0hqos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eR0IQyF+WPhSu4l5rp7kF48UTVIGmAiTFX/GMhnMPr0B0/ZVqF++kGvQNdoDpe+as
	 zBJQw36pOwMnt9UxEvj74ihTS9/HKIhX1RIlEnF/TYlmqmDPXqtWmn68iYoYW2XL+w
	 CvF6iT4uJmozZrYFNjHZc6IcH+t0PqmEl8A2hc+IPcLoINiAmobLlS/8+TOc7ZL7PW
	 SWwf6qcGPKUNI+GKVDwsxdcew8exJFK4HP+qmiOteQRomkA0RYU3hSrqaamwrK4SrN
	 DYWZ7b6bPIyIc4cNzl634W55cdqpIlKeYB1xBJfPNOF2VE10OCDoMHcbhqj4K97uXZ
	 BHMccci2Ama6g==
Date: Wed, 6 Dec 2023 17:36:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
 conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: Add support for AMS AS6200
Message-ID: <20231206173658.57b00a49@jic23-huawei>
In-Reply-To: <ZW6IArKhx4KvxyTD@abdel>
References: <20231202041651.719963-1-alkuor@gmail.com>
	<20231202041651.719963-2-alkuor@gmail.com>
	<20231204135014.15ea47b6@jic23-huawei>
	<ZW6IArKhx4KvxyTD@abdel>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 21:16:34 -0500
Abdel Alkuor <alkuor@gmail.com> wrote:

> On Mon, Dec 04, 2023 at 01:50:14PM +0000, Jonathan Cameron wrote:
> > On Fri,  1 Dec 2023 23:16:51 -0500
> > Abdel Alkuor <alkuor@gmail.com> wrote:
> >   
> > > as6200 is a high accuracy temperature sensor of 0.0625C with a range
> > > between -40 to 125 Celsius degrees.
> > > 
> > > The driver implements the alert trigger event in comparator mode where
> > > consecutive faults are converted into periods, high/low temperature
> > > thresholds require to be above/below the set limit for n seconds for
> > > the alert to be triggered/cleared. The alert is only cleared when the
> > > current temperature is below the low temperature threshold for n seconds.
> > > 
> > > The driver supports the following:
> > > - show available sampling frequencey
> > > - read/write sampling frequency
> > > - read raw temperature
> > > - read scaling factor
> > > - read/write temperature period that needs to be met for low/high
> > >   temperature thresholds to trigger an alert
> > > - show available temperature period thresholds
> > > - buffer trigger
> > > - temperature alert event trigger  
> > 
> > Hi Abdel,
> > 
> > A few comments inline. Looking good in general.
> >  
> Hi Jonathon,
> 
> Thank you for your time. I have a couple _silly_ questions about the tag
> and returning from if else. Other than that, your comments will be addressed
> in v3.
> > > 
> > > Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> > >   
> > 
> > No blank line here.  Tags block (and Datasheet is a tag) never has blank lines
> > as that breaks some existing tooling.
> >   
> Understood. 
> 
> P.S. when running checkpatch.pl on this patch, I get the following warning:
> 
> WARNING: Unknown link reference 'Datasheet:', use 'Link:' or 'Closes:' instead
> 
> should I use Link instead?

Nah. Just ignore checkpatch. :)

Also, if just accepting a comment, no need to say so.  Assumption of reviewer
is that if you keep quiet on a particular comment you will have it fixed in next
version.  Crop out that section of the email and only keep the bits that
you want the reviewer to see your comments on.

Hopefully I've cropped it appropriately!

> > > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> > > +	if (info == IIO_EV_INFO_VALUE) {
> > > +		*val = sign_extend32(FIELD_GET(AS6200_TEMP_MASK, tmp), 11);
> > > +		ret = IIO_VAL_INT;  
> > return here.
> >   
> > > +	} else {
> > > +		cf = FIELD_GET(AS6200_CONFIG_CF, tmp);
> > > +		cr = FIELD_GET(AS6200_CONFIG_CR, tmp);
> > > +		*val = as6200_temp_thresh_periods[cr][cf][0];
> > > +		*val2 = as6200_temp_thresh_periods[cr][cf][1];
> > > +		ret = IIO_VAL_INT_PLUS_MICRO;  
> > 
> > and here.  If there is nothing more to be done, it simplifies the code
> > flow being read to just return as quick as possible.
> >  
> I did it as you mentioned, and when running check_patch.pl, it gives back a
> warning that else is not needed here because of the return in the if
> statement. So I opted into using ret instead, should I remove the else or ignore
> the warning?

Dropping the else is fine or take the view it's wrong and ignore it.
Checkpatch is providing hints and suggestions on where to double check.
There is no requirement to accept it's suggestions if you feel the
code ends up less readable.

> > > +	}
> > > +
> > > +	return ret;

