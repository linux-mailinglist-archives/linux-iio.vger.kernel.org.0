Return-Path: <linux-iio+bounces-16414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A736DA4FF06
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6903E3AD010
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194E245011;
	Wed,  5 Mar 2025 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DasqBcYz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B51FCF6D;
	Wed,  5 Mar 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179216; cv=none; b=SQkL6IW3fHO90clJ3zXX77zhwRIuDx+5wwMkRCwT7ySZd0fl0p64yZLQ5cPhihOrlihxPfhnaV+1KhQb6FbQCFXClAkHxB9TIyjByhqkqo0icLWLq7lJ3hcI4AJnFXqpJDsvRmdwJBnPDrQjEIGAmcpqH72ePBG+NDhxHFex5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179216; c=relaxed/simple;
	bh=fKa8NCmKVSUhAM+Bn1+AWNVfrf1xS55tuW0rpw0edRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLwDySn3nFF4+FdfIw/Ojky+wyhWUXMORqu8+h9v0FrwYOcLzTM2zj+SJ2wbr6RFgIdcUBVFpwaeUWbJjskYikM439+Fk/bA/HGOXqgNPwNPWzEInGlpfaedCpKZSBUMYFF0PSI68D95T+ouk+nHzF0PhqUfWOlhx4iTkpv+L1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DasqBcYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B15C4CEE2;
	Wed,  5 Mar 2025 12:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179214;
	bh=fKa8NCmKVSUhAM+Bn1+AWNVfrf1xS55tuW0rpw0edRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DasqBcYz89gn78pbEMAs4btgCMFbKxf8SALRyNGXHP+BVqvpmgXJBhKvgUxm8qDq5
	 HrK9qD/SgT/LLxqpnk7cAOJa8MFwbG3+J/WT1lxSjaX6I8qsDWunE0fZrM/O9MM7lY
	 LZwHBLUgkXncH3bnyN1vjFNt7O799Neu3uZQevA3j8lrrHJdYla9G62zGAVwc3vXWF
	 S6EX+9Ivlg9heY8tJDvyVvudh37cJBEKhe3vV7HpKnbeUIom/VCyARSZ1v3Bu61Zid
	 xpCQo704IgvfUwki5VOUPMzKaSMDQZ3tb0UCMbF7lwNUnBQNhHwDmZK2DgRjk3WBo3
	 pRvnwcePrzXwQ==
Date: Wed, 5 Mar 2025 12:53:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Esteban Blanc <eblanc@baylibre.com>,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [linux-next:master 3206/7719] drivers/iio/adc/ad4030.c:378
 ad4030_get_chan_scale() error: 'scan_type' dereferencing possible ERR_PTR()
Message-ID: <20250305125322.4c753886@jic23-huawei>
In-Reply-To: <03ab29ed-f96f-467e-b5bd-4ccfea780191@stanley.mountain>
References: <03ab29ed-f96f-467e-b5bd-4ccfea780191@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 09:22:43 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
> commit: 949abd1ca5a4342d9fb8c774035222e65dd1cfe4 [3206/7719] iio: adc: ad4030: add averaging support
> config: openrisc-randconfig-r071-20250304 (https://download.01.org/0day-ci/archive/20250304/202503040954.n6MhjSsV-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 14.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202503040954.n6MhjSsV-lkp@intel.com/
> 
> smatch warnings:
> drivers/iio/adc/ad4030.c:378 ad4030_get_chan_scale() error: 'scan_type' dereferencing possible ERR_PTR()
> 
> vim +/scan_type +378 drivers/iio/adc/ad4030.c
> 
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  366  static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  367  				 struct iio_chan_spec const *chan,
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  368  				 int *val,
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  369  				 int *val2)
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  370  {
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  371  	struct ad4030_state *st = iio_priv(indio_dev);
> 949abd1ca5a4342 Esteban Blanc 2025-02-14  372  	const struct iio_scan_type *scan_type;
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  373  
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  374  	if (chan->differential) {
> 949abd1ca5a4342 Esteban Blanc 2025-02-14  375  		scan_type = iio_get_current_scan_type(indio_dev,
> 949abd1ca5a4342 Esteban Blanc 2025-02-14  376  						      st->chip->channels);
> 
> 
> Do we need an if (IS_ERR(scan_type)) return;?
No but it is a bit of chase to establish why not so I think it would be sensible from
the point of view of resilience and readability to add that check.

That function can fail with an ERR_PTR() if either the callback it uses returns an error
(the one in this driver never does) or the value is out of range (I assume with only 2 values
we manage to avoid that too though I didn't actually check).

It's not a high performance path to read this so the check would be a good addition but
I'm not going to rush in the change.  Esteban, would you mind spinning a patch to add
the check if you agree with the reasoning?

+CC linux-iio for wider visibility.

Thanks,

Jonathan

> 
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  377  		*val = (st->vref_uv * 2) / MILLI;
> 949abd1ca5a4342 Esteban Blanc 2025-02-14 @378  		*val2 = scan_type->realbits;
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  379  		return IIO_VAL_FRACTIONAL_LOG2;
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  380  	}
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  381  
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  382  	*val = st->vref_uv / MILLI;
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  383  	*val2 = chan->scan_type.realbits;
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  384  	return IIO_VAL_FRACTIONAL_LOG2;
> 0cb8b324852f3e3 Esteban Blanc 2025-02-14  385  }
> 



