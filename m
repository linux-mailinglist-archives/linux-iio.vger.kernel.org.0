Return-Path: <linux-iio+bounces-13292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28A9EA2E0
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 00:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDABA18866D1
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24EA226160;
	Mon,  9 Dec 2024 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBbWn/1N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB621171C;
	Mon,  9 Dec 2024 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787319; cv=none; b=ufJN87dTQrj+60F7jsBwTqZ5y2MKZ5461q1sd+mfvIDRLdiowoXaLWiHkHUwzVCkHqArdL7MNlQ3swPxcBJJCZGiNonnF0l3kTihDyT7miuagQFWC4o11McgZ4Bh08R9SKou+/x509RHjGbA0xapbMYHRCyutXuCsLJuBvU+a6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787319; c=relaxed/simple;
	bh=09eOszdQp8aADM+FBr3jl7oQCtkzq2XVKku21nI+EJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcFpF4Ubb5lHqYwK8VLkFBDgcIbur3U/8b//oiZHuLwSLmk8CxwFQErMQz2mGvODMPyIQxE7dv0CByuoU1LMOMAi3t0RXRr/U88UF2X91MxeW7268roGorAZZdxu0cetoeRlaqa3QBzjttR4i3ftdrlD+WRkwPlDzHwSbxMtaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBbWn/1N; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so3370583f8f.1;
        Mon, 09 Dec 2024 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733787315; x=1734392115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9seuM7L9vuan498Cf2vQlSWlEELVDh6UuDY7NqRGeK4=;
        b=QBbWn/1N7F2qebVMrlq/47uM9R2N6jUPbB8DjauuUd/W11Ovfe9rTlkrV2jpqVmeVY
         EdD4xtw+ZunJZtLQ64b+Qt4SnPbAMD625bQGB3JtJda+XwFrAUjtKNI6KiSiVuBrok8n
         Qx01QK6EfoOgb1a0TcBqsxsl3tk93YQJkgnsNCPpun5jQJBpq9xo+MsJwz8fbm71Q47+
         /UnOeDYu794LedNw5FODoddfo7JC2tuAlUUcqjoH3DGmwvsBKvcjDQCWZx34Y+MaFhvU
         ZpFhTbjvVH9aFN/QplxEwEDlA9vU8GbekLd3ajVQ5Wlh30lVk1O42d+49EH4YQENWJ8r
         Fsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787315; x=1734392115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9seuM7L9vuan498Cf2vQlSWlEELVDh6UuDY7NqRGeK4=;
        b=ZaWh3YGAlQPQ5v/ZLWstJqVOruR/szsuOgmxH8ZhNHVpKDVkzdcW9vYpWeR17VLglP
         cBwcQfCpOGvQwEWbbFCkmO1NsfJGYTQo2CsWDZ61qK7j2JmCY+d7vkVVx0k0kgFn8SUD
         lrkb/xsXbK7Mq6gmAuNC068CpE/sJ9HlRk3mOOaVrJzP0dyPYVVWOZb3uJ2Dcs/XFQ1Q
         Fj5UqWpVr6fDQ1/g7lYrkPYP4FL6zyrsjB6pasPXpWv8SrEbRMNKRZ2uckm4zf+gHtdS
         KbzvSET9YjRY8EbvA+3XyGPyoiPPF3IbeVYkR8Nfguq55Pp2JFsSgSHRJS7qojBYaSJN
         hePw==
X-Forwarded-Encrypted: i=1; AJvYcCVIVELnrikxDuYgn5yVfbRb1Jd+Pu0f+T1wTFoGyqWHmsyK2orsSTnF73SdRiCFW3TZBaxU4PpP8EG7@vger.kernel.org, AJvYcCW1sdPlKHmg4v234UBYGXLBA3P45PmjZxgxL87pO2rESCIwqupOp2VExD2nt+PyhTHIudCdr70jhZU4idWL@vger.kernel.org, AJvYcCXT5OJxdzkdO4DhGahsNUjLAKX9rkp1PmsmwPD0EQ/8o6r+aJ+zXoS1uq1qsM0jxTyJencgoyKZdfCW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94y7TVKj1LWiQLzxkkVuxmTjb8xI5XcJoVxFzS+j2Cyk7aveu
	2mh8KvNuo4sAFnxQDsxj5YLbBRFBlk+gznLT2wVgT9Ak/jSJB6G3
