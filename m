Return-Path: <linux-iio+bounces-9105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE996AC71
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 00:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E97B23A9C
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 22:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADBC1D7994;
	Tue,  3 Sep 2024 22:43:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DD1D5CDF
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2024 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403436; cv=none; b=QMy6yO/ia/1xxiDMgCAJRoTp6vTQAA3tqPgkRy3k1YFf0ZC4vzv/QuyN1dDMvX8S6HaKYxTVuMV+5gCcA6W+0IejMG8XQNI5sCxzwxYhHqtlaS+t7dbGLidF6adhpFPOEqpCAyhI6x9Cxqvc6V3YQiJX6rIYOndB35ELjWOLreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403436; c=relaxed/simple;
	bh=itxpL9AylZvLxi2g4MKj7cOwlR5V30GodpZINUgimWA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/OqgyQ3wcp3jI6I1yU1ScIrQwho+JXaM56SAxnYAKNNyHVUCxPWgTFDvqK1Sq36W751GGZa/2e4xCjJ/oH8pCnaWWsXGEre9gr2Ls/7t3IJQ5zb6+EspGN1v8ywy8WauD86gOQyeTU4Xcgl6jMUnGn/48VHHLb7YrZSPAu2wuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id fa384007-6a45-11ef-8ece-005056bdf889;
	Wed, 04 Sep 2024 01:43:45 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 01:43:45 +0300
To: Jonathan Cameron <jic23@kernel.org>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: iio: rm .*.cmd when make clean
Message-ID: <ZteRIY3H0o4wYy1G@surfacebook.localdomain>
References: <20240831115931.596e35fb@jic23-huawei>
 <20240902035412.4835-1-zhangjiao2@cmss.chinamobile.com>
 <20240903200923.21c4c1ff@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903200923.21c4c1ff@jic23-huawei>

Tue, Sep 03, 2024 at 08:09:23PM +0100, Jonathan Cameron kirjoitti:
> On Mon,  2 Sep 2024 11:54:12 +0800
> zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:
> > On Sat, 31 Aug 2024 11:59:31, Jonathan Cameron wrote:
> > >> On Thu, 29 Aug 2024 13:33:09 +0800
> > >> zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:

...

> > >> rm .*.cmd when make clean  
> > > Where do those come from?  
> > 	Those come from tools/build/Build.include.
> > These .*.cmd files ware created when make.
> > So clean them when make clean.
> Hmm. I'm still a little curious about the path to those getting created as
> I don't see them. when testing.

At least this is documented here
https://elixir.bootlin.com/linux/v6.11-rc6/source/tools/build/Documentation/Build.txt#L149

Here is where they are being created
https://elixir.bootlin.com/linux/v6.11-rc6/source/tools/build/Build.include#L58

And it seems it is only created when there are actual dependencies.

-- 
With Best Regards,
Andy Shevchenko



