Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A8B67C4F5
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jan 2023 08:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjAZHkz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Jan 2023 02:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZHky (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2023 02:40:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1F65F1D;
        Wed, 25 Jan 2023 23:40:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1E661755;
        Thu, 26 Jan 2023 07:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD98DC433EF;
        Thu, 26 Jan 2023 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674718853;
        bh=AgNWI9viKcWsyuHJQss0XWLMRWQElz7GAinAlTF2TPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rim4yhFXn6p3tDekm3gytOfffD/on9BGP1zD1G2TEpiW8IVmHvIvpmPJcX+kJHeTX
         +qQUroHaz4vp+ZB4tvGZEprPr7/9Yo03A0FPuCfGylIt7/GW2Twynwzp//DTigOx1D
         zueI11KENZDTLrj7/Xl/oFBCVykWztvdBGsTNqtpYpTkQhfXNAYEfM41ML/UCXA9HP
         e1+5sfHX3LN8zzTKNpBCim08Y/zUnEPbTQhvSBbR6J5alp5IL5Ch0ns/oCq5HXwchC
         OEWH9uLuPtXmxhONxHYugzZ3D2xizdQEEzG5HDP8JHN/f0QRLgLV8OAzrfCLzRm/eT
         Ud23XNhV9kB9g==
Date:   Thu, 26 Jan 2023 15:40:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     haibo.chen@nxp.com
Cc:     jic23@kernel.org, s.hauer@pengutronix.de, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/3] arm64: dts: imx93: add ADC support
Message-ID: <20230126074043.GX20713@T480>
References: <20230117135137.1735536-1-haibo.chen@nxp.com>
 <20230117135137.1735536-4-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117135137.1735536-4-haibo.chen@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 17, 2023 at 09:51:37PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add ADC support for imx93-11x11-evk board.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied, thanks!
