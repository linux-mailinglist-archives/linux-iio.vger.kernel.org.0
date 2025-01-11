Return-Path: <linux-iio+bounces-14145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E15A0A64D
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 23:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1332D168A5D
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 22:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2021BBBD4;
	Sat, 11 Jan 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZFpsNtr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF18192B8A;
	Sat, 11 Jan 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736635823; cv=none; b=Ope+YjeTapUgrq4lfY6J1FHJVbJKBjfKvPpIlRUpibhq8MfKoWR7PdLxwXvhvcJF3J8QrO71u6sVJa0nsTrfZxkTXuGQwdk7v2qdYM1xA78LBUeQWifXYitZvL451pA27NkkUmqgD/Uwyy5rVHTAoVA7VGkkV++Nw+MevmKedMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736635823; c=relaxed/simple;
	bh=57BUQRm5CpDl5O6xYUuG2zZI129fZ6RyxJ5iW9A+HpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVXM+eFJL/iLt7PDwSZEq8xkxzEWW/e5bHuBUbB6vjiwSHEe2cjAOR6EKoUiWZEIilkHQhC4zrf0C35x0sN+LWd1ZvTz3ofgjws6lPlXLifQZ3aE41eMKD8R2zHNGrayN3N4myM2KGdG5lysk9F1kQPyCR2gAQROpaBhNMKZ45g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZFpsNtr; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e252c3c19so207063a34.2;
        Sat, 11 Jan 2025 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736635821; x=1737240621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqIGw26QfbBZkP0ka4AqH4cix7WA90/E1Q7X8jAGMGI=;
        b=VZFpsNtrP/k94WEqFW1nIr2smm2/bruaxC6MX+0xfPFRolaFHPmdCP/zleOMHsmzMt
         uqCr4XKqL21kB3VUcGPQ3luZWZ06hRyISEyZNvXb1RsfCO0bPcRVm2ajPFlzA+KtXmgX
         ynlALd8Az27YssZvYJVFLYFqOjg2JFepRDsVtM7ZUbvyb01yCL43Qk5kFFzhGXOm33nF
         lmkmb+crQZGg6EyvpNhX0n0WmvwttKhNjjn+KhGPNsGRvieEEqMAvKgo4WJPLw5vdFul
         yyw+Ss8I9lL1q7EYjVnEyqWnzDT0Eik9mNkYtROdCKSOd/9z3l9qY/AN9v2edPd3+7Bv
         zWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736635821; x=1737240621;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqIGw26QfbBZkP0ka4AqH4cix7WA90/E1Q7X8jAGMGI=;
        b=JNxONVz89MDPorDaigQhlZWeOxsWiLoQDXoTmMuoVG6OrfIxV9+kizCjgEXrUruIfq
         BjsRt26IvLthSMHOwB/aVlLSqjSlrbpmSu9BWEoJVVYVS+wnbExgxoZ80Ok2LmTeYdOX
         8TBmc9vKL6A18BLQaUcfi0es2Md8/WJIg+nI3jfKq8HTW2tdKtBysFTTL/mEfMBihbpi
         Qgx/r3XLN26oz5+9oW+60UF6PDPS5PNg3QtnWkH8gAFbbeYYgFZHL7jEbIW+rd062gRS
         FYPrAfk0QK2UxuBcmCoMyYqBARmbLTzWIgIlC6XNXWjXMJNb+Fj6KCgiQJpQTrVT/33R
         khwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU79bfINYew7L+b7xDauIneJ88vfjobuZwvcVAAy0QmTe53TLJXit/QKbfBpURtLTv5qLqJItgYHgXA@vger.kernel.org, AJvYcCUMP0/m/IjzKQ76lRVECLs1nMSUK4snGMJMbXuN+edUxfcwffi5dgsyx1mQQc+0vftXxIT7HoHcgwtk@vger.kernel.org, AJvYcCXowbc4MhfNjYYjpzZwo+T7WQhaTT2xoisNL3uNU/TMh40LT72TGrggapby9wjVd1lQh9+gK3JJs+eUy+q+@vger.kernel.org
X-Gm-Message-State: AOJu0YwvP7tWu9Wg6X1BnjLs2Gybs+plWShSItb4AQL0hdowvCMTrDGr
	XcN9vLl9V5ZzpFmsUP/iJUID4F0xzAc4+Qmkv8OGNWMyk0wzu8OV
X-Gm-Gg: ASbGncsT93VBbPQEWwl6m9SkR3Ku6f+PZFpHv5zuOuLqd7ZWAwXYk1F+Wgma4pyfNxp
	Lil49Q0zEK2c8YdPoEvSbh6gSB/WSCy+d4Y2lQIKpjwumdfX3uODSIfgkfL1oAINOcRsYmGAjpe
	hycHxClpflcLq1vgD1No6iF2fZs7N4jdMOa4R4eUZ5+3l5dKizsLC0Zb8w2UfqaDDuTpRvJWMVg
	vmX33i0j8yykuyhB43gC2Nm+TI4P1iXb/tLC4eTkIsx3Wb0qz6JpqUCaYL3QXdZ6zhFCvskHm0C
	xQ==
X-Google-Smtp-Source: AGHT+IGVcwKOYTRdWGOSClDeVXtJhGfYDMmO4gL05Ja+f2uI5m75/VhDIUeBI7AjW7BE4zTSgNoL4w==
X-Received: by 2002:a05:6830:660f:b0:710:f408:bd54 with SMTP id 46e09a7af769-721e2de3ad9mr3140119a34.2.1736635821670;
        Sat, 11 Jan 2025 14:50:21 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723185382a2sm2076612a34.3.2025.01.11.14.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 14:50:21 -0800 (PST)
Date: Sat, 11 Jan 2025 19:50:18 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 02/15] Documentation: ABI: add wideband filter type to
 sysfs-bus-iio
Message-ID: <Z4L1qrqHBUE5JGdX@JSANTO12-L01.ad.analog.com>
Reply-To: 8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <40707fa904ba7b1659554747ff7520139dd6f94e.1736201898.git.Jonathan.Santos@analog.com>
 <8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:24 AM, Jonathan Santos wrote:
> > The Wideband Low Ripple FIR filter is used for AD7768-1 Driver.
> > Document wideband filter option into filter_type_avaialable
> 
> s/avaialable/available/
> 
> > attribute.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index f83bd6829285..c4c21a7bfba1 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2291,6 +2291,8 @@ Description:
> >  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
> >  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
> >  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> > +		* "wideband" - FIR filter with wideband low ripple passband
> 
> I think "fir" would be a more specific filter type name than "wideband". (i.e.
> there are wikipedia pages for sinc and FIR filters, but not one for "wideband"
> filters)
> 

Isn't "fir" a bit too generic for this case? Since Wideband here is a class of a FIR filter.
Maybe something like "wideband-fir" or "fir-wideband" would work better?

> > +		  and sharp transition band.
> >  
> >  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
> >  KernelVersion:	6.6
> 

