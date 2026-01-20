Return-Path: <linux-iio+bounces-28047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ECED3C589
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 11:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28C3A7079D2
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B13D2FE5;
	Tue, 20 Jan 2026 09:47:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7213C1FD1;
	Tue, 20 Jan 2026 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902460; cv=none; b=KR796aXjDO714T48BGgb8WpYnVaGunK+2zRTtXf9VEZmoUcK4JkMoIrDHjU+Xd9dTz9+cFZmSh0hoOeu1KtST2EfpjBrRIarDiAyQUzFotUrI0T3XGvfUDa1LR37vpqRdy+fEGJs0RFubh2WEFVd8W4j5T8tqK3sw5EwB6zU+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902460; c=relaxed/simple;
	bh=8h628bA49V/gtfQ+WE7IDpVvvMuRfgkzaZLm45T7r+k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FC8Fh9qW/EVt7qkUB0LB3ZoQvFBac77B5kkYpf+X/5fwXdCNIRiUILhci1UcDJDBd5sh3oUEXgOZ3JyhJV1kqRtecnJnnCsugo0L/EtAtFrQZMhuX8BW+1swSoO57/iy2UAnx0l7fPa5odZcljA6jnseqXHZYTH5Pk3tzoEUfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwMtQ1GPlzJ46fv;
	Tue, 20 Jan 2026 17:47:10 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BACF40539;
	Tue, 20 Jan 2026 17:47:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Jan
 2026 09:47:33 +0000
Date: Tue, 20 Jan 2026 09:47:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mark Brown <broonie@kernel.org>
CC: Jorge Marques <jorge.marques@analog.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the iio tree
Message-ID: <20260120094732.00006a84@huawei.com>
In-Reply-To: <aW6EGSEYxm2iTXXD@sirena.org.uk>
References: <aW6EGSEYxm2iTXXD@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 19 Jan 2026 19:20:57 +0000
Mark Brown <broonie@kernel.org> wrote:

> Hi all,
> 
> After merging the iio tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
Hi Mark,

Seems we raced last night. I pushed the fix about 5 minutes after
you sent this :)

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=a1e5b99bc7c6b6a1c3c3b79a8fba1dc16ea160fa

Sasha gave a heads up that this was coming yesterday.

There are a couple more i3c related fixes but the more significant of those
issues probably doesn't turn up in next builds because the real fix
is in the i3c tree and I'm just papering over being unable to cleanly
pull that into IIO tree.

https://lore.kernel.org/all/20260119221736.804825-1-jic23@kernel.org/

Jonathan

