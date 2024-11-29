Return-Path: <linux-iio+bounces-12838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B29DEDB1
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2128B281D2C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 23:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D4199FAC;
	Fri, 29 Nov 2024 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmR/Gve0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84015530F;
	Fri, 29 Nov 2024 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732924491; cv=none; b=Ig1PJEGCnKdEOXF3FC1kNVqBF/zH3t0lpiccqz/q3tj59CbgTxEDUnJYsAbpwamIAKFfH3IxEuMQrbE3T88YEO/d2tX10/5kUWBFQvQPWy+merE6SWkFj7F7BCFWji+x3HgCeeb3ISH7vcu3CvMvYyYbYEv5pIW4MveWz2H7Els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732924491; c=relaxed/simple;
	bh=RXmFWIqBdeITpAI29tkUBBKRJ+AI8lY+rUqfD3si3xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiHySReTLA427e1rgbxiMIWGAHVP5TDLWRW4KVEI7nDsk5A41RO0PivWrnJpn8u5rf6QjzmcoDoQSziBZMIOsBhdenWbFor/jIWRNAsSEr3GHnE7dLTqKG/lyvbghO9auiBBJcAHIVC46E5Zop3BxquV69YnWGOwY5ii4wifia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmR/Gve0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385d7f19f20so872479f8f.1;
        Fri, 29 Nov 2024 15:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732924488; x=1733529288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEPesXU+h9oIb2rQWQl22qE/+ZEA6qAcZJWXR1NmMyo=;
        b=AmR/Gve0BiQryAy9PWJQ9NE6l2PAA0fM479sEmV0sJIvgIjidlZNTLauCipAs8SsyO
         4s4Y2ov9JSCXVjq72VEDvvjuoVgZAEbH9uh1cR+/RUVo/CToJvRF/NCyxUskfWdzpTR5
         Midg2SQjHdUahcFdnrjS+5Azv9+ATMASlUW3B+3l+lpME6YY0f7KoMiBhxS8FXYM0RQV
         83Lwr28rUd0s9e8DmtPig83GgF6dWBHP/GMA35/4n0ldep0o6NOSRRFGx5QqGg7l2I6o
         gyYHkdKEPI5gDk0qzwRTma8zVbzMTeuv+NRBR9Yzhtlp09yBoPsvFPQCS8zYvl3QZyan
         0u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732924488; x=1733529288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEPesXU+h9oIb2rQWQl22qE/+ZEA6qAcZJWXR1NmMyo=;
        b=CM6EqVf2OkZEUzkHrbKOmz9CqYxXl5KP3X/J6RSrwMuVEL3TBzLpuu5skVRFA+k0O2
         2BA4nLlHLy8Tg2azgLffr5LLlBrYlU+rxHt7DKJo3ETrurGGnS8TEeV8mGjungZbd8IR
         A1Oa2IlUC6BnwpipeDeMXaFMgZvm9e47+lCfVBSCrV2lzkfHMjA35vfd1uAdKi4M+De5
         H4xSXlIYZ/T49/bcnt2On7i7MTqAfwsA74e7Zwt798DenPokD8PEoqbrJRM7Xh+pfLoI
         tyM6/IOAemFNyK6T6XidL6mvd6aRr7ah2Rd3gF91YOlQg4vyStvL7L+/qIFbl3e4EWCH
         O9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVpyRmY+2qDncWtd7s6s/kDejHTtlhA8o3aY2qUTFdswIN/rqgANlUmWm8zNgrtilH21kiVG8KRCS0w@vger.kernel.org, AJvYcCWhCmI7XEpGLwO/IfaiQw4vwVYKiBk02l0BniKbgxCdCo6mqI5mR16DtN1fr5S1n1NHYaSEAJyMrBvjeNCQ@vger.kernel.org, AJvYcCX0YLTwhlF/APJod+QbrEHM+tYbMFK+0pG3rCYZnoQIjYy5vChQLQE99Cn/A3okBeEwXpy021Gmx3/X@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsm3Be1KJ4FEEYn22C6jZI8Sj/xixYmrQ0/w+Fxf5Qfpjr5fiG
	T1ugMKyoE3w9aQQA+KypSmGKUjGdoM0LC7DZgtXPcHat7mVNNxPJ
X-Gm-Gg: ASbGncvemqHPTFMbnneHnOJbclPqsbzEYX3ERKqE6H66+/uei7Nr1uwnJ71fYhojAnH
	5oiN2PIMSenLAJ929guam5wylJpX2bbEL0x6QD8M8uR3nvDSDnfeEXOCVTSgBhtgmIHKbMZuOmt
	DwVoJiiBvlmxZnA3NRIyWOVVyR2kSLuhGeV8XlyQ4hzOvKzBUvfN3L4OnrtfOq1BGIlMq1TM69H
	5cHVDzuxKKgArCz0HqsixkD+D8SqyI03BRDtB1Mk6i0tBRQRvG44nJ3KE4=
X-Google-Smtp-Source: AGHT+IHBMBxAfyqoTtOJA9LCRV8ah0cIhYx7tY0Qbu/qA0nUl6gfNdVPHblCaTGYtwp/2XGRgKx5Xg==
X-Received: by 2002:a05:6000:1849:b0:385:e013:39ec with SMTP id ffacd0b85a97d-385e0133a41mr3770848f8f.8.1732924488446;
        Fri, 29 Nov 2024 15:54:48 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2e940sm5610573f8f.15.2024.11.29.15.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 15:54:47 -0800 (PST)
Date: Sat, 30 Nov 2024 00:54:44 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ajarizzo@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] iio: pressure: bmp280: Make time vars intuitive
 and move to fsleep
Message-ID: <Z0pURIPAG4MHRYH3@vamoirid-laptop>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
 <20241128232450.313862-4-vassilisamir@gmail.com>
 <Z0nXNW4751P6hDtC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0nXNW4751P6hDtC@smile.fi.intel.com>

On Fri, Nov 29, 2024 at 05:01:09PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 29, 2024 at 12:24:50AM +0100, Vasileios Amoiridis wrote:
> > Add time unit abbreviation in the end of the variables to make the names
> > more intuitive. While at it, move to new fsleep().
> 
> Seems to me the commit message's primary and secondary purposes should be
> swapped, i.e. you do --> fsleep() conversions and while at it, rename variable.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

Hi Andy,

Thank you very much for the review! I can change that in next version.

Cheers,
Vasilis

