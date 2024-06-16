Return-Path: <linux-iio+bounces-6327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31B909CCC
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597ADB20F32
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8B180A76;
	Sun, 16 Jun 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="QGxeGZf7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB585025E;
	Sun, 16 Jun 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718530748; cv=none; b=dnGbhLUQPGZ799Y+3M/wAoSo/FltSvDvFpSo46ZoO0oowLxPf3pZTY6jRT63aVNQRksxz8BCYgSjO0005eFIWNRbO0iuivHYxxgCWQ8u7/cvSY5sMu1kKTKjzDO484rse/wDxpkAIVHTokKDHypyPIWxQTmgaDJYRJNqtfaQn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718530748; c=relaxed/simple;
	bh=6dA7/dibViLlVg0vuBTN+RMz0VQaAmKhfC47NLA+bFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhJo2iIYo8rfaxOb3KRIwyNpLhZ4WaZPj4cyhBt1dL1TZL6YgByLSSsMo+YBUTwHXAUBT1V78Fohx5tllcueJjt0aLCEKlU0hStL0jDDsBd3IAPfpBUcDgT9b+ikMGh0jAOg6ZgUqeoMQh85mldpJPYToyqP+oe89dQUTBSP0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=QGxeGZf7; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1CFB61FA58;
	Sun, 16 Jun 2024 11:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718530735;
	bh=kAZnTqax55Wjz2CBuGAYc20MbuOcHgLalijRLo3HDcQ=;
	h=Received:Received:From:To:Subject;
	b=QGxeGZf7VFUIyjs7eMpMcP44kq7toXzmdvMApNC6/P9eAphWRKEAyDjfEPKZPSMoS
	 GwjeVknER1jzSlW786B5EKaZTUlvrjfwSTgT3CzT+ry5AhqAJFs1viKp61YpgxpCgV
	 q5vHwIRq+aPbrA01yiIlTyvKnWRpDMRSISGjgeO2JTHh3yA8HXrpzGGekrONWYWeeA
	 s2sHMoRROf/638icUfjIAhIfVNmMcoyr7yNZ/A+mU8VuW0bf6RSZknfKLGTmCslQk3
	 cxntzqOYIBRanjOUOEOOsNPxIeMFnkrPlmA2ORuJlkIO8843irHR0CgoNAQWnD9CJK
	 29jpi+ZXF2OWQ==
Received: from livingston (unknown [192.168.42.11])
	by gaggiata.pivistrello.it (Postfix) with ESMTP id 89CC57F9AA;
	Sun, 16 Jun 2024 11:38:54 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.96)
	(envelope-from <francesco@dolcini.it>)
	id 1sImLe-0000xO-1H;
	Sun, 16 Jun 2024 11:38:54 +0200
Date: Sun, 16 Jun 2024 11:38:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix condition for own trigger
Message-ID: <Zm6yrnDwSye85Hl1@livingston.pivistrello.it>
References: <20240614143658.3531097-1-jpaulo.silvagoncalves@gmail.com>
 <20240615115018.2b73d6b3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240615115018.2b73d6b3@jic23-huawei>

On Sat, Jun 15, 2024 at 11:50:18AM +0100, Jonathan Cameron wrote:
> On Fri, 14 Jun 2024 11:36:58 -0300
> João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com> wrote:
> 
> > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > 
> > The condition for checking if triggers belong to the same IIO device to
> > set attached_own_device is currently inverted, causing
> > iio_trigger_using_own() to return an incorrect value. Fix it by testing
> > for the correct return value of iio_validate_own_trigger().
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 517985ebc531 ("iio: trigger: Add simple trigger_validation helper")
> > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

> 
> Ouch.  Can you give an example of resulting user visible result? That
> will help people decide whether to pick this up for their distro kernels
> etc.  In some cases, looks like we'll get garbage timestamps and in others
> may get stale data (or garbage).

This was noticed while me and Joao were working on the ads1119 driver you
have been recently reviewing. We wanted to use iio_trigger_using_own()
and it was not behaving the right way. We looked into it and found the bug.

Given that I do not know the exact impact on the drivers that are using this
function.

> Odd no one has noticed this in the past whilst testing those dependent
> features in particular drivers and I worry a little that we may have bugs
> in the users as a result of iio_trigger_using_own() reporting the inverse
> of the intended. I've take a quick look at the users and 'think' they are
> ok, but would definitely like a few others to confirm.

All the users of iio_trigger_using_own() are older than the commit that
introduced the bug, it is safe to assume that they need the fix and
are expecting the function to behave the same way is documented and it was
before the bug was introduced.

The broken commit is not that old and less than 10 IIO drivers are using this
function. Given that I think that is not that odd that it took 1 year to find
the bug.

Francesco


