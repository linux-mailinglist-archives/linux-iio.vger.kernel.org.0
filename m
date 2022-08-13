Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE417591B49
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiHMPQv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiHMPQu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 11:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29E13F56;
        Sat, 13 Aug 2022 08:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A3EF60EB8;
        Sat, 13 Aug 2022 15:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE57C433C1;
        Sat, 13 Aug 2022 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660403808;
        bh=6tGOO1ijE7S/GiCxvtc4LOcQt/od6M5Es+DFz4ypggg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hCPIv1A0+PRvMgeCTjHm0C7GbnEcgf/9GdrrZ4v5evuH0s7eYudk5dSq1EL8w2cqs
         oT18bzgcPEcPkwWjN2h0/w4AS6aV0miPMdxq2HUnSTPWgNGNOgPeY0no9AdwEOny9f
         NfAsT+xjLGFY8cWHpfYYwoLljxrTjxz/mYT1mvx7cvAzPrQ35kKl7XQEe4izB2L23e
         qf8nZZL0Ivfp+AUDaht5E7FuLguS5ygbGFoWKor5iZ3URLt5vYOLZfQ+qPGkkissLv
         IsJ6hxty2LG/IkLviKNlotcCOzkWGNjc5XDDUDpOhpmGMzCFo9OdP2KJbCeFSynQhY
         P4usbuCbddqvw==
Date:   Sat, 13 Aug 2022 16:27:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220813162715.2c8bdc47@jic23-huawei>
In-Reply-To: <20220809103519.437rcude7fstxyy4@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
        <20220803131132.19630-3-ddrokosov@sberdevices.ru>
        <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
        <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
        <20220806155523.37c3e587@jic23-huawei>
        <20220809095251.vpp6arac3pkntdlo@CAB-WSD-L081021.sigma.sbrf.ru>
        <CAHp75Vc9LGX-=Y2smOrKuAgSRrhA0AgGuBE-0=_-q78FpSB6ag@mail.gmail.com>
        <20220809103519.437rcude7fstxyy4@CAB-WSD-L081021.sigma.sbrf.ru>
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

On Tue, 9 Aug 2022 10:35:19 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> On Tue, Aug 09, 2022 at 12:05:12PM +0200, Andy Shevchenko wrote:
> > > > > > > +       indio_dev->modes = 0; /* setup buffered mode later */  
> > > > > >
> > > > > > Why explicit assignment to 0? Doesn't kzalloc() do it for you?  
> > > > >
> > > > > kzalloc() will do it for me, of course. Previously, I initialized modes to
> > > > > INDIO_DIRECT_MODE to just provide default value for that. Jonathan
> > > > > suggested to replace it with 0.  
> > > >
> > > > I did?  I wonder what I was smoking that day.
> > > > Should be set to INDIO_DIRECT_MODE as you had it previously.
> > > >
> > > > (From what I recall it will work either way but we have in the past had
> > > > core code that checked this and may do again in the future so drivers should
> > > > still be setting it to specify they provide sysfs interfaces to directly read
> > > > the channels).  
> > >
> > > Jonathan, really sorry I referred to you. I'm confused. This comment was
> > > from Andy in the v3 discussion:
> > >
> > > https://lore.kernel.org/linux-iio/CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com/  
> > 
> > Indeed. I was confused by the comment. My understanding at that time
> > was that the triggered mode is inevitable and hence assigning to
> > something which _will_ be reassigned later makes a little sense. So,
> > does it mean that triggered mode is optional and might not be set? In
> > such a case the comment is misleading.  
> 
> Actually, this comment was introduced in the early MSA311 driver
> versions, when I have made buffer setup only if HW irq is enabled. In
> the newest versions buffer is setup unconditionally, because buffer mode
> can be used based on hrtimer software trigger.
> 
> Jonathan, why we shouldn't delete INDIO_DIRECT_MODE initialization if
> after couple of lines we always setup buffer mode?
> 

The buffered mode setup does
modes |= INDIO_BUFFER_TRIGGERED;
https://elixir.bootlin.com/linux/latest/source/drivers/iio/buffer/industrialio-triggered-buffer.c#L71

Direct mode indicates that it is possible to read the channels without
using any of the triggered modes (there are devices - though rare - where
it is not set as they are only accessible through FIFOs for example).

We don't make much use of IIO_DIRECT_MODE today (though we did until fairly
recently).  It could be replaced with a specific check on provision of
raw / processed channels I guess - but I'm not that keen to see it go without
thinking hard about whether we should be using that flag to catch misconfiguration
in some cases.  So I'd rather postpone any changes in that for now.

Jonathan
