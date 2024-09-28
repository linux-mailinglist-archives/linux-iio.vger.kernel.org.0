Return-Path: <linux-iio+bounces-9809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB53988F92
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432841C20D2C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E6818870E;
	Sat, 28 Sep 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIqhBVFA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2917C9FA;
	Sat, 28 Sep 2024 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727532851; cv=none; b=PygifmEgCPohihhn5iHw+SHEW2UcNtdE9ZSK1nSQlt5oBI7yDKnAqQ8pSXNWOCtEngUeanASmxr9PRTxsPOxuYAuL78P3O54UwuBornJ8PhgtSja0u5ASxoQnCRqTC2AWomcdJcS7rZI2OUDK88OfBVzbjYxx5bCdjOsVGdkbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727532851; c=relaxed/simple;
	bh=ErgmS0qH1M7/ozTiDtG+anlSeTKB3BQPSYxTtDg4HTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTbJdJiZLyFAWGiSE4g1HzkHkSXo8xnGUZ6jAv+6wuJp/fJ8tY6r9jEzKHApwH1ynLZioXtNiBspHvbVVJx9xWQkp4mYq8s+DUibypr1Tz0DQTGDqS1TCelV+hg7OVs+VLCPpbGYNL6W3vtRfX4CgsUKq+FMR0QHQ/YjW7+/udA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIqhBVFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A9EC4CEC3;
	Sat, 28 Sep 2024 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727532850;
	bh=ErgmS0qH1M7/ozTiDtG+anlSeTKB3BQPSYxTtDg4HTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TIqhBVFAJLcjosHWIxaP1+YYy3rDLVJsDO/eEZXEmcccLouo57BFN8ZBtoMX/sZPQ
	 bMLhBEFAvukX5TI+WeX7+cDcUcZ8hK8wbBdCezj/UDjHpZ2lf/zjywqZO1lIGcu/49
	 64Qpg0CvsY/m52nUpdB9CnIbTOLd6N86k7KPI+Qe1fqvjqKbUNIJDT23FQwyU+5tCb
	 T12RJFYJhmIGqwHYiKUeaArIh+Y7ICF8eHArks75w9Or93eFXvMJ/E5Otyg8I/HqFW
	 AO30C6odnBs6Pp6+YuORqQfc1/8x7zJCSTfQre4yRmH/Z29TxXhIDJxLPaE99iAwH1
	 CvuphGY6Z2DjQ==
Date: Sat, 28 Sep 2024 15:13:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Conor Dooley <conor+dt@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt1@gmail.com>, Dimitri Fedrau
 <dima.fedrau@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240928151358.220e3edf@jic23-huawei>
In-Reply-To: <202409210849.cRodncgA-lkp@intel.com>
References: <20240912095435.18639-3-Mariel.Tinaco@analog.com>
	<202409210849.cRodncgA-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Sep 2024 09:11:12 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Mariel,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on fec496684388685647652ab4213454fbabdab099]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mariel-Tinaco/dt-bindings-iio-dac-add-docs-for-ad8460/20240912-175718
