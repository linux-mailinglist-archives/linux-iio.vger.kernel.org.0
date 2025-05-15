Return-Path: <linux-iio+bounces-19552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA3AB8D0C
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 19:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A321BC6A5F
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 17:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF84256C6C;
	Thu, 15 May 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcNyxHhr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB7255F4D;
	Thu, 15 May 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328383; cv=none; b=p8HqsiuWyvSgJnQ+vBrSc1Cxazo+kblQCB9JmbXddlA8vuNehONHISIPLEpc+vuBMzS8bSXinB8ZfdL8BVbHj1C+L6tyF0YGD7h7eGMsyaNejE6WVX7xeyvb/aFAEFBEzzfDgKaV1hSw7WKBkJWxbzWo1tC12bPjWR1/TpAOTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328383; c=relaxed/simple;
	bh=QqeJinLNjCwHI9lqJ7eAgQPajUYOTAGrRLDu2R8Nv6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZkMfMVjdaDCgjTvnMa/4ZuTbidS3iPL5vnldwjefwOqap7CoSyFEvA/YXi3reTlj7NNx3p49ANI6lCnIYAGwy36HrYmJJG03hB1K4XUG9hWIil7lavwhb6eav3Qqpm72Ojkh+7X2n0qkXQ7gmhe0wTA/FsBzJR7R7EnbPi6TY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcNyxHhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24676C4CEE7;
	Thu, 15 May 2025 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747328382;
	bh=QqeJinLNjCwHI9lqJ7eAgQPajUYOTAGrRLDu2R8Nv6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DcNyxHhr0HKBMn832YhjDOEyfRW+iX/YdN8GrCUxqSOaVQk+7MQzhL6octYhPY+ZM
	 68dk8cjfKozt/gPurguAhIqJQ3e/St4ZK6XwKNyZjqChxt2IxMHyva4FEXeYGORSZj
	 Hz3lqYAMSy7h6S/sEyQgznHyIkFAsdCKGP5/0UAir2SCBc/8iwTts1LRSaIJvtZ//z
	 MGpg9/g0NkJE1o7Ab0nGct4Sf20MVPdpbGs61KIk7vcp1DSdyFe8UsUMWqifTcT2wq
	 t9LTS+h18Jfkf9uVTKSWXH+uUBDS1b7LfhXDwIfdx44COuWuICZIg6EBjPWPvJ38Kv
	 mQcMtnINN5aWQ==
Date: Thu, 15 May 2025 17:59:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Eason Yang <j2anfernee@gmail.com>, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com, alisadariana@gmail.com,
 gstols@baylibre.com, olivier.moysan@foss.st.com, tgamblin@baylibre.com,
 antoniu.miclaus@analog.com, eblanc@baylibre.com, stefan.popa@analog.com,
 angelogioacchino.delregno@collabora.com, marcelo.schmitt@analog.com,
 tobias.sperling@softing.com, chanh@os.amperecomputing.com,
 KWLIU@nuvoton.com, yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <20250515175932.3ad4bbe0@jic23-huawei>
In-Reply-To: <aCG2yfmg-tSq95ur@smile.fi.intel.com>
References: <20250512083156.3300006-1-j2anfernee@gmail.com>
	<20250512083156.3300006-3-j2anfernee@gmail.com>
	<aCG2yfmg-tSq95ur@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 11:52:25 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, May 12, 2025 at 04:31:56PM +0800, Eason Yang wrote:
> > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> > 
> > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> > to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> > for independent alarm signals, and all the threshold values could be set
> > for system protection without any timing delay. It also supports reset
> > input RSTIN# to recover system from a fault condition.
> > 
> > Currently, only single-edge mode conversion and threshold events are
> > supported.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
Series applied to the testing branch of iio.git.
I'll push out as togreg once it's had some basic build testing.

thanks,

Jonathan


