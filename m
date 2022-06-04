Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E1353D7A1
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiFDQIA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiFDQH7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:07:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0928E07
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57FDCB8069F
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E2FC385B8;
        Sat,  4 Jun 2022 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654358876;
        bh=yLKbwF2gxK0JYmF+m2LXGBcu3usF2WL6JJ0OcvCD7sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rkLJzqw6jdU3blaBMbAt675h8gI3LZCGhjIBD4v5eok4aelZC2vteeC17VmnkGXUR
         naRNfbeR3eBeaXkyjTUIkzHDGiDl4V0NOuHg6ISKCcuxzRtis/8vBbuSWRr5aHU23b
         ARPMcKJo7njTPaAuG3DYrmF2/uFlzw93iB4E+GpEtRfGzVlekGOgNMSBwIkEmLS4a/
         fFmx09ffYsgePs9oa3PAhTI1+W5AtdW2qISxCENl9ldQAYYXY7QDhrRavDKQ8Ne63x
         EyALW4lwt2SoK2CiYI3c3oT45pXPpQH4mnLvqKJGXbIXwYZEMlO/pcdsmHyTy7gMkW
         U2Pzelu0ydlew==
Date:   Sat, 4 Jun 2022 17:16:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] iio: accel: mma8452: remove the reset operation during
 driver probe
Message-ID: <20220604171657.78eb7927@jic23-huawei>
In-Reply-To: <YhfBZv7msnpvDVEs@ninjato>
References: <1645505151-5789-1-git-send-email-haibo.chen@nxp.com>
        <20220222164331.00002d18@Huawei.com>
        <VI1PR04MB401628231C1D06E318820D26903D9@VI1PR04MB4016.eurprd04.prod.outlook.com>
        <YhfBZv7msnpvDVEs@ninjato>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Feb 2022 18:33:26 +0100
Wolfram Sang <wsa@kernel.org> wrote:

> > > Wolfram is there a standard way to work around missing ACK in cases like
> > > this?  Would just ignoring the return value be fine or are their i2c masters
> > > that will get stuck if they don't get the expected ack?  
> 
> Did I get this right: the reset procedures terminates the ACK and STOP?
> And the client expects a new START condition for communication?
> 

@Bough Chen,

I'm assuming this is still an issue for you?  If so can you reply to
Wolfram so we can hopefully move this forwards.

Found this because it's still listed as needing an action in the IIO
patchwork.

Thanks,

Jonathan