> base:   fec496684388685647652ab4213454fbabdab099
> patch link:    https://lore.kernel.org/r/20240912095435.18639-3-Mariel.Tinaco%40analog.com
> patch subject: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
> config: sparc-randconfig-r071-20240921 (https://download.01.org/0day-ci/archive/20240921/202409210849.cRodncgA-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 14.1.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409210849.cRodncgA-lkp@intel.com/
> 
> smatch warnings:
> drivers/iio/dac/ad8460.c:545 ad8460_write_event_value() warn: unsigned 'fault' is never less than zero.
> drivers/iio/dac/ad8460.c:545 ad8460_write_event_value() warn: error code type promoted to positive: 'fault'
> drivers/iio/dac/ad8460.c:567 ad8460_read_event_value() warn: unsigned 'fault' is never less than zero.
> drivers/iio/dac/ad8460.c:567 ad8460_read_event_value() warn: error code type promoted to positive: 'fault'
> drivers/iio/dac/ad8460.c:585 ad8460_write_event_config() warn: unsigned 'fault' is never less than zero.
> drivers/iio/dac/ad8460.c:585 ad8460_write_event_config() warn: error code type promoted to positive: 'fault'
> drivers/iio/dac/ad8460.c:605 ad8460_read_event_config() warn: unsigned 'fault' is never less than zero.
> drivers/iio/dac/ad8460.c:605 ad8460_read_event_config() warn: error code type promoted to positive: 'fault'
> 
> vim +/fault +545 drivers/iio/dac/ad8460.c
> 
>    528	
>    529	static int ad8460_write_event_value(struct iio_dev *indio_dev,
>    530					    const struct iio_chan_spec *chan,
>    531					    enum iio_event_type type,
>    532					    enum iio_event_direction dir,
>    533					    enum iio_event_info info, int val, int val2)
>    534	{
>    535		struct ad8460_state *state = iio_priv(indio_dev);
>    536		unsigned int fault;
I fixed this up by making all the local fault variables int instead.

Jonathan

>    537	
>    538		if (type != IIO_EV_TYPE_THRESH)
>    539			return -EINVAL;
>    540	
>    541		if (info != IIO_EV_INFO_VALUE)
>    542			return -EINVAL;
>    543	
>    544		fault = ad8460_select_fault_type(chan->type, dir);
>  > 545		if (fault < 0)  
>    546			return fault;
>    547	
>    548		return ad8460_set_fault_threshold(state, fault, val);
>    549	}
>    550	
>    551	static int ad8460_read_event_value(struct iio_dev *indio_dev,
>    552					   const struct iio_chan_spec *chan,
>    553					   enum iio_event_type type,
>    554					   enum iio_event_direction dir,
>    555					   enum iio_event_info info, int *val, int *val2)
>    556	{
>    557		struct ad8460_state *state = iio_priv(indio_dev);
>    558		unsigned int fault;
>    559	
>    560		if (type != IIO_EV_TYPE_THRESH)
>    561			return -EINVAL;
>    562	
>    563		if (info != IIO_EV_INFO_VALUE)
>    564			return -EINVAL;
>    565	
>    566		fault = ad8460_select_fault_type(chan->type, dir);
>  > 567		if (fault < 0)  
>    568			return fault;
>    569	
>    570		return ad8460_get_fault_threshold(state, fault, val);
>    571	}
>    572	
>    573	static int ad8460_write_event_config(struct iio_dev *indio_dev,
>    574					     const struct iio_chan_spec *chan,
>    575					     enum iio_event_type type,
>    576					     enum iio_event_direction dir, int val)
>    577	{
>    578		struct ad8460_state *state = iio_priv(indio_dev);
>    579		unsigned int fault;
>    580	
>    581		if (type != IIO_EV_TYPE_THRESH)
>    582			return -EINVAL;
>    583	
>    584		fault = ad8460_select_fault_type(chan->type, dir);
>  > 585		if (fault < 0)  
>    586			return fault;
>    587	
>    588		return ad8460_set_fault_threshold_en(state, fault, val);
>    589	}
>    590	
>    591	static int ad8460_read_event_config(struct iio_dev *indio_dev,
>    592					    const struct iio_chan_spec *chan,
>    593					    enum iio_event_type type,
>    594					    enum iio_event_direction dir)
>    595	{
>    596		struct ad8460_state *state = iio_priv(indio_dev);
>    597		unsigned int fault;
>    598		bool en;
>    599		int ret;
>    600	
>    601		if (type != IIO_EV_TYPE_THRESH)
>    602			return -EINVAL;
>    603	
>    604		fault = ad8460_select_fault_type(chan->type, dir);
>  > 605		if (fault < 0)  
>    606			return fault;
>    607	
>    608		ret = ad8460_get_fault_threshold_en(state, fault, &en);
>    609		if (ret)
>    610			return ret;
>    611	
>    612		return en;
>    613	}
>    614	
> 


