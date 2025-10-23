Return-Path: <linux-iio+bounces-25388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BDAC02B73
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C3FF4E1A93
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E66346E41;
	Thu, 23 Oct 2025 17:23:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809C26F28F;
	Thu, 23 Oct 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240204; cv=none; b=qG1JBvmbIqKVIJS26pZTqcNSYSd0oC0yPmlPKZ8guVuRv0IGqXQEHjj6UGue9QIV8VN73H8X/G0A/dxG4wwpTArxWty33Y8XzGQSpqBkLimsTonuH9IS2M5IHE8zDQtLHFznuFD03Lr/PEljc4Ry8wqtvXrE78o2q4wGlovbNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240204; c=relaxed/simple;
	bh=cqptFKx+PeLWN+cR84e1h12c8cA8o3wGoLSoU3gjjLc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkvKyRaZofGeIbgfnVufwh7vmoCdGJg0q9q3+qc1v+R/6cHC+r6d7zewjjMCe6mMkf7wvxym8FeF5dS4y9ZYlLx4bO4C/0I2J4E8jUSrCl4qnBs5wJuloqsT8r8q8gOc+pZT1tO/O3dwwplKEDVbx6KIGa60M0pt3INpiHFKz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cst844WR8z6HJhX;
	Fri, 24 Oct 2025 01:20:04 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C4F01402F3;
	Fri, 24 Oct 2025 01:23:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 18:23:19 +0100
Date: Thu, 23 Oct 2025 18:23:18 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Petre Rodan <petre.rodan@subdimension.ro>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: accel: bma220: move set_wdt() out of bma220_core
Message-ID: <20251023182318.00004319@huawei.com>
In-Reply-To: <aPjE-n0wKNIJd2-M@smile.fi.intel.com>
References: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
	<aPjE-n0wKNIJd2-M@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 22 Oct 2025 14:50:18 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Oct 21, 2025 at 01:31:49PM +0300, Petre Rodan wrote:
> > Move bma220_set_wdt() into bma220_i2c.c instead of using a conditional
> > based on i2c_verify_client() in bma220_core.c that would make core
> > always depend on the i2c module.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> But Kconfig for this driver is a bit strange. Usually we do other way around,
> i.e. make user visible selection of the glue drivers, while core is selected if
> at least one of the leaf driver selected by the user.
> 
This comes up from time to time.  There kind of isn't a right answer
to my mind in the trade off between complexity of configuration 
and desire for minimum useful set of Kconfig symbols and people wanting
to build only exactly what they want.  So we've ended up with a mix.

I don't mind setting a policy on this for new code going forwards, but
that means we need to decide which approach we prefer and document
it somewhere.

Jonathan

