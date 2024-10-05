Return-Path: <linux-iio+bounces-10198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328C3991900
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCFCB20F52
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BD7156C6F;
	Sat,  5 Oct 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2WDNQmB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81CD288B1;
	Sat,  5 Oct 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150499; cv=none; b=WaTgx5kwKdCJpRncNFSzKJ9G3BaIqRp1eLIPedjAOWe51PsBEhYjLNFa5rTLRJxNX1fwC3d4VoH7O85Culp1k3WG7jvt7KzDyyz+yzD65724j3ZN9ojaLlHQOAFpg+FN/w369wf5jIIxXQ31kqG0spaxMEfmx5uBoOB90wy52a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150499; c=relaxed/simple;
	bh=BIsAptceuiA71qMnD+Mb8RJmlRWJ5OhCjMDV0YBrZFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7WlQJBtihSX8DEPnOEwDsT7eBNjWpRKGPVfDTPuLI2NaRYGdq0qBiO5GQpJSdLBiGD0mLVXYLWEvKeX8H7w91etN4H1Itcorn/JWR7ymJ3L5NWo/tTniIWuTwaqGM7HwRXd9+TF0oa0L2b7zXVjOQN48/yhpql/QiSIVMoboLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2WDNQmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90377C4CEC2;
	Sat,  5 Oct 2024 17:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150499;
	bh=BIsAptceuiA71qMnD+Mb8RJmlRWJ5OhCjMDV0YBrZFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X2WDNQmByXJnUO0Qvi0fVSEqlnVzs9WcsIPAkdelUWum2ny+hrKBtxH/sXu/Gpwuf
	 OgEbzsDcPN2r+dBTq0uvjxK2lTa1OrgDsn4twBHl/PZBhuMhldh/IIW/Sp1r9+yx7q
	 xTbS/cW1VX4+N/0pBVToPL/ydv72cxMQfPmTcG0QyCuwpG3RdQeJXqe4a0moln9ZCx
	 snw2bX9UHAuW8VUZvYRn2w7A0LdwP101MsuCThFfTlePSgf6FKYUWtyCvFBMN1oVg0
	 50GnYeg2g/CQeixHgTjQ7ruOoHn7QWvEsCQne+I3S4Z9bY2ST2Ykc6Ez86OXVxSBIb
	 H1RPywOW0tWtw==
Date: Sat, 5 Oct 2024 18:47:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Dan
 Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mihail Chindris
 <mihail.chindris@analog.com>, Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, Dalton Durst
 <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, Andreas Klinger
 <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>
Subject: Re: [PATCH 01/13] iio: accel: kx022a: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005184735.7ce57499@jic23-huawei>
In-Reply-To: <15e6b791-379d-42c0-afb4-b08790d1b4da@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-1-67c0385197cd@gmail.com>
	<15e6b791-379d-42c0-afb4-b08790d1b4da@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 11:17:34 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 04/10/2024 00:04, Javier Carrasco wrote:
> > This driver makes use of triggered buffers, but does not select the
> > required modules.
> > 
> > Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> > 
> > Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> 
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> 

Applied to the fixes-togreg branch of iio.git.

J

