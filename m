Return-Path: <linux-iio+bounces-21253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8465EAF5D72
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 17:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048877B9D8D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59DC2D781D;
	Wed,  2 Jul 2025 15:40:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D252D375A;
	Wed,  2 Jul 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470827; cv=none; b=m6W0Zk7J1sWuJGsRvf86CjCa/sBZdXb6uzxb+HeV5RvOnsBpUU2GYTcfY/TCb1qDj6XEB2z8fom8qAgq11e5Hyj7qe8EJiXxzmKtYvWuv1OMFM11lNY6ftA2gYhFx8d7qhxvBbcg4NfLQjjD95D75elAEv7iTiJmiyuc40RjbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470827; c=relaxed/simple;
	bh=o8ilAhr3zD03buME2l5n8+FNjqhVnN4JTb7lUuydy3Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fi9wOvIzUjlnLKi4s1O3ELnIugLWJH1wAnHtgDZCCSvPuCrIHQTFkR7WeWEIu/exIyb8cqsjhJFauwrst5du4+nbr3gADHycakbC6fx+hYVdEV8NG8dwI8PbCS1Zi9nqkFHqQOPzYHEk2CVx/QWCOW8CFUwYchUJgp1ENQsal54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXPG82CkKz6M4g3;
	Wed,  2 Jul 2025 23:39:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 18EA214033F;
	Wed,  2 Jul 2025 23:40:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 17:40:23 +0200
Date: Wed, 2 Jul 2025 16:40:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: "Colin King (gmail)" <colin.i.king@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Gustavo Bastos
	<gustavobastos@usp.br>, Andrew Ijano <andrew.ijano@gmail.com>, "Julien
 Stephan" <jstephan@baylibre.com>, <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iio: accel: sca3000: dead code issue
Message-ID: <20250702164022.000027e8@huawei.com>
In-Reply-To: <aGUh7uXenHc7NYB2@smile.fi.intel.com>
References: <1c1e39cb-5fe0-46b3-898e-c65bbb3beb30@gmail.com>
	<aGUh7uXenHc7NYB2@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 2 Jul 2025 15:11:26 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 02, 2025 at 10:00:55AM +0100, Colin King (gmail) wrote:
> 
> >                 ret = spi_w8r8(st->us,
> > SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
> >   
> > >>>  the call to spi_w8r8 returns 0 on success or -ve on an error  
> 
> Where did you get this from, please?  Any link to elixir or Git repo?
> 

Hmm.  Just for reference the docs of spi_w8r8 are:

* Return: the (unsigned) eight bit number returned by the
* device, or else a negative error code.

Not 0 on success (well not unless it is zero.

So the check indeed looks wrong as should be if (ret < 0)


https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=ca66d8208762492df8442a503db568d9aab65f2f
It's in my tree.

I'll drop the patch when I'm on the right machine.  Andrew, could
you do a new version fixing this up?  If not can make the changes
but will be at least the weekend before I get a chance.

Looks like there are a couple of instances of this.

Jonathan



> > 
> >                 if (ret)
> >                         goto error_ret;  
> 


