Return-Path: <linux-iio+bounces-12706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9AE9D9DA7
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D0B1662E7
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE381DE2A5;
	Tue, 26 Nov 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjXl7Fiq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385D1D63E8;
	Tue, 26 Nov 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647140; cv=none; b=mQ2SK4FdAR8HMgNXlfrftxdXj5z4zAiKmZV9HrX4HXkVnJlKpXwaCPLBX5+ys+CZ6FTBkGwIW0N0rMqHr8jRGKQ8Km8dnlmMmRJWv+az6Pp+sY8h2GDmyJQ0KxLbgoDbKljqA3qOee3hn2s3SxkiBchTaR0IAol4o1Yf4rmSyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647140; c=relaxed/simple;
	bh=5vy3ETKoRBehBMtsbIQQeHicXBlDE6OcnPhy+O5N65U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZ4Is65zYf5boTqQlzyOSdRxuythDGZw+aSRkpMoBW0iLCqMlPuRPc4dPxEDLARZSGdL3cviDmwZ7bijj5ltb8yUthYbpgCK71zaNOvkeIbmyMXtvZVc8nd2CWlKeyKgdBbIQx0i+rzYS7w7rom/z02y6Gzj/ypgKae+nK21FzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjXl7Fiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E70C4CECF;
	Tue, 26 Nov 2024 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732647139;
	bh=5vy3ETKoRBehBMtsbIQQeHicXBlDE6OcnPhy+O5N65U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OjXl7FiqYgkanSgMqRUgFZWhsrDscNA+htu1e6t6nN5DLEX8UEG9SzSZLtvQ8AlBY
	 qhQOSCdfKQopnT/bOHU3QEVGQAypBhpBlm0e6H8tzl5thIJ+OmWlElQosPKHmwVtMs
	 3rHnbVnliHXut4vSM647M9wItEwWOr/4WBUiXjI1Ac7CDFR705nrICK5+Za3SwxOwf
	 nhobSZ8YJ89mAmp1eBobO+6noWEmR5zYir8ec++WW3aYCkRnBs59rypJNxwI3u84iI
	 taute58duUWn4j/cb7N48EqILhLC+sBnjXuGjN7X5/1RP5dIb3Udxa6Uni8XDDziHo
	 UV4r33tyZjpWA==
Date: Tue, 26 Nov 2024 18:52:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Lars-Peter Clausen
 <lars@metafoo.de>, Antoni Pokusinski <apokusinski01@gmail.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH 02/11] iio: adc: ti-ads1119: fix information leak in
 triggered buffer
Message-ID: <20241126185211.385f82c4@jic23-huawei>
In-Reply-To: <59a4b096-101b-419d-8a19-1063d759b4e2@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
	<20241126085958.GA13577@francesco-nb>
	<59a4b096-101b-419d-8a19-1063d759b4e2@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 10:46:37 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 26/11/2024 09:59, Francesco Dolcini wrote:
> > On Mon, Nov 25, 2024 at 10:16:10PM +0100, Javier Carrasco wrote:  
> >> The 'scan' local struct is used to push data to user space from a
> >> triggered buffer, but it has a hole between the sample (unsigned int)
> >> and the timestamp. This hole is never initialized.
> >>
> >> Initialize the struct to zero before using it to avoid pushing
> >> uninitialized information to userspace.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> ---
> >>  drivers/iio/adc/ti-ads1119.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> >> index e9d9d4d46d38..2615a275acb3 100644
> >> --- a/drivers/iio/adc/ti-ads1119.c
> >> +++ b/drivers/iio/adc/ti-ads1119.c
> >> @@ -506,6 +506,8 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
> >>  	unsigned int index;
> >>  	int ret;
> >>  
> >> +	memset(&scan, 0, sizeof(scan));  
> > 
> > Did you consider adding a reserved field after sample and just
> > initializing that one to zero?
> > 
> > It seems a trivial optimization not adding much value, but I thought about
> > it, so I'd like to be sure you considered it.
> > 
> > In any case, the change is fine.
> > 
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Thanks,
> > Francesco
> >   
> 
> Hi Francesco, thanks for your review.
> 
> In this particular case where unsigned int is used for the sample, the
> padding would _in theory_ depend on the architecture. The size of the
> unsigned int is usually 4 bytes, but the standard only specifies that it
> must be able to contain values in the [0, 65535] range i.e. 2 bytes.
> That is indeed theory, and I don't know if there is a real case where a
> new version of Linux is able to run on an architecture that uses 2 bytes
> for an int. I guess there is not, but better safe than sorry.
Using an unsigned int here is a bug as well as we should present consistent
formatted data whatever the architecture.
> 
> We could be more specific with u32 for the sample and then add the
> reserved field, but I would still prefer a memset() for this small
> struct. Adding and initializing a reserved field looks a bit artificial
> to me, especially for such marginal gains.
Issue with reserved fields is we would have to be very very careful to spot them
all.  A memset avoids that care being needed.

Jonathan

> 
> Moreover, the common practice (at least in IIO)is a plain memset() to
> initialize struct holes, and such common patterns are easier to maintain :)
> 
> Best regards,
> Javier Carrasco


