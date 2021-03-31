Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987043500D7
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhCaNBL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Mar 2021 09:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235634AbhCaNBF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Mar 2021 09:01:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5C756196C;
        Wed, 31 Mar 2021 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617195664;
        bh=fpjbRjzuhhKjDVMy/Iwk4X2pjxw44PsDGZYpY5/o2yM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfnOKjp8c8lRwPgGVAS8BSFnrABlFY4SHtoLLZTex7WdcxvhjIMbHMnMxpJH0MPpK
         i0c8KFB7AXvwfitOwDE4RJSZLRgzaTBq0Xjqso7ZPaWJ8AxLEFdFlyd7FSm509xrMj
         cUcRFTlZZorzERIBb0RhURjQi2NXFQGpbW3URTKv9lrxR7Kh/ZYr+a3S9iTPtXPl/L
         T/o5T/r+H5a9/qxg+vB5rIzofyP+qMuJMHcfP8WHgGqG39yFKEn5yMN7s1vEGD+mQC
         cbSb/ZnhxW+0Tpms5iDoIOLVfn7nqXM5E5Jo5IPcpekdIoTp72Cv7yJpx8ED4LKk5P
         d5FG88bLfpGSQ==
Date:   Wed, 31 Mar 2021 18:31:00 +0530
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH v2 7/8] dt-bindings: phy: fix dt_binding_check warning in
 mediatek,ufs-phy.yaml
Message-ID: <YGRyjE+CjkJojqBM@vkoul-mobl.Dlink>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
 <20210319023427.16711-9-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319023427.16711-9-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 19-03-21, 10:34, Seiya Wang wrote:
> This commit fixes the warning messages of make dt_binding_check from
> newly added mediatek,mt8195-ufsphy in mediatek,ufs-phy.yaml

Applied, thanks

-- 
~Vinod
