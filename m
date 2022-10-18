Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E9602C45
	for <lists+linux-iio@lfdr.de>; Tue, 18 Oct 2022 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJRNAi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Oct 2022 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJRNAg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2022 09:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC8895CC;
        Tue, 18 Oct 2022 06:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 986556153F;
        Tue, 18 Oct 2022 13:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8312C433C1;
        Tue, 18 Oct 2022 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666098035;
        bh=hJkmyb0el7q4g4MjHB/cF/uww5w6exRobS/z6T4Jn8Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AZT+UP1XWTvk0ZuZsKot3x2PUBpE1KwBfxVJqUl5QtYtQhX6LhcIPNx+OwrwaEuYX
         PeELTwcj3uMPlX2KRYazDOf09yCJs2lBxE7Ed6h5EBFC+CDnoDainRKLUKCaYrrdVA
         1/hLBV6o+dodkym8uMWNHTAlwTPDwGkTUoZXhg8Iy7bvzcZfeDRLUO9qCoDY5hoTRF
         659D3aw9ifbe7WLgorwva1xKMjuSdr29tjJXgxgVW9l884XEjg4sjiDdgjPCFu2byS
         VCUXcHo3CIEUM+7EI6M84b7jr4Nmj9XrHftepojH5N8B+qeCrvse+JgKZOy7d/2uuP
         FtclvoFo5EAVw==
Date:   Tue, 18 Oct 2022 15:00:31 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
cc:     Matt Ranostay <matt.ranostay@konsulko.com>, gupt21@gmail.com,
        benjamin.tissoires@redhat.com, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v6 3/3] HID: mcp2221: add ADC/DAC support via iio
 subsystem
In-Reply-To: <20221002145052.036003b5@jic23-huawei>
Message-ID: <nycvar.YFH.7.76.2210181500130.29912@cbobk.fhfr.pm>
References: <20221001005208.8010-1-matt.ranostay@konsulko.com> <20221001005208.8010-4-matt.ranostay@konsulko.com> <20221002145052.036003b5@jic23-huawei>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 Oct 2022, Jonathan Cameron wrote:

> > Add support for 3x 10-bit ADC and 1x DAC channels registered via the 
> > iio subsystem.
> > 
> > To prevent breakage and unexpected dependencies this support only is
> > only built if CONFIG_IIO is enabled, and is only weakly referenced by
> > 'imply IIO' within the respective Kconfig.
> > 
> > Additionally the iio device only gets registered if at least one channel
> > is enabled in the power-on configuration read from SRAM.
> > 
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> 
> I'm never particularly keen on drivers from elsewhere in the tree gaining
> IIO support - but that's just because it can make a bit of a mess of
> changes to the IIO subsystem itself.  Having said that, this code looks fine to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks. Applied for 6.2.

-- 
Jiri Kosina
SUSE Labs

