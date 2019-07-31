Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9773A7CE3D
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 22:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfGaU00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 16:26:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfGaU00 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 16:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+a5BC2SMQTZyNnosj2+NVoaE/cuHtdCJLsTbfMI7CM8=; b=cd0EZcQkx68qz1mV7MZC2uM8w
        P5cYOfzRqT4jAj1XeIa5cZwCKRpuEARrsXGCDxCq8sgpCmoEJ8VyMoB1ZGWIv3KkGkC8AIFMmG3zu
        rlsmWUq3FLoiDUPohjPULvC4w5BLIzEmbwgXzpFT+L80k80QNHwktIQFstvBvlBiAagdTYKLP7kd6
        mgvL4iD+sHmcbJxX4pbsqTYJFd9WsDq0iZww0LtIbpC3Rwlt6XCZ+VcKY2odTaplLXORSAqBC7jw+
        ktYQ73C/T59Q53D5UHvn8GEbIRSj5leo+helE+/aJGkkXgpqWFvenf2ZTIwIz7KLtjIJb7x/x8Xk3
        8x9hawtXg==;
Received: from [191.33.152.89] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsvB0-0001Q8-KC; Wed, 31 Jul 2019 20:26:22 +0000
Date:   Wed, 31 Jul 2019 17:26:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        samba-technical@lists.samba.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve French <sfrench@samba.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-cifs@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        Hartmut Knaack <knaack.h@gmx.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/6] ReST conversion patches not applied yet
Message-ID: <20190731172613.32d65ad8@coco.lan>
In-Reply-To: <20190731202007.GI4369@sirena.org.uk>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
        <20190731141734.1fa9ce64@lwn.net>
        <20190731202007.GI4369@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Wed, 31 Jul 2019 21:20:07 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Wed, Jul 31, 2019 at 02:17:34PM -0600, Jonathan Corbet wrote:
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:  
> 
> > > As promised, this is the rebased version of the patches that were not applied
> > > from the /26 patch series because you had merge conflicts.
> > > 
> > > They're all based on your docs-next branch, so should apply fine.
> > > 
> > > The first one fixes all but one error with a broken reference.
> > > 
> > > The only broken reference right now is due to a DT patch with was not
> > > accepted (no idea why), but whose driver is upstream.  
> 
> > All but 5/6 applied, thanks.  
> 
> Oh, I still hadn't reviewed this version of the SPI stuff :(

It is basically the one sent on that /26 patch series, just rebased
on the top of docs-next.

> There were outstanding questions about where it was going to get moved
> to but if I read the diff correctly it looks like it didn't actually get
> moved in the end?

Yeah, it doesn't have the move. My understanding from our discussions
is that we didn't reach a conclusion.

In any case, I can send a separate patch with the move part once
we reach an agreement about what's the best way to proceed (or you
can do it directly, if you prefer so).

Thanks,
Mauro
