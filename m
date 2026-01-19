Return-Path: <linux-iio+bounces-27974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC2CD3B2DB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9A553051960
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD832D0F9;
	Mon, 19 Jan 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9cS99yg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA72632C925
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840643; cv=none; b=IvTWKvib4igZO4w/dOADYNzkguKSnNLCGHEsWJ9WZHTKatzSGKcqDGrQ6bE8gIG2SrKr0uX+ciyBnh0CT+5J/laHmVuPljXGtS69HUBv4TXINlOkDGvmL9RFuSSjeAwYwboCDhNZiqC+DOgq7D3GnX4KWH35witaB1gDeu/R+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840643; c=relaxed/simple;
	bh=EZrNpq9rChwQifuKMlIJR8/++2PQTZ9sdidJy9GUDCQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkSvnWedwI0Y2rmqBNoayppjW7XfHdwxvmfwQBAO0PWTI0phoHbECLANeb1efyf+l59wvO4mCXZ62EuY02IOqVGDkPWc9bivaIxu3PSIvsU0on+KINNFksK6zD7v+Lis7umQv1rfGEHbHUNewmwjHEBjHzlwygbWX8WCvsdrfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9cS99yg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-501469b598fso30800661cf.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 08:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840640; x=1769445440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWa5GFU+0/3D3/qFeqSukARO3O554NFHrTD7tJlV5sE=;
        b=D9cS99yg1VoDWp7dVzCSIAogNp7MVRfxu8/xvenT4fc9hEpPfxKtrHNRjfvroD7NoL
         d9WLORGDWCtyRgNC09E/mwxenrfnd4MVwuxFzOMEmePgFbEpmx9k2CGTG2LcBN05OO7X
         oJxOO//3kBx4XUlOsFYuWHkK6JrXqvET7wS1EWNfWwtB8eaLiy90qpqldcN+i0B+YB8x
         O/qzra2Z1j19Vt1m0NOSyAoZI12u9GAJaXURpbGQtTYahe8D1cWfdzWRy8UDOeQGWM28
         97SPY/TcmbHRciJamAIoZbNqJlPbo/iI1swmn1C+n7hOoQhXrHWQg9f+wBtYAH3A3C2Z
         AXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840640; x=1769445440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWa5GFU+0/3D3/qFeqSukARO3O554NFHrTD7tJlV5sE=;
        b=KKmvxHTq1H5cnpCgGK/kD24dlSGTqR432Po4OuOtkq5O8aRcUu/+XcSr6UFkOeezp/
         KtUlIpPO0j9C2yPMdfkbQQkSYc+NaY2HfTwfYDekBj6uUJaWnJIwl2JxejIjmiB14uur
         1L+ZPbfg/Is8NBY/3euNjF1saHDDo0TNS7uvm5Vk+QDHeOW9M6hR/JjhbeS4Ket1LH5y
         DUTC/D0lR2QBnRem10FG7aNrrKwmD4LrGOwhL1SBPj+FA7fqX4ZpoAKBEvcBf2nrcIbv
         YpjiTWEU0HgpzMTlCWCDMx4QvhLiknHGDlJEJtMDITjsFxmDNSTOxAvJo2qimOBJuD+/
         KxHg==
X-Forwarded-Encrypted: i=1; AJvYcCWnUKkDCd5+5seOikX2m323XDvScKgslSondmn0QJ8jY1HdjkvXzI3lRvkI81oVHOeuHq7w6pdQvLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyltggB+fH1p+zUSh+o2msbra76YuEMEMF8tZszFZTYhw1JhCDj
	xC2SvK29VEC1lQTLaNM8MG51ZAi0P6tbnnSe4HGXRo2EPgW3SaKuVNuh
X-Gm-Gg: AY/fxX6qCVf9/M8y3mHrIGEOOkbMP6Q4LgXTq/D+x/CT4r63K6uNDdYFB7NirATf6zO
	yBEthM+xu9HQ0t0zjv7I1gCmbKIzijvM0tHANIOia+kfeQYgswOUe9DPQK2JIWRTrXRnszYbcFD
	bkf7PWinJXzP1kykMNja8gp10TwEn4E+GAzNE46TtmsFTrUOP+7tDOuX9o+PqhD4p35LY6bJfLP
	0Dk86hs7sIuJeTQora/OVXN0NtDxnZaBL38pMCoOwVnhQeb4/4NGZ+PhlxkGYzs6IF6pWg9B3Er
	xfA+1X5Rgq76FFodHn5qQdkYwIjlxJMXLxGCBl/Bxj0WBnuj564SNuCdfqlh+zdWUj5sM4NWLGE
	2Z+iEbyVb+8+IUh5wrmGVO934Lyh6GuBjitivBhDOvfyCmql1z6+plDDOa+/uGbRr41TbmwmmlJ
	ygm/m+OPJ4DHXG9eH4Q+tgBtVXG/K2SUYKlwBDFqoC07vJDeDRYkz6d0y3VfLPw+/lIp8m4QTpq
	+N+ldWkV/8Ap6M=
