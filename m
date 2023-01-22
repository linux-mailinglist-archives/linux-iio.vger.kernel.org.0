Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD796770DA
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jan 2023 18:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjAVRDo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Jan 2023 12:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAVRDn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2023 12:03:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A86193E9;
        Sun, 22 Jan 2023 09:03:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5A52CE0F52;
        Sun, 22 Jan 2023 17:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AF2C433D2;
        Sun, 22 Jan 2023 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674407018;
        bh=PFSSD8HM29uiRCS7E5U5ztKtJ+iGgVO77wPZHOGKuSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gnANlTyzSXvD/HJln33IP45ZpZAE4IXRfHrV6qzEbsco7nT6XzzQU0dlSildB/Q5Y
         MpAkyy0QsoiTxbvmDF3sfbyZ1tMEpbrokDzH144oyUwTmWKKdGbLVYo5Z7D086/rf0
         SLlu7xKaDn5MMUoV/nMpzp1pZdiDPgufFxFUzwE01hCpeODY0qEMfemODIl/mRaP60
         Sh71MAfeLyapVvWEMtcF94dRRvj36DNrbv6ThVue8zRMC8wFrio/qPEX9VeQkQo7ey
         T9ax+O4OGgAqIx6LIRuy2YXb5mLiX5FpDZ8QcGDl8npdd56SqELSO4F5tVp/Wh8iaD
         6rtuDQ82qnI8A==
Date:   Sun, 22 Jan 2023 17:17:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/3] iio: adc: add imx93 adc support
Message-ID: <20230122171723.7e8c878a@jic23-huawei>
In-Reply-To: <20230117135137.1735536-2-haibo.chen@nxp.com>
References: <20230117135137.1735536-1-haibo.chen@nxp.com>
        <20230117135137.1735536-2-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Jan 2023 21:51:35 +0800
haibo.chen@nxp.com wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The ADC in i.mx93 is a total new ADC IP, add a driver to support
> this ADC.
> 
> Currently, only support one shot normal conversion triggered by
> software. For other mode, will add in future.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

Applied to the togreg branch of iio.git and pushed out as testing.
Thanks,

Jonathan


