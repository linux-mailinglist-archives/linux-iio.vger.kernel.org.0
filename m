Return-Path: <linux-iio+bounces-20629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD13AD9C3D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C431899F43
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E424A061;
	Sat, 14 Jun 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eptmj3db"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE451DE3A8;
	Sat, 14 Jun 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749898297; cv=none; b=XwWrIG8C+ZR6Q6E/8b0OwVS54RxmepbmzQjROqaH1YejAfEs3HUm2BgeRF2JZv9YL8+xPpCBH+V0/G1kFaM6Ilxl8/6CoBiYwXrF6nb/iQSAqaXGfGQVUTFvPp222qDbCSdgWsqLggcEint/xVa6kX97BeWhMvaxnBEUjtt+Y68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749898297; c=relaxed/simple;
	bh=70Kj5g5xree1/k5BJ+R8p4tct5cPQROl6hgLiXLF+h4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/+bxmCEYRMDEK+tVDTuV8g9K/23of63qwja4vlW/SbrjXN8YKInzpucwHEtHIMt+bW8HIU5VuEE2G5T7J1Ar3KunJGd52pJ01Gz4tgHlm+DYW+FW3Lkwd5lo+PTMlZx1nQIp5r20ehAgbvLYCZufsN9Zfo58Axu4t2axZr5oiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eptmj3db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D8C4CEEB;
	Sat, 14 Jun 2025 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749898296;
	bh=70Kj5g5xree1/k5BJ+R8p4tct5cPQROl6hgLiXLF+h4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eptmj3dbGMAso+9Zg7IIrZRVG5KsMuB2xoNl1tUCUp8IArsmbRi/lWogkOELuRCVQ
	 pX6j7JRXB4r0QO0q+6li6SEVjqF8ofUgGRpD/1mIs792LDcQJzSiQaCuXF3hFLWhh7
	 256FsFFR2vZVyqXLFzk0NI4ns09rlASGSPDwI/3HfXlycoLlS0+kHLDdoeknBkuHWD
	 MrPRYbjTIRl7Oj58YURZwFCGgLvzIqYgJMyTT+3jqrQ4toR82nWeiL8jfpjM9LyDhI
	 kjeXNxRK/h45yAUc7+2FFhYvDowjRZCnQeEk7OkzrVSUnoPvfRv6cvFcSKpllmO1x2
	 dFrakZY106+hg==
Date: Sat, 14 Jun 2025 11:51:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ana-Maria Cusco <ana-maria.cusco@analog.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <20250614115126.73b82431@jic23-huawei>
In-Reply-To: <aEsg-3AWGRLTpvuJ@smile.fi.intel.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
	<48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
	<aEifWXPV1nsIyWbT@smile.fi.intel.com>
	<aEnvcaP2ZNPLhzXi@debian-BULLSEYE-live-builder-AMD64>
	<aErMgh6AKVStF4rQ@smile.fi.intel.com>
	<aEreFQUZXsdsgBSm@debian-BULLSEYE-live-builder-AMD64>
	<aEsg-3AWGRLTpvuJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 21:48:27 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Jun 12, 2025 at 11:03:01AM -0300, Marcelo Schmitt wrote:
> > On 06/12, Andy Shevchenko wrote:  
> > > On Wed, Jun 11, 2025 at 06:04:49PM -0300, Marcelo Schmitt wrote:  
> > > > On 06/11, Andy Shevchenko wrote:  
> > > > > On Tue, Jun 10, 2025 at 05:31:25PM -0300, Marcelo Schmitt wrote:  
> 
> ...
> 
> > Not sure about sending a patch only adding a TODO to the regulator framework.
> > Aren't developers expected to propose things?
> > I'm anticipating 'talk is cheap, show me the code' coming.  
> 
> This maybe done in a form of the discussion started with the maintainers and
> stakeholders of regulator framework. It doesn't mean we must have something
> in the form of the patch right now.
> 

Been quite a few years since we last looked at negative regulator voltages.
Might be worth a revisit.

J

