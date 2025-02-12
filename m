Return-Path: <linux-iio+bounces-15448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81394A32968
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DD73A2988
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D721127F;
	Wed, 12 Feb 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHbna+ln"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F161F91F4;
	Wed, 12 Feb 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372495; cv=none; b=FAEsA7mRl0tMVGqRy4qUDTRy4HbBSqiC2+gVxj3F8KHFuSCBZQqmYQD3owrhW2AzfQBwe9Hyenb4bFaSTbJeRF2fUrenwbtQoIOR7Ot828bgR9S2ifGTa1i3dAwM/nySFLsjoZTedgHWR7yCiKEycb1DsJf0/rq081NXqBUpiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372495; c=relaxed/simple;
	bh=/1wYxzH2vvMBa+uXtOsAiSn9kflMv1QpIbMTlo7WA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCPh9wMQ70VPYgCvkwllB7QHs6CuCVVIsb78I4kAbb1SXvlfEmEnWAYqOE+65KsXFt4o5NucVtx2RZ7YkBMjcl7X7Wadid+HCVLBdkx0Ot6bUfbuCgMIHNpkWWvIBGYpwpNIilk0nB/BiKx7ZSu9H6MzSqXlZKa7XHhim7Oir74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHbna+ln; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c05cce598dso54812585a.3;
        Wed, 12 Feb 2025 07:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739372493; x=1739977293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blnGbtqtXovVHL5EjJvNJKTh2bWybf5Y0tbaYGJQ8As=;
        b=mHbna+lnkg4nLFcHgPxDpGz8qH6DUyhHO0+fBM9KuxVaeJrcuZHOD66wAgZlMQYsqZ
         HX+Ty2fxX6ls755UVRy14ROGXRxAo3IKAjHUanMJTk/shLzmneQ4mNhGFEIjh4CQ81gv
         WryghUZzawQNiklbFCGuGIZXZGeSAxhHFCXK6TYgmxeQinYCazWBY7us4Qm4OdP6E/c/
         qpPlfIIniBzIEOVW2Cahu/VnfnWj6p+N8vmC8gIOK0DSg6/NVmcsT4q6tWVV3z4N2RRv
         aC13xoe2mWxIDxeDJfhb+BCluFqw2UIpTmcq4qA7uEKXXppUjQTy/wG8B23HWZhCkjtU
         LJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739372493; x=1739977293;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blnGbtqtXovVHL5EjJvNJKTh2bWybf5Y0tbaYGJQ8As=;
        b=XxgDmga8Ylt1JE1FdJqo5JpjsSAkV/AZc1n7RX+MUnz2TxAMOl+SxqMfNstwhi61E0
         PoL7kghUWB6iBSqPBVfQgb5Wh4kI87rXN3lLku7mCGRtRJub0ojP8CHUXzoA990sj9QW
         jBYnJKRSQ6uj3nYVcOlLJIg7zHgp7wK9zPcF4X/yvbpi3vePbBQOFIC9WNORU3HFt0RT
         0dzq0B/QyBCYab03QLharYr3pkfmHfmcHmKruJ1ChPkvY8FWu3KJXWa0veXT+TKzxcJb
         92iXNcjeKKNx72n8TLeFwAEkFvIieoLKh0Bob7rDlDSSVE9iSsxHB0DNPfah7Cp9toJL
         hgcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU40KyZnI2Z6iptofq7yB70IkCnnuI2Pq8K+J3vEVeRzSrUMq0MTp0KQfyd0nUeGZYpOTGe3Rj0Yx6sevdn@vger.kernel.org, AJvYcCUDFM/4eYwAhb+5MXtrYXn4P4nXbRa1mSygy8gHrP/pdjP6HnMIpV7eMnLgE1dwBDJ7G53puLaMRvYf@vger.kernel.org, AJvYcCVuAcfZtvmiQltLcXhzldjBnjQrtMF98N2LU1dtuyspVEI2zQgkY9lJtoNfIWfOzAcCOyvQa8egctQf@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmvBTvN/S1vXwFzRdIexpfuPfPEfQFtTbfWum/p3Q67CJDNet
	Sok2ig3ceQ0GgNFLeKv+wP+TXvND9N0OqCnZHyN9kNxCUs6y4BW9
X-Gm-Gg: ASbGncs/5If11EFF/S+2U+7E/KeVcfT/cKYY48XD7zLlcS/e83Vx6QrjsAqy8i5aNV7
	kTnrZZJtHhy4iz2BDLGvFRiYdjaEi86psmrfCPFxkdyhFCQqm/aFauMpy/Z6iqkqUFuO66u2zK5
	lCiDBpA45YUBuf+l8iN36PvrOL+TmQqZxhvjetjfa4NNGxpIOjiONBn0OH3gUmRTLGx2QUeK0CX
	SFjUaGdEwcnggrx9hxCgT/uXTNMauyhdwDzgyDkBRnkSFzASOzEDXcw0IWlLSyS0zYJchlrJUcR
	pDsyxATL4XlS6ImMcxAzN3a0hsMI4FoBLv96
X-Google-Smtp-Source: AGHT+IHbgAAy7fTQpUT8vy3ySgyK22jiUtW2mszdjL4oFyCXI0tcIuWyBeyOVdyiDzDHkvBiJyafaA==
X-Received: by 2002:a05:620a:2b8f:b0:7c0:603a:4c4f with SMTP id af79cd13be357-7c06fca0cf9mr204432985a.9.1739372492469;
        Wed, 12 Feb 2025 07:01:32 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05fdd0d58sm443063785a.6.2025.02.12.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:01:31 -0800 (PST)
Date: Wed, 12 Feb 2025 12:01:27 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 05/17] dt-bindings: iio: adc: ad7768-1: document
 regulator provider property
Message-ID: <Z6y3x6WYCdTmXo3X@JSANTO12-L01.ad.analog.com>
Reply-To: 20250212-dazzling-glaring-shrimp-9530e6@krzk-bin.smtp.subspace.kernel.org
References: <20250211234717.1008325-1-Jonathan.Santos@analog.com>
 <20250212-dazzling-glaring-shrimp-9530e6@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-dazzling-glaring-shrimp-9530e6@krzk-bin>

On 02/12, Krzysztof Kozlowski wrote:
> On Tue, Feb 11, 2025 at 08:47:16PM -0300, Jonathan Santos wrote:
> > The AD7768-1 provides a buffered common-mode voltage output
> > on the VCM pin that can be used to bias analog input signals.
> > 
> > Add regulators property to enable the use of the VCM output,
> > referenced here as vcm_output, by any other device.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v3 Changes:
> > * VCM is now provided as a regulator within the device, instead of a 
> >   custom property.
> > 
> > v2 Changes:
> > * New patch in v2.
> 
> There is some mess in this posting. Nothing looks threaded and b4 does
> not see entire posting.
> 
> Sorry, don't make it complicated to us. Send proper submission - see
> numorous guides or submitting-patches - so reviewing will be
> straightforward.
> 
> Best regards,
> Krzysztof

I am sorry about that, my mistake. I missed the --thread option
when creating the patches. I will resend them properly. 

Apologies,
Jonathan S.

> 

