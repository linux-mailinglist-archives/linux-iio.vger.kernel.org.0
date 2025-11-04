Return-Path: <linux-iio+bounces-25869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBBC31625
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EBF1897F60
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B334032C95E;
	Tue,  4 Nov 2025 14:03:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D532AAA0;
	Tue,  4 Nov 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265004; cv=none; b=DrVMucY8g+R4Y5dhnXOh8EcBKw47dohPnu1UjzAZ73vFkiGIdc5EvVywVq/7+7jSkp3n9XMrT+rNouxBUCsyKicBRdpnO2Rrmg1eXqSWG8p46lHufu7uEqVRFtY2EF94rQgZe5fC9D68uAlDnRKrBAM4kTFWFZ/0qWKv2y/Egu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265004; c=relaxed/simple;
	bh=TIs0KSHaAZac+8fB2KI+RpslKr1YnFy+r4pUcWY1ixE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trd2O0JDbKPwPkNVJHfMWsW37Jix7eYusNXXKEfPV1VCjK+HkSNmdXUlAfFPXlARcaGNvEBl5McbZBLxxfvqMhwwop97DDe1Cun7scMF1rQ2xQobwaQ7/NoBGkOTAPXydXzpS7XYylD3jcuSRlaa8o4cEiwTXM7vo0SZRxKiacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d19CQ1Q53zHnH87;
	Tue,  4 Nov 2025 22:03:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A80611402F0;
	Tue,  4 Nov 2025 22:03:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 14:03:17 +0000
Date: Tue, 4 Nov 2025 14:03:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Antoni Pokusinski
	<apokusinski01@gmail.com>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: mpl3115: add threshold events support
Message-ID: <20251104140315.0000394d@huawei.com>
In-Reply-To: <aQhmNDoI8k3KvyMR@smile.fi.intel.com>
References: <20251031201821.88374-1-apokusinski01@gmail.com>
	<20251031201821.88374-2-apokusinski01@gmail.com>
	<20251102103808.73cac929@jic23-huawei>
	<aQhmNDoI8k3KvyMR@smile.fi.intel.com>
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

On Mon, 3 Nov 2025 10:22:12 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Nov 02, 2025 at 10:38:08AM +0000, Jonathan Cameron wrote:
> > On Fri, 31 Oct 2025 21:18:22 +0100
> > Antoni Pokusinski <apokusinski01@gmail.com> wrote:  
> 
> ...
> 
> 
> > Generally looks good to me, but some comments on the 24 bit value reading.  
> 
> > > +		i2c_smbus_read_i2c_block_data(data->client,
> > > +					      MPL3115_OUT_PRESS,
> > > +					      3, (u8 *)&val_press);  
> > 
> > This is an oddity.  Why read into a __be32 when it's a 24bit number?
> > I guess it doesn't really matter as you just need a big enough space
> > and throw the value away.  However, I'd read it into a u8 [3]; then size off that
> > as well.
> > 
> > There are two existing cases of this in the driver. One of them should use
> > get_unaligned_be24 on a u8[3] buffer.  The other one is more complex as it's
> > reading directly into the scan buffer that gets pushed to the kfifo and is
> > reading into a u8 buffer ultimately anyway so at least there is no
> > real suggestion of it being 32 bits (just a +4 shift to deal with natural
> > alignment as the storage has to be power of 2 in that case.).
> > 
> > hmm. I think either we should tidy up the easy case (_read_info_raw) +
> > use a u8[3] here or just stick to this being odd.
> > My preference would be to have another patch tidying up the other case
> > + use a u8[3] here.  
> 
> Just a side question... Wondering, if we actually can defined __be24 and __le24
> types (or at least u24) for really explicit cases.

Would be useful for readability. Particularly if we could make it work with the
type checking stuff similar to the endian markings, but restricted to only be
accessed with the unaligned accessors.  Possibly worth doing even without that.

Jonathan

> 


