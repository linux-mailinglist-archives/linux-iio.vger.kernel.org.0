Return-Path: <linux-iio+bounces-9409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E3972244
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 21:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C18F285585
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4765189BBE;
	Mon,  9 Sep 2024 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQCzjK0F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF05134C4;
	Mon,  9 Sep 2024 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908499; cv=none; b=GGQzxEjdjBfqQ+1U1EXIaEhQ3SHxcaiXrS139oUzraKsE85iCBem5XxZ8ndIogrUgvBTGUsXVyTfDuml1I3vLl+IgdDDg1pCu7GGhkJ9EFt0xU/wTkeTUxXoSB083tiIgQG0Gs76qdBLQpPGlCLfsZ0dWRDgLHpB471z40acuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908499; c=relaxed/simple;
	bh=ASY6fn5f+uR0NZzuJMwJ5v8KnACdFT6Kh/q/QEiENDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfi5s3TxJh244NWIsJlyhsJ5OFhimip/2eWaWoYjAPmQMSiuGheCp25auvDx4BbxQs9HsNJo50OxwXH0/d9OGUn0dI5C5qm63RDsbOqFBbTCpSuFyO6aLwy49eoQR6rzyVPtnDkF6AruwNjwKb77ON8Y10eHmRbvOr7jbKy/sOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQCzjK0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5815FC4CEC5;
	Mon,  9 Sep 2024 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725908499;
	bh=ASY6fn5f+uR0NZzuJMwJ5v8KnACdFT6Kh/q/QEiENDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MQCzjK0FNk7Pvdtzj0ceN8TejCl6EJyiJJpLxw73ib5yTPtLD2LXnXbIDTlxQ2r9F
	 h51d/ItgUiolSZFu4QIZ/d9t77OjUqmsN5jFAxmG5ygxjoTvauVAhlqmZHod18huqH
	 wMxsUMYKxL6Lse99i9VIOrQ50t6uaXCZKNarzCRy7wrVyQ7YgrBblBLEetsW4SqdNH
	 p9vHv9vPbn1p2z1f4I+bYtT9eEKIrTOYJ5BJYtKHXWLbIBlvCNC8oFqnxIONUzIxyO
	 X2C+9kmwU0TYv3AAISgzWi1wtquCJs6LH3jdnbu6rG4SvqymKr+VniAe7M4knsPWoG
	 /KYHBTpYg0YoA==
Date: Mon, 9 Sep 2024 20:01:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Subject: Re: [PATCH v2 0/3] iio: Introduce and use aligned_s64 type
Message-ID: <20240909200130.26bd56e3@jic23-huawei>
In-Reply-To: <Zt695hJRwiT2RSJT@smile.fi.intel.com>
References: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
	<20240907163752.2eb3be6a@jic23-huawei>
	<Zt695hJRwiT2RSJT@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 12:20:38 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Sep 07, 2024 at 04:37:52PM +0100, Jonathan Cameron wrote:
> > On Tue,  3 Sep 2024 20:59:03 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Instead of having open coded idea of aligned member, use
> > > a newly defined type like it's done in, e.g., u64 case.
> > > Update a few IIO drivers to show how to use it.
> > > 
> > > v2 (took only one year from v1, not bad!):  
> > :)
> > 
> > Applied with that tweak for patch 2 that you called out.  
> 
> Please, also do
> s/__aligned_s64/aligned_s64/
> in the commit message there.
done I think

> 
> > Will probably be next cycle though before these go upstream
> > (so think of this as queuing them up very early for 6.13 :)  
> 
> Sure, thanks!
> 


