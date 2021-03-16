Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7133DBC4
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbhCPSAI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 14:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239547AbhCPR7x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Mar 2021 13:59:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68DBA6512B;
        Tue, 16 Mar 2021 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615917592;
        bh=nXlw2vfyIp1WV4usGhcoH7XilW2OrIy0e0d+yxJsh9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8pqAQMPjtlThMC66+kC/1hiYm64eWZ4wYu4wYB5j5y7/non75NV+4zzyXJ/+Whf9
         LsklXdLpM/fJxJNyg7ccJ6WdDe7xFKiYpv2nB9fIQUiYIeLbzoGxzdIlAQxx5BJQtj
         fg9JlGMFIYeHWV7iJ00Ct6qCS2rqxHtF0cOYWY8rsWRzYkdKqZb2UPFQnPsXQZSNGa
         aupAREoPkP7+LV5Iv7X4CgE5SqmeIchFynOt+etteCZ7Ly3mq8mzFp5pkV8b56iEZf
         mFvvw9TdSuroBaPuJqFasTU/ZmQQUSXe+4uRAi5ygoUtfFeyL5IdN6r0zaWBGh69I6
         Z0WRHjPpDrV/g==
From:   Mark Brown <broonie@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-iio@vger.kernel.org,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-serial@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-spi@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-mmc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: (subset) [PATCH 00/10] Add basic node support for Mediatek MT8195 SoC
Date:   Tue, 16 Mar 2021 17:59:39 +0000
Message-Id: <161591750213.14124.1270039699331063876.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210316111443.3332-1-seiya.wang@mediatek.com>
References: <20210316111443.3332-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Mar 2021 19:14:33 +0800, Seiya Wang wrote:
> MT8195 is a SoC based on 64bit ARMv8 architecture.
> It contains 4 CA55 and 4 CA78 cores.
> MT8195 share many HW IP with MT65xx series.
> This patchset was tested on MT8195 evaluation board to shell.
> 
> Based on v5.12-rc2
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[05/10] dt-bindings: spi: Add compatible for Mediatek MT8195
        commit: 5ac1b909e5b60cc2735bd9174f631dc2c7f44c5a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