> 
> /tmp/next/build/drivers/iio/adc/ad4062.c: In function 'ad4062_set_operation_mode':
> /tmp/next/build/drivers/iio/adc/ad4062.c:471:24: error: variable 'xfer_trigger' has initializer but incomplete type
>   471 |                 struct i3c_priv_xfer xfer_trigger = {
>       |                        ^~~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:472:26: error: 'struct i3c_priv_xfer' has no member named 'data'
>   472 |                         .data.out = &st->conv_addr,
>       |                          ^~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:472:37: error: excess elements in struct initializer [-Werror]
>   472 |                         .data.out = &st->conv_addr,
>       |                                     ^
> /tmp/next/build/drivers/iio/adc/ad4062.c:472:37: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:473:26: error: 'struct i3c_priv_xfer' has no member named 'len'
>   473 |                         .len = sizeof(st->conv_addr),
>       |                          ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:473:32: error: excess elements in struct initializer [-Werror]
>   473 |                         .len = sizeof(st->conv_addr),
>       |                                ^~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:473:32: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:474:26: error: 'struct i3c_priv_xfer' has no member named 'rnw'
>   474 |                         .rnw = false,
>       |                          ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:474:32: error: excess elements in struct initializer [-Werror]
>   474 |                         .rnw = false,
>       |                                ^~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:474:32: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:471:38: error: storage size of 'xfer_trigger' isn't known
>   471 |                 struct i3c_priv_xfer xfer_trigger = {
>       |                                      ^~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:477:24: error: implicit declaration of function 'i3c_device_do_priv_xfers'; did you mean 'i3c_device_do_xfers'? [-Wimplicit-function-declaration]
>   477 |                 return i3c_device_do_priv_xfers(st->i3cdev, &xfer_trigger, 1);
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>       |                        i3c_device_do_xfers
> /tmp/next/build/drivers/iio/adc/ad4062.c:471:38: error: unused variable 'xfer_trigger' [-Werror=unused-variable]
>   471 |                 struct i3c_priv_xfer xfer_trigger = {
>       |                                      ^~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c: In function 'ad4062_trigger_work':
> /tmp/next/build/drivers/iio/adc/ad4062.c:610:16: error: variable 'xfer_sample' has initializer but incomplete type
>   610 |         struct i3c_priv_xfer xfer_sample = {
>       |                ^~~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:611:18: error: 'struct i3c_priv_xfer' has no member named 'data'
>   611 |                 .data.in = &st->buf.be32,
>       |                  ^~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:611:28: error: excess elements in struct initializer [-Werror]
>   611 |                 .data.in = &st->buf.be32,
>       |                            ^
> /tmp/next/build/drivers/iio/adc/ad4062.c:611:28: note: (near initialization for 'xfer_sample')
> /tmp/next/build/drivers/iio/adc/ad4062.c:612:18: error: 'struct i3c_priv_xfer' has no member named 'len'
>   612 |                 .len = st->conv_sizeof,
>       |                  ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:612:24: error: excess elements in struct initializer [-Werror]
>   612 |                 .len = st->conv_sizeof,
>       |                        ^~
> /tmp/next/build/drivers/iio/adc/ad4062.c:612:24: note: (near initialization for 'xfer_sample')
> /tmp/next/build/drivers/iio/adc/ad4062.c:613:18: error: 'struct i3c_priv_xfer' has no member named 'rnw'
>   613 |                 .rnw = true,
>       |                  ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:613:24: error: excess elements in struct initializer [-Werror]
>   613 |                 .rnw = true,
>       |                        ^~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:613:24: note: (near initialization for 'xfer_sample')
> /tmp/next/build/drivers/iio/adc/ad4062.c:610:30: error: storage size of 'xfer_sample' isn't known
>   610 |         struct i3c_priv_xfer xfer_sample = {
>       |                              ^~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:615:16: error: variable 'xfer_trigger' has initializer but incomplete type
>   615 |         struct i3c_priv_xfer xfer_trigger = {
>       |                ^~~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:616:18: error: 'struct i3c_priv_xfer' has no member named 'data'
>   616 |                 .data.out = &st->conv_addr,
>       |                  ^~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:616:29: error: excess elements in struct initializer [-Werror]
>   616 |                 .data.out = &st->conv_addr,
>       |                             ^
> /tmp/next/build/drivers/iio/adc/ad4062.c:616:29: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:617:18: error: 'struct i3c_priv_xfer' has no member named 'len'
>   617 |                 .len = sizeof(st->conv_addr),
>       |                  ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:617:24: error: excess elements in struct initializer [-Werror]
>   617 |                 .len = sizeof(st->conv_addr),
>       |                        ^~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:617:24: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:618:18: error: 'struct i3c_priv_xfer' has no member named 'rnw'
>   618 |                 .rnw = false,
>       |                  ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:618:24: error: excess elements in struct initializer [-Werror]
>   618 |                 .rnw = false,
>       |                        ^~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:618:24: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:615:30: error: storage size of 'xfer_trigger' isn't known
>   615 |         struct i3c_priv_xfer xfer_trigger = {
>       |                              ^~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:615:30: error: unused variable 'xfer_trigger' [-Werror=unused-variable]
> /tmp/next/build/drivers/iio/adc/ad4062.c:610:30: error: unused variable 'xfer_sample' [-Werror=unused-variable]
>   610 |         struct i3c_priv_xfer xfer_sample = {
>       |                              ^~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c: In function 'ad4062_read_chan_raw':
> /tmp/next/build/drivers/iio/adc/ad4062.c:855:16: error: variable 'xfer_trigger' has initializer but incomplete type
>   855 |         struct i3c_priv_xfer xfer_trigger = {
>       |                ^~~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:856:18: error: 'struct i3c_priv_xfer' has no member named 'data'
>   856 |                 .data.out = &st->conv_addr,
>       |                  ^~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:856:29: error: excess elements in struct initializer [-Werror]
>   856 |                 .data.out = &st->conv_addr,
>       |                             ^
> /tmp/next/build/drivers/iio/adc/ad4062.c:856:29: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:857:18: error: 'struct i3c_priv_xfer' has no member named 'len'
>   857 |                 .len = sizeof(st->conv_addr),
>       |                  ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:857:24: error: excess elements in struct initializer [-Werror]
>   857 |                 .len = sizeof(st->conv_addr),
>       |                        ^~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:857:24: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:858:18: error: 'struct i3c_priv_xfer' has no member named 'rnw'
>   858 |                 .rnw = false,
>       |                  ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:858:24: error: excess elements in struct initializer [-Werror]
>   858 |                 .rnw = false,
>       |                        ^~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:858:24: note: (near initialization for 'xfer_trigger')
> /tmp/next/build/drivers/iio/adc/ad4062.c:855:30: error: storage size of 'xfer_trigger' isn't known
>   855 |         struct i3c_priv_xfer xfer_trigger = {
>       |                              ^~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:860:16: error: variable 'xfer_sample' has initializer but incomplete type
>   860 |         struct i3c_priv_xfer xfer_sample = {
>       |                ^~~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:861:18: error: 'struct i3c_priv_xfer' has no member named 'data'
>   861 |                 .data.in = &st->buf.be32,
>       |                  ^~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:861:28: error: excess elements in struct initializer [-Werror]
>   861 |                 .data.in = &st->buf.be32,
>       |                            ^
> /tmp/next/build/drivers/iio/adc/ad4062.c:861:28: note: (near initialization for 'xfer_sample')
> /tmp/next/build/drivers/iio/adc/ad4062.c:862:18: error: 'struct i3c_priv_xfer' has no member named 'len'
>   862 |                 .len = sizeof(st->buf.be32),
>       |                  ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:862:24: error: excess elements in struct initializer [-Werror]
>   862 |                 .len = sizeof(st->buf.be32),
>       |                        ^~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:862:24: note: (near initialization for 'xfer_sample')
> /tmp/next/build/drivers/iio/adc/ad4062.c:863:18: error: 'struct i3c_priv_xfer' has no member named 'rnw'
>   863 |                 .rnw = true,
>       |                  ^~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:863:24: error: excess elements in struct initializer [-Werror]
>   863 |                 .rnw = true,
>       |                        ^~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:863:24: note: (near initialization for 'xfer_sample')
> /tmp/next/build/drivers/iio/adc/ad4062.c:860:30: error: storage size of 'xfer_sample' isn't known
>   860 |         struct i3c_priv_xfer xfer_sample = {
>       |                              ^~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:860:30: error: unused variable 'xfer_sample' [-Werror=unused-variable]
> /tmp/next/build/drivers/iio/adc/ad4062.c:855:30: error: unused variable 'xfer_trigger' [-Werror=unused-variable]
>   855 |         struct i3c_priv_xfer xfer_trigger = {
>       |                              ^~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c: In function 'pm_ad4062_triggered_buffer_postenable':
> /tmp/next/build/drivers/iio/adc/ad4062.c:1239:30: error: array type has incomplete element type 'struct i3c_priv_xfer'
>  1239 |         struct i3c_priv_xfer xfer_sample[2] = {
>       |                              ^~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/ad4062.c:1239:30: error: unused variable 'xfer_sample' [-Werror=unused-variable]
> /tmp/next/build/drivers/iio/adc/ad4062.c:1254:1: error: control reaches end of non-void function [-Werror=return-type]
>  1254 | }
>       | ^
> 
> Caused by commit
> 
>     d5284402d28f3 (iio: adc: Add support for ad4062)
> 
> I have used the version from 20260116 instead.
> 


