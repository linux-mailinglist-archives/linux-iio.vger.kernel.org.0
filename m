Return-Path: <linux-iio+bounces-14525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3204A18BB1
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 07:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC853A349A
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 06:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C74190486;
	Wed, 22 Jan 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6hKWMFx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D52EAE6
	for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526006; cv=none; b=eLWdu2S0KSDs2ZwKjdYTMe2q519YgRjQ44f+eayRWXv9HqqmHc/lR9Wwik65fb80W27U/B/WXkMXpiQvZu+I4gGsDbd43O6Bttvmy7LaHF1GMQP29ZkfSSXbclRPCAeNQXbBnNPEQdhWmahQY+XlwDLwrlE4Xyv8CuXK4k67XJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526006; c=relaxed/simple;
	bh=Ey9EpO8/Au2zsBU+aaQAo642hPbjS5nK4Kqu2rvOzBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw1Gh7897NTKc2CIp+rRAuOVEl4sIJDzAufjWnh7h2NkAc4jvmSzuXgjYf57THksXdIdkGVtKDQW6CgFYenUt564nQUCQ4HO7DFYPbxxz9HYI48pkiCCMSbTeyFJuGRXk2UAeNRphoYBhEQScRbFbT2GIEwnVvuiJaeuGLFxlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6hKWMFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF1CC4CED6;
	Wed, 22 Jan 2025 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737526005;
	bh=Ey9EpO8/Au2zsBU+aaQAo642hPbjS5nK4Kqu2rvOzBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6hKWMFx1/x1C4dj7CUDmYdlbOGj6A9u6Pxf0IzRSv/h4MPDcvmBrxjISPpHg1Te5
	 Ecr5Fm91ID5fextk+Bjh8uX5RkGJO9oNQA44SnQ7Gsfu+pqwFMY4BfmzmgDsEJRkN2
	 O4KjuT8c7I46HR7mLF8xl6Z2wTsvuPFZMEXHaDlAmseFdD1vAHcgcWka+AYbSAylUJ
	 czcTIUNKDGQmY6G7qH0KEJ8hatMdGldDabdeg64KAH2/I9O7sKiug4pW4rcAKT/P0n
	 3h4FzJubmLLUTI+7KfH4LMf29SVUgU099pzK9OTAjnN/MRIbfT3O5UHsxWMB8ImEK6
	 IeOajQbClRXnQ==
Date: Wed, 22 Jan 2025 06:06:42 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Trace EC sensors command
Message-ID: <Z5CK8ltaZM6Z85Wi@google.com>
References: <20250117230136.2237346-1-gwendal@chromium.org>
 <20250118162748.6badf0ab@jic23-huawei>
 <Z44OaSCdFeCygJLQ@google.com>
 <CAPUE2utb_L0rhjN6BdY2WEOX3i48DiTAkytY=WLgjbymrZc6Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUE2utb_L0rhjN6BdY2WEOX3i48DiTAkytY=WLgjbymrZc6Tw@mail.gmail.com>

On Tue, Jan 21, 2025 at 01:54:31PM -0800, Gwendal Grignou wrote:
> On Mon, Jan 20, 2025 at 12:50 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Sat, Jan 18, 2025 at 04:33:52PM +0000, Jonathan Cameron wrote:
> > > I briefly applied this, but...
> > >
> > > [jic23@jic23-huawei iio]$ make LOCALVERSION= W=1 -j12  C=1
> > > mkdir -p /home/jic23/src/kernel/iio/tools/objtool && make O=/home/jic23/src/kernel/iio subdir=tools/objtool --no-print-directory -C objtool
> > >   CALL    scripts/checksyscalls.sh
> > >   INSTALL libsubcmd_headers
> > >   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.o
> > >   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.o
> > > In file included from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h:56,
> > >                  from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c:32:
> > > ./include/trace/define_trace.h:106:42: fatal error: ./cros_ec_sensors_trace.h: No such file or directory
> > >   106 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > >       |                                          ^
> > >
> > > Despite dealing with trace points a lot in the day job
> > > I still find them hard to actually add to a subsystem because
> > > of fun things like this one.
> I reproduced this error on a fresh kernel source tree. I suspect an
> issue with sparse, as other trace.c files use __CHECKER__ macros. For
> instance `drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c`:
> 
>  10 /* sparse doesn't like tracepoint macros */
>  11 #ifndef __CHECKER__
> ...

I still can't reproduce the error by using a just-cloned kernel source tree
with C=1.  Could you provide some more details about your steps?  I'm
wondering about which steps I may miss.

