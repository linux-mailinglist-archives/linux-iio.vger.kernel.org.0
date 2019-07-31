Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB537CE03
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfGaURh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 16:17:37 -0400
Received: from ms.lwn.net ([45.79.88.28]:56130 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfGaURh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Jul 2019 16:17:37 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7F83A7DA;
        Wed, 31 Jul 2019 20:17:35 +0000 (UTC)
Date:   Wed, 31 Jul 2019 14:17:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        samba-technical@lists.samba.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <20190731141734.1fa9ce64@lwn.net>
In-Reply-To: <cover.1564603513.git.mchehab+samsung@kernel.org>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 31 Jul 2019 17:08:47 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> As promised, this is the rebased version of the patches that were not applied
> from the /26 patch series because you had merge conflicts.
> 
> They're all based on your docs-next branch, so should apply fine.
> 
> The first one fixes all but one error with a broken reference.
> 
> The only broken reference right now is due to a DT patch with was not
> accepted (no idea why), but whose driver is upstream.

All but 5/6 applied, thanks.

jon
