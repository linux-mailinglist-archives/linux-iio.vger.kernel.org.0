Return-Path: <linux-iio+bounces-22737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC459B26658
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 15:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1C45E1A13
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBDD2FD7B1;
	Thu, 14 Aug 2025 13:06:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D82FF166
	for <linux-iio@vger.kernel.org>; Thu, 14 Aug 2025 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176819; cv=none; b=qwTTzWVcPJuS2mOna5XeYXFizUqMf06LBbkcGgMOoAqaR+EeDpH87iCLYCurwnnADXGquQ2YTd6XFOf4fF+TpbdujdyufuKquvd7tLdA2k/weWWmXOhJDAiRysCBin7BKHUqGBHh2RAtQ/N0WEn2Rb8sil94MA4RgMbExiKeE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176819; c=relaxed/simple;
	bh=rBSOaaGlQrBIbubiWvvRgdcKsQgmkod6l6U7O0ehnTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4IVVn4avWyH9FU8yB5mVd59RWoyBJtWwKjqg38vc2z/xc+vGSs337J9xZ06F8ewD8rsW0wuB+S3TE591M6VpcN/asehomJM8r1PDq/BxM9eYhoaeRI+3icexm7dZ12KgcguUqryqC/riR+8LB63gYR28Ekl5/0Rah3XGJini0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 09:06:39 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081408-umber-axolotl-e6c6dd@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 13, 2025 at 05:52:04PM -0500, David Lechner wrote:
> On 8/13/25 10:15 AM, Ben Collins wrote:
> > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
... 
> >  static int mcp9600_read(struct mcp9600_data *data,
> > @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> >  		*val = mcp9600_tc_types[data->thermocouple_type];
> >  		return IIO_VAL_CHAR;
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		*val = data->filter_level;
> 
> We can't just pass the raw value through for this. The ABI is defined
> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
> is the frequency in Hz.
...
> For example, for 3 Hz sample rate (18-bit samples), I got:
> 
>   n  f_3dB (Hz)
>   1  0.58774
>   2  0.24939
>   3  0.12063
>   4  0.05984
>   5  0.02986
>   6  0.01492
>   7  0.00746
> 
> I had to skip n=0 though since that is undefined. Not sure how we
> handle that since it means no filter. Maybe Jonathan can advise?

Thanks for notes. If I'm reading for datasheet formula right,

k = 2 / (2^n + 1)

So n=0 would be k=1. I did this formula for n=[0-7] and get:

n	k
0	1.00000
1	0.66667
2	0.40000
3	0.22222
4	0.11765
5	0.06061
6	0.03077
7	0.01550

I'm not versed in filter frequency, but would these be the correct
values to use for the coefficients?

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

