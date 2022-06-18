Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FCB55056E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiFROGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbiFROG0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 10:06:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F113E3C;
        Sat, 18 Jun 2022 07:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 391FEB8013C;
        Sat, 18 Jun 2022 14:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787ADC3411A;
        Sat, 18 Jun 2022 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655561182;
        bh=C5dR11nmIbd7ulhKg+caNcYU9xH6pSpJ8aq4v29W2BU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DReMJwDyEA1rcbhV7Wyw0PnbBvnKJgwDNmNDXZH9pP3SmmsLbJOO1DGD2skMuNudA
         mHpUBsKzkhPIXv000C2dhc6HAG/hgWkDq16QbQE3Ab+m7MaPVK9a68XLmJyK4Pj8P5
         8Fn/fVD9N8RYPM4gxc0KKMJrYt5/HrojBDyhiAj9tagHYWSMRJjylJHMv/Sjde33TZ
         pRWw/OJz5IilCqdu/a7b/zErgY93zaO8F/SbjHZyvBqDjDNvZYySzgG8wWhmyIO3vO
         Iol28XLu7Rw4p0QLtt6iiHHyMI3hfxa3X/28TIS4b+IGJqmtPN4+AKMHq1CbJnl9UC
         bB7e/whQTcRRA==
Date:   Sat, 18 Jun 2022 15:15:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 7/7] iio: magnetometer: yas530: Add YAS537 variant
Message-ID: <20220618151538.3d142682@jic23-huawei>
In-Reply-To: <033f64ea-4ba7-eb89-3259-688008e29989@rocketmail.com>
References: <cover.1655081082.git.jahau@rocketmail.com>
        <b6e100de37921c22ebf0698f8e0e99794053303a.1655081082.git.jahau@rocketmail.com>
        <CAHp75VfFwSQ6bk=TMLiyA1j-AsafjGdVFbTTHJJ67C8zeYfz8Q@mail.gmail.com>
        <033f64ea-4ba7-eb89-3259-688008e29989@rocketmail.com>
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



> 
> >> +       /* Sanity check, is this all zeroes? */
> >> +       if (memchr_inv(data, 0x00, 16) == NULL) {  
> > 
> >   if (!memchr_inv(...))
> >   
> >> +               if (FIELD_GET(GENMASK(5, 0), data[16]) == 0)
> >> +                       dev_warn(yas5xx->dev, "calibration is blank!\n");
> >> +       }  
> 
> No problem to change for YAS537.
> 
> At YAS530/532, there is a similar line that should be changed
> accordingly. However, there is a patch by Linus that was already added
> to "fixes-togreg" branch in iio.git quite a while ago [5]. The patch is
> not included in torvalds/linux v5.19-rc1 or -rc2 and neither in iio.git
> testing branch. So I'm unsure what I should base the patchset on if I
> want to change that line. I will probably choose linux-next, as the
> patch is included there and in Kconfig also patch "iio: magnetometer:
> ak8974: Drop dependency on OF" is included (which on the other hand
> isn't included in "fixes-togreg" branch in iio.git).
> 
> [5]
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=bb52d3691db8cf24cea049235223f3599778f264

Busy couple of weeks for me and that fix got caught up in the merge
window timing before that.  I should get a pull request out shortly.

Jonathan


