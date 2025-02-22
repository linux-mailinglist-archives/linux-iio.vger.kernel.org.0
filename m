Return-Path: <linux-iio+bounces-15968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99EA40A33
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AD53BD98E
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41E71EA7EA;
	Sat, 22 Feb 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAfkdkm9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7D1C5F37;
	Sat, 22 Feb 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242727; cv=none; b=FBmQRdcn+dI/hd6VWcae/yC1yijvvkfv9pKvMoopiFR6utE95h7L+TZRDh0m/L3SSiKC3+fjHM7chBPKt2f78ysOZxlGlvi0wNfJQFgax3iSa3hGZ1X+EYTzQhNFTDcIuZnDBlpZkAOSF5B+bI8FWhqq7WWO0GpKA4pNz+1uMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242727; c=relaxed/simple;
	bh=vbJCp+e9xPwW5z2JijA383yFH/nOJJDHw1hTpjyQdxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHvSV8r1QDXcxxqRJnuLKQsOY5Yav9lls58r1tOD25X/5l8tOm51RL1eN8MFHpTii5JLtKgrR2HBtIP2/M2BWw1rNJaO+rXmo4YpSy7s9I6jjyRctTb+5nPW1E5D/EVLS11ik2/y94Jn8JhIrCWRXIjGc4jjMgzJjvxOr0G4mDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAfkdkm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3318AC4CED1;
	Sat, 22 Feb 2025 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740242726;
	bh=vbJCp+e9xPwW5z2JijA383yFH/nOJJDHw1hTpjyQdxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FAfkdkm9Sy59BMZ8242k9Gme9cJkPH08yoCdhI3fa4QQZzzhuYy0A39o/at3Iz2xa
	 hrPCBM7M+3HnixPd6vxb/UVAljxqplEe5ueJEZ5KMvh7PiS7XYi2sAnw/4+ydEn+Yw
	 Ar3+CRiN4L7QzfxnmK/X5ictuyy8dO8vfks1GICs6Y2nTS4iIPvQkPOHpOyR5kwgIJ
	 WcOCXFn9MAY0R19iGlu0obkGj9+x/R66o0Sdfd7g40DwASIYnYmUlf8rBOLlMahlGB
	 utGR+5glAgokGIKxQc+c2NfDFhqe33Pz8o+GicZv3u5aCd94mWG89SvlKMDsaG7Aj4
	 yWlVzbgC8pP4A==
Date: Sat, 22 Feb 2025 16:45:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Message-ID: <20250222164519.45c48a52@jic23-huawei>
In-Reply-To: <20250222164337.0372fb58@jic23-huawei>
References: <Z7dnrEpKQdRZ2qFU@Emma>
	<20250222164337.0372fb58@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 16:43:37 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 20 Feb 2025 17:34:36 +0000
> Karan Sanghavi <karansanghvi98@gmail.com> wrote:
> 
> > The array contains only 5 elements, but the index calculated by
> > veml6075_read_int_time_index can range from 0 to 7,
> > which could lead to out-of-bounds access. The check prevents this issue.
> > 
> > Coverity Issue
> > CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
> > overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
> > elements at element index 7 (byte offset 31) using
> > index int_index (which evaluates to 7)
> > 
> > Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor driver")
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > ---  
> Superficially this looks hardening against malicious or broken hardware.
> That is fine to add, but not worth backporting or (in my opinion) adding a fixes
> tag.
Ah I see Javier asked for the fixes tag.  Ok.  Maybe just add a note that
the hardware is not expected to return such an out of bounds value.

That will help me to remember we don't need to rush this one upstream!

Jonathan

> 
> >  drivers/iio/light/veml6075.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> > index 05d4c0e9015d..5dd951f6e989 100644
> > --- a/drivers/iio/light/veml6075.c
> > +++ b/drivers/iio/light/veml6075.c
> > @@ -201,7 +201,12 @@ static int veml6075_read_int_time_index(struct veml6075_data *data)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	return FIELD_GET(VEML6075_CONF_IT, conf);
> > +	int int_index = FIELD_GET(VEML6075_CONF_IT, conf);
> > +
> > +	if (int_index >= ARRAY_SIZE(veml6075_it_ms))
> > +		return -EINVAL;
> > +
> > +	return int_index;
> >  }
> >  
> >  static int veml6075_read_int_time_ms(struct veml6075_data *data, int *val)  
> 