X-Received: by 2002:ac8:7d4d:0:b0:4f1:b9e8:1d34 with SMTP id d75a77b69052e-502a1f303bamr165768011cf.61.1768840640429;
        Mon, 19 Jan 2026 08:37:20 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f1abb9sm73070231cf.30.2026.01.19.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:37:19 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 19 Jan 2026 16:37:09 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
Message-ID: <hgy3bcrqqsvt7pobhnzuvwzhb2taetpxltkaxpigmmlvmlirod@v6anhmrsvv2r>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
 <aW3dxuelYDM67pqZ@smile.fi.intel.com>
 <texwv5s2tvcy34bwr4iruj5xofmea663pwletmpqpuh66zulmv@m7qvjgqbhalv>
 <aW40ylvMwVhqNQMw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW40ylvMwVhqNQMw@smile.fi.intel.com>

On 26/01/19 03:42PM, Andy Shevchenko wrote:
> On Mon, Jan 19, 2026 at 11:21:59AM +0000, Rodrigo Alencar wrote:
> > On 26/01/19 09:31AM, Andy Shevchenko wrote:
> > > On Fri, Jan 16, 2026 at 02:32:22PM +0000, Rodrigo Alencar via B4 Relay wrote:

...
> > > > +struct adf41513_pll_settings {
> > > > +	enum adf41513_pll_mode mode;
> > > 
> > > Sounds to me like a room to improve the layout here,
> > 
> > I am targeting a 32-bit cpu, just moved in_value down:
> > would this be fine? (pahole output):
> 
> Likely.
> 
> > struct adf41513_pll_settings {
> >         enum adf41513_pll_mode     mode;                 /*     0     4 */
> 
> Wondering if this can be shorter if moved down...
> 
> >         u8                         r_counter;            /*     4     1 */
> >         u8                         ref_doubler;          /*     5     1 */
> >         u8                         ref_div2;             /*     6     1 */
> >         u8                         prescaler;            /*     7     1 */
> >         u64                        target_frequency_uhz; /*     8     8 */
> >         u64                        actual_frequency_uhz; /*    16     8 */
> >         u64                        pfd_frequency_uhz;    /*    24     8 */
> >         u32                        frac1;                /*    32     4 */
> >         u32                        frac2;                /*    36     4 */
> >         u32                        mod2;                 /*    40     4 */
> >         u16                        int_value;            /*    44     2 */
> > 
> >         /* size: 48, cachelines: 1, members: 12 */
> >         /* padding: 2 */
> >         /* last cacheline: 48 bytes */
> > };
> 
> ...at least I have had in mind that "mode" should be moved to be near
> to "int_value". But I think it will take 4 bytes still as we don't use
> short enums compile wise.
> 

As you mentioned without short-enums it does not make any difference.

> > > > +static int adf41513_parse_uhz(const char *str, u64 *freq_uhz)
> > > > +{
> > > > +	u64 uhz = 0;
> > > > +	int f_count = ADF41513_HZ_DECIMAL_PRECISION;
> > > > +	bool frac_part = false;
> > > > +
> > > > +	if (str[0] == '+')
> > > > +		str++;
> > > > +
> > > > +	while (*str && f_count > 0) {
> > > > +		if ('0' <= *str && *str <= '9') {
> > > > +			uhz = uhz * 10 + *str - '0';
> > > > +			if (frac_part)
> > > > +				f_count--;
> > > > +		} else if (*str == '\n') {
> > > > +			if (*(str + 1) == '\0')
> > > > +				break;
> > > > +			return -EINVAL;
> > > 
> > > > +		} else if (*str == '.' && !frac_part) {
> > > 
> > > This can be found by strchr() / strrchr() (depending on the expectations of
> > > the input).
> > > 
> > > > +			frac_part = true;
> > > > +		} else {
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		str++;
> > > > +	}
> > > 
> > > With the above the rest becomes just a couple of simple_strtoull() calls with
> > > a couple of int_pow(10) calls (and some validation on top).
> > > 
> > > > +	for (; f_count > 0; f_count--)
> > > > +		uhz *= 10;
> > > 
> > > This is int_pow(10).
> > > 
> > > > +	*freq_uhz = uhz;
> > > > +
> > > > +	return 0;
> > > > +}
> > 
> > The current implementation is kind of a stripped version of
> > __iio_str_to_fixpoint(). Would you prefer something like this, then?:
> 
> Do they have most of the parts in common? If so, why can't we use
> __iio_str_to_fixpoint() directly? Or why can't we slightly refactor
> that to give us the results we need here?

__iio_str_to_fixpoint() only parses "int" chunks, adf41513_parse_uhz
was modified to accomodate the u64 parsing removing unnecessary stuff.
I am preparing V5 to use simple_strtoull. Thanks for early review
and suggestions.

Kind regards,

Rodrigo Alencar