X-Gm-Gg: ASbGncv0OzQQjQOaBwjDP9jOILEoPDFuxu/CuvxSxkBOvErE/v4WUYPl33PX/5yFmjn
	SqEcqTc4wSTSxwk58YGllWtGop4qKosKjmK8dZgO0cUaN81iFqcJwLFBdcDLZgK8RxK9nbS4G0w
	0Yrl2tskWzHEOo1hWmkw4Svq2ZmhnbYpdJCRvLmPy2h9Xi+jaCq8IYtf6JNZ16IM5IgiYqkUwm3
	PO2WbrvYAoZE/C5W5xmAO3O304os32Gw2XHNF4+LVmuetM8ptAG6FLs2JTdOuo=
X-Google-Smtp-Source: AGHT+IGs9Qpy11HwXA8BlsWLwAy944ebyg9XHnPObRtV0jDuR5b6pXiV2buYKBhksgzU+H/I7ik9Jg==
X-Received: by 2002:a5d:47aa:0:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-3862b345322mr10569851f8f.1.1733787315017;
        Mon, 09 Dec 2024 15:35:15 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:1688:29d6:6b3:2e70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8758sm14243877f8f.27.2024.12.09.15.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:35:13 -0800 (PST)
Date: Tue, 10 Dec 2024 00:35:11 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: chemical: bme680: add power management
Message-ID: <Z1d-r5DE159oEAdZ@vamoirid-laptop>
References: <20241202192341.33187-1-vassilisamir@gmail.com>
 <20241202192341.33187-4-vassilisamir@gmail.com>
 <Z04N6GUSL2H0zt6_@smile.fi.intel.com>
 <Z04aJg7eoBR9CYKe@vamoirid-laptop>
 <Z078vIxRoQf_zLsy@smile.fi.intel.com>
 <20241208173336.6a09c9b2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208173336.6a09c9b2@jic23-huawei>

On Sun, Dec 08, 2024 at 05:33:36PM +0000, Jonathan Cameron wrote:
> On Tue, 3 Dec 2024 14:42:36 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Dec 02, 2024 at 09:35:50PM +0100, Vasileios Amoiridis wrote:
> > > On Mon, Dec 02, 2024 at 09:43:36PM +0200, Andy Shevchenko wrote:  
> > > > On Mon, Dec 02, 2024 at 08:23:41PM +0100, Vasileios Amoiridis wrote:  
> > > > > Add runtime power management to the device.  
> > 
> > ...
> > 
> > > > > +	ret = pm_runtime_resume_and_get(dev);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
> > > > > +	pm_runtime_mark_last_busy(dev);
> > > > > +	pm_runtime_put_autosuspend(dev);  
> > > > 
> > > > Side note: as long as idle method is not defined (NULL) the above dance is
> > > > already taken into account in the regular put.  
> > 
> > > Thanks again for the review! Indeed by looking at the code a bit, it
> > > looks like the suspend callback is being called if the idle one is not
> > > found. But I have seen this dance that you mention much more often in
> > > the IIO that's why I used it. We can see what Jonathan has to say as
> > > well, I think what you propose, simplifies things.  
> > 
> > Yeah, this is cargo cult by many people (including me :-) who missed that
> > detail. If any, this can be addressed in a different series.
> > 
> > ...
> > 
> > > > > +static int bme680_buffer_preenable(struct iio_dev *indio_dev)
> > > > > +{
> > > > > +	struct bme680_data *data = iio_priv(indio_dev);
> > > > > +	struct device *dev = regmap_get_device(data->regmap);
> > > > > +	int ret;  
> > > >   
> > > > > +	ret = pm_runtime_resume_and_get(dev);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	return 0;  
> > > > 
> > > > Either this is broken (if the above can return positive codes), or can be
> > > > replaced with direct return:
> > > > 
> > > > 	return pm_...
> > > > 
> > > > (but I believe it's the former and you wanted something like if (ret < 0)
> > > >  there).
> > > >   
> > > > > +}  
> > > 
> > > Well, pm_runtime_resume_and_get() looks like it returns 0 on success and
> > > negative value on error so I think the if (ret) is correct, no? But I
> > > agree with you that it can be simplified as you proposed.  
> > 
> > Please, go ahead with the simplification!
> > 
> I tweaked it and applied the series to the togreg branch of iio.git and
> pushed out as testing for all the normal reasons.
> 
> There was some mess because of the EXPORT_SYMBOL() macro changes this raced
> against.  Please sanity check I didn't mess it up.
> 
> Jonathan
> 
>

Hi Jonathan,

Thank you for this! It looks good in the tree. 

Cheers,
Vasilis

