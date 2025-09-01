Return-Path: <linux-iio+bounces-23578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F037B3E3C9
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBDC1A83C19
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF724DCF9;
	Mon,  1 Sep 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Awce9pZ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61222FA0FF
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731436; cv=none; b=sZAx7yJ7JAN4aqGpCqaEtpWBleYHrC4rQvh+3lMg1/8WcYIIDXQF741ViDb+JuyHOAbRt34OtvW9BwRBIuYkOjyPJuvoenGdbEF2TYMmR0rh3gWsAt03YT2y6Y5iXQqLkA8cq6cNuhhibedz8UnwgbZqll6WRqZkolm+MEXgSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731436; c=relaxed/simple;
	bh=LA2Cde+xwNLHGVNxK+nOoJLLEK4E0j9VLsGVDb7DoCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDDQk6CCCt8htTGXTnj4RqxtgSI2F3B55lQr5JOwE+neKw4TxCJ1vaBQFoC+g3e1NS7+3NsOXZGqSzwBAhp+VH3OzZC3lOA876AuxBRtoI+Y3BDWSbpq2/jIdmW8Kr+sCoGYwfpldUkg2690LPArpKbI4HLBzrc3w6f9aSd04fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Awce9pZ6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so10358965e9.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2025 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756731433; x=1757336233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6CcZZgmXTEgXi67UOd8flewdG478TxsuC7DDhDV9EhI=;
        b=Awce9pZ6KKPpqfDStm6grTv6TraGZ2p8PretycNa9sV5G3eSgzJvqpCJcm8gV4EWSb
         D5toCoTaOa8VA6BgR0rFcZ5O3B9qFcROxZaOdj7gG9KYPw20eidJ3E3WYqsKcXyAWMpW
         7gM0nrHH0z+sVCJ3we8YL+x3i00B41E8hnVJ3c0R0J1Wh7vjKIh54G9yUl2s5C6rxy5f
         raqPU5Rg0x95su+ppJz8/HXtucfzq7cfw1S/8URMIcgPgOgFgh8fH8txVPpIgPjKzY82
         BgdVu6ALnGakh3TLcMPeozZ9SQg6/HpikTF1EP5P3UEMwUWbr6iqziC6DWj2tMd89Vv9
         OfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731433; x=1757336233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CcZZgmXTEgXi67UOd8flewdG478TxsuC7DDhDV9EhI=;
        b=PXrL4WOSvAuWuMFRxb7byIxbT/srRDqxGNWK+624S+tkAWYdNdoVzZ0TUKhC2W0/4C
         PbDyCXguBm4kY/c4HanSozCX0Fo4XXcedPyh+q+kmud0Q71h77pqwuZAbum1/OAiycl1
         WTMzYfJeI1/Mal5CAcE8MW1jrCy2MeAHSkpgmB/f1zW1Ug0KjMOhHRoMJQE/8MT/ku55
         0uAJli3XQEblxYaRIbtR2Lvm3SwCeEXxM0jiCkP+fZCR1UcxyHUMQw4CsOMsYI+ny68I
         8ZQFDBeV0ky5S4zrOqp8NvwUdOEhpnbMxqXoONOMdkTsrf69AromUeRvBbE+GMeQBvYG
         oW4A==
X-Forwarded-Encrypted: i=1; AJvYcCV/8eo3fBqhpbFyo0W3JhIAlZGZZnR+szKQ12WAtfIKtDiGnxn9N5KcnS8O0aSiVsbilxKElfZLLPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSK01POOCcYd0L5Iea3aP6ieek8I5U+L33tDIkNc5pbpZW91nz
	o52GIEGxcf7teIL1XkVEAcYZRgRRkW5HMFruEXQAIgl2xd0gLSNYQOIXHxgm6LqI3TY=
X-Gm-Gg: ASbGncvsiJuq74w3A2M9TH+tbFt5GGzCra3HNJ6VOrbr+rVz32mdLVpNQB0nGOBltsc
	nlL08xCGqQM2l1jx2VhtPGRMSeY8QvOPp1fTesHJpJmDNgIMQFYCuytp1rElrsz61oRai0bONxD
	11Gd2jThls2yOE72U+x6EC0efWHwAXCy3vOQZjvsOuxRaSfabsuPHq0dcNlHwsP9pkUn8HSw5dd
	c88z57OXOP7+SpSMriqGpGVCX3uFZOzq/Y7Aahyinor3iu1sXWP1K9bcRQlySI43qMPmCWJCkvU
	V3wCsZSf9WI4xdxdvRWnMkd5axZOft1krF95Xzw7w6QkSr7i58/3qyW/fsjfqalRLe9GLJ050Xg
	SKtCCjBvYohoixd4fNPuleVEwNNtAvjKQCKLuAg==
X-Google-Smtp-Source: AGHT+IFGr7/8/ZT9kzcrMvxG5Dy4K+Li2LIxqb9UOtAyrwkmZc8eBIyFR7BB1vat/tRDTqmJKwd0jQ==
X-Received: by 2002:a05:6000:4013:b0:3b7:94a2:87e8 with SMTP id ffacd0b85a97d-3d1dcb75006mr6117687f8f.18.1756731432991;
        Mon, 01 Sep 2025 05:57:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b87b38fcfsm51362895e9.0.2025.09.01.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:57:12 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:57:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <aLWYJKSDjNajmAlh@stanley.mountain>
References: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>
 <aLV0LBxD0KIHPSmo@stanley.mountain>
 <aLWULUIcYEz3N-Rx@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLWULUIcYEz3N-Rx@smile.fi.intel.com>

On Mon, Sep 01, 2025 at 03:40:13PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 01, 2025 at 01:23:40PM +0300, Dan Carpenter wrote:
> > On Mon, Sep 01, 2025 at 10:24:45AM +0330, Mohammad Amin Hosseini wrote:
> > > From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> > > 
> > > The ad7816 driver was accessing SPI and GPIO lines without
> > > synchronization, which could lead to race conditions when accessed
> > > concurrently from multiple contexts. This might result in corrupted
> > > readings or inconsistent GPIO states.
> > > 
> > > Introduce an io_lock mutex in the driver structure to serialize:
> > > - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> > > - GPIO pin toggling sequences
> > > - Updates to device state via sysfs store functions (mode, channel, oti)
> > > 
> > > The mutex ensures proper mutual exclusion and prevents race
> > > conditions under concurrent access.
> 
> ...
> 
> > > +	mutex_lock(&chip->io_lock);
> > >  	chip->channel_id = data;
> > > +	mutex_unlock(&chip->io_lock);
> 
> > > +	mutex_lock(&chip->io_lock);
> > >  	chip->oti_data[chip->channel_id] = data;
> > > +	mutex_unlock(&chip->io_lock);
> 
> > I'm not really knowledgeable to review the others, if they are
> > required or how the locking is supposed to work.  But these aren't
> > correct because we're only locking around the writers and not the
> > readers so it could still race.
> 
> Readers are in spi_write(), or what do you imply by this comment?
> I.o.w. I do not see the issue with the idea of locking and how it's
> done (I haven't checked all of the details, though).

Sorry, I meant we don't have locking in ad7816_show_oti(), for example.

regards,
dan carpenter

