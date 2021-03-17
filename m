Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9433E9E9
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 07:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCQGkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 02:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhCQGjw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Mar 2021 02:39:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40C2E64F4F;
        Wed, 17 Mar 2021 06:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615963192;
        bh=8lbNnEdiagk8rX9RCfb8bBZx8x2kTMgPKKigZX60Bgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8AKUzLS550wVz4Cgqm+n5QU0ySJxryUeGpgzgrnjQfY2yNU5dQBYcud0SDjyKG2t
         y3fuc4ktRTwM20dEUv2RpeFODfCtr3toO/nbOf6aBXxlvCj3K8qr5Ubf/G757jG6vb
         Enn1ZI+zSp+VvgkxhmR4fx0NAs6g9GRhm2O1qbIg9uHbo14LAwLm5DZo8jXE+ZFy1Z
         pekwNtkppnGxhLHw2PQ9KtGj5zIxv60Dkj4T0AQh60JX58X4VXbmxM1tCEVzHHaH6C
         WP/MWQxKePZhTfGHb9ttBENCYYqd3mcHWfTmeVNxumXKj3cYstDlIHwpc6weViJfj6
         gs//JP/a/cqHA==
Date:   Wed, 17 Mar 2021 12:09:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: Add compatible for Mediatek
 MT8195
Message-ID: <YFGkNM9z7n70bImA@vkoul-mobl.Dlink>
References: <20210316111443.3332-1-seiya.wang@mediatek.com>
 <20210316111443.3332-8-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316111443.3332-8-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 16-03-21, 19:14, Seiya Wang wrote:
> This commit adds dt-binding documentation of T-Phy for Mediatek MT8195 SoC
> Platform.

Applied, thanks

-- 
~Vinod
