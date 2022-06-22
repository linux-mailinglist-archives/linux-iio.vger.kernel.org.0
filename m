Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7469554952
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jun 2022 14:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357506AbiFVLVt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jun 2022 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357528AbiFVLVg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 07:21:36 -0400
X-Greylist: delayed 614 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 04:19:52 PDT
Received: from onstation.org (onstation.org [52.200.56.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89983E5F0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 04:19:52 -0700 (PDT)
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by onstation.org (Postfix) with ESMTPSA id B706741F4AB;
        Wed, 22 Jun 2022 07:09:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 onstation.org B706741F4AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onstation.org;
        s=default; t=1655896176;
        bh=A46xSNiHgr0OtXPW/tKxAHg6N2G73umDxu2Vfa+xiqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wm2cX7E2184MUu36bDASEzhCs2zauczHqo9rbc9fJoYb+xm6M0BymNA/mSz26QfKW
         12rXo3cqw0y20Uv6OE4dH+X0Q4lPp69braq7Nah47LLmVyxGgxPSo3tjDmuDtZKfdN
         DL+5fecOsN2XYP0mz+OHo95lmg+lr8YiyHQTZ1Ss=
Date:   Wed, 22 Jun 2022 07:09:36 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 29/36] iio: light: isl29028: Use
 DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
Message-ID: <20220622110936.GA11035@onstation.org>
References: <20220621202719.13644-1-jic23@kernel.org>
 <20220621202719.13644-30-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621202719.13644-30-jic23@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 21, 2022 at 09:27:12PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using these new macros allows removal of unused pm_ops structure
> and functions if !CONFIG_PM without the need to mark the functions
> __maybe_unused.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Brian Masney <masneyb@onstation.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>

