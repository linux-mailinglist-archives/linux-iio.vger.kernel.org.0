Return-Path: <linux-iio+bounces-3002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620018625D1
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC542831E6
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D547A7D;
	Sat, 24 Feb 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN37C2xI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E647F4A
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708788716; cv=none; b=dPvTfTA+LpdSDpJpelFi9FwBQeUUPjltgFRG89h1wsm6VWrJqiXXk/ST6hb9TiXXUG1PBvV1RblqF5YRk7IfCMSYlMmxr/3bNII5Pn2gIrsygj9amCKfvRUFOXHn2+4glV4NTRDCYt16mf1gtVZaPxmcF/UTPiDi2JUE/nyJzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708788716; c=relaxed/simple;
	bh=slaNKtEOrRjVHSbfHZQcIJozRNhRyQjouMlsmld3Nqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrbcrAFRFM+/fxa7XLA6BvUqp+8Q6EPofodU9eyqYJw8vg2oYW9MmJn0Y0hH6zYWVke6wxCGZ6Rpf8xYyJjgWwrlYdXTeqYCI2uBR1IR+0UKhQLMJ9xQpDm/kzhy4xRHB9J/0c0eLU1wnY3lDP4FrT0vlnzPyftV69md4BJXPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN37C2xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05880C433C7;
	Sat, 24 Feb 2024 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708788715;
	bh=slaNKtEOrRjVHSbfHZQcIJozRNhRyQjouMlsmld3Nqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nN37C2xIoRoHtszWDvdec3ldiRQp/6jgWMAv2vmMwP7hWkL4DPRfUU9BYrfuc/BjQ
	 vgNvEi4uss4eAqSGgfMwT2yNEgxrdcdQ2zKunPuH7sOczrGcQdSAkKVJ1PXlRqhDe/
	 ZfHTmcFm2m3hXYTNOfzHcfnxUAnZ8FH7GoE4BJ3DR6MD1yhpQiZIgFlHiJ/VsCRzbi
	 XdOYJwBE+mqniRREq4F0y3ce7KdH1W+kHwqHyDPDPQvcrC7HvzJ7drBAXLuf+s0gRt
	 sMfapE91+TP5WYNuxr30cBxmC6chkMukBngEg3tm26ev3eS/pC3i9AL9Pa8QaUbiYf
	 Cq3qPvWQvKevQ==
Date: Sat, 24 Feb 2024 15:31:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, Haibo
 Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>, Andreas Klinger
 <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] IIO: Convert DT specific handling over to fwnode
Message-ID: <20240224153019.2c7d5894@jic23-huawei>
In-Reply-To: <ZdNEXh7u1XdTv_4u@smile.fi.intel.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
	<ZdNEXh7u1XdTv_4u@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 14:06:54 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 18, 2024 at 05:27:23PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Andy pointed out that some of the drivers I was using as examples for
> > "[PATCH 0/8] of: automate of_node_put() - new approach to loops."
> > should be converted over to fwnode / property.h based handling anyway
> > at which point the device_for_each_child_node_scoped() handler could be
> > used instead. He correctly observed that it made more sense to make this
> > transition directly than to improve the device tree specific handling.
> > 
> > So this series does that and also some of the other drivers that were still
> > using device tree specific handling.  Note the rcar-adc remains DT
> > specific due to it directly handling maching against of_device_id tables.
> > It probably doesn't make sense to move that custom handling over to
> > fwnode.
> > 
> > I included one devm_ cleanup patch in here as I was touching the
> > driver anyway.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> Thank you!
> I have some minor comments, but in general I like this series,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied with various suggestions acted on (even if that is asking
Nuno to send a patch to tidy them up at a later date :)

Applied to the togreg branch of iio.git and pushed out as testing
to see what I missed.

Thanks,

Jonathan

