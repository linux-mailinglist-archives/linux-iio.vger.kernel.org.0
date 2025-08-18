Return-Path: <linux-iio+bounces-22934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E5BB2AFC6
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5FE17CB6B
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A42D24B0;
	Mon, 18 Aug 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cgn3c1c+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743B2D24A8
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539527; cv=none; b=Af1U7bho74U42cAaNlb86g4VBxuQWX2x7BVNndhUhgfaqi14897EnoEEYfZFRVtxD8Z4qrpW55szJT5+4zKI+4/YqbjDNnHN2pJXIDW1ec4nAuLwfot/mLJl5AGuXkBnJ8gSxuU837syGOI4cWjKi6B6ZhOvkC8+kiqMCxi7EL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539527; c=relaxed/simple;
	bh=ISYfXVSerFWi+GkqW+zdxgB/O5nROE+nAivoL33COhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdOtbAgv3lm7OLffp//86dO4tBgrxoD+73qqcQA1yVbRavgy0j6vs0axgONR+NaQMR2452j8oZBKHDy9bYhD9FKTE9xOl9M9qdUPSUNzFHkjQYG/gaGQrtNeCfqEGjUBjDmgteotm6HFQ43FuEeNsd512T4GkzS/ZlGhFsAj/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cgn3c1c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A249C4CEEB;
	Mon, 18 Aug 2025 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755539527;
	bh=ISYfXVSerFWi+GkqW+zdxgB/O5nROE+nAivoL33COhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cgn3c1c+y5+/xdlY7YO0JWIvehHrvyrs08BU5jTpwKfhBN0dmBQZWscwFVlG1Jz2o
	 LlgTrxI3mxAUvx03DBej/vBSS23TNMKUpq2/NZOTXwxyHC7J6qWIMlM8FHLIP4X7dc
	 46ouUq836cll02geEWfizIHfvgZpIvb0t1Kd6/5LWLT38XWT1D5Qmk2Y6MUgWILmTH
	 +8cE5Iczg1uqsxjstOUr1rQj48oxfFbU3nmf9nH81YySzAc0HI9q+dYVNXY/GQk7fl
	 qDt3KPXfBdYd+Pst6TQwgJbq5JsUYvpDa0EBTlX/I020uMk5ywiG2smBD44O74dDpe
	 Dc5hPf+K7Yarg==
Date: Mon, 18 Aug 2025 18:52:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ASSI <Stromeko@nexgo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH v2 8/9] iio: pressure: bmp280: implement
 sampling_frequency calculation for BMx280
Message-ID: <20250818185200.0367f873@jic23-huawei>
In-Reply-To: <87ldnhonha.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-9-Achim.Gratz@Stromeko.DE>
	<20250817180421.1d9edb28@jic23-huawei>
	<87ldnhonha.fsf@Gerda.invalid>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 19:40:49 +0200
ASSI <Stromeko@nexgo.de> wrote:

> Jonathan Cameron writes:
> > This driver seems to have the infrastructure for providing available attributes
> > but is it hooked up?  I can't find where info_mask_*_available is set for
> > any of the channels.  Maybe I'm missing something, but if not would be
> > good to fix that as part of your improvements.  
> 
> I think not, there isn't any *_available sysfs files I can see.  Where
> can I look up examples of how to enable these?
Any driver that sets both iio_dev.info_mask_*_available 
(separate, shared_by_type etc)
and the read_avail callback. 

There are two ways to represent data, either a list in which case return
IIO_AVAIL_LIST from the callback and provide a suitable array of value / value pairs
or a range with start, step, stop in which case return IIO_AVAIL_RANGE.

Seems like someone half implemented it in this driver but then stopped.
Not something I tend to look for when reviewing, but I guess I should add that
to my mental list of things to check.

Jonathan

> 
> 
> Regards,
> Achim.


